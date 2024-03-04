namespace SocialPulse.Core
{
    public class UserUpsertDto : BaseUpsertDto
    {
        public string Email { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string? Password { get; set; }
        public Role Role { get; set; } = Role.User;
        public DateTime BirthDate { get; set; }
    }
}
