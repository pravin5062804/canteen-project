<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="CanteenComplaintSystem.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-card" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); text-align: center;">
        <h1 class="page-header-title">Campus Canteen Admin Portal</h1>
        <p class="page-header-desc">
            Authorized Administrator Authentication Console
        </p>
    </div>

    <div class="card-container" style="max-width: 460px; margin: 0 auto 3rem auto; padding: 2.25rem;">
        <div style="text-align: center; margin-bottom: 1.5rem;">
            <div style="font-size: 2.5rem; margin-bottom: 0.5rem;">&#128274;</div>
            <h2 class="card-title" style="justify-content: center; margin-bottom: 0.25rem;">Admin Sign In</h2>
            <p style="font-size: 0.875rem; color: var(--text-secondary);">Enter administrator credentials to manage complaints.</p>
        </div>

        <!-- Login Error Alert Banner -->
        <asp:Panel ID="pnlLoginError" runat="server" CssClass="alert-banner alert-danger" Visible="false">
            <asp:Literal ID="litLoginError" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="form-group">
            <label class="form-label" for="txtUsername">Admin Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username (e.g. admin)"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                ControlToValidate="txtUsername" 
                ErrorMessage="Username is required." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="form-label" for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                ControlToValidate="txtPassword" 
                ErrorMessage="Password is required." 
                CssClass="validator-error" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>

        <div style="margin-top: 1.5rem;">
            <asp:Button ID="btnLogin" runat="server" Text="Sign In to Admin Console" CssClass="btn btn-primary" Style="width: 100%; padding: 0.85rem;" OnClick="btnLogin_Click" />
        </div>

        <div style="margin-top: 1.5rem; padding-top: 1.25rem; border-top: 1px solid var(--border-color); font-size: 0.825rem; color: var(--text-muted); text-align: center;">
            🔑 Default Credentials: Username <strong>admin</strong> | Password <strong>admin123</strong>
        </div>
    </div>
</asp:Content>
