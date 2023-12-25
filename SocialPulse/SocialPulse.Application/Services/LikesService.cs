using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class LikesService : BaseService<Like, LikeDto, LikeUpsertDto, BaseSearchObject, ILikesRepository>, ILikesService
    {
        public LikesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<LikeUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
