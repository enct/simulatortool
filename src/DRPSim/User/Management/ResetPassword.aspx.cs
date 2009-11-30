namespace DRPSim.User.Management
{
    using System;
    using System.Web.UI;
    using Model;
    using Rhino.Commons;

    public partial class ResetPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                Response.Redirect("~/User/Management/ListUsers.aspx");
                return;
            }

            if (IsPostBack)
                return;

            var userRepository = IoC.Resolve<IRepository<User>>();
            var userId = new Guid(Request.QueryString["id"]);
            var user = userRepository.Get(userId);

            UserName.Text = user.UserName;
        }

        protected void Change_Click(object sender, EventArgs e)
        {
            var userRepository = IoC.Resolve<IRepository<User>>();

            using (RhinoTransaction tran = UnitOfWork.Current.BeginTransaction())
            {
                // get user
                var user = userRepository.Get(new Guid(Request.QueryString["id"]));

                // update users password
                var salt = Encryption.GenerateSalt();
                user.Password = Encryption.EncodePassword(Password.Text, salt);
                user.PasswordSalt = salt;

                userRepository.Update(user);

                tran.Commit();
                UnitOfWork.Current.TransactionalFlush();
            }

            SuccessMessage.Text = "User's password changed successfully.";
        }
    }
}