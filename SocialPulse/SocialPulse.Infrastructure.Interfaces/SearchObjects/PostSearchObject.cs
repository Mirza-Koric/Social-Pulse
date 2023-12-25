using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class PostSearchObject : BaseSearchObject
    {
        public string? Title { get; set; }
        public string? Text { get; set; }
        public int? UserId { get; set; }
        public int? GroupId { get; set; }
        public int? TagId { get; set; }
    }
}
