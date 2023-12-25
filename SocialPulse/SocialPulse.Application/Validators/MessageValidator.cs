using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class MessageValidator : AbstractValidator<MessageUpsertDto>
    {
        public MessageValidator()
        {
            RuleFor(c => c.Text).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ConversationId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
