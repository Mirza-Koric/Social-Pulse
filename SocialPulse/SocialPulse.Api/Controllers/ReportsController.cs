using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class ReportsController : BaseCrudController<ReportDto, ReportUpsertDto, ReportSearchObject, IReportsService>
    {
        public ReportsController(IReportsService service, ILogger<ReportsController> logger) : base(service, logger)
        {
        }
    }
}
