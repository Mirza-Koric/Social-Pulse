using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class ConversationsRepository : BaseRepository<Conversation, int, ConversationSearchObject>, IConversationsRepository
    {
        public ConversationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Conversation>> GetPagedAsync(ConversationSearchObject searchObject, CancellationToken cancellationToken)
        {
            if (searchObject.UserId == null && searchObject.UserId2 == null || searchObject.UserId != null && searchObject.UserId2 != null)
            {
                return await DbSet.Include(c => c.Messages).ThenInclude(c => c.Images).Include(c => c.Users).ThenInclude(c => c.User)
                    .Where(c => searchObject.UserId == null && searchObject.UserId2 == null || c.Users.Any(obj => obj.UserId == searchObject.UserId) && c.Users.Any(obj => obj.UserId == searchObject.UserId2))
                    .ToPagedListAsync(searchObject, cancellationToken);
            }

            return await DbSet.Include(c => c.Messages).ThenInclude(c => c.Images).Include(c => c.Users).ThenInclude(c => c.User)
                .Where(c => c.Users.Any(obj => obj.UserId == searchObject.UserId) || c.Users.Any(obj => obj.UserId == searchObject.UserId2))
                .ToPagedListAsync(searchObject, cancellationToken);
        }

    }
}
