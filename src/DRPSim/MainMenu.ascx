<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.ascx.cs" Inherits="DRPSim.MainMenu" %>
<% if(Context.User.Identity.IsAuthenticated) { %>
    <a href="#NavigationMenu_SkipLink"></a>
    
    <div class="menu" id="NavigationMenu" style="float: left;">
	    <ul class="level1">
		    <li style="position: relative; float: left;"><asp:HyperLink ID="HyperLink1" NavigateUrl="~/Default.aspx" Text="Home" runat="server"></asp:HyperLink></li>
		    <li style="position: relative; float: left;"><asp:HyperLink ID="HyperLink2" NavigateUrl="~/User/Edit.aspx" Text="My Profile" runat="server"></asp:HyperLink></li>					
    		
		    <% if(Context.User.IsInRole("Admin")) { %>
		    <li style="position: relative; float: left;"><asp:HyperLink ID="HyperLink4" NavigateUrl="~/User/Management/ListUsers.aspx" Text="Manage Users" runat="server"></asp:HyperLink></li>
		    <% } %>		    	    
		    
	    </ul>
    </div>
    
    <div style="clear: left;"></div>
    
    <a id="NavigationMenu_SkipLink"></a>
<% } %>