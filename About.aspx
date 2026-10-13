<%@ Page Title="Canteen Info & Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CanteenComplaintSystem.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Banner -->
    <div class="page-header-card">
        <h1 class="page-header-title">Campus Canteen Services &amp; Info Hub</h1>
        <p class="page-header-desc">
            Serving fresh, hygienic, and affordable meals across campus with 100% student satisfaction commitment.
        </p>
    </div>

    <!-- Operating Hours & Meal Schedule -->
    <div class="card-container">
        <h2 class="card-title">&#9251; Daily Operating Hours &amp; Meal Schedule</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(260px, 1fr)); gap: 1.5rem; margin-top: 1rem;">
            <div style="background: var(--primary-light); padding: 1.25rem; border-radius: var(--radius-md); border: 1px solid #bfdbfe;">
                <h3 style="color: var(--primary-hover); font-size: 1.1rem; font-weight: 700; margin-bottom: 0.5rem;">
                    &#127883; Breakfast Special
                </h3>
                <p style="font-size: 0.9rem; font-weight: 600; color: var(--text-primary);">7:30 AM – 10:30 AM (Mon – Sat)</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.4rem;">
                    Fresh South &amp; North Indian breakfasts, hot beverages, seasonal fruit bowls, and bakery items.
                </p>
            </div>

            <div style="background: #dcfce7; padding: 1.25rem; border-radius: var(--radius-md); border: 1px solid #bbf7d0;">
                <h3 style="color: #166534; font-size: 1.1rem; font-weight: 700; margin-bottom: 0.5rem;">
                    &#127869; Lunch Combo Hours
                </h3>
                <p style="font-size: 0.9rem; font-weight: 600; color: var(--text-primary);">12:00 PM – 3:00 PM (Daily)</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.4rem;">
                    Executive Thali combos, subsidized student lunches, salad bar, and daily chef specials.
                </p>
            </div>

            <div style="background: #fef3c7; padding: 1.25rem; border-radius: var(--radius-md); border: 1px solid #fde68a;">
                <h3 style="color: #92400e; font-size: 1.1rem; font-weight: 700; margin-bottom: 0.5rem;">
                    &#9749; Snacks &amp; Evening Refreshments
                </h3>
                <p style="font-size: 0.9rem; font-weight: 600; color: var(--text-primary);">4:00 PM – 7:30 PM (Mon – Sat)</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary); margin-top: 0.4rem;">
                    Hot tea &amp; coffee, grilled sandwiches, fresh juices, samosas, and evening snacks.
                </p>
            </div>
        </div>
    </div>

    <!-- Canteen Outlets Directory -->
    <div class="card-container">
        <h2 class="card-title">&#127970; Campus Canteen Outlets Directory</h2>
        <div class="table-responsive">
            <table class="custom-grid">
                <thead>
                    <tr>
                        <th>Outlet Name</th>
                        <th>Campus Location</th>
                        <th>Seating Capacity</th>
                        <th>Specialty / Service</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Central Dining Hall</strong></td>
                        <td>Block A, Ground Floor</td>
                        <td>450 Seats</td>
                        <td>Full Course Meals, Thali Combos, Salad Bar</td>
                    </tr>
                    <tr>
                        <td><strong>Express Food Court</strong></td>
                        <td>Block C, Student Activity Center</td>
                        <td>200 Seats</td>
                        <td>Quick Bites, Beverages, Sandwiches, Wraps</td>
                    </tr>
                    <tr>
                        <td><strong>Staff &amp; Faculty Lounge</strong></td>
                        <td>Block B, 1st Floor</td>
                        <td>120 Seats</td>
                        <td>Executive Lunch, Coffee Lounge, Quiet Dining</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Quality Standards & Contact Support -->
    <div class="card-container">
        <h2 class="card-title">&#128222; Canteen Management &amp; Support Contacts</h2>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem;">
            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                    &#128104; Canteen Administrative Manager
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">Mr. Robert Vance</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128231; Email: <a href="mailto:canteen-manager@campus.edu">canteen-manager@campus.edu</a></p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128222; Office Phone: Ext 4400</p>
            </div>

            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                    &#9989; Hygiene &amp; Quality Inspector
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">Dr. Sarah Jenkins (Food Safety Dept)</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128231; Email: <a href="mailto:hygiene-officer@campus.edu">hygiene-officer@campus.edu</a></p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128222; Helpline: Ext 4401</p>
            </div>

            <div>
                <h4 style="font-size: 1rem; font-weight: 700; color: var(--text-primary); margin-bottom: 0.5rem;">
                    &#128105; Student Welfare Committee
                </h4>
                <p style="font-size: 0.9rem; color: var(--text-secondary);">Student Affairs Council Representatives</p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128231; Email: <a href="mailto:student-welfare@campus.edu">student-welfare@campus.edu</a></p>
                <p style="font-size: 0.85rem; color: var(--text-secondary);">&#128205; Office: Block A, Room 102</p>
            </div>
        </div>
    </div>
</asp:Content>
