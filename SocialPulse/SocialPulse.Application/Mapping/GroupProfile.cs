using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class GroupProfile : BaseProfile
    {
        public GroupProfile()
        {
            CreateMap<GroupDto, Group>().ReverseMap();

            CreateMap<GroupUpsertDto, Group>();
        }
    }
}
