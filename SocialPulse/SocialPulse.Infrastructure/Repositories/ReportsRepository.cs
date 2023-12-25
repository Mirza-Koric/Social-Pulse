using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class ReportsRepository : BaseRepository<Report, int, ReportSearchObject>, IReportsRepository
    {
        public ReportsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
