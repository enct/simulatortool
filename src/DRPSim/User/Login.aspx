<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
	CodeBehind="Login.aspx.cs" Inherits="DRPSim.User.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
		Log In
	</h2>
	<p>
		Please enter your username and password.
	</p>
	<span class="failureNotification">
		<asp:Literal ID="FailureText" EnableViewState="false" runat="server"></asp:Literal>
	</span>
	<asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
		ValidationGroup="LoginUserValidationGroup" />
	<div class="accountInfo">
		<fieldset class="login">
			<legend>Account Information</legend>
			<p>
				<asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
				<asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
				<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
					CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required."
					ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
			</p>
			<p>
				<asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
				<asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
				<asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
					CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required."
					ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
			</p>
			<p>
				<asp:CheckBox ID="RememberMe" runat="server" />
				<asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">Keep me logged in</asp:Label>
			</p>
		</fieldset>
		<p>
			<asp:Button ID="LoginButton" runat="server" CssClass="submitButton" OnClick="Submit_Click"
				Text="Log In" ValidationGroup="LoginUserValidationGroup" />
		</p>
	</div>
</asp:Content>
