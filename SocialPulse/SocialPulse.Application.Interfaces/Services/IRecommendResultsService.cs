using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IRecommendResultsService
    {
        Task<RecommendResultDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default);
        Task<PagedList<RecommendResultDto>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<RecommendResultDto>> TrainPostsModelAsync(CancellationToken cancellationToken = default);
        Task DeleteAllRecommendation(CancellationToken cancellationToken = default);
    }
}
