using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class LikesService : BaseService<Like, LikeDto, LikeUpsertDto, LikeSearchObject, ILikesRepository>, ILikesService
    {
        public LikesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<LikeUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public override async Task RemoveByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            await CurrentRepository.RemoveByIdAsync(id, false, cancellationToken);
        }
    }
}
