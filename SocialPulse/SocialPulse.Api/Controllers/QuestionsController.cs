using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class QuestionsController : BaseCrudController<QuestionDto, QuestionUpsertDto, QuestionSearchObject, IQuestionsService>
    {
        public QuestionsController(IQuestionsService service, ILogger<QuestionsController> logger) : base(service, logger)
        {
        }
    }
}
