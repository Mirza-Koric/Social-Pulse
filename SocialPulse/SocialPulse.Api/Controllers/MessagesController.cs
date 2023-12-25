using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class MessagesController : BaseCrudController<MessageDto, MessageUpsertDto, MessageSearchObject, IMessagesService>
    {
        public MessagesController(IMessagesService service, ILogger<MessagesController> logger) : base(service, logger)
        {
        }
    }
}
