using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class NotificationConfiguration : BaseConfiguration<Notification>
    {
        public override void Configure(EntityTypeBuilder<Notification> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Title)
                   .IsRequired();

            builder.Property(e => e.Content)
                   .IsRequired(false);

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Notifications)
                   .HasForeignKey(e => e.UserId)
                   .IsRequired();
        }
    }
}
