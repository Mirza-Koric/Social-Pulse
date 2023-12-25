namespace SocialPulse.Api
{
    public class AccessSignUpModel
    {
        public string Email { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public DateTime BirthDate { get; set; }
    }
}
