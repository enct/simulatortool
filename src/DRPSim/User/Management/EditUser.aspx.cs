namespace DRPSim.User.Management
{
	using System;
	using System.Linq;
	using System.Web.UI;
	using Model;
	using NHibernate;
	using Rhino.Commons;

	public partial class EditUser : Page
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

			IRepository<User> userRepository = IoC.Resolve<IRepository<User>>();
			Guid userId = new Guid(Request.QueryString["id"]);
			User user = userRepository.Get(userId);

			UserName.Text = user.UserName;
			Name.Text = user.Name;
			EMail.Text = user.EMail;

		    IsAdmin.Checked = user.Roles.Any(x => x == UserRole.Admin);
            IsStandartUser.Checked = user.Roles.Any(x => x == UserRole.Standart);
		}

		protected void Submit_Click(object sender, EventArgs e)
		{
            if (!IsAdmin.Checked && !IsController.Checked && !IsStandartUser.Checked)
            {
                ErrorMessage.Text = "You have to select at least one role for the user.";
                return;
            }

			IRepository<User> userRepository = IoC.Resolve<IRepository<User>>();

			using (RhinoTransaction tran = UnitOfWork.Current.BeginTransaction())
			{
				// get editing user 
				User user = userRepository.Get(new Guid(Request.QueryString["id"]));

				// check if the user name is unique
				IFutureValue<long> sameUserNameCount = UnitOfWork.CurrentSession
					.CreateQuery(@"select count(user) from User user where user.UserName = :userName and user.Id != :id")
					.SetString("userName", UserName.Text.Trim())
					.SetGuid("id", user.Id)
					.FutureValue<long>();

				// check if the email is unique
				IFutureValue<long> sameEmailCount = UnitOfWork.CurrentSession
					.CreateQuery(@"select count(user) from User user where user.EMail = :email and user.Id != :userId")
					.SetString("email", EMail.Text)
					.SetGuid("userId", user.Id)
					.FutureValue<long>();

				if (sameUserNameCount.Value > 0)
				{
					ErrorMessage.Text = UserName.Text.Trim() + " is not available.";
				}
				else if (sameEmailCount.Value > 0)
				{
					ErrorMessage.Text = EMail.Text + " is not available.";
				}
				else
				{
					// edit user
					user.Name = Name.Text.Trim();
					user.UserName = UserName.Text.Trim();
					user.EMail = EMail.Text.Trim();

                    user.Roles.Clear();
                    if (IsAdmin.Checked) user.Roles.Add(UserRole.Admin);
                    if (IsStandartUser.Checked) user.Roles.Add(UserRole.Standart);

					// save user
					userRepository.Update(user);

					SuccessMessage.Text = "Changes saved successfully";
				}

				tran.Commit();
				UnitOfWork.Current.TransactionalFlush();
			}
		}
	}
}