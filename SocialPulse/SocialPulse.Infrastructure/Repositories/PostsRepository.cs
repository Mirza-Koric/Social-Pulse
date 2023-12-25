using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class PostsRepository : BaseRepository<Post, int, PostSearchObject>, IPostsRepository
    {
        public PostsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
