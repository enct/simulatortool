namespace DRPSim
{
    using System;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    public class UserIdObjectSourceParameter : Parameter
    {
        protected override object Evaluate(HttpContext context, Control control)
        {
            return new Guid(context.User.Identity.Name);
        }
    }
}