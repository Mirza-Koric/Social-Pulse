using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class UserConversationsRepository : BaseRepository<UserConversation, int, BaseSearchObject>, IUserConversationsRepository
    {
        public UserConversationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
