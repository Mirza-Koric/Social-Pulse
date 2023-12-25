using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class AnswerValidator : AbstractValidator<AnswerUpsertDto>
    {
        public AnswerValidator()
        {
            RuleFor(c => c.Text).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.AdminId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.QuestionId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
