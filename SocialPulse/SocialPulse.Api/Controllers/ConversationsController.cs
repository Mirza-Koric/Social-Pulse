using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class ConversationsController : BaseCrudController<ConversationDto, ConversationUpsertDto, BaseSearchObject, IConversationsService>
    {
        public ConversationsController(IConversationsService service, ILogger<ConversationsController> logger) : base(service, logger)
        {
        }
    }
}
