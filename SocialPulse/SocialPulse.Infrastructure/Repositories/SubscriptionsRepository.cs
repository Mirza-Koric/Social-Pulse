using Microsoft.EntityFrameworkCore;
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

        public async Task<Subscription?> GetByUserIdAsync(int userId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(s => s.UserId == userId, cancellationToken);
        }

        public override async Task<PagedList<Subscription>> GetPagedAsync (SubscriptionSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Where(s => searchObject.Active == null || s.Active == searchObject.Active)
                .Where(p => searchObject.IsDeleted == null || p.IsDeleted == searchObject.IsDeleted)
                .Where(p => searchObject.CreatedAt == null || p.CreatedAt >= searchObject.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
