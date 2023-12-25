using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IQuestionsService : IBaseService<int, QuestionDto, QuestionUpsertDto, QuestionSearchObject>
    {
    }
}
