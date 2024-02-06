using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class ConversationsService : BaseService<Conversation, ConversationDto, ConversationUpsertDto, ConversationSearchObject, IConversationsRepository>, IConversationsService
    {
        public ConversationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ConversationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
