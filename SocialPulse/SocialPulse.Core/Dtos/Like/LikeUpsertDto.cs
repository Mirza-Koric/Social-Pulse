namespace SocialPulse.Core
{
    public class LikeUpsertDto : BaseUpsertDto
    {
        public bool Type { get; set; }

        public int PostId { get; set; }
        public int UserId { get; set; }
    }
}
