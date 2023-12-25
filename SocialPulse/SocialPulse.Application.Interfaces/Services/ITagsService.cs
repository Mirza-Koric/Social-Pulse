using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface ITagsService : IBaseService<int, TagDto, TagUpsertDto, TagSearchObject>
    {
    }
}
