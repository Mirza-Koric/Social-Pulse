using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class TagProfile : BaseProfile
    {
        public TagProfile()
        {
            CreateMap<TagDto, Tag>().ReverseMap();

            CreateMap<TagUpsertDto, Tag>();
        }
    }
}
