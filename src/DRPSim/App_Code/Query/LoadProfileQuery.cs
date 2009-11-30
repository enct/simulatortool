namespace DRPSim.Query
{
    using System.Collections.Generic;
    using System.ComponentModel;
    using NHibernate;
    using NHibernate.Criterion;
    using NHibernate.Transform;
    using Rhino.Commons;

    public static class LoadProfileQuery
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public static IList<Model.Simulation.LoadProfile> GetAllLoadProfiles(int startIndex, int pageSize, string sortBy)
        {
            var query = UnitOfWork.CurrentSession.CreateCriteria(typeof (Model.Simulation.LoadProfile), "loadProfile")
                .CreateAlias("AddedBy", "AddedBy");

            if (!string.IsNullOrEmpty(sortBy))
            {
                var parts = sortBy.Split(' ');
                if (parts.Length == 2 && parts[1].Equals("DESC"))
                {
                    query.AddOrder(Order.Desc(parts[0]));
                }
                else
                {
                    query.AddOrder(Order.Asc(parts[0]));
                }
            }

            query.SetResultTransformer(Transformers.DistinctRootEntity);

            query.SetFirstResult(startIndex);
            query.SetMaxResults(pageSize);

            query.SetCacheable(true);
            return query.List<Model.Simulation.LoadProfile>();
        }

       

        public static int GetTotalLoadProfileCount()
        {
            return (int)UnitOfWork.CurrentSession
                             .CreateQuery(@"select count(loadProfile) from LoadProfile loadProfile")
                             .SetCacheable(true)
                             .UniqueResult<long>();
        }


       
    }
}