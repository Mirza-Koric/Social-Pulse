using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class TagsRepository : BaseRepository<Tag, int, TagSearchObject>, ITagsRepository
    {
        public TagsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Tag>> GetPagedAsync(TagSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet
                .Where(g => searchObject.Name == null || g.Name.ToLower().Contains(searchObject.Name.ToLower()))
                .OrderByDescending(p => p.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
