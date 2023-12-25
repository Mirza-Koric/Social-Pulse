using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class UserValidator : AbstractValidator<UserUpsertDto>
    {
        private readonly IUsersRepository _usersRepository;
        public UserValidator(IUsersRepository usersRepository)
        {
            _usersRepository = usersRepository;

            RuleFor(u => u.Email).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty)
                                 .EmailAddress().MustAsync(IsUnique).WithErrorCode(ErrorCodes.InvalidValue);
            
            RuleFor(c => c.Username).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Role).IsInEnum().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.BirthDate).NotNull().WithErrorCode(ErrorCodes.NotNull);

            RuleFor(u => u.Password)
                .NotEmpty()
                .NotNull()
                .MinimumLength(8)
                .Matches(@"[A-Z]+")
                .Matches(@"[a-z]+")
                .Matches(@"[0-9]+")
                .WithErrorCode(ErrorCodes.InvalidValue)
                .When(u => u.Id == null || u.Password != null);

        }

        private async Task<bool> IsUnique (string value, CancellationToken cancellationToken)
        {
            User user = await _usersRepository.GetByEmailAsync(value, cancellationToken);

            if (user == null)
            {
                return true;
            }

            return false;
        }
    }
}
