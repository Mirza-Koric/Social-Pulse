using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class SubscriptionsController : BaseCrudController<SubscriptionDto, SubscriptionUpsertDto, SubscriptionSearchObject, ISubscriptionsService>
    {
        public SubscriptionsController(ISubscriptionsService service, ILogger<SubscriptionsController> logger) : base(service, logger)
        {
        }
    }
}
