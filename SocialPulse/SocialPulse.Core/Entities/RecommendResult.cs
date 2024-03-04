namespace SocialPulse.Core
{
    public class RecommendResult : BaseEntity
    {
        public int PostId { get; set; }
        public int FirstCopostId { get; set; }
        public int SecondCopostId { get; set; }
        public int ThirdCopostId { get; set; }
    }
}
