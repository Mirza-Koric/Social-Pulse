using Microsoft.AspNetCore.Mvc;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using System.Threading;

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

        [HttpGet("GetRandom")]
        public async Task<IActionResult> GetRandom ([FromQuery] PostSearchObject searchObject, CancellationToken cancellationToken)
        {
            try
            {
                var dto = await Service.GetRandomAsync(searchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting paged resources for page number {0}, with page size {1}", searchObject.PageNumber, searchObject.PageSize);
                return BadRequest();
            }
        }
    }
}
