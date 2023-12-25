using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class CommentsRepository : BaseRepository<Comment, int, CommentSearchObject>, ICommentsRepository
    {
        public CommentsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
