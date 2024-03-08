namespace SocialPulse.Core
{
    public class User : BaseEntity
    {
        public string Email { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string PasswordHash { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;
        public Role Role { get; set; }
        public DateTime BirthDate { get; set; }

        public ICollection<Post> Posts { get; set; } = null!;
        public ICollection<Comment> Comments { get; set; } = null!;
        public ICollection<Like> Likes { get; set; } = null!;
        public ICollection<Report> Reports { get; set; } = null!;
        public ICollection<Report> MyReports { get; set; } = null!;
        public ICollection<Question> Questions { get; set; } = null!;
        public ICollection<Answer> Answers { get; set; } = null!;
        public ICollection<Message> Messages { get; set; } = null!;
        public ICollection<UserConversation> Conversations { get; set; } = null!;
        public Subscription Subscription { get; set; } = null!;

        public ICollection<Notification> Notifications = null!;
    }
}
