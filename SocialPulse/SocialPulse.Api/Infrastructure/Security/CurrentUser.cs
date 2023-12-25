using SocialPulse.Application;
using System.Security.Claims;

namespace SocialPulse.Api
{
    public class CurrentUser : ICurrentUser
    {
        private static readonly Claim[] EmptyClaims = Array.Empty<Claim>();

        private readonly ICurrentPrincipalAccessor _currentPrincipalAccessor;

        public CurrentUser(ICurrentPrincipalAccessor currentPrincipalAccessor)
        {
            _currentPrincipalAccessor = currentPrincipalAccessor;
        }

        public int? Id => _currentPrincipalAccessor.Principal.GetUserId();

        public string[] Roles => FindClaims(ClaimTypes.Role).Select(c => c.Value).ToArray();

        public Claim? FindClaim(string claimType) =>
            _currentPrincipalAccessor.Principal?.FindFirst(claimType);

        public Claim[] FindClaims(string claimType) =>
            _currentPrincipalAccessor.Principal?.FindAll(claimType).ToArray() ?? EmptyClaims;

        public Claim[] GetAllClaims() =>
            _currentPrincipalAccessor.Principal?.Claims.ToArray() ?? EmptyClaims;

        public bool IsInRole(string roleName) =>
            _currentPrincipalAccessor.Principal.IsInRole(roleName);
    }
}
