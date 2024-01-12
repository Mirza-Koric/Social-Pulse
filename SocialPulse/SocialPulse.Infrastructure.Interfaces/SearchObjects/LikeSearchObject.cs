using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class LikeSearchObject : BaseSearchObject
    {
        public bool? Type { get; set; }
        public int? UserId { get; set; }
        public int? PostId { get; set; }
    }
}
