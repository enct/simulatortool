<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
	CodeBehind="Edit.aspx.cs" Inherits="DRPSim.Simulation.LoadProfile.Edit" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	
	<h2>
        Edit Load Profile
    </h2>
	<p>
		<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="List.aspx">&lt;&lt; Return to the Load Profile Management Page</asp:HyperLink>
    </p>
    <p>
        Use the form below to edit the load profile.
    </p>    
    
    <span class="failureNotification">
        <asp:Literal ID="ErrorMessage" EnableViewState="false" runat="server"></asp:Literal>
    </span>
    
    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
         ValidationGroup="RegisterUserValidationGroup"/>
    
    <div class="accountInfo">
        <fieldset class="register">
            <legend>Load Profile Information</legend>            
            <p>
                <asp:Label ID="NameLabel" runat="server" AssociatedControlID="Name">Name:</asp:Label>
                <asp:TextBox ID="Name" runat="server" CssClass="textEntry"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NameRequired" runat="server" ControlToValidate="Name" 
                     CssClass="failureNotification" ErrorMessage="Name is required." ToolTip="Name is required." 
                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </p>
            <p>
                <asp:Label ID="DescriptionLabel" runat="server" AssociatedControlID="Description">Comments:</asp:Label>
                <asp:TextBox ID="Description" runat="server" CssClass="textEntry" TextMode="MultiLine" Rows="5" style="width: 99%"></asp:TextBox>                
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
                         Text="Update Load Profile" ValidationGroup="RegisterUserValidationGroup"/>
                </td>
            </tr>
        </table>       
    </div>

</asp:Content>