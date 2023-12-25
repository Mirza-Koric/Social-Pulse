using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class CommentConfiguration : BaseConfiguration<Comment>
    {
        public override void Configure(EntityTypeBuilder<Comment> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Text)
                   .IsRequired();


            builder.HasOne(e => e.Post)
                   .WithMany(e => e.Comments)
                   .HasForeignKey(e => e.PostId)
                   .IsRequired();

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Comments)
                   .HasForeignKey(e => e.UserId)
                   .OnDelete(DeleteBehavior.NoAction)
                   .IsRequired();
        }
    }
}
