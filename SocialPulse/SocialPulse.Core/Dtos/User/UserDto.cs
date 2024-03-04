namespace SocialPulse.Core
{
    public class UserDto : BaseDto
    {
        public string Email { get; set; } = null!;
        public string Username { get; set; } = null!;
        public Role Role { get; set; }
        public DateTime BirthDate { get; set; }
        public SubscriptionDto Subscription { get; set; } = null!;

    }
}
