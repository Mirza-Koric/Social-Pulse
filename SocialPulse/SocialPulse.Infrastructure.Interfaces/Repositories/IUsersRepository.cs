using SocialPulse.Core;

namespace SocialPulse.Infrastructure.Interfaces
{
    public interface IUsersRepository : IBaseRepository<User, int, UserSearchObject>
    {
        public interface IUsersRepository : IBaseRepository<User, int, UserSearchObject>
        {
        }

        Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        List<User> UsersWhoLikedPosts();
    }
}
