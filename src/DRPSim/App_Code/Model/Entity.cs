namespace DRPSim.Model
{
    using System;

    public abstract class Entity : IEntity
    {
        #region Implementation of IEntity

        public virtual Guid Id { get; set; }

        public virtual DateTime DateCreated { get; set; }
        public virtual DateTime? DateUpdated { get; set; }

        #endregion
    }
}