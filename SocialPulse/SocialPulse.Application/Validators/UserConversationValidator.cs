using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class UserConversationValidator : AbstractValidator<UserConversationUpsertDto>
    {
        public UserConversationValidator()
        {
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ConversationId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
