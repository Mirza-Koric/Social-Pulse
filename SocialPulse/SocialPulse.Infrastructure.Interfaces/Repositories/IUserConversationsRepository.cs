using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IUserConversationsRepository : IBaseRepository<UserConversation, int, UserConversationSearchObject>
    {
    }
}
