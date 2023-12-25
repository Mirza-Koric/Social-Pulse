namespace SocialPulse.Core
{
    public class CommentUpsertDto: BaseUpsertDto
    {
        public string Text { get; set; } = null!;

        public int PostId { get; set; }
        public int UserId { get; set; }
    }
}
