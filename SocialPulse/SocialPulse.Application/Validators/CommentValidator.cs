using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class CommentValidator : AbstractValidator<CommentUpsertDto>
    {
        public CommentValidator()
        {
            RuleFor(c => c.Text).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.PostId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
