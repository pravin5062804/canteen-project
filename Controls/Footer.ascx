<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="CanteenComplaintSystem.Controls.Footer" %>
<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-grid">
            <div class="footer-col brand-col">
                <div class="footer-logo">
                    <span>&#127858; Canteen Quality Hub</span>
                </div>
                <p class="footer-desc">
                    Dedicated to maintaining hygiene, food excellence, and rapid grievance resolution across campus canteens.
                </p>
            </div>
            <div class="footer-col links-col">
                <h4 class="footer-heading">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="Default.aspx">Home Dashboard</a></li>
                    <li><a href="SubmitComplaint.aspx">Lodge a Complaint</a></li>
                    <li><a href="ViewComplaints.aspx">Browse Complaints</a></li>
                    <li><a href="ManageComplaints.aspx">Admin Portal</a></li>
                    <li><a href="ViewLogs.aspx">Audit Trail Logs</a></li>
                </ul>
            </div>
            <div class="footer-col contact-col">
                <h4 class="footer-heading">Campus Helpdesk</h4>
                <p>&#128205; Central Canteen Block A, Room 102</p>
                <p>&#128231; <a href="mailto:canteen-support@campus.edu">canteen-support@campus.edu</a></p>
                <p>&#128222; Ext: 4400 / 4401 (Mon - Sat: 8 AM - 8 PM)</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; <%= DateTime.Now.Year %> Canteen Complaint System (.NET Framework 4.8 Web Forms). All Rights Reserved.</p>
            <span class="version-tag">v1.0.0 | ASP.NET Web Forms</span>
        </div>
    </div>
</footer>
