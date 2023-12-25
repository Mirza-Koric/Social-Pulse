using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class GroupsController : BaseCrudController<GroupDto, GroupUpsertDto, GroupSearchObject, IGroupsService>
    {
        public GroupsController(IGroupsService service, ILogger<GroupsController> logger) : base(service, logger)
        {
        }
    }
}
