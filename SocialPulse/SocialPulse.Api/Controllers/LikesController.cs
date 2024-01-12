using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class LikesController : BaseCrudController<LikeDto, LikeUpsertDto, LikeSearchObject, ILikesService>
    {
        public LikesController(ILikesService service, ILogger<LikesController> logger) : base(service, logger)
        {
        }
    }
}
