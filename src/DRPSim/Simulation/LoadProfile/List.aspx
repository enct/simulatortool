<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="List.aspx.cs" Inherits="DRPSim.Simulation.LoadProfile.List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <script type="text/javascript">
        function confirmDelete() {
            return confirm("Are you sure you want to delete this load profile.\n\nThis operation cannot be rolled back!");
        }		
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Load Profile Management
    </h2>
    <p>
        See the grid below to see the load profiles exist in the system.<br />        
    </p>
    <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; padding-bottom: 3px;">
        <tr>
            <td>
                <span class="successNotification">
                    <asp:Literal ID="SuccessMessage" EnableViewState="false" runat="server"></asp:Literal>
                </span>
            </td>
            <td style="text-align: right">
                <asp:HyperLink ID="ImportLoadProfile" runat="server" NavigateUrl="Import.aspx"
                    Font-Underline="false">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Assets/images/i_add.png" Style="vertical-align: bottom;" />
                    <asp:Label ID="Label1" runat="server" Text="Import New LoadProfile" />
                </asp:HyperLink>
            </td>
        </tr>
    </table>
    <div class="clear">
    </div>
    <asp:GridView ID="LoadProfilesGrid" runat="server" AutoGenerateColumns="False" DataSourceID="UsersObjectDataSource"
        OnRowCommand="LoadProfilesGrid_RowCommand" OnRowDataBound="LoadProfilesGrid_RowDataBound" AllowPaging="True"
        PageSize="15" OnPageIndexChanging="LoadProfilesGrid_PageIndexChanging" AllowSorting="True">
        <Columns>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="Edit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("Id") %>'
                        ImageUrl="~/Assets/images/i_edit.gif" ToolTip="Edit" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="Export" runat="server" CommandName="Export" CommandArgument='<%# Eval("Id") %>'
                        ImageUrl="~/Assets/images/i_application_go.png" ToolTip="Export to Excel file" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemStyle Width="30px" />
                <ItemTemplate>
                    <asp:ImageButton ID="DeleteLoadProfile" runat="server" CommandName="DeleteLoadProfile" OnClientClick="return confirmDelete();"
                        CommandArgument='<%# Eval("Id") %>' ImageUrl="~/Assets/images/i_delete.gif" ToolTip="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="loadProfile.Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="loadProfile.Description" />            
            <asp:BoundField DataField="DateCreated" HeaderText="Date Created" SortExpression="loadProfile.DateCreated" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" SelectMethod="GetAllLoadProfiles"
        EnablePaging="true" TypeName="DRPSim.Query.LoadProfileQuery, DRPSim" StartRowIndexParameterName="startIndex"
        MaximumRowsParameterName="pageSize" SortParameterName="sortBy" SelectCountMethod="GetTotalLoadProfileCount">
    </asp:ObjectDataSource>
</asp:Content>
