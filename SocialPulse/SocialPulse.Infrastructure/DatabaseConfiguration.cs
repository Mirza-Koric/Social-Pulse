using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public partial class DatabaseContext
    {
        public override int SaveChanges()
        {
            ModifyTimestamps();

            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            ModifyTimestamps();

            return base.SaveChangesAsync(cancellationToken);
        }

        private void ModifyTimestamps()
        {
            foreach (var entry in ChangeTracker.Entries())
            {
                var entity = (BaseEntity)entry.Entity;

                if (entry.State == EntityState.Modified) 
                {
                    var databaseValues = entry.GetDatabaseValues();
                    var originalCreatedAt = (DateTime)databaseValues.GetValue<DateTime>("CreatedAt");
                    entity.CreatedAt = (DateTime)originalCreatedAt;

                    entity.ModifiedAt = DateTime.Now;
                }
                else if (entry.State == EntityState.Added) entity.CreatedAt = DateTime.Now;
            }
        }

        private void ApplyConfigurations(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(BaseConfiguration<>).Assembly);
        }
    }
}
