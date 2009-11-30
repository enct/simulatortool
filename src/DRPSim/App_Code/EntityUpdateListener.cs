namespace DRPSim
{
    using System;
    using Model;
    using NHibernate.Event.Default;

    public class EntityUpdateListener : DefaultSaveEventListener
    {
        protected override object PerformSaveOrUpdate(NHibernate.Event.SaveOrUpdateEvent @event)
        {
            var entity = @event.Entity as IEntity;
            if (entity != null)
            {
                entity.DateUpdated = DateTime.Now;    
            }

            return base.PerformSaveOrUpdate(@event);
        }
    }
}