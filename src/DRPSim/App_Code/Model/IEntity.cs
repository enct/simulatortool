namespace DRPSim.Model
{
    using System;

    public interface IEntity
    {
        Guid Id { get; set; }

        DateTime DateCreated { get; set; }
        DateTime? DateUpdated { get; set; }
    }
}