namespace DRPSim.Query
{
    using System.Collections.Generic;
    using System.ComponentModel;
    using Model;
    using NHibernate;
    using NHibernate.Criterion;
    using NHibernate.Transform;
    using Rhino.Commons;

    public static class UserQuery
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public static IList<User> GetAllUnLockedUsers(int startIndex, int pageSize, string sortBy)
        {
            var query = UnitOfWork.CurrentSession.CreateCriteria(typeof (User), "user")
                .Add(Restrictions.Eq("user.IsLocked", false));

            if (!string.IsNullOrEmpty(sortBy))
            {
                var parts = sortBy.Split(' ');
                if (parts.Length == 2 && parts[1].Equals("DESC"))
                {
                    query.AddOrder(Order.Desc("user." + parts[0]));
                }
                else
                {
                    query.AddOrder(Order.Asc("user." + parts[0]));
                }
            }

            query.SetFetchMode("Roles", FetchMode.Select);
            query.SetResultTransformer(Transformers.DistinctRootEntity);

            query.SetFirstResult(startIndex);
            query.SetMaxResults(pageSize);

            query.SetCacheable(true);

            return query.List<User>();
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public static IList<User> GetAllLockedUsers(int startIndex, int pageSize, string sortBy)
        {
            var query = UnitOfWork.CurrentSession.CreateCriteria(typeof(User), "user")
                .Add(Restrictions.Eq("user.IsLocked", true));

            if (!string.IsNullOrEmpty(sortBy))
            {
                var parts = sortBy.Split(' ');
                if (parts.Length == 2 && parts[1].Equals("DESC"))
                {
                    query.AddOrder(Order.Desc("user." + parts[0]));
                }
                else
                {
                    query.AddOrder(Order.Asc("user." + parts[0]));
                }
            }

            query.SetFetchMode("Roles", FetchMode.Select);
            query.SetResultTransformer(Transformers.DistinctRootEntity);

            query.SetFirstResult(startIndex);
            query.SetMaxResults(pageSize);

            query.SetCacheable(true);

            return query.List<User>();
        }

        public static int GetTotalUnlockedUsersCount()
        {
            return (int) UnitOfWork.CurrentSession
                             .CreateQuery(@"select count(user) from User user where user.IsLocked = false")
                             .SetCacheable(true)
                             .UniqueResult<long>();
        }


        public static int GetTotalLockedUsersCount()
        {
            return (int) UnitOfWork.CurrentSession
                             .CreateQuery(@"select count(user) from User user where user.IsLocked = true")
                             .SetCacheable(true)
                             .UniqueResult<long>();
        }
    }
}