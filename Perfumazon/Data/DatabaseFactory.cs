using Perfumazon.Data.Interfaces;

namespace Perfumazon.Data
{
    public class DatabaseFactory : Disposable, IDatabaseFactory
    {
        private PetaPoco.Database dataContext;
        
        public PetaPoco.Database Get()
        {
            //return dataContext ?? (dataContext = new PetaPoco.Database("QuranContext"));
            return Perfumazon.Model.Perfumazon.GetInstance();
        }
        protected override void DisposeCore()
        {
            if (dataContext != null)
                dataContext.Dispose();
        }
    }
}
