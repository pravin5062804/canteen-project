<%@ Page Title="Edit Complaint Status" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditComplaint.aspx.cs" Inherits="CanteenComplaintSystem.EditComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-card">
        <h1 class="page-header-title">Admin Complaint Status Editor</h1>
        <p class="page-header-desc">
            Update resolution status, category, and administrative notes for complaint records.
        </p>
    </div>

    <div class="card-container" style="max-width: 800px; margin: 0 auto 2rem auto;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
            <h2 class="card-title" style="margin: 0;">&#128736; Edit Record #<asp:Label ID="lblComplaintIdHeader" runat="server"></asp:Label></h2>
            <a href="ManageComplaints.aspx" class="btn btn-secondary" style="font-size: 0.85rem;">&larr; Back to Admin Console</a>
        </div>

        <!-- Status Message Banner -->
        <asp:Panel ID="pnlEditStatus" runat="server" Visible="false">
            <asp:Literal ID="litEditStatus" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="form-group">
            <label class="form-label">Student Name</label>
            <asp:TextBox ID="txtStudentName" runat="server" CssClass="form-control" ReadOnly="true" Style="background-color: #f1f5f9;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label">Student Email</label>
            <asp:TextBox ID="txtStudentEmail" runat="server" CssClass="form-control" ReadOnly="true" Style="background-color: #f1f5f9;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label class="form-label">Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                <asp:ListItem Value="Food Quality">Food Quality &amp; Taste</asp:ListItem>
                <asp:ListItem Value="Hygiene">Hygiene &amp; Cleanliness</asp:ListItem>
                <asp:ListItem Value="Service Speed">Service Speed &amp; Wait Time</asp:ListItem>
                <asp:ListItem Value="Staff Behavior">Staff Behavior &amp; Assistance</asp:ListItem>
                <asp:ListItem Value="Billing">Billing &amp; Payment Errors</asp:ListItem>
                <asp:ListItem Value="Other">Other Issues</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label class="form-label">Resolution Status <span style="color: var(--danger-color);">*</span></label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" Style="font-weight: 700;">
                <asp:ListItem Value="Pending">🟡 Pending (Under Review)</asp:ListItem>
                <asp:ListItem Value="In Progress">🔵 In Progress (Investigation Active)</asp:ListItem>
                <asp:ListItem Value="Resolved">🟢 Resolved (Completed)</asp:ListItem>
                <asp:ListItem Value="Rejected">🔴 Rejected (Invalid / Out of Scope)</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label class="form-label">Student Incident Description</label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" ReadOnly="true" Style="background-color: #f1f5f9;"></asp:TextBox>
        </div>

        <div style="margin-top: 1.5rem; display: flex; gap: 1rem;">
            <asp:Button ID="btnSave" runat="server" Text="Save Status &amp; Update Record" CssClass="btn btn-primary" OnClick="btnSave_Click" />
            <a href="ManageComplaints.aspx" class="btn btn-secondary">Cancel</a>
        </div>
    </div>
</asp:Content>
