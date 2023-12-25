using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);

        }

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    Email = "user@mail.com",
                    Username = "TestUser",
                    Role = Role.Administrator,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
        }
    }
}
