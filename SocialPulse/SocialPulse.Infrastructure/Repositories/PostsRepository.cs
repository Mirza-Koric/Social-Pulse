using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class PostsRepository : BaseRepository<Post, int, PostSearchObject>, IPostsRepository
    {
        public PostsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Post>> GetPagedAsync(PostSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(p => p.Group).Include(p => p.Comments).Include(p => p.Likes).Include(p=>p.User).Include(p=>p.Images).Include(p=>p.Tag)
                .Where(p => searchObject.Title == null || p.Title.ToLower().Contains(searchObject.Title.ToLower()))
                .Where(p => searchObject.Text == null || p.Text.ToLower().Contains(searchObject.Text.ToLower()))
                .Where(p => searchObject.UserId == null || p.UserId == searchObject.UserId)
                .Where(p => searchObject.GroupId == null || p.GroupId == searchObject.GroupId)
                .Where(p => searchObject.TagId == null || p.TagId == searchObject.TagId)
                .OrderByDescending(p => p.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
