using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IConversationsService : IBaseService<int, ConversationDto, ConversationUpsertDto, ConversationSearchObject>
    {
    }
}
