using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface ISubscriptionsService : IBaseService<int, SubscriptionDto, SubscriptionUpsertDto, SubscriptionSearchObject>
    {
    }
}
