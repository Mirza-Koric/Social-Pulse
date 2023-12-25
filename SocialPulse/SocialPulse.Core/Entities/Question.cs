namespace SocialPulse.Core
{
    public class Question : BaseEntity
    {
        public string Text { get; set; } = null!;
        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public Answer? Answer { get; set; }
    }
}
