using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface ISubscriptionsRepository : IBaseRepository<Subscription, int, SubscriptionSearchObject>
    {
        public interface ISubscriptionsRepository : IBaseRepository<Subscription, int, SubscriptionSearchObject>
        {
        }

        Task<Subscription?> GetByUserIdAsync(int userId, CancellationToken cancellationToken = default);
    }
}
