using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class UserConversationProfile : BaseProfile
    {
        public UserConversationProfile()
        {
            CreateMap<UserConversationDto, UserConversation>().ReverseMap();

            CreateMap<UserConversationUpsertDto, UserConversation>();
        }
    }
}
