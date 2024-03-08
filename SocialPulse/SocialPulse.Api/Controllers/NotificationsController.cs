using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, NotificationUpsertDto, NotificationSearchObject, INotificationsService>
    {
        public NotificationsController(INotificationsService service, ILogger<NotificationsController> logger) : base(service, logger)
        {
        }
    }
}
