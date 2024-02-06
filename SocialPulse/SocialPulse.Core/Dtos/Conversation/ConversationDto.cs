namespace SocialPulse.Core
{
    public class ConversationDto : BaseDto
    {
        public ICollection<MessageDto> Messages { get; set; } = null!;
        public ICollection<UserConversationDto> Users { get; set; } = null!;
    }
}
