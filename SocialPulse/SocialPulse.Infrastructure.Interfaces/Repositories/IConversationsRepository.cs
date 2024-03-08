using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IConversationsRepository : IBaseRepository<Conversation, int, ConversationSearchObject>
    {
    }
}
