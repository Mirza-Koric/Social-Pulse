using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IRecommendResultsRepository
    {
        Task<RecommendResult?> GetByIdAsync(int bookId, CancellationToken cancellationToken = default);
        Task<PagedList<RecommendResult>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default);
        Task CreateNewRecommendation(List<RecommendResult> results, CancellationToken cancellationToken = default);
        Task DeleteAllRecommendation(CancellationToken cancellationToken = default);
    }
}
