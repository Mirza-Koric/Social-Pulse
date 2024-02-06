using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class UserConversationsController : BaseCrudController<UserConversationDto, UserConversationUpsertDto, UserConversationSearchObject, IUserConversationsService>
    {
        public UserConversationsController(IUserConversationsService service, ILogger<UserConversationsController> logger) : base(service, logger)
        {
        }
    }
}
