namespace SocialPulse.Core
{
    public class Answer : BaseEntity
    {
        public string Text { get; set; } = null!;
        public int AdminId { get; set; }
        public User Admin { get; set; } = null!;
        public int QuestionId { get; set; }
        public Question Question { get; set; } = null!;
    }
}
