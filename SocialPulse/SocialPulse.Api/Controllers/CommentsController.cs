using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class CommentsController : BaseCrudController<CommentDto, CommentUpsertDto, CommentSearchObject, ICommentsService>
    {
        public CommentsController(ICommentsService service, ILogger<CommentsController> logger) : base(service, logger)
        {
        }
    }
}
