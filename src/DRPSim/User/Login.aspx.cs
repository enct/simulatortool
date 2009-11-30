namespace DRPSim.User
{
	using System;
	using System.Web.Security;
	using System.Web.UI;
	using Model;
	using Rhino.Commons;

	public partial class Login : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if(User.Identity.IsAuthenticated)
            {
                RedirectToRequestedPage();
            }
		}

		protected void Submit_Click(object sender, EventArgs e)
		{
		    var isLoginSuccessful = false;
		    var userRepository = IoC.Resolve<IRepository<User>>();
            using(var tran = UnitOfWork.Current.BeginTransaction())
            {
                // try to login the user with specified username and password
                User user = UnitOfWork.CurrentSession
                    .CreateQuery(@"from User where UserName=:username and IsLocked = false")
                    .SetString("username", UserName.Text)
                    .UniqueResult<User>();

                if (user == null)
                {
                    // there is no user with this username
                    FailureText.Text = "Username or password is not correct. Login failed!";
                }
                else
                {
                    // check password of the user
                    bool passwordCheck = Encryption.CheckPassword(Password.Text, user.Password, user.PasswordSalt);
                    if (!passwordCheck)
                    {
                        // user entered invalid password
                        user.IncorrectPasswordAttemptCount += 1;
                        FailureText.Text = "Username or password is not correct. Login failed!";
                    }
                    else
                    {
                        // everything is ok.
                        // we need to set auth cookie
                        // and reset the incorrect password attempt count
                        user.IncorrectPasswordAttemptCount = 0;
                        user.LastSuccessfulLoginDate = DateTime.Now;
                        FormsAuthentication.SetAuthCookie(user.Id.ToString(), RememberMe.Checked);
                        isLoginSuccessful = true;
                    }

                    userRepository.Update(user);
                }

                tran.Commit();
                UnitOfWork.Current.TransactionalFlush();
            }

            if(isLoginSuccessful)
            {
                RedirectToRequestedPage();
            }
		}

        private void RedirectToRequestedPage()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                Response.Redirect(Request.QueryString["ReturnUrl"]);
            }
            else
            {
                Response.Redirect("~/");
            }
        }
	}
}