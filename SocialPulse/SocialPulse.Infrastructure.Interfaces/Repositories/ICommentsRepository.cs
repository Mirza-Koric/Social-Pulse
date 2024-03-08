using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface ICommentsRepository : IBaseRepository<Comment, int, CommentSearchObject>
    {
    }
}
