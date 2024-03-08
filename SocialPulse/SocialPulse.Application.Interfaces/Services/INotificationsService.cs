using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface INotificationsService : IBaseService<int, NotificationDto, NotificationUpsertDto, NotificationSearchObject>
    {
    }
}
