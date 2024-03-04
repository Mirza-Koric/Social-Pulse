using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;
using SocialPulse.Infrastructure;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace SocialPulse.Application.Services
{
    public class RecommendResultsService : IRecommendResultsService
    {
        protected readonly IMapper Mapper;
        protected readonly UnitOfWork UnitOfWork;
        protected readonly IRecommendResultsRepository CurrentRepository;
        protected readonly IValidator<RecommendResultUpsertDto> Validator;
        private readonly IPostsRepository _postsRepository;
        private readonly IUsersRepository _usersRepository;
        private readonly ILikesService _likesService;

        public RecommendResultsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<RecommendResultUpsertDto> validator, IRecommendResultsRepository currentRepository, IPostsRepository postsRepository, IUsersRepository usersRepository, ILikesService likesService)
        {
            Mapper = mapper;
            UnitOfWork = (UnitOfWork)unitOfWork;
            Validator = validator;
            CurrentRepository = currentRepository;
            _postsRepository = postsRepository;
            _usersRepository = usersRepository;
            _likesService = likesService;
        }
        public virtual async Task<PagedList<RecommendResultDto>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var pagedList = await CurrentRepository.GetPagedAsync(searchObject, cancellationToken);
            return Mapper.Map<PagedList<RecommendResultDto>>(pagedList);
        }

        public async Task<RecommendResultDto?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await CurrentRepository.GetByIdAsync(id, cancellationToken);
            return Mapper.Map<RecommendResultDto>(entity);
        }

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<PostDto> Recommend(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var tmpData = _usersRepository.UsersWhoLikedPosts();

                    var data = new List<PostEntry>();

                    foreach (var x in tmpData)
                    {
                        if (x.Likes.Count > 1)
                        {
                            var distinctItemId = x.Likes.Select(y => y.PostId).ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = x.Likes.Where(z => z.PostId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new PostEntry()
                                    {
                                        PostID = (uint)y,
                                        CoLikedPostID = (uint)z.PostId,
                                    });
                                }
                            });
                        }
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);//trian data

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(PostEntry.PostID);
                    options.MatrixRowIndexColumnName = nameof(PostEntry.CoLikedPostID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }
            }

            var posts = _postsRepository.GetExceptId(id);

            var predictionResult = new List<Tuple<Post, float>>();

            foreach (var post in posts)
            {

                var predictionengine = mlContext.Model.CreatePredictionEngine<PostEntry, CoPost_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new PostEntry()
                                         {
                                             PostID = (uint)id,
                                             CoLikedPostID = (uint)post.Id
                                         });

                predictionResult.Add(new Tuple<Post, float>(post, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return Mapper.Map<List<PostDto>>(finalResult);
        }

        public async Task<List<RecommendResultDto>> TrainPostsModelAsync(CancellationToken cancellationToken = default)
        {
            var postResult = await _postsRepository.GetPagedAsync(new PostSearchObject() { PageSize = 100000 }, cancellationToken);
            var posts = postResult.Items.ToList();
            var records = await _likesService.GetPagedAsync(new LikeSearchObject() { PageSize = 1000000, Type=true }, cancellationToken);

            if (posts.Count() > 4 && records.TotalCount > 8)
            {
                List<RecommendResult> recommendList = new List<RecommendResult>();

                foreach (var book in posts)
                {
                    var recommendedPosts = Recommend(book.Id);

                    var resultRecoomend = new RecommendResult()
                    {
                        PostId = book.Id,
                        FirstCopostId = recommendedPosts[0].Id,
                        SecondCopostId = recommendedPosts[1].Id,
                        ThirdCopostId = recommendedPosts[2].Id
                    };
                    recommendList.Add(resultRecoomend);
                }
                await CurrentRepository.CreateNewRecommendation(recommendList, cancellationToken);
                await UnitOfWork.SaveChangesAsync();

                return Mapper.Map<List<RecommendResultDto>>(recommendList);
            }
            else
            {
                throw new Exception("Not enough data to do recommmedation");
            }
        }

        public async Task DeleteAllRecommendation(CancellationToken cancellationToken = default)
        {
            await CurrentRepository.DeleteAllRecommendation(cancellationToken);
        }
    }

    public class CoPost_prediction
    {
        public float Score { get; set; }
    }

    public class PostEntry
    {
        [KeyType(count:10)]
        public uint PostID { get; set; }

        [KeyType(count: 10)]
        public uint CoLikedPostID { get; set; }

        public float Label { get; set; }
    }
}
