namespace DRPSim
{
    using System;
    using HibernatingRhinos.Profiler.Appender.NHibernate;
    using log4net.Config;
    using Rhino.Commons.HttpModules;

    public class Global : UnitOfWorkApplication
    {
        public override void Application_Start(object sender, EventArgs e)
        {
            XmlConfigurator.Configure();
            NHibernateProfiler.Initialize();

            base.Application_Start(sender, e);
        }
    }
}