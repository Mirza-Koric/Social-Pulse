using Microsoft.AspNetCore.Mvc;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, UserUpsertDto, UserSearchObject, IUsersService>
    {
        public UsersController(IUsersService service, ILogger<UsersController> logger) : base(service, logger)
        {
        }

        [HttpPut("ChangePassword")]
        public async Task<IActionResult> ChangePassword([FromBody] UserChangePasswordDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.ChangePasswordAsync(dto, cancellationToken);
                return Ok();
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem when updating password");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }
    }
}
