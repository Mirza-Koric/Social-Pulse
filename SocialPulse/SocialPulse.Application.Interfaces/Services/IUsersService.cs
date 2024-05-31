using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application.Interfaces
{
    public interface IUsersService : IBaseService<int, UserDto, UserUpsertDto, UserSearchObject>
    {
        Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        Task ChangePasswordAsync(UserChangePasswordDto dto, CancellationToken cancellationToken = default);
    }
}
