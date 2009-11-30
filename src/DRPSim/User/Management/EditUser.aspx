<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="DRPSim.User.Management.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
        Edit User Account
    </h2>
    <p>
		<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/User/Management/ListUsers.aspx">&lt;&lt; Return to the User Management Page</asp:HyperLink>
    </p>
    <p>
        Use the form below to edit selected user's account.
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
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
					ControlToValidate="EMail" CssClass="failureNotification" Display="Dynamic" 
					ErrorMessage="E-mail is not in correct form." 
					ToolTip="E-mail is not in correct form." 
					ValidationGroup="RegisterUserValidationGroup" 
					ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </p>
            <p>                
                <asp:CheckBox ID="IsAdmin" runat="server" Checked="false" Text="Has Administrator Privilages" Font-Bold="true"  CssClass="checkBoxEntry"></asp:CheckBox><br />
                <asp:CheckBox ID="IsController" runat="server" Checked="false" Text="Has Controller Privilages" Font-Bold="true"  CssClass="checkBoxEntry"></asp:CheckBox><br />
                <asp:CheckBox ID="IsStandartUser" runat="server" Checked="false" Text="Has Starndart User Privilages" Font-Bold="true" CssClass="checkBoxEntry"></asp:CheckBox>
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
                        Text="Update User" ValidationGroup="RegisterUserValidationGroup"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
