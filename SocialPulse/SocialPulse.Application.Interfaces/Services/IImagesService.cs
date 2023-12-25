using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IImagesService : IBaseService<int, ImageDto, ImageUpsertDto, BaseSearchObject>
    {
    }
}
