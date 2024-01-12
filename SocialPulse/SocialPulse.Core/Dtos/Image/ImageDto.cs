namespace SocialPulse.Core
{
    public class ImageDto : BaseDto
    {
        public byte[] Data { get; set; } = null!;
        public string ContentType { get; set; } = null!;

        public int? PostId { get; set; }
        public PostDto? Post { get; set; }
        public int? MessageId { get; set; }
        public MessageDto? Message { get; set; }
    }
}
