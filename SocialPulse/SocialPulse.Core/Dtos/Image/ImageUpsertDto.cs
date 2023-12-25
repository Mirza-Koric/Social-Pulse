namespace SocialPulse.Core
{
    public class ImageUpsertDto : BaseUpsertDto
    {
        public byte[] Data { get; set; } = null!;
        public string ContentType { get; set; } = null!;

        public int? PostId { get; set; }
        public int? MessageId { get; set; }
    }
}
