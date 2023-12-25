using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class AnswerProfile : BaseProfile
    {
        public AnswerProfile()
        {
            CreateMap<AnswerDto, Answer>().ReverseMap();

            CreateMap<AnswerUpsertDto, Answer>();
        }
    }
}
