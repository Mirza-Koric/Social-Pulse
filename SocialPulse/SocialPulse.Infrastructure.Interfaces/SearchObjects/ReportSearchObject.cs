using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class ReportSearchObject : BaseSearchObject
    {
        public string? ReportReason { get; set; }
        public int? ReporterId { get; set; }
        public int? ReportedId { get; set; }
    }
}
