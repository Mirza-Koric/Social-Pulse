namespace SocialPulse.Core
{
    public class RecommendResultDto : BaseDto
    {
        public int PostId { get; set; }
        public int FirstCopostId { get; set; }
        public int SecondCopostId { get; set; }
        public int ThirdCopostId { get; set; }
    }
}
