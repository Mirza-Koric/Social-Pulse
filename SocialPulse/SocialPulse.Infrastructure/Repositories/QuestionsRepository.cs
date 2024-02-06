using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class QuestionsRepository : BaseRepository<Question, int, QuestionSearchObject>, IQuestionsRepository
    {
        public QuestionsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Question>> GetPagedAsync(QuestionSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(q => q.Answer)
                .Where(q => searchObject.Text == null || q.Text.ToLower().Contains(searchObject.Text.ToLower()))
                .Where(q => searchObject.UserId == null || q.UserId == searchObject.UserId)
                .OrderByDescending(q => q.CreatedAt)
                .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
