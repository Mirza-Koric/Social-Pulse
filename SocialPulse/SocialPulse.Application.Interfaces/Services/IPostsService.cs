using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IPostsService : IBaseService<int, PostDto, PostUpsertDto, PostSearchObject>
    {
        Task<bool> Exists(int postId, CancellationToken cancellationToken);
    }
}
