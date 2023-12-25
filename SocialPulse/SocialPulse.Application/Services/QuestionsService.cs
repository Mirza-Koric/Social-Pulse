using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class QuestionsService : BaseService<Question, QuestionDto, QuestionUpsertDto, QuestionSearchObject, IQuestionsRepository>, IQuestionsService
    {
        public QuestionsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<QuestionUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
