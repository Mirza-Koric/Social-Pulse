namespace SocialPulse.Core
{
    public class QuestionDto : BaseDto
    {
        public string Text { get; set; } = null!;
        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
