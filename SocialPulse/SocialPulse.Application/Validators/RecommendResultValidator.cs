using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class RecommendResultValidator : AbstractValidator<RecommendResultUpsertDto>
    {
        public RecommendResultValidator()
        {
            RuleFor(u => u.PostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.FirstCopostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(u => u.SecondCopostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ThirdCopostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
