using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IAnswersRepository : IBaseRepository<Answer, int, AnswerSearchObject>
    {
    }
}