
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class RecommendResultProfile : BaseProfile
    {
        public RecommendResultProfile()
        {
            CreateMap<RecommendResultDto, RecommendResult>().ReverseMap();

            CreateMap<RecommendResultUpsertDto, RecommendResult>();
        }
    }
}
