namespace DRPSim.User
{
	using System;
	using System.Web.UI;
	using Model;
	using Rhino.Commons;

	public partial class ChangePassword : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if(!User.Identity.IsAuthenticated)
				Response.Redirect("~/Accounts/Login.aspx");
		}

		protected void Change_Click(object sender, EventArgs e)
		{
			IRepository<User> userRepository = IoC.Resolve<IRepository<User>>();
			
			using(RhinoTransaction tran = UnitOfWork.Current.BeginTransaction())
			{
				// get current user
				User user = userRepository.Get(new Guid(User.Identity.Name));

				// check users current password
				if(!Encryption.CheckPassword(CurrentPassword.Text, user.Password, user.PasswordSalt))
				{
					FailureText.Text = "Old password is wrong. Your password cannot be updated.";
				}
				else
				{
					// update users password
					string salt = Encryption.GenerateSalt();
					user.Password = Encryption.EncodePassword(Password.Text, salt);
					user.PasswordSalt = salt;
				    user.LastPasswordChangeDate = DateTime.Now;

					userRepository.Update(user);
					SuccessMessage.Text = "Your password successfully updated";
				}

				tran.Commit();
				UnitOfWork.Current.TransactionalFlush();
			}
		}
	}
}