using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class ImageConfiguration : BaseConfiguration<Image>
    {
        public override void Configure(EntityTypeBuilder<Image> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Data)
                   .IsRequired();

            builder.Property(e => e.ContentType)
                   .IsRequired();

            builder.HasOne(e => e.Post)
                   .WithMany(e => e.Images)
                   .HasForeignKey(e => e.PostId)
                   .IsRequired(false);

            builder.HasOne(e => e.Message)
                   .WithMany(e => e.Images)
                   .HasForeignKey(e => e.MessageId)
                   .IsRequired(false);
        }
    }
}
