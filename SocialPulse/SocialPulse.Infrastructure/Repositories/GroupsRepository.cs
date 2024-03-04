using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class GroupsRepository : BaseRepository<Group, int, GroupSearchObject>, IGroupsRepository
    {
        public GroupsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Group>> GetPagedAsync(GroupSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet
                .Where(g => searchObject.Name == null || g.Name.ToLower().Contains(searchObject.Name.ToLower()))
                .Where(g => searchObject.Description == null || g.Description.ToLower().Contains(searchObject.Description.ToLower()))
                .OrderByDescending(p => p.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
