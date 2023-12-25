using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class ImagesController : BaseCrudController<ImageDto, ImageUpsertDto, BaseSearchObject, IImagesService>
    {
        public ImagesController(IImagesService service, ILogger<ImagesController> logger) : base(service, logger)
        {
        }
    }
}
