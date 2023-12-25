using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class UserConversationConfiguration : BaseConfiguration<UserConversation>
    {
        public override void Configure(EntityTypeBuilder<UserConversation> builder)
        {
            base.Configure(builder);

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Conversations)
                   .HasForeignKey(e => e.UserId)
                   .OnDelete(DeleteBehavior.NoAction)
                   .IsRequired();

            builder.HasOne(e => e.Conversation)
                   .WithMany(e => e.Users)
                   .HasForeignKey(e => e.ConversationId)
                   .IsRequired();
        }
    }
}
