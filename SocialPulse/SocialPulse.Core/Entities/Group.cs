namespace SocialPulse.Core
{
    public class Group : BaseEntity
    {
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
        public ICollection<Post> Posts { get; set; } = null!;
    }
}
