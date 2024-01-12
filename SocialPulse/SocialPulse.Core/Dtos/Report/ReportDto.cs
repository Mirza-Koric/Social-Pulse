namespace SocialPulse.Core
{
    public class ReportDto : BaseDto
    {
        public string ReportReason { get; set; } = null!;

        public int ReporterId { get; set; }
        public UserDto Reporter { get; set; } = null!;
        public int ReportedId { get; set; }
        public UserDto Reported { get; set; } = null!;
    }
}
