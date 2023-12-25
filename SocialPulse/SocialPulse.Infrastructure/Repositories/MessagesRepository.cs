using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class MessagesRepository : BaseRepository<Message, int, MessageSearchObject>, IMessagesRepository
    {
        public MessagesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
