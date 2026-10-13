<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CanteenComplaintSystem.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Banner Card -->
    <div class="page-header-card">
        <h1 class="page-header-title">Welcome to Campus Canteen Quality Portal</h1>
        <p class="page-header-desc">
            Submit food and hygiene feedback, track complaint resolution in real-time, and ensure campus dining excellence.
        </p>
    </div>

    <!-- DB Connection Diagnostic Alert Banner -->
    <asp:Panel ID="pnlDbStatus" runat="server" CssClass="alert-banner alert-success" Visible="false">
        <asp:Literal ID="litDbStatus" runat="server"></asp:Literal>
    </asp:Panel>

    <!-- Dashboard Quick Metrics -->
    <div class="dashboard-grid">
        <div class="stat-card">
            <div class="stat-icon stat-blue">&#128203;</div>
            <div>
                <div class="stat-val">
                    <asp:Label ID="lblTotalComplaints" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Total Logged Complaints</div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon stat-amber">&#9251;</div>
            <div>
                <div class="stat-val">
                    <asp:Label ID="lblPendingComplaints" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Pending / In Progress</div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon stat-green">&#9989;</div>
            <div>
                <div class="stat-val">
                    <asp:Label ID="lblResolvedComplaints" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stat-label">Resolved Complaints</div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon stat-indigo">&#11088;</div>
            <div>
                <div class="stat-val">4.8 / 5</div>
                <div class="stat-label">Hygiene &amp; Resolution Score</div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Panel -->
    <div class="card-container">
        <h2 class="card-title">&#128640; Quick Actions</h2>
        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <a href="SubmitComplaint.aspx" class="btn btn-primary">&#10133; Lodge New Complaint</a>
            <a href="ViewComplaints.aspx" class="btn btn-secondary">&#128269; Browse All Complaints</a>
            <a href="ManageComplaints.aspx" class="btn btn-success">&#128736; Admin Management Console</a>
            <a href="ViewLogs.aspx" class="btn btn-secondary">&#128220; View Activity Audit Logs</a>
        </div>
    </div>

    <!-- Features Overview -->
    <div class="card-container">
        <h2 class="card-title">&#128161; Key Features of the Canteen Complaint System</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem;">
            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--primary-color); margin-bottom: 0.5rem;">
                    &#128227; Dynamic AdRotator Announcements
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">
                    Stay informed with daily canteen menus, special student discounts, and hygiene alerts powered by <code>App_Data/ads.xml</code>.
                </p>
            </div>
            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--primary-color); margin-bottom: 0.5rem;">
                    &#9889; ASP.NET AJAX &amp; UpdatePanels
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">
                    Admin portal allows instant status updates, dynamic sitemap category filtering, and paginated complaint resolution without page reloads.
                </p>
            </div>
            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--primary-color); margin-bottom: 0.5rem;">
                    &#128274; XML Audit Logging &amp; Parameterized SQL
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">
                    All complaint submissions and admin resolutions trigger safe <code>SqlCommand</code> parameterized queries and auto-append to <code>ActivityLog.xml</code> using LINQ to XML (<code>XDocument</code>).
                </p>
            </div>
        </div>
    </div>
</asp:Content>
