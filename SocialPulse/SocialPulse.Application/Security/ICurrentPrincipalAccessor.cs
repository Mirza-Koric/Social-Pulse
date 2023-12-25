using System.Security.Claims;

namespace SocialPulse.Application
{
    public interface ICurrentPrincipalAccessor
    {
        ClaimsPrincipal Principal { get; }
    }
}
