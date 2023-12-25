namespace SocialPulse.Core
{
    public class CommentDto : BaseDto
    {
        public string Text { get; set; } = null!;

        public int PostId { get; set; }
        public Post Post { get; set; } = null!;
        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
