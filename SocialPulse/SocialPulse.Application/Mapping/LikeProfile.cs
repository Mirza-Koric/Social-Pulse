using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class LikeProfile : BaseProfile
    {
        public LikeProfile()
        {
            CreateMap<LikeDto, Like>().ReverseMap();

            CreateMap<LikeUpsertDto, Like>();
        }
    }
}
