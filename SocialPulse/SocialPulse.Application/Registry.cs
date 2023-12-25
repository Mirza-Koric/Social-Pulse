using FluentValidation;
using Microsoft.Extensions.DependencyInjection;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public static class Registry
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IAnswersService,AnswersService>();
            services.AddScoped<ICommentsService, CommentsService>();
            services.AddScoped<IConversationsService, ConversationsService>();
            services.AddScoped<IGroupsService, GroupsService>();
            services.AddScoped<IImagesService, ImagesService>();
            services.AddScoped<ILikesService, LikesService>();
            services.AddScoped<IMessagesService, MessagesService>();
            services.AddScoped<IPostsService, PostsService>();
            services.AddScoped<IQuestionsService, QuestionsService>();
            services.AddScoped<IReportsService, ReportsService>();
            services.AddScoped<ISubscriptionsService, SubscriptionsService>();
            services.AddScoped<ITagsService,TagsService>();
            services.AddScoped<IUserConversationsService, UserConversationsService>();
            services.AddScoped<IUsersService, UsersService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<AnswerUpsertDto>,AnswerValidator>();
            services.AddScoped<IValidator<CommentUpsertDto>, CommentValidator>();
            services.AddScoped<IValidator<ConversationUpsertDto>, ConversationValidator>();
            services.AddScoped<IValidator<GroupUpsertDto>, GroupValidator>();
            services.AddScoped<IValidator<ImageUpsertDto>, ImageValidator>();
            services.AddScoped<IValidator<LikeUpsertDto>, LikeValidator>();
            services.AddScoped<IValidator<MessageUpsertDto>, MessageValidator>();
            services.AddScoped<IValidator<PostUpsertDto>, PostValidator>();
            services.AddScoped<IValidator<QuestionUpsertDto>, QuestionValidator>();
            services.AddScoped<IValidator<ReportUpsertDto>, ReportValidator>();
            services.AddScoped<IValidator<SubscriptionUpsertDto>, SubscriptionValidator>();
            services.AddScoped<IValidator<TagUpsertDto>,TagValidator>();
            services.AddScoped<IValidator<UserConversationUpsertDto>, UserConversationValidator>();
            services.AddScoped<IValidator<UserUpsertDto>,UserValidator>();
        }
    }
}
