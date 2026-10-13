<%@ Page Title="Browse Complaints" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewComplaints.aspx.cs" Inherits="CanteenComplaintSystem.ViewComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-card">
        <h1 class="page-header-title">Browse Student Complaints &amp; Status</h1>
        <p class="page-header-desc">
            Public transparent log of registered campus canteen complaints and current resolution status.
        </p>
    </div>

    <div class="card-container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem;">
            <h2 class="card-title" style="margin: 0;">&#128202; Registered Complaints Stream</h2>
            <a href="SubmitComplaint.aspx" class="btn btn-primary" style="font-size: 0.85rem;">&#10133; Submit New Complaint</a>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvPublicComplaints" runat="server" 
                AllowPaging="True" 
                PageSize="10" 
                AutoGenerateColumns="False" 
                CssClass="custom-grid" 
                OnPageIndexChanging="gvPublicComplaints_PageIndexChanging"
                EmptyDataText="No complaints have been submitted yet. Be the first to lodge feedback!">
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="ComplaintId" 
                        DataNavigateUrlFormatString="ComplaintDetails.aspx?ID={0}" 
                        DataTextField="ComplaintId" 
                        DataTextFormatString="#{0}"
                        HeaderText="ID" 
                        HeaderStyle-Width="70px" />

                    <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="IncidentDate" HeaderText="Incident Date" DataFormatString="{0:yyyy-MM-dd}" />

                    <asp:TemplateField HeaderText="Resolution Status">
                        <ItemTemplate>
                            <span class='<%# GetStatusBadgeCss(Eval("Status")) %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="SubmittedDate" HeaderText="Submitted Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />

                    <asp:HyperLinkField DataNavigateUrlFields="ComplaintId" 
                        DataNavigateUrlFormatString="ComplaintDetails.aspx?ID={0}" 
                        Text="View Details &rarr;" 
                        HeaderText="Details" />
                </Columns>
                <PagerStyle CssClass="pager-row" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
