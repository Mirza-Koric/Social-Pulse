using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SocialPulse.Infrastructure
{
    internal class RecommendResultsRepository : IRecommendResultsRepository
    {
        protected readonly DatabaseContext DatabaseContext = null!;
        protected readonly DbSet<RecommendResult> DbSet = null!;
        private readonly IPostsRepository _postsRepository = null!;

        public RecommendResultsRepository(DatabaseContext databaseContext, IPostsRepository booksRepository)
        {
            DatabaseContext = databaseContext;
            DbSet = DatabaseContext.Set<RecommendResult>();
            _postsRepository = booksRepository;
        }

        public async Task CreateNewRecommendation(List<RecommendResult> results, CancellationToken cancellationToken = default)
        {
            var list = await DbSet.ToListAsync();
            PagedList<Post> post = await _postsRepository.GetPagedAsync(new PostSearchObject { PageSize = 100000 }, cancellationToken);
            var postCount = post.TotalCount;
            var recordCount = await DbSet.CountAsync();

            if (recordCount != 0)
            {
                if (recordCount > postCount)
                {
                    for (int i = 0; i < postCount; i++)
                    {
                        list[i].PostId = results[i].PostId;
                        list[i].FirstCopostId = results[i].FirstCopostId;
                        list[i].SecondCopostId = results[i].SecondCopostId;
                        list[i].ThirdCopostId = results[i].ThirdCopostId;
                    }

                    for (int i = postCount; i < recordCount; i++)
                    {
                        DbSet.Remove(list[i]);
                    }
                }
                else
                {
                    for (int i = 0; i < DbSet.Count(); i++)
                    {
                        list[i].PostId = results[i].PostId;
                        list[i].FirstCopostId = results[i].FirstCopostId;
                        list[i].SecondCopostId = results[i].SecondCopostId;
                        list[i].ThirdCopostId = results[i].ThirdCopostId;
                    }
                    var num = results.Count() - DbSet.Count();

                    if (num > 0)
                    {
                        for (int i = results.Count() - num; i < results.Count(); i++)
                        {
                            await DbSet.AddAsync(results[i]);
                        }
                    }
                }
            }
            else
            {
                await DbSet.AddRangeAsync(results);
            }
        }

        public async Task DeleteAllRecommendation(CancellationToken cancellationToken = default)
        {
            await DbSet.ExecuteDeleteAsync(cancellationToken);
        }

        public async Task<RecommendResult?> GetByIdAsync(int postId, CancellationToken cancellationToken = default)
        {
            return await DbSet.FirstOrDefaultAsync(c => c.PostId == postId);
        }

        public async Task<PagedList<RecommendResult>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
