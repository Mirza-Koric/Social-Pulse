using Microsoft.AspNetCore.Mvc;
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

        [HttpGet("Exists/{postId}")]
        public virtual async Task<IActionResult> Exists(int postId, CancellationToken cancellationToken = default)
        {
            try
            {
                var exist = await Service.Exists(postId, cancellationToken);
                return Ok(exist);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error ", postId);
                return BadRequest();
            }
        }
    }
}
