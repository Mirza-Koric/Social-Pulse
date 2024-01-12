namespace SocialPulse.Core
{
    public class CommentDto : BaseDto
    {
        public string Text { get; set; } = null!;

        public int PostId { get; set; }
        public PostDto Post { get; set; } = null!;
        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
