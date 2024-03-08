namespace SocialPulse.Core
{
    public class NotificationDto : BaseDto
    {
        public string Title { get; set; } = null!;
        public string? Content { get; set; }

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
