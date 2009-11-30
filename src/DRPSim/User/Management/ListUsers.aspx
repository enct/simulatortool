<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ListUsers.aspx.cs" Inherits="DRPSim.User.Management.ListUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <script type="text/javascript">
        function confirmLock() {
            return confirm("Are you sure you want to lock this user?\n\nLocked users cannot login and operate on the site.\nIf necessary locked users can be activated later.");
        }		
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        User Management
    </h2>
    <p>
        See the grid below to see the registered users in the system.<br />
        You can edit user's properties and reset his/her password.<br />
        To unlock previously locked users go to the
        <asp:HyperLink ID="GoToLockedUsersPageLink" runat="server" NavigateUrl="LockedUsers.aspx"
            Text="Locked Users Page"></asp:HyperLink>
    </p>
    <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; padding-bottom: 3px;">
        <tr>
            <td>
                <span class="successNotification">
                    <asp:Literal ID="SuccessMessage" EnableViewState="false" runat="server"></asp:Literal>
                </span>
            </td>
            <td style="text-align: right">
                <asp:HyperLink ID="NewUser" runat="server" NavigateUrl="~/User/Management/CreateUser.aspx"
                    Font-Underline="false">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Assets/images/i_add.png" Style="vertical-align: bottom;" />
                    <asp:Label ID="Label1" runat="server" Text="Create New User" />
                </asp:HyperLink>
            </td>
        </tr>
    </table>
    <div class="clear">
    </div>
    <asp:GridView ID="UsersGrid" runat="server" AutoGenerateColumns="False" DataSourceID="UsersObjectDataSource"
        OnRowCommand="UsersGrid_RowCommand" OnRowDataBound="UsersGrid_RowDataBound" AllowPaging="True"
        PageSize="15" OnPageIndexChanging="UsersGrid_PageIndexChanging" AllowSorting="True">
        <Columns>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="Edit" runat="server" CommandName="EditUser" CommandArgument='<%# Eval("Id") %>'
                        ImageUrl="~/Assets/images/i_edit.gif" ToolTip="Edit User" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="ResetPassword" runat="server" CommandName="ResetPassword" CommandArgument='<%# Eval("Id") %>'
                        ImageUrl="~/Assets/images/i_key.png" ToolTip="Reset User Password" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="LockUser" runat="server" CommandName="LockUser" OnClientClick="return confirmLock();"
                        CommandArgument='<%# Eval("Id") %>' ImageUrl="~/Assets/images/i_delete.gif" ToolTip="Lock User" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
            <asp:TemplateField HeaderText="E-mail" SortExpression="EMail">
                <ItemTemplate>
                    <a href='<%# Eval("EMail", "mailto://{0}") %>'>
                        <%# Eval("EMail") %></a></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Last Login" SortExpression="LastSuccessfulLoginDate">
                <ItemTemplate>
                    <asp:Literal ID="LastLogin" runat="server" Text="" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="A">
                <ItemTemplate>
                    <asp:Image ID="IsAdmin" runat="server" ImageUrl="~/Assets/images/i_delete.gif" ToolTip="User is NOT an Administrator." />
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="S">
                <ItemTemplate>
                    <asp:Image ID="IsStandart" runat="server" ImageUrl="~/Assets/images/i_delete.gif"
                        ToolTip="User is NOT a standart user." />
                </ItemTemplate>
                <ItemStyle Width="20px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" SelectMethod="GetAllUnLockedUsers"
        EnablePaging="true" TypeName="DRPSim.Query.UserQuery, DRPSim" StartRowIndexParameterName="startIndex"
        MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="GetTotalUnlockedUsersCount">
    </asp:ObjectDataSource>
</asp:Content>
