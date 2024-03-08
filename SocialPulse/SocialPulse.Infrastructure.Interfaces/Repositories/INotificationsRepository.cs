using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface INotificationsRepository : IBaseRepository<Notification, int, NotificationSearchObject>
    {
    }
}
