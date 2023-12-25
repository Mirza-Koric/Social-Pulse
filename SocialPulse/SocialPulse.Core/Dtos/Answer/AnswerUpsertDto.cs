namespace SocialPulse.Core
{
    public class AnswerUpsertDto: BaseUpsertDto
    {
        public string Text { get; set; } = null!;
        public int AdminId { get; set; }
        public int QuestionId { get; set; }
    }
}
