namespace SocialPulse.Core
{
    public class MessageUpsertDto : BaseUpsertDto
    {
        public string Text { get; set; } = null!;

        public int UserId { get; set; }
        public int ConversationId { get; set; }
    }
}
