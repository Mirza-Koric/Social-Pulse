using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IAnswersService : IBaseService<int, AnswerDto, AnswerUpsertDto, AnswerSearchObject>
    {
    }
}
