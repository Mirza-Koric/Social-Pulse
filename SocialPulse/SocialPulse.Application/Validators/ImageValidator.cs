using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ImageValidator : AbstractValidator<ImageUpsertDto>
    {
        public ImageValidator()
        {
            RuleFor(c => c.ContentType).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Data).NotNull().WithErrorCode(ErrorCodes.NotNull);

            RuleFor(c => c.PostId)
                .Must((model, PostId) => IsMutuallyExclusive(PostId, model.MessageId))
                .WithMessage("Image cannot belong to post and message simultaneously.");

            RuleFor(c => c.MessageId)
                .Must((model, MessageId) => IsMutuallyExclusive(MessageId, model.PostId))
                .WithMessage("Image cannot belong to post and message simultaneously.");
        }

        private bool IsMutuallyExclusive(int? value1, int? value2)
        {
            return (value1.HasValue && !value2.HasValue) || (!value1.HasValue && value2.HasValue);
        }
    }
}
