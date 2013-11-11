using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Repository.Interfaces
{
    public interface IDbContext : IDisposable
    {
        //DbContextConfiguration Configuration { get; }
        Guid InstanceId { get; }
        //DbSet<T> Set<T>() where T : class;
        int SaveChanges();
        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
        Task<int> SaveChangesAsync();
        void Dispose();
        //IEnumerable<DbEntityValidationResult> GetValidationErrors();
        void ApplyStateChanges();
    }
}
