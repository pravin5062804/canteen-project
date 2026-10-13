<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="CanteenComplaintSystem.Controls.Header" %>
<header class="header-navbar">
    <div class="header-container">
        <div class="brand-section">
            <div class="brand-logo">
                <span class="logo-icon">&#127869;</span>
            </div>
            <div class="brand-text">
                <h1 class="brand-title">Canteen Complaint System</h1>
                <span class="brand-subtitle">Student Service Portal &amp; Quality Management</span>
            </div>
        </div>
        <div class="header-actions">
            <div class="status-pill">
                <span class="status-indicator online"></span>
                <span class="status-text">System Online</span>
            </div>
            <div class="user-profile-badge">
                <asp:Literal ID="litUserBadge" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
</header>
