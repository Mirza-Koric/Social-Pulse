using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class NotificationsRepository : BaseRepository<Notification, int, NotificationSearchObject>, INotificationsRepository
    {
        public NotificationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Notification>> GetPagedAsync(NotificationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Where(c => searchObject.Title == null || c.Title.ToLower().Contains(searchObject.Title.ToLower()))
                .Where(c => searchObject.UserId == c.UserId || searchObject.UserId == null)
                .OrderByDescending(c => c.Id)
            .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}