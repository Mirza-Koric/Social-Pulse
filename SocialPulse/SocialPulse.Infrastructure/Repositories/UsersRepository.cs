using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class UsersRepository : BaseRepository<User, int, UserSearchObject>, IUsersRepository
    {
        public UsersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(u => u.Email == email, cancellationToken);
        }

        public override async Task<PagedList<User>> GetPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(u => u.Subscription)
                .Where(p => searchObject.Username == null || p.Username.ToLower().Contains(searchObject.Username))
                .Where(p => searchObject.Role == null || p.Role == searchObject.Role)
                .Where(p => searchObject.Subscribed == null || (searchObject.Subscribed==true ? p.Subscription.Active==true : p.Subscription==null || p.Subscription.Active == false))
                .Where(p => searchObject.IsDeleted == null || p.IsDeleted == searchObject.IsDeleted)
                .Where(p => searchObject.CreatedAt == null || p.CreatedAt >= searchObject.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }

        public List<User> UsersWhoLikedPosts()
        {
            return DbSet.Include(u => u.Likes.Where(l => l.Type==true)).Where(u => u.Role == Role.User).ToList();
        }

        public override async Task<User> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(u => u.Subscription).FirstOrDefaultAsync(u => u.Id == id);
               
        }
    }
}
