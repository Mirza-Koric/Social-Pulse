namespace SocialPulse.Core
{
    public class Message : BaseEntity
    {
        public string Text { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public int ConversationId { get; set; }
        public Conversation Conversation { get; set; } = null!;
        public ICollection<Image> Images { get; set; } = null!;

    }
}
