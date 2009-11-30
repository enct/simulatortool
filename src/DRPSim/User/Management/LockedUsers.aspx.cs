namespace DRPSim.User.Management
{
    using System;
    using System.Linq;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using Model;
    using Rhino.Commons;

    public partial class LockedUsers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            PopulateUsersGrid();
        }

        private void PopulateUsersGrid()
        {
            using (var tran = UnitOfWork.Current.BeginTransaction())
            {
                UsersGrid.DataBind();
                tran.Commit();
            }
        }

        protected void UsersGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                Guid userId = new Guid(e.CommandArgument.ToString());
                Response.Redirect("EditUser.aspx?id=" + userId);
            }
            else if (e.CommandName == "UnlockUser")
            {
                Guid userId = new Guid(e.CommandArgument.ToString());

                using (var tran = UnitOfWork.Current.BeginTransaction())
                {
                    IRepository<User> userRepository = IoC.Resolve<IRepository<User>>();

                    User user = userRepository.Get(userId);
                    user.IsLocked = false;
                    userRepository.Update(user);

                    tran.Commit();
                    UnitOfWork.Current.TransactionalFlush();

                    SuccessMessage.Text = user.Name + " unlocked successfully.";
                }

                PopulateUsersGrid();
            }
        }

        protected void UsersGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var isAdmin = (Image) e.Row.FindControl("IsAdmin");
                var isStandart = (Image) e.Row.FindControl("IsStandart");
                var lastLogin = (Literal) e.Row.FindControl("LastLogin");

                var user = (User) e.Row.DataItem;

                if (user.Roles.Any(x => x == UserRole.Admin))
                {
                    isAdmin.ImageUrl = "~/Assets/images/i_success.png";
                    isAdmin.ToolTip = "User is an Administrator.";
                }

                if (user.Roles.Any(x => x == UserRole.Standart))
                {
                    isStandart.ImageUrl = "~/Assets/images/i_success.png";
                    isStandart.ToolTip = "User is a Standart user.";
                }

                lastLogin.Text = user.LastSuccessfulLoginDate.HasValue
                                     ? user.LastSuccessfulLoginDate.Value.ToShortDateString()
                                     : "--";
            }
        }

        protected void UsersGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            UsersGrid.PageIndex = e.NewPageIndex;
            PopulateUsersGrid();
        }
    }
}