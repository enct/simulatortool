namespace DRPSim
{
    using System;
    using Model;
    using NHibernate.Event.Default;

    public class EntityCreateListener : DefaultSaveEventListener
    {
        protected override object PerformSaveOrUpdate(NHibernate.Event.SaveOrUpdateEvent @event)
        {
            var entity = @event.Entity as IEntity;
            if (entity != null)
            {
                entity.DateCreated = DateTime.Now;    
            }

            return base.PerformSaveOrUpdate(@event);
        }
    }
}