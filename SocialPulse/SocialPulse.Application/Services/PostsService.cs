using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class PostsService : BaseService<Post, PostDto, PostUpsertDto, PostSearchObject, IPostsRepository>, IPostsService
    {
        public PostsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PostUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public async Task<bool> Exists(int postId, CancellationToken cancellationToken)
        {
            var book = await CurrentRepository.GetByIdAsync(postId, cancellationToken);

            if (book == null)
                return false;
            return true;
        }
    }
}
