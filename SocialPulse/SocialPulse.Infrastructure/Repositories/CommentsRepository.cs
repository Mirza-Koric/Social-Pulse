using Microsoft.EntityFrameworkCore;
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

        public override async Task<PagedList<Comment>> GetPagedAsync(CommentSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(c => c.User).Include(c => c.Post)
                .Where(c => searchObject.Text == null || c.Text.ToLower().Contains(searchObject.Text.ToLower()))
                .Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                .Where(c => searchObject.PostId == null || c.PostId == searchObject.PostId)
                .Where(p => searchObject.IsDeleted == null || p.IsDeleted == searchObject.IsDeleted)
                .Where(p => searchObject.CreatedAt == null || p.CreatedAt >= searchObject.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
