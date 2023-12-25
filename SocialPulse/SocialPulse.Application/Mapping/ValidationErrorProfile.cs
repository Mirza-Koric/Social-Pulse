using FluentValidation.Results;
using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ValidationErrorProfile : BaseProfile
    {
        public ValidationErrorProfile()
        {
            CreateMap<ValidationFailure, ValidationError>();
        }
    }
}
