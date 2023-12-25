namespace SocialPulse.Core
{
    public class UserConversation : BaseEntity
    {
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public int ConversationId { get; set; }
        public Conversation Conversation { get; set; } = null!;
    }
}
