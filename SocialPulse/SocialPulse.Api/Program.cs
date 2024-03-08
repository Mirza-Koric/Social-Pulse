using SocialPulse.Api;
using System.Text.Json.Serialization;
using SocialPulse.Application;
using SocialPulse.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SocialPulse.Application.Interfaces;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using SocialPulse.Core;
using System.Text;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");

builder.Services.AddMapper();
builder.Services.AddValidators();
builder.Services.AddApplication();
builder.Services.AddInfrastructure();
builder.Services.AddDatabase(connectionStringConfig);
builder.Services.AddAuthenticationAndAuthorization(jwtTokenConfig);
builder.Services.AddOther();
builder.Services.AddResponseCaching();
builder.Services.AddControllers()
                      .AddJsonOptions(options =>
                      {
                          options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
                          options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
                      });

builder.Services.AddHttpContextAccessor()
    .AddScoped<ICurrentUser, CurrentUser>()
    .AddSingleton<ICurrentPrincipalAccessor, CurrentPricipalAccessor>();


builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});

builder.Services.AddCors(options => options.AddPolicy(
    name: "CorsPolicy",
    builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()
));

builder.Services.Configure<ApiBehaviorOptions>(options => options.SuppressModelStateInvalidFilter = true);

if (builder.Environment.IsDevelopment())
{
    builder.Services.AddSwagger();
}

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseCors("CorsPolicy");
app.UseHttpsRedirection();
app.UseResponseCaching();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();


using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<DatabaseContext>();
    dataContext.Database.EnsureCreated();

    if(!dataContext.Database.CanConnect())
    {
        dataContext.Database.Migrate();

        var recommendResultService = scope.ServiceProvider.GetRequiredService<IRecommendResultsService>();
        try
        {
            await recommendResultService.TrainPostsModelAsync();
        }
        catch (Exception)
        {

        }
    }
}

string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

var factory = new ConnectionFactory
{
    HostName = hostname,
    UserName = username,
    Password = password,
    VirtualHost = virtualHost,
};
using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "notification",
                     durable: false,
                     exclusive: false,
                     autoDelete: true,
                     arguments: null);

var consumer = new EventingBasicConsumer(channel);

consumer.Received += async (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine(message.ToString());
    var notification = JsonSerializer.Deserialize<NotificationUpsertDto>(message);
    using (var scope = app.Services.CreateScope())
    {
        var notificationsService = scope.ServiceProvider.GetRequiredService<INotificationsService>();

        if (notification != null)
        {
            try
            {
                await notificationsService.AddAsync(notification);
            }
            catch (Exception e)
            {

            }
        }
    }
    Console.WriteLine(Environment.GetEnvironmentVariable("Some"));
};

channel.BasicConsume(queue: "notification",
                     autoAck: true,
                     consumer: consumer);

app.Run();

