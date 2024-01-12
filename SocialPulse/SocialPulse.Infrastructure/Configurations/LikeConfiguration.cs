using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class LikeConfiguration : BaseConfiguration<Like>
    {
        public override void Configure(EntityTypeBuilder<Like> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Type)
                   .IsRequired();

            builder.HasIndex(e => new { e.UserId, e.PostId }).IsUnique();

            builder.HasOne(e => e.Post)
                   .WithMany(e => e.Likes)
                   .HasForeignKey(e => e.PostId)
                   .IsRequired();

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Likes)
                   .HasForeignKey(e => e.UserId)
                   .OnDelete(DeleteBehavior.NoAction)
                   .IsRequired();
        }
    }
}
