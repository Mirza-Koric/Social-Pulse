namespace SocialPulse.Core
{
    public class UserConversationDto : BaseDto
    {
        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
        public int ConversationId { get; set; }
        public ConversationDto Conversation { get; set; } = null!;
    }
}
