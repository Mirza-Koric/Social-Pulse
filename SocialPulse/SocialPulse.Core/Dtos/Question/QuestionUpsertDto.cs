namespace SocialPulse.Core
{
    public class QuestionUpsertDto : BaseUpsertDto
    {
        public string Text { get; set; } = null!;
        public int UserId { get; set; }
    }
}
