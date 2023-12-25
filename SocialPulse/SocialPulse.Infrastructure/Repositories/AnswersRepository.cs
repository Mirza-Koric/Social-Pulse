using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class AnswersRepository : BaseRepository<Answer, int, AnswerSearchObject>, IAnswersRepository
    {
        public AnswersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
