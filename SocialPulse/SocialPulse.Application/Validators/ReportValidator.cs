using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ReportValidator : AbstractValidator<ReportUpsertDto>
    {
        public ReportValidator()
        {
            RuleFor(c => c.ReportReason).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.ReporterId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ReportedId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
