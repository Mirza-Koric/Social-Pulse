using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class ReportConfiguration : BaseConfiguration<Report>
    {
        public override void Configure(EntityTypeBuilder<Report> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.ReportReason)
                   .IsRequired();

            builder.HasOne(e => e.Reporter)
                   .WithMany(e => e.MyReports)
                   .HasForeignKey(e => e.ReporterId)
                   .IsRequired();

            builder.HasOne(e => e.Reported)
                   .WithMany(e => e.Reports)
                   .HasForeignKey(e => e.ReportedId)
                   .OnDelete(DeleteBehavior.NoAction)
                   .IsRequired();
        }
    }
}
