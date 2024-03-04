using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    [Authorize]
    public class RecommendResultsController : BaseController
    {
        private readonly IRecommendResultsService _recommendResultsService;
        public RecommendResultsController(ILogger<RecommendResultsController> logger, IRecommendResultsService recommendResultsService) : base(logger)
        {
            _recommendResultsService = recommendResultsService;
        }

        [HttpGet("{postId}")]
        public virtual async Task<IActionResult> Get(int postId, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await _recommendResultsService.GetByIdAsync(postId, cancellationToken);
                if (dto == null)
                {
                    return Ok(null);
                }
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", postId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }

        [HttpGet("GetPaged")]
        public virtual async Task<IActionResult> GetPaged([FromQuery] BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await _recommendResultsService.GetPagedAsync(searchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting paged resources for page number {0}, with page size {1}", searchObject.PageNumber, searchObject.PageSize);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }


        [HttpPost("TrainModelAsync")]
        public virtual async Task<IActionResult> TrainModel(CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await _recommendResultsService.TrainPostsModelAsync(cancellationToken);
                return Ok(dto);
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem when updating resource");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when posting resource");
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }

        [HttpDelete("ClearRecommendation")]
        public virtual async Task<IActionResult> ClearRecommendation(CancellationToken cancellationToken = default)
        {
            try
            {
                await _recommendResultsService.DeleteAllRecommendation();
                return Ok();
            }
            catch (ValidationException e)
            {
                Logger.LogError(e, "Problem");
                return ValidationResult(e.Errors);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Error");
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }


        protected IActionResult ValidationResult(List<ValidationError> errors)
        {
            var dictionary = new Dictionary<string, List<string>>();

            foreach (var error in errors)
            {
                if (!dictionary.ContainsKey(error.PropertyName))
                    dictionary.Add(error.PropertyName, new List<string>());

                dictionary[error.PropertyName].Add(error.ErrorCode);
            }

            return BadRequest(new
            {
                Errors = dictionary.Select(i => new
                {
                    PropertyName = i.Key,
                    ErrorCodes = i.Value
                })
            });
        }
    }
}
