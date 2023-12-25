using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class MessageSearchObject : BaseSearchObject
    {
        public string? Text { get; set; }
        public int? UserId { get; set; }
        public int? ConversationId { get; set; }
    }
}
