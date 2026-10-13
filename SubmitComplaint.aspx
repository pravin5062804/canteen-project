<%@ Page Title="Submit Complaint" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubmitComplaint.aspx.cs" Inherits="CanteenComplaintSystem.SubmitComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Banner -->
    <div class="page-header-card">
        <h1 class="page-header-title">Lodge Canteen Complaint / Feedback</h1>
        <p class="page-header-desc">
            Report food quality issues, hygiene concerns, or staff feedback to help us improve campus dining.
        </p>
    </div>

    <!-- AdRotator Control displaying Canteen Announcements -->
    <div class="ad-rotator-wrapper">
        <div style="display: flex; align-items: center; gap: 1rem;">
            <span class="ad-rotator-tag">Canteen Bulletin</span>
            <div style="font-size: 0.9rem; color: var(--text-secondary);">
                <strong>Latest Announcement &amp; Offers:</strong>
            </div>
        </div>
        <div>
            <asp:AdRotator ID="AdRotatorCanteen" runat="server" AdvertisementFile="~/App_Data/ads.xml" Target="_blank" />
        </div>
    </div>

    <!-- Complaint Form Container -->
    <div class="card-container" style="max-width: 800px; margin: 0 auto 2rem auto;">
        <h2 class="card-title">&#128221; Student Complaint Form</h2>

        <!-- Status Message Banner -->
        <asp:Panel ID="pnlStatus" runat="server" Visible="false">
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
        </asp:Panel>

        <div class="form-group">
            <label class="form-label" for="txtFullName">Full Name <span style="color: var(--danger-color);">*</span></label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                ControlToValidate="txtFullName" 
                ErrorMessage="Full Name is required." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtEmail">Student Email <span style="color: var(--danger-color);">*</span></label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="e.g. student@campus.edu"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                ControlToValidate="txtEmail" 
                ErrorMessage="Student email is required." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                ControlToValidate="txtEmail" 
                ErrorMessage="Please enter a valid email address." 
                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="ddlCategory">Complaint Category <span style="color: var(--danger-color);">*</span></label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">-- Select Category --</asp:ListItem>
                <asp:ListItem Value="Food Quality">Food Quality &amp; Taste</asp:ListItem>
                <asp:ListItem Value="Hygiene">Hygiene &amp; Cleanliness</asp:ListItem>
                <asp:ListItem Value="Service Speed">Service Speed &amp; Wait Time</asp:ListItem>
                <asp:ListItem Value="Staff Behavior">Staff Behavior &amp; Assistance</asp:ListItem>
                <asp:ListItem Value="Billing">Billing &amp; Payment Errors</asp:ListItem>
                <asp:ListItem Value="Other">Other Issues</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" 
                ControlToValidate="ddlCategory" 
                InitialValue="0" 
                ErrorMessage="Please select a complaint category." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label">Incident Date <span style="color: var(--danger-color);">*</span></label>
            <div style="background: #f8fafc; padding: 1rem; border-radius: var(--radius-sm); border: 1px solid var(--border-color);">
                <asp:Calendar ID="calIncidentDate" runat="server" 
                    OnSelectionChanged="calIncidentDate_SelectionChanged"
                    TitleStyle-BackColor="#3b82f6" TitleStyle-ForeColor="#ffffff" TitleStyle-Font-Bold="true"
                    NextPrevStyle-ForeColor="#ffffff"
                    DayHeaderStyle-BackColor="#e2e8f0" DayHeaderStyle-Font-Bold="true"
                    SelectedDayStyle-BackColor="#2563eb" SelectedDayStyle-ForeColor="#ffffff"
                    TodayDayStyle-BackColor="#fef3c7" TodayDayStyle-ForeColor="#92400e">
                </asp:Calendar>
                <div style="margin-top: 0.5rem; font-size: 0.9rem; color: var(--text-secondary);">
                    Selected Incident Date: <strong><asp:Label ID="lblSelectedDate" runat="server" Text="Today"></asp:Label></strong>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtDescription">Detailed Description <span style="color: var(--danger-color);">*</span></label>
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" placeholder="Describe the incident clearly (time, location, specific items involved)..."></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                ControlToValidate="txtDescription" 
                ErrorMessage="Please provide a detailed description of your complaint." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <div style="margin-top: 1.5rem; display: flex; gap: 1rem; align-items: center;">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Complaint" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            <a href="Default.aspx" class="btn btn-secondary">Cancel</a>
        </div>
    </div>
</asp:Content>
