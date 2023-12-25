using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class MessageProfile : BaseProfile
    {
        public MessageProfile()
        {
            CreateMap<MessageDto, Message>().ReverseMap();

            CreateMap<MessageUpsertDto, Message>();
        }
    }
}
