namespace SocialPulse.Core
{
    public class ReportUpsertDto : BaseUpsertDto
    {
        public string ReportReason { get; set; } = null!;

        public int ReporterId { get; set; }
        public int ReportedId { get; set; }
    }
}
