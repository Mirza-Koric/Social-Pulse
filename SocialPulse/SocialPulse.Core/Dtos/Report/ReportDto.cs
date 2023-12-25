namespace SocialPulse.Core
{
    public class ReportDto : BaseDto
    {
        public string ReportReason { get; set; } = null!;

        public int ReporterId { get; set; }
        public User Reporter { get; set; } = null!;
        public int ReportedId { get; set; }
        public User Reported { get; set; } = null!;
    }
}
