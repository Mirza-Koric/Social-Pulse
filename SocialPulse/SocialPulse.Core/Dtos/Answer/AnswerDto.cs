namespace SocialPulse.Core
{
    public class AnswerDto : BaseDto
    {
        public string Text { get; set; } = null!;
        public int AdminId { get; set; }
        public UserDto Admin { get; set; } = null!;
        public int QuestionId { get; set; }
        public QuestionDto Question { get; set; } = null!;
    }
}
