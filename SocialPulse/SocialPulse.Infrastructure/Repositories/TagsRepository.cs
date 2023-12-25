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
    }
}
