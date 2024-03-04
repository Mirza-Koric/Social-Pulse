using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public partial class DatabaseContext : DbContext
    {
        public DbSet<Answer> Answers { get; set; } = null!;
        public DbSet<Comment> Comments { get; set; } = null!;
        public DbSet<Conversation> Conversations { get; set; } = null!;
        public DbSet<Group> Groups { get; set; } = null!;
        public DbSet<Image> Images { get; set; } = null!;
        public DbSet<Like> Likes { get; set; } = null!;
        public DbSet<Message> Messages { get; set; } = null!;
        public DbSet<Post> Posts { get; set; } = null!;
        public DbSet<Question> Questions { get; set; } = null!;
        public DbSet<Report> Reports { get; set; } = null!;
        public DbSet<Subscription> Subscriptions { get; set; } = null!;
        public DbSet<Tag> Tags { get; set; } = null!;
        public DbSet<UserConversation> UserConversations { get; set; } = null!;
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<RecommendResult> RecommendResults { get; set; } = null!;


        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            SeedData(modelBuilder);
            ApplyConfigurations(modelBuilder);
        }
    }
}
