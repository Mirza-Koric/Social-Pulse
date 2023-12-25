using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class ConversationsRepository : BaseRepository<Conversation, int, BaseSearchObject>, IConversationsRepository
    {
        public ConversationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
