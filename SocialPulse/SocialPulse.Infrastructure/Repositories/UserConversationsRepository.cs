using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class UserConversationsRepository : BaseRepository<UserConversation, int, UserConversationSearchObject>, IUserConversationsRepository
    {
        public UserConversationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<UserConversation>> GetPagedAsync(UserConversationSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(c => c.Conversation).ThenInclude(c => c.Messages)
                .Where(c => searchObject == null || c.UserId==searchObject.UserId)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
