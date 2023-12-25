using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ReportProfile : BaseProfile
    {
        public ReportProfile()
        {
            CreateMap<ReportDto, Report>().ReverseMap();

            CreateMap<ReportUpsertDto, Report>();
        }
    }
}
