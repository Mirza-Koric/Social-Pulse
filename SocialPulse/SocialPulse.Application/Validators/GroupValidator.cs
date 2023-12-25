using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class GroupValidator : AbstractValidator<GroupUpsertDto>
    {
        public GroupValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Description).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
