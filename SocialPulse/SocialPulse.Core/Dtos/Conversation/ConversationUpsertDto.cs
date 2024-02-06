namespace SocialPulse.Core
{
    public class ConversationUpsertDto : BaseUpsertDto
    {
        public ICollection<UserConversationUpsertDto> Users { get; set; } = null!;
    }
}
