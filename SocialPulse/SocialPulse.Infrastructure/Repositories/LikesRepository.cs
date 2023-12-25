using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class LikesRepository : BaseRepository<Like, int, BaseSearchObject>, ILikesRepository
    {
        public LikesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
