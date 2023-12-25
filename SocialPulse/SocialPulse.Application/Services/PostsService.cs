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
    }
}
