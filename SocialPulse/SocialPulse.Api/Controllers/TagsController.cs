using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class TagsController : BaseCrudController<TagDto, TagUpsertDto, TagSearchObject, ITagsService>
    {
        public TagsController(ITagsService service, ILogger<TagsController> logger) : base(service, logger)
        {
        }
    }
}
