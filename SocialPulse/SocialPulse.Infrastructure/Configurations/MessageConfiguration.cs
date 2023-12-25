using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class MessageConfiguration : BaseConfiguration<Message>
    {
        public override void Configure(EntityTypeBuilder<Message> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Text)
                   .IsRequired();

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Messages)
                   .HasForeignKey(e => e.UserId)
                   .IsRequired();

            builder.HasOne(e => e.Conversation)
                   .WithMany(e => e.Messages)
                   .HasForeignKey(e => e.ConversationId)
                   .IsRequired();
        }
    }
}
