namespace SocialPulse.Core
{
    public class MessageDto : BaseDto
    {
        public string Text { get; set; } = null!;

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
        public int ConversationId { get; set; }
        public ConversationDto Conversation { get; set; } = null!;
        public ICollection<ImageDto> Images { get; set; } = null!;

    }
}
