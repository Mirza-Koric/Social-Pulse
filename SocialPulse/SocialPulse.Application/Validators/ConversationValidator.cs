using FluentValidation;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ConversationValidator : AbstractValidator<ConversationUpsertDto>
    {
        public ConversationValidator()
        {
        }
    }
}
