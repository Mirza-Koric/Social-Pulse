using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class MessagesService : BaseService<Message, MessageDto, MessageUpsertDto, MessageSearchObject, IMessagesRepository>, IMessagesService
    {
        public MessagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<MessageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
