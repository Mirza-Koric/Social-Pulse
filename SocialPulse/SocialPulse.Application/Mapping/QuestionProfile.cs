using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class QuestionProfile : BaseProfile
    {
        public QuestionProfile()
        {
            CreateMap<QuestionDto, Question>().ReverseMap();

            CreateMap<QuestionUpsertDto, Question>();
        }
    }
}
