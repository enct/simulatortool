namespace DRPSim.Model.Simulation
{
    using System;

    public class LoadProfileData
    {
        public virtual DateTime StartTime { get; set; }
        public virtual DateTime EndTime { get; set; }
        public virtual double Consumption { get; set; }
    }
}