using Microsoft.Extensions.DependencyInjection;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IAnswersRepository, AnswersRepository>();
            services.AddScoped<ICommentsRepository, CommentsRepository>();
            services.AddScoped<IConversationsRepository, ConversationsRepository>();
            services.AddScoped<IGroupsRepository, GroupsRepository>();
            services.AddScoped<IImagesRepository, ImagesRepository>();
            services.AddScoped<ILikesRepository, LikesRepository>();
            services.AddScoped<IMessagesRepository, MessagesRepository>();
            services.AddScoped<IPostsRepository, PostsRepository>();
            services.AddScoped<IQuestionsRepository, QuestionsRepository>();
            services.AddScoped<IReportsRepository, ReportsRepository>();
            services.AddScoped<ISubscriptionsRepository, SubscriptionsRepository>();
            services.AddScoped<ITagsRepository, TagsRepository>();
            services.AddScoped<IUserConversationsRepository, UserConversationsRepository>();
            services.AddScoped<IUsersRepository, UsersRepository>();
            services.AddScoped<IRecommendResultsRepository, RecommendResultsRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
        }
    }
}
