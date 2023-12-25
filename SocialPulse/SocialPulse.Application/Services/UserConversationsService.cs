using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class UserConversationsService : BaseService<UserConversation, UserConversationDto, UserConversationUpsertDto, BaseSearchObject, IUserConversationsRepository>, IUserConversationsService
    {
        public UserConversationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserConversationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
