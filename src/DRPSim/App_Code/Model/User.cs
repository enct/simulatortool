namespace DRPSim.Model
{
    using System;
    using System.Collections.Generic;

    public class User : Entity
    {
        public User()
        {
            Roles = new List<UserRole>();
        }

        public virtual string UserName { get; set; }
        public virtual string Name { get; set; }
        public virtual string EMail { get; set; }

        public virtual string Password { get; set; }
        public virtual string PasswordSalt { get; set; }

        public virtual DateTime? LastSuccessfulLoginDate { get; set; }

        public virtual int IncorrectPasswordAttemptCount { get; set; }
        public virtual DateTime LastPasswordChangeDate { get; set; }
        public virtual bool IsLocked { get; set; }

        public virtual IList<UserRole> Roles { get; set; }
    }
}