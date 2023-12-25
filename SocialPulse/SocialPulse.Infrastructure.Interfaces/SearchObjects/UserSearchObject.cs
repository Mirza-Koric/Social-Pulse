using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public class UserSearchObject : BaseSearchObject
    {
        public string? Username { get; set; }
        public Role? Role { get; set; }
        public DateTime? BirthDate { get; set; }
    }
}
