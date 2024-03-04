namespace SocialPulse.Core
{
    public class PostDto : BaseDto
    {
        public string Title { get; set; } = null!;
        public string Text { get; set; } = null!;
        public bool IsAdvert { get; set; }

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
        public int GroupId { get; set; }
        public GroupDto Group { get; set; } = null!;
        public int? TagId { get; set; }
        public TagDto Tag { get; set; } = null!;

        public ICollection<CommentDto> Comments { get; set; } = null!;
        public ICollection<LikeDto> Likes { get; set; } = null!;
        public ICollection<ImageDto> Images { get; set; } = null!;
    }
}
