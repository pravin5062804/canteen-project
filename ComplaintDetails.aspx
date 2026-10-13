<%@ Page Title="Complaint Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ComplaintDetails.aspx.cs" Inherits="CanteenComplaintSystem.ComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Banner -->
    <div class="page-header-card">
        <h1 class="page-header-title">Complaint Audit &amp; Full Record</h1>
        <p class="page-header-desc">
            Detailed investigation summary and status record driven by QueryString parameter.
        </p>
    </div>

    <div class="card-container" style="max-width: 900px; margin: 0 auto 2rem auto;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
            <h2 class="card-title" style="margin: 0;">&#128269; Complaint Specifications</h2>
            <div>
                <a href="ManageComplaints.aspx" class="btn btn-secondary" style="font-size: 0.85rem;">&larr; Return to Management Console</a>
                <a href="ViewComplaints.aspx" class="btn btn-secondary" style="font-size: 0.85rem; margin-left: 0.5rem;">View All Complaints</a>
            </div>
        </div>

        <!-- Status Alert Banner -->
        <asp:Panel ID="pnlDetailsError" runat="server" CssClass="alert-banner alert-danger" Visible="false">
            <asp:Literal ID="litDetailsError" runat="server"></asp:Literal>
        </asp:Panel>

        <!-- DetailsView Control driven by QueryString (ID) -->
        <asp:DetailsView ID="dvComplaintDetails" runat="server" 
            AutoGenerateRows="False" 
            CssClass="custom-detailsview"
            HeaderStyle-CssClass="field-header" 
            FieldHeaderStyle-CssClass="field-header"
            RowStyle-CssClass="field-value">
            <Fields>
                <asp:TemplateField HeaderText="Complaint Ref ID">
                    <ItemTemplate>
                        <strong>#<%# Eval("ComplaintId") %></strong>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="StudentName" HeaderText="Student Full Name" />
                <asp:BoundField DataField="StudentEmail" HeaderText="Student Email Address" />
                <asp:BoundField DataField="Category" HeaderText="Complaint Category" />
                <asp:BoundField DataField="IncidentDate" HeaderText="Incident Occurred Date" DataFormatString="{0:yyyy-MM-dd (dddd)}" />
                <asp:BoundField DataField="SubmittedDate" HeaderText="Lodge Timestamp" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />

                <asp:TemplateField HeaderText="Current Status">
                    <ItemTemplate>
                        <span class='<%# GetStatusBadgeCss(Eval("Status")) %>'>
                            <%# Eval("Status") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Full Incident Description">
                    <ItemTemplate>
                        <div style="background: #f8fafc; padding: 1rem; border-radius: var(--radius-sm); border: 1px solid var(--border-color); white-space: pre-wrap; font-family: inherit;">
                            <%# Eval("Description") %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
        </asp:DetailsView>

        <!-- Audit Action Footer -->
        <div style="background: var(--primary-light); padding: 1.25rem; border-radius: var(--radius-md); border: 1px solid #bfdbfe; margin-top: 1.5rem; font-size: 0.9rem; color: var(--text-secondary);">
            <strong>&#128204; Audit Information:</strong> This record was generated dynamically from <code>CanteenDB</code> via parameterized SQL query and logged to <code>App_Data/ActivityLog.xml</code>.
        </div>
    </div>
</asp:Content>
