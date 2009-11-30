<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LockedUsers.aspx.cs" Inherits="DRPSim.User.Management.LockedUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">	
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<h2>
        Locked Users
    </h2>
    <p>
        See the grid below to see the locked users in the system.<br />
        You can edit his/her properties and reactivate them.<br />
        To manage currently active users go to the <asp:HyperLink ID="GoToUnLockedUsersPageLink" runat="server" NavigateUrl="ListUsers.aspx" Text="Active Users Management Page"></asp:HyperLink>
    </p>     
	
	<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; padding-bottom: 3px;">
	    <tr>
	        <td>
	            <span class="successNotification">
                    <asp:Literal ID="SuccessMessage" EnableViewState="false" runat="server"></asp:Literal>
                </span>
	        </td>
	        <td style="text-align: right">
	            &nbsp;	           
	        </td>
	    </tr>
	</table>		
	<div class="clear"></div>
	<asp:GridView ID="UsersGrid" runat="server" AutoGenerateColumns="False" 
		DataSourceID="UsersObjectDataSource" onrowcommand="UsersGrid_RowCommand" 
        onrowdatabound="UsersGrid_RowDataBound" AllowPaging="True" PageSize="15"
        onpageindexchanging="UsersGrid_PageIndexChanging" AllowSorting="True">		
		<Columns>
			<asp:TemplateField>
				<ItemStyle Width="30px" />
				<ItemTemplate>
					<asp:ImageButton ID="Edit" runat="server" CommandName="EditUser" CommandArgument='<%# Eval("Id") %>' ImageUrl="~/Assets/images/i_edit.gif" ToolTip="Edit User" />
				</ItemTemplate>
			</asp:TemplateField>
			
			<asp:TemplateField>
				<ItemStyle Width="30px" />
				<ItemTemplate>
					<asp:ImageButton ID="UnlockUser" runat="server" CommandName="UnlockUser" CommandArgument='<%# Eval("Id") %>' ImageUrl="~/Assets/images/i_application_go.png" ToolTip="Unlock User" />
				</ItemTemplate>
			</asp:TemplateField>			
			
			<asp:BoundField DataField="Name" HeaderText="Name" 
                SortExpression="Name" /><asp:BoundField DataField="UserName" 
                HeaderText="Username" SortExpression="UserName" /><asp:TemplateField 
                HeaderText="E-mail" SortExpression="EMail"><ItemTemplate>
				    <a href='<%# Eval("EMail", "mailto://{0}") %>'><%# Eval("EMail") %></a></ItemTemplate></asp:TemplateField><asp:TemplateField 
                HeaderText="Last Login" SortExpression="LastSuccessfulLoginDate"><ItemTemplate>
					<asp:Literal ID="LastLogin" runat="server" Text="" />
				</ItemTemplate>
			</asp:TemplateField>
						
			<asp:TemplateField HeaderText="A">
				<ItemTemplate>				    
					<asp:Image ID="IsAdmin" runat="server" 
						ImageUrl="~/Assets/images/i_delete.gif"
						ToolTip="User is NOT an Administrator." />
				</ItemTemplate>
			<ItemStyle Width="20px" /></asp:TemplateField>			
			<asp:TemplateField HeaderText="S">
				<ItemTemplate>				    
					<asp:Image ID="IsStandart" runat="server" 
						ImageUrl="~/Assets/images/i_delete.gif"
						ToolTip="User is NOT a standart user." />
				</ItemTemplate>
			    <ItemStyle Width="20px" />
			</asp:TemplateField>
		</Columns>		
	</asp:GridView>
	<asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" SelectMethod="GetAllLockedUsers" EnablePaging="true"
	    TypeName="DRPSim.Query.UserQuery, DRPSim" StartRowIndexParameterName="startIndex" MaximumRowsParameterName="pageSize" SortParameterName="sortBy"
	    SelectCountMethod="GetTotalLockedUsersCount"></asp:ObjectDataSource>
</asp:Content>
