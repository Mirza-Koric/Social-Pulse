namespace SocialPulse.Core
{
    public class Notification : BaseEntity
    {
        public string Title { get; set; } = null!;
        public string? Content { get; set; }

        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
