using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class SubscriptionConfiguration : BaseConfiguration<Subscription>
    {
        public override void Configure(EntityTypeBuilder<Subscription> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Active)
                   .IsRequired();

            builder.Property(e => e.ExpirationDate)
                   .IsRequired();
        }
    }
}
