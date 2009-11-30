namespace DRPSim
{
    using System;
    using System.Web.UI;
    using Rhino.Commons;

    public partial class Site : MasterPage
    {
        protected override void OnPreRender(EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                var userRepository = IoC.Resolve<IRepository<Model.User>>();
                var user = userRepository.Get(new Guid(Context.User.Identity.Name));
                LoginName.Text = user.Name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}