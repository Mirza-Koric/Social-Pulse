using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class SubscriptionValidator : AbstractValidator<SubscriptionUpsertDto>
    {
        public SubscriptionValidator()
        {
            RuleFor(c => c.Active).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ExpirationDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
