namespace DRPSim.Simulation.LoadProfile
{
    using System;
    using System.Web.UI;
    using Rhino.Commons;

    public partial class Edit : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                Response.Redirect("List.aspx");
                return;    
            }

            if(IsPostBack)
                return;

            var loadProfileRepository = IoC.Resolve<IRepository<Model.Simulation.LoadProfile>>();
            var loadProfile = loadProfileRepository.Get(new Guid(Request.QueryString["Id"]));
            Name.Text = loadProfile.Name;
            Description.Text = loadProfile.Description;
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            using (var tran = UnitOfWork.Current.BeginTransaction())
            {
                var loadProfileRepository = IoC.Resolve<IRepository<Model.Simulation.LoadProfile>>();
                var loadProfile = loadProfileRepository.Get(new Guid(Request.QueryString["Id"]));

                loadProfile.Name = Name.Text;
                loadProfile.Description = Description.Text;

                loadProfileRepository.Update(loadProfile);

                tran.Commit();
                UnitOfWork.Current.TransactionalFlush();

                SuccessMessage.Text = "Load Profile updated successfully.";
            }
        }
    }
}