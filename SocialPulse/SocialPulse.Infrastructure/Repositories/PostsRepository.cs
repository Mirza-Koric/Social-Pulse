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
                .Where(p => searchObject.IsAdvert == null || p.IsAdvert == searchObject.IsAdvert)
                .Where(p => searchObject.IsDeleted == null || p.IsDeleted  == searchObject.IsDeleted)
                .Where(p => searchObject.CreatedAt == null ||p.CreatedAt >= searchObject.CreatedAt)
                .OrderByDescending(p => p.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }

        public async Task<PagedList<Post>> GetRandomAsync (PostSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(p => p.Group).Include(p => p.Comments).Include(p => p.Likes).Include(p => p.User).Include(p => p.Images).Include(p => p.Tag)
                .OrderBy(p => Guid.NewGuid()).Take(3)
                .ToPagedListAsync(searchObject, cancellationToken);
        }

        public override async Task<Post> GetByIdAsync (int id, CancellationToken cancellationToken)
        {
            return await DbSet.Include(p=>p.Group).Include(p=>p.Likes).Include(p => p.Comments).Include(p => p.User).Include(p => p.Images).Include(p => p.Tag).FirstOrDefaultAsync(p => p.Id == id);
        }

        public List<Post> GetExceptId(int id)
        {
            return DbSet.Where(p => p.Id != id).ToList();
        }

        
    }
}
