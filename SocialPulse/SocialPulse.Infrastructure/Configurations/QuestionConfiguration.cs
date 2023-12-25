using Microsoft.EntityFrameworkCore.Metadata.Builders;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public class QuestionConfiguration : BaseConfiguration<Question>
    {
        public override void Configure(EntityTypeBuilder<Question> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Text)
                   .IsRequired();

            builder.HasOne(e => e.User)
                   .WithMany(e => e.Questions)
                   .HasForeignKey(e => e.UserId)
                   .IsRequired();

            builder.HasOne(e => e.Answer)
                   .WithOne(e => e.Question)
                   .HasForeignKey<Answer>(e => e.QuestionId)
                   .IsRequired();
        }
    }
}
