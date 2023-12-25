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
    }
}
