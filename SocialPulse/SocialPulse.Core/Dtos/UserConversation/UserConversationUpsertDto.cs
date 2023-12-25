namespace SocialPulse.Core
{
    public class UserConversationUpsertDto : BaseUpsertDto
    {
        public int UserId { get; set; }
        public int ConversationId { get; set; }
    }
}
