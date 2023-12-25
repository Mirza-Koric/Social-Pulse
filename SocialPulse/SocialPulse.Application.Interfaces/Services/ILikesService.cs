using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface ILikesService : IBaseService<int, LikeDto, LikeUpsertDto, BaseSearchObject>
    {
    }
}
