using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface ILikesRepository : IBaseRepository<Like, int, LikeSearchObject>
    {
    }
}
