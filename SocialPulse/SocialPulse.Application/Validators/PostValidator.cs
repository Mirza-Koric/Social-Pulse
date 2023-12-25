using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class PostValidator : AbstractValidator<PostUpsertDto>
    {
        public PostValidator()
        {
            RuleFor(c => c.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Text).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.GroupId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.TagId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
