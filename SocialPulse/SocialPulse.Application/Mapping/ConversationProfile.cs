using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ConversationProfile : BaseProfile
    {
        public ConversationProfile()
        {
            CreateMap<ConversationDto, Conversation>().ReverseMap();

            CreateMap<ConversationUpsertDto, Conversation>()
                .ForMember(c => c.Users, opt => opt.MapFrom(src => src.Users));
        }
    }
}
