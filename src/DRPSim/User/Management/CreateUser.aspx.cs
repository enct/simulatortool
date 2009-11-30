namespace DRPSim.User.Management
{
    using System;
    using System.Web.UI;
    using Model;
    using NHibernate;
    using Rhino.Commons;

    public partial class CreateUser : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if(!IsAdmin.Checked && !IsStandartUser.Checked)
            {
                ErrorMessage.Text = "You have to select at least one role for the user.";
                return;
            }

            var userRepository = IoC.Resolve<IRepository<User>>();

            using (var tran = UnitOfWork.Current.BeginTransaction())
            {
                // check if the user name is unique
                IFutureValue<long> sameUserNameCount = UnitOfWork.CurrentSession
                    .CreateQuery(@"select count(user) from User user where user.UserName = :userName")
                    .SetString("userName", UserName.Text.Trim())
                    .FutureValue<long>();

                // check if the email is unique
                IFutureValue<long> sameEmailCount = UnitOfWork.CurrentSession
                    .CreateQuery(@"select count(user) from User user where user.EMail = :email")
                    .SetString("email", EMail.Text)
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
                    // create new user
                    User user = new User();
                    user.Name = Name.Text.Trim();
                    user.UserName = UserName.Text.Trim();
                    user.EMail = EMail.Text.Trim();
                    user.IsLocked = false;

                    string salt = Encryption.GenerateSalt();
                    user.Password = Encryption.EncodePassword(Password.Text, salt);
                    user.PasswordSalt = salt;

                    user.LastPasswordChangeDate = DateTime.Now;
                    user.IncorrectPasswordAttemptCount = 0;

                    if (IsAdmin.Checked) user.Roles.Add(UserRole.Admin);
                    if (IsStandartUser.Checked) user.Roles.Add(UserRole.Standart);

                    // save user
                    userRepository.Save(user);

                    SuccessMessage.Text = "Account Created Successfully.";
                    ClearFields();
                }

                tran.Commit();
                UnitOfWork.Current.TransactionalFlush();
            }
        }

        private void ClearFields()
        {
            Name.Text = "";
            UserName.Text = "";
            EMail.Text = "";
            Password.Text = "";
            ConfirmPassword.Text = "";
            IsAdmin.Checked = false;
            IsStandartUser.Checked = true;
        }
    }
}