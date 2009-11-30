namespace DRPSim.Model.Simulation
{
    using System.Collections.Generic;

    public class LoadProfile : Entity
    {
        public LoadProfile()
        {
            Data = new List<LoadProfileData>();
        }

        public virtual string Name { get; set; }
        public virtual string Description { get; set; }
        public virtual User AddedBy { get; set; }
        public virtual IList<LoadProfileData> Data { get; set; }
    }
}