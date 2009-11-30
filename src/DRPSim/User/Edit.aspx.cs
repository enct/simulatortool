namespace DRPSim.User
{
	using System;
	using System.Web.UI;
	using Model;
	using NHibernate;
	using Rhino.Commons;

	public partial class Edit : Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!User.Identity.IsAuthenticated)
				Response.Redirect("~/User/Login.aspx");

			if(IsPostBack) 
				return;

			ShowUserProperties();
		}

		protected void Submit_Click(object sender, EventArgs e)
		{
			// update user
			var userRepository = IoC.Resolve<IRepository<User>>();
			
			using(RhinoTransaction tran = UnitOfWork.Current.BeginTransaction())
			{
				var user = userRepository.Get(new Guid(User.Identity.Name));

				// check entered user name and email for uniquness
				var sameUserNameCount = UnitOfWork.CurrentSession
					.CreateQuery(@"select count(user) from User user where user.UserName = :userName and user.Id != :id")
					.SetString("userName", UserName.Text.Trim())
					.SetGuid("id", user.Id)
					.FutureValue<long>();

				var sameEmailCount = UnitOfWork.CurrentSession
                    .CreateQuery(@"select count(user) from User user where user.EMail = :email and user.Id != :userId")
					.SetString("email", EMail.Text)
					.SetGuid("userId", user.Id)
					.FutureValue<long>();

				if(sameUserNameCount.Value > 0)
				{
					ErrorMessage.Text = UserName.Text.Trim() + " is not available.";
				}
				else if (sameEmailCount.Value > 0)
				{
					ErrorMessage.Text = EMail.Text + " is not available.";
				}
				else
				{
					user.UserName = UserName.Text;
					user.Name = Name.Text;
					user.EMail = EMail.Text;

					// update user
					userRepository.Update(user);

					SuccessMessage.Text = "Your changes updated successfully";
				}

				tran.Commit();
				UnitOfWork.Current.TransactionalFlush();
			}

			ShowUserProperties();
		}

		private void ShowUserProperties()
		{
			IRepository<User> userRepository = IoC.Resolve<IRepository<User>>();
			User user = userRepository.Get(new Guid(User.Identity.Name));

			// set editing fields
			UserName.Text = user.UserName;
			Name.Text = user.Name;
			EMail.Text = user.EMail;
		}
	}
}