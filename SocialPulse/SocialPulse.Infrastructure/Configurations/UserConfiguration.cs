using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class UserConfiguration : BaseConfiguration<User>
    {
        public override void Configure(EntityTypeBuilder<User> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Email)
                   .IsRequired();

            builder.Property(e => e.Username)
                   .IsRequired();

            builder.Property(e => e.PasswordHash)
                   .IsRequired();

            builder.Property(e => e.PasswordSalt)
                   .IsRequired();
            
            builder.Property(e => e.Role)
                   .IsRequired();

            builder.Property(e => e.BirthDate)
                   .IsRequired();

            builder.HasOne(e => e.Subscription)
                   .WithOne(e => e.User)
                   .HasForeignKey<Subscription>(e => e.UserId)
                   .IsRequired();
        }
    }
}
