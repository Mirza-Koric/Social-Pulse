namespace SocialPulse.Core
{
    public class Post : BaseEntity
    {
        public string Title { get; set; } = null!;
        public string Text { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public int GroupId { get; set; }
        public Group Group { get; set; } = null!;
        public int? TagId { get; set; }
        public Tag Tag { get; set; } = null!;

        public ICollection<Image> Images { get; set; } = null!;
        public ICollection<Comment> Comments { get; set; } = null!;
        public ICollection<Like> Likes { get; set; } = null!;
    }
}
