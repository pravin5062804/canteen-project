<%@ Page Title="Activity Audit Logs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewLogs.aspx.cs" Inherits="CanteenComplaintSystem.ViewLogs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Banner -->
    <div class="page-header-card">
        <h1 class="page-header-title">XML Audit Trail &amp; System Log Viewer</h1>
        <p class="page-header-desc">
            Real-time audit log stream populated directly from <code>App_Data/ActivityLog.xml</code> using LINQ to XML (<code>XDocument</code>).
        </p>
    </div>

    <div class="card-container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem;">
            <h2 class="card-title" style="margin: 0;">&#128220; System Activity Stream</h2>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <span style="font-size: 0.85rem; color: var(--text-secondary);">Source: <code>App_Data/ActivityLog.xml</code></span>
                <asp:Button ID="btnRefreshLogs" runat="server" Text="&#128259; Refresh Log Stream" CssClass="btn btn-secondary" OnClick="btnRefreshLogs_Click" Style="font-size: 0.85rem; padding: 0.4rem 0.9rem;" />
            </div>
        </div>

        <!-- Log Status Banner -->
        <asp:Panel ID="pnlLogStatus" runat="server" Visible="false">
            <asp:Literal ID="litLogStatus" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="table-responsive">
            <asp:GridView ID="gvActivityLogs" runat="server" 
                AllowPaging="True" 
                PageSize="10" 
                AutoGenerateColumns="False" 
                CssClass="custom-grid" 
                OnPageIndexChanging="gvActivityLogs_PageIndexChanging"
                EmptyDataText="No audit log entries recorded yet in App_Data/ActivityLog.xml.">
                <Columns>
                    <asp:BoundField DataField="Timestamp" HeaderText="Log Timestamp" HeaderStyle-Width="180px" />
                    
                    <asp:TemplateField HeaderText="Action Executed" HeaderStyle-Width="200px">
                        <ItemTemplate>
                            <span class="badge" style="background-color: var(--primary-light); color: var(--primary-color); border: 1px solid #bfdbfe;">
                                <%# Eval("Action") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="Details" HeaderText="Detailed Event Information" />
                </Columns>
                <PagerStyle CssClass="pager-row" HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
