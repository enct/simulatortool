namespace DRPSim
{
    using System;
    using System.Collections.Generic;
    using System.Web.Security;
    using Rhino.Commons;

    public class DRPSimRoleProvider : RoleProvider
    {
        #region Overrides of RoleProvider

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override string[] GetRolesForUser(string username)
        {
            UnitOfWork.Start();

            // check if the user is admin or not
            var userRepository = IoC.Resolve<IRepository<Model.User>>();
            var user = userRepository.Get(new Guid(username));

            var roles = new List<string>();
            foreach (var userRole in user.Roles)
            {
                roles.Add(userRole.ToString());
            }
            UnitOfWork.Current.Dispose();

            return roles.ToArray();
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get { return "/"; }
            set { throw new NotImplementedException(); }
        }

        #endregion
    }
}