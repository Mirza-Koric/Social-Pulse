namespace SocialPulse.Infrastructure.Interfaces
{
    public class SubscriptionSearchObject : BaseSearchObject
    {
        public bool? Active { get; set; }
        public DateTime? ExpirationDate { get; set; }
    }
}
