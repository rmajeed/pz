using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Perfumazon.Data.Interfaces
{
    public interface IUnitOfWork : IDisposable
    {
        void Commit();
    }
}
