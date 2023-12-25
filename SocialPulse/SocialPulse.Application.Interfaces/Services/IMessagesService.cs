using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IMessagesService : IBaseService<int, MessageDto, MessageUpsertDto, MessageSearchObject>
    {
    }
}
