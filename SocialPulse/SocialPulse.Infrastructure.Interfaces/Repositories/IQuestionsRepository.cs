using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IQuestionsRepository : IBaseRepository<Question, int, QuestionSearchObject>
    {
    }
}
