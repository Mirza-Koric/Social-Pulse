namespace SocialPulse.Core
{
    public class LikeDto : BaseDto
    {
        public bool Type { get; set; }

        public int PostId { get; set; }
        public PostDto Post { get; set; } = null!;
        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
