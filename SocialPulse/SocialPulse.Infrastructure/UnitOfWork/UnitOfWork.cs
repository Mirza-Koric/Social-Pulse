using Microsoft.EntityFrameworkCore.Storage;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly DatabaseContext _databaseContext;

        public readonly IAnswersRepository AnswersRepository;
        public readonly ICommentsRepository CommentsRepository;
        public readonly IConversationsRepository ConversationsRepository;
        public readonly IGroupsRepository GroupsRepository;
        public readonly IImagesRepository ImagesRepository;
        public readonly ILikesRepository LikesRepository;
        public readonly IMessagesRepository MessagesRepository;
        public readonly IPostsRepository PostsRepository;
        public readonly IQuestionsRepository QuestionsRepository;
        public readonly IReportsRepository ReportsRepository;
        public readonly ISubscriptionsRepository SubscriptionsRepository;
        public readonly ITagsRepository TagsRepository;
        public readonly IUserConversationsRepository UserConversationsRepository;
        public readonly IUsersRepository UsersRepository;
        public readonly IRecommendResultsRepository RecommendResultsRepository;
        public readonly INotificationsRepository NotificationsRepository;

        public UnitOfWork(
            DatabaseContext databaseContext,
            IAnswersRepository answersRepository, 
            ICommentsRepository commentsRepository,
            IConversationsRepository conversationsRepository,
            IGroupsRepository groupsRepository,
            IImagesRepository imagesRepository,
            ILikesRepository likesRepository,
            IMessagesRepository messagesRepository,
            IPostsRepository postsRepository,
            IQuestionsRepository questionsRepository,
            IReportsRepository reportsRepository,
            ISubscriptionsRepository subscriptionsRepository,
            ITagsRepository tagsRepository,
            IUserConversationsRepository userConversationsRepository,
            IUsersRepository usersRepository,
            IRecommendResultsRepository recommendResultsRepository,
            INotificationsRepository notificationsRepository)
        {
            _databaseContext = databaseContext;

            AnswersRepository = answersRepository;
            CommentsRepository = commentsRepository;
            ConversationsRepository = conversationsRepository;
            GroupsRepository = groupsRepository;
            ImagesRepository = imagesRepository;
            LikesRepository = likesRepository;
            MessagesRepository = messagesRepository;
            PostsRepository = postsRepository;
            QuestionsRepository = questionsRepository;
            ReportsRepository = reportsRepository;
            SubscriptionsRepository = subscriptionsRepository;
            TagsRepository = tagsRepository;
            UserConversationsRepository = userConversationsRepository;
            UsersRepository = usersRepository;
            RecommendResultsRepository = recommendResultsRepository;
            NotificationsRepository = notificationsRepository;
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.Database.BeginTransactionAsync(cancellationToken);
        }

        public async Task CommitTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.CommitTransactionAsync(cancellationToken);
        }

        public async Task RollbackTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.RollbackTransactionAsync(cancellationToken);
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.SaveChangesAsync(cancellationToken);
        }
    }
}
