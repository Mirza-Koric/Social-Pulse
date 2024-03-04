namespace SocialPulse.Infrastructure.Interfaces
{
    public class QuestionSearchObject : BaseSearchObject
    {
        public string? Text { get; set; }
        public int? UserId { get; set; }
        public bool? Answered { get; set; }
    }
}
