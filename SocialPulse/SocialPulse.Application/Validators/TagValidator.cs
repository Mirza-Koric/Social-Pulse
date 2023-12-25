using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class TagValidator : AbstractValidator<TagUpsertDto>
    {
        public TagValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
