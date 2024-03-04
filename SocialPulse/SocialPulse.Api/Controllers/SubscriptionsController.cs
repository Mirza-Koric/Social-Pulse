using Microsoft.AspNetCore.Mvc;
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

        [HttpPut("PaySubscription")]
        public async Task<IActionResult> PaySubscription([FromQuery] int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.PaySubscriptionAsync(userId, cancellationToken);
                return Ok("Premium account successfully activated");
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem when paying for premium account");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }
    }
}
