using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class CommentSearchObject : BaseSearchObject
    {
        public string? Text { get; set; }
        public int? PostId { get; set; }
        public int? UserId { get; set; }
    }
}
