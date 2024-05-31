using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IPostsRepository : IBaseRepository<Post, int, PostSearchObject>
    {
        public List<Post> GetExceptId(int id);
        public Task<PagedList<Post>> GetRandomAsync(PostSearchObject searchObject, CancellationToken cancellationToken);
    }
}
