<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="DRPSim.User.Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
        Edit My Account
    </h2>
    <p>
        Use the form below to edit your account.
    </p>   
    
    <p>
		You can change your password in <asp:HyperLink NavigateUrl="~/User/ChangePassword.aspx" runat="server">Change Password Page</asp:HyperLink>
    </p>
    
    <span class="failureNotification">
        <asp:Literal ID="ErrorMessage" EnableViewState="false" runat="server"></asp:Literal>
    </span>
    
    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
         ValidationGroup="RegisterUserValidationGroup"/>
    
    <div class="accountInfo">
        <fieldset class="register">
            <legend>Account Information</legend>
            <p>
                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">User Name:</asp:Label>
                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is required." 
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </p>
            <p>
                <asp:Label ID="NameLabel" runat="server" AssociatedControlID="Name">Name:</asp:Label>
                <asp:TextBox ID="Name" runat="server" CssClass="textEntry"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NameRequired" runat="server" ControlToValidate="Name" 
                     CssClass="failureNotification" ErrorMessage="Name is required." ToolTip="Name is required." 
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </p>
            <p>
                <asp:Label ID="EMailLabel" runat="server" AssociatedControlID="EMail">E-mail:</asp:Label>
                <asp:TextBox ID="EMail" runat="server" CssClass="textEntry"></asp:TextBox>
                <asp:RequiredFieldValidator ID="EMailRequired" runat="server" ControlToValidate="EMail" 
                     CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
                     ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">*</asp:RequiredFieldValidator>                
            	<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
					ControlToValidate="EMail" CssClass="failureNotification" Display="Dynamic" 
					ErrorMessage="E-mail is not in correct form." 
					ToolTip="E-mail is not in correct form." 
					ValidationGroup="RegisterUserValidationGroup" 
					ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                
            </p>
                        
        </fieldset>
        <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;">
            <tr>
                <td>
                    <span class="successNotification">
                        <asp:Literal ID="SuccessMessage" EnableViewState="false" runat="server"></asp:Literal>
                    </span>
                </td>	        
                <td>
                    <asp:Button ID="CreateUserButton" runat="server" OnClick="Submit_Click" CssClass="submitButton" 
                        Text="Save" ValidationGroup="RegisterUserValidationGroup"/>
                </td>
            </tr>
        </table>       
    </div>
</asp:Content>
