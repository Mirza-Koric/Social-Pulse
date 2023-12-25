using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class PostsController : BaseCrudController<PostDto, PostUpsertDto, PostSearchObject, IPostsService>
    {
        public PostsController(IPostsService service, ILogger<PostsController> logger) : base(service, logger)
        {
        }
    }
}
