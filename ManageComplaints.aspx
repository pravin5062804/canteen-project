<%@ Page Title="Manage Complaints" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageComplaints.aspx.cs" Inherits="CanteenComplaintSystem.ManageComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ScriptManager for ASP.NET AJAX Controls -->
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Header Banner -->
    <div class="page-header-card" style="background: linear-gradient(135deg, #1e293b 0%, #334155 100%);">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <div>
                <h1 class="page-header-title">Admin Complaint Management Portal</h1>
                <p class="page-header-desc">
                    Filter, review, and update canteen complaints with seamless ASP.NET AJAX UpdatePanels.
                </p>
            </div>
            <div>
                <a href="ViewLogs.aspx" class="btn btn-secondary" style="font-size: 0.85rem;">&#128220; View Activity Audit Logs</a>
                <a href="Logout.aspx" class="btn btn-secondary" style="font-size: 0.85rem; background: #fee2e2; color: #991b1b; margin-left: 0.5rem;">&#128682; Admin Sign Out</a>
            </div>
        </div>
    </div>

    <!-- UpdatePanel enclosing main management content -->
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <!-- Status Feedback Alert Banner -->
            <asp:Panel ID="pnlAdminStatus" runat="server" Visible="false">
                <asp:Label ID="lblAdminStatus" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Admin Layout: Side TreeView + Main Grid -->
            <div class="admin-layout-grid">
                
                <!-- Side Panel: TreeView displaying categories from web.sitemap -->
                <aside class="sidebar-panel">
                    <h3 class="sidebar-title">&#128193; Navigation &amp; Sitemap</h3>
                    <div class="treeview-container">
                        <asp:TreeView ID="TreeViewCategories" runat="server" 
                            DataSourceID="SiteMapDataSource1" 
                            ExpandDepth="2" 
                            ImageSet="BulletedList2"
                            NodeStyle-CssClass="treeview-node">
                        </asp:TreeView>
                    </div>
                    
                    <hr style="margin: 1.5rem 0; border: none; border-top: 1px solid var(--border-color);" />
                    
                    <h4 style="font-size: 0.95rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                        &#128202; Status Summary
                    </h4>
                    <ul style="list-style: none; font-size: 0.85rem; color: var(--text-secondary);">
                        <li style="margin-bottom: 0.4rem;">&#9990; Pending: <strong><asp:Label ID="lblCountPending" runat="server" Text="0"></asp:Label></strong></li>
                        <li style="margin-bottom: 0.4rem;">&#9989; Resolved: <strong><asp:Label ID="lblCountResolved" runat="server" Text="0"></asp:Label></strong></li>
                        <li>&#128200; Total Registered: <strong><asp:Label ID="lblCountTotal" runat="server" Text="0"></asp:Label></strong></li>
                    </ul>
                </aside>

                <!-- Main Content Area -->
                <section>
                    <!-- Filter Bar -->
                    <div class="filter-bar">
                        <div class="filter-group">
                            <label for="ddlStatusFilter" style="font-weight: 600; font-size: 0.9rem;">Filter by Status:</label>
                            <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="True" CssClass="form-control" Style="width: auto;" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                                <asp:ListItem Value="All">All Complaints</asp:ListItem>
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                                <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div style="font-size: 0.85rem; color: var(--text-secondary);">
                            Showing page size: <strong>5 items</strong> | Non-refresh AJAX UpdatePanel
                        </div>
                    </div>

                    <!-- GridView Container -->
                    <div class="card-container" style="padding: 1rem;">
                        <h3 class="card-title">&#128203; Active Complaint Records</h3>

                        <div class="table-responsive">
                            <asp:GridView ID="gvComplaints" runat="server" 
                                AllowPaging="True" 
                                PageSize="5" 
                                AutoGenerateColumns="False" 
                                DataKeyNames="ComplaintId"
                                CssClass="custom-grid" 
                                OnPageIndexChanging="gvComplaints_PageIndexChanging"
                                OnRowCommand="gvComplaints_RowCommand"
                                EmptyDataText="No complaints found matching the selected filter criteria.">
                                <Columns>
                                    <%-- HyperLinkField pointing to ComplaintDetails.aspx?ID={0} --%>
                                    <asp:HyperLinkField DataNavigateUrlFields="ComplaintId" 
                                        DataNavigateUrlFormatString="ComplaintDetails.aspx?ID={0}" 
                                        DataTextField="ComplaintId" 
                                        DataTextFormatString="#{0}"
                                        HeaderText="ID" 
                                        HeaderStyle-Width="60px" />

                                    <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" />
                                    <asp:BoundField DataField="IncidentDate" HeaderText="Incident Date" DataFormatString="{0:yyyy-MM-dd}" />

                                    <%-- Custom Status Badges --%>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='<%# GetStatusBadgeCss(Eval("Status")) %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="SubmittedDate" HeaderText="Submitted Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                                    <%-- Action Buttons --%>
                                    <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="180px">
                                        <ItemTemplate>
                                            <a href='<%# "EditComplaint.aspx?ID=" + Eval("ComplaintId") %>' class="btn btn-secondary" style="padding: 0.25rem 0.6rem; font-size: 0.78rem;">Edit</a>
                                            <asp:Button ID="btnResolve" runat="server" 
                                                CommandName="MarkResolved" 
                                                CommandArgument='<%# Eval("ComplaintId") %>' 
                                                Text="Resolve" 
                                                CssClass="btn btn-success" 
                                                Style="padding: 0.25rem 0.6rem; font-size: 0.78rem; margin-left: 0.25rem;"
                                                Visible='<%# Eval("Status").ToString() != "Resolved" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="pager-row" HorizontalAlign="Center" />
                            </asp:GridView>
                        </div>
                    </div>

                    <!-- Bottom DataList displaying cards of Recently Resolved Complaints -->
                    <div class="card-container" style="margin-top: 2rem;">
                        <h3 class="card-title">&#127881; Recently Resolved Complaints</h3>
                        
                        <asp:DataList ID="dlResolvedComplaints" runat="server" 
                            RepeatDirection="Horizontal" 
                            RepeatColumns="3" 
                            CssClass="resolved-datalist">
                            <ItemTemplate>
                                <div class="resolved-card">
                                    <div class="resolved-card-header">
                                        <span class="resolved-category"><%# Eval("Category") %></span>
                                        <span class="badge badge-resolved">Resolved</span>
                                    </div>
                                    <h4 class="resolved-title">Complaint #<%# Eval("ComplaintId") %> - <%# Eval("StudentName") %></h4>
                                    <p class="resolved-desc"><%# TruncateDescription(Eval("Description"), 80) %></p>
                                    <div class="resolved-meta">
                                        <span>Submitted: <%# Eval("SubmittedDate", "{0:MMM dd, yyyy}") %></span>
                                        <a href='<%# "ComplaintDetails.aspx?ID=" + Eval("ComplaintId") %>'>View Details &rarr;</a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>

                </section>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
