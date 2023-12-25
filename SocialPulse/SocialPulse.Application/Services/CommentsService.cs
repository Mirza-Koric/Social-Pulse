using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class CommentsService : BaseService<Comment, CommentDto, CommentUpsertDto, CommentSearchObject, ICommentsRepository>, ICommentsService
    {
        public CommentsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<CommentUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
