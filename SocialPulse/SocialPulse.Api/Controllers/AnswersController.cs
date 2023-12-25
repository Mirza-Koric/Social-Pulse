using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class AnswersController : BaseCrudController<AnswerDto, AnswerUpsertDto, AnswerSearchObject, IAnswersService>
    {
        public AnswersController(IAnswersService service, ILogger<AnswersController> logger) : base(service, logger)
        {
        }
    }
}
