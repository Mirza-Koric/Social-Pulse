using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ConversationProfile : BaseProfile
    {
        public ConversationProfile()
        {
            CreateMap<ConversationDto, Conversation>().ReverseMap();

            CreateMap<ConversationUpsertDto, Conversation>();
        }
    }
}
