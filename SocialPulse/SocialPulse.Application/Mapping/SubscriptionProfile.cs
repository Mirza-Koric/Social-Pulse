using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class SubscriptionProfile : BaseProfile
    {
        public SubscriptionProfile()
        {
            CreateMap<SubscriptionDto, Subscription>().ReverseMap();

            CreateMap<SubscriptionUpsertDto, Subscription>();
        }
    }
}
