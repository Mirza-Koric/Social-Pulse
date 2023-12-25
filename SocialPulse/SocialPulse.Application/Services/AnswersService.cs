using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class AnswersService : BaseService<Answer, AnswerDto, AnswerUpsertDto, AnswerSearchObject, IAnswersRepository>, IAnswersService
    {
        public AnswersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AnswerUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
