using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class LikeValidator : AbstractValidator<LikeUpsertDto>
    {
        public LikeValidator()
        {
            RuleFor(c => c.Type).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.PostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
