using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface ICommentsService : IBaseService<int, CommentDto, CommentUpsertDto, CommentSearchObject>
    {
    }
}
