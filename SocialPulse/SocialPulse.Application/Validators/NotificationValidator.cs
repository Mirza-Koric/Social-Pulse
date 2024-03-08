using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class NotificationValidator : AbstractValidator<NotificationUpsertDto>
    {
        public NotificationValidator()
        {
            RuleFor(u => u.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
