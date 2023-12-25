using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure.Repositories;

namespace SocialPulse.Infrastructure
{
    public class ImagesRepository : BaseRepository<Image, int, BaseSearchObject>, IImagesRepository
    {
        public ImagesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
