<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="DRPSim.User.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
		Change Password
	</h2>
		
	<span class="failureNotification">
		<asp:Literal ID="FailureText" EnableViewState="false" runat="server"></asp:Literal>
	</span>
	
	<asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
		ValidationGroup="RegisterUserValidationGroup" />
	
	<div class="accountInfo">
		<fieldset class="login">
			<legend>Change My Password</legend>
			
			<p>
                <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Current Password:</asp:Label>
                <asp:TextBox ID="CurrentPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CurrentPassword" 
                     CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Current Password is required." 
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 					 ErrorMessage="Password length must be minimum 6 characters length." ValidationExpression="[\w\s]{6,255}" 
					 ValidationGroup="RegisterUserValidationGroup" ControlToValidate="CurrentPassword" Display="Dynamic">*</asp:RegularExpressionValidator>
            </p>
			<p>
                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                     CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 					 ErrorMessage="Password length must be minimum 6 characters length." ValidationExpression="[\w\s]{6,255}" 
					 ValidationGroup="RegisterUserValidationGroup" ControlToValidate="Password" Display="Dynamic">*</asp:RegularExpressionValidator>
            </p>
            <p>
                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification" Display="Dynamic" 
                     ErrorMessage="Confirm Password is required." ID="ConfirmPasswordRequired" runat="server" 
                     ToolTip="Confirm Password is required." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                     CssClass="failureNotification" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match."
                     ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
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
                   <asp:Button ID="Change" runat="server" CssClass="submitButton"
				        Text="Change Password" ValidationGroup="RegisterUserValidationGroup" 
				        onclick="Change_Click" />
                </td>
            </tr>
        </table>   		
	</div>
</asp:Content>
