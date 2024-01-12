using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class LikesRepository : BaseRepository<Like, int, LikeSearchObject>, ILikesRepository
    {
        public LikesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Like>> GetPagedAsync(LikeSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet
                .Where(p => searchObject.Type == null || p.Type==searchObject.Type)
                .Where(p => searchObject.UserId == null || p.UserId == searchObject.UserId)
                .Where(p => searchObject.PostId == null || p.PostId == searchObject.PostId)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
