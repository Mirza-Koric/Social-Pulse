using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IReportsRepository : IBaseRepository<Report, int, ReportSearchObject>
    {
    }
}
