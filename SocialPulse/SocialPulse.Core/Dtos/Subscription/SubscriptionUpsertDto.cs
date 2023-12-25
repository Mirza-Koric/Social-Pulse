namespace SocialPulse.Core
{
    public class SubscriptionUpsertDto : BaseUpsertDto
    {
        public int UserId { get; set; }
        public bool Active { get; set; }
        public DateTime ExpirationDate { get; set; }
    }
}
