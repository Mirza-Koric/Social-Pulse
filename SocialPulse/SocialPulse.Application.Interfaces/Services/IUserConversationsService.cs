using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IUserConversationsService : IBaseService<int, UserConversationDto, UserConversationUpsertDto, BaseSearchObject>
    {
    }
}
