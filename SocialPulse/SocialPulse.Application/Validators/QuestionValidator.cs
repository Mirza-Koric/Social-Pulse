using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class QuestionValidator : AbstractValidator<QuestionUpsertDto>
    {
        public QuestionValidator()
        {
            RuleFor(c => c.Text).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
