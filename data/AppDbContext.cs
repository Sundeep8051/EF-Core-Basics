using domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace data;

public class AppDbContext(DbContextOptions options) : DbContext(options)
{
    public DbSet<Coach> Coaches { get; set; }
    public DbSet<Team> Teams { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Coach>(entity =>
        {
            entity.HasKey(x => x.Id);

            entity.HasData(new List<Coach>
            {
                new Coach {Id = 1, Name="Coach A"},
                new Coach {Id = 2, Name="Coach B"},
            });
        });
    }
}
