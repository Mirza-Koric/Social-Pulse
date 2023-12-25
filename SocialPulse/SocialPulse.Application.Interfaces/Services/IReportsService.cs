using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IReportsService : IBaseService<int, ReportDto, ReportUpsertDto, ReportSearchObject>
    {
    }
}
