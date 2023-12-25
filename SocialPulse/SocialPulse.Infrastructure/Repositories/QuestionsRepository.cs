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
    }
}
