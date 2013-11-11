using System;

namespace Perfumazon.Data.Interfaces
{
    public interface IDatabaseFactory : IDisposable
    {
        PetaPoco.Database Get();
    }
}
