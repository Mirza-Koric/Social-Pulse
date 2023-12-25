using SocialPulse.Application;
using SocialPulse.Core;

namespace SocialPulse.Api
{
    public class SignUpProfile : BaseProfile
    {
        public SignUpProfile()
        {
            CreateMap<AccessSignUpModel, UserUpsertDto>();
        }
    }
}
