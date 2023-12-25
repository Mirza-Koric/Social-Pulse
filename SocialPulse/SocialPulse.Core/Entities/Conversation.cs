namespace SocialPulse.Core
{
    public class Conversation : BaseEntity
    {
        public ICollection<Message> Messages { get; set; } = null!;
        public ICollection<UserConversation> Users { get; set; } = null!;

    }
}
