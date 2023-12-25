using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class GroupsService : BaseService<Group, GroupDto, GroupUpsertDto, GroupSearchObject, IGroupsRepository>, IGroupsService
    {
        public GroupsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<GroupUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
