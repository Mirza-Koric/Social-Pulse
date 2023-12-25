using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IGroupsService : IBaseService<int, GroupDto, GroupUpsertDto, GroupSearchObject>
    {
    }
}
