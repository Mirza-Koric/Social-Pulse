using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class PostConfiguration : BaseConfiguration<Post>
    {
        public override void Configure(EntityTypeBuilder<Post> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Title)
                   .IsRequired();

            builder.Property(e => e.Text)
                   .IsRequired();


            builder.HasOne(e => e.User)
                   .WithMany(e => e.Posts)
                   .HasForeignKey(e => e.UserId)
                   .OnDelete(DeleteBehavior.NoAction)
                   .IsRequired();

            builder.HasOne(e => e.Group)
                   .WithMany(e => e.Posts)
                   .HasForeignKey(e => e.GroupId)
                   .IsRequired();

            builder.HasOne(e => e.Tag)
                   .WithMany(e => e.Posts)
                   .HasForeignKey(e => e.TagId)
                   .IsRequired();
        }
    }
}
