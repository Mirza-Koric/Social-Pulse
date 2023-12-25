using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class SubscriptionsRepository : BaseRepository<Subscription, int, SubscriptionSearchObject>, ISubscriptionsRepository
    {
        public SubscriptionsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
