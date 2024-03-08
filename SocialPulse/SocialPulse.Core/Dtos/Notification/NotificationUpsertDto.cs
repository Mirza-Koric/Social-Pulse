namespace SocialPulse.Core
{
    public class NotificationUpsertDto : BaseUpsertDto
    {
        public string Title { get; set; } = null!;
        public string? Content { get; set; }

        public int UserId { get; set; }
    }
}
