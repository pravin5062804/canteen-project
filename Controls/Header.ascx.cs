using System;
using System.Web.UI;

namespace CanteenComplaintSystem.Controls
{
    public partial class Header : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUser"] != null)
            {
                string adminUser = Session["AdminUser"].ToString();
                litUserBadge.Text = $"<span class=\"user-avatar\">&#128104;</span> <span class=\"user-name\">Admin: <strong>{adminUser}</strong></span> <a href=\"Logout.aspx\" style=\"margin-left: 0.75rem; color: #fca5a5; font-weight: 600; text-decoration: underline;\">Sign Out</a>";
            }
            else
            {
                litUserBadge.Text = "<span class=\"user-avatar\">&#128104;</span> <span class=\"user-name\">Student Portal</span> <a href=\"AdminLogin.aspx\" style=\"margin-left: 0.75rem; color: #93c5fd; font-weight: 600; text-decoration: underline;\">Admin Sign In</a>";
            }
        }
    }
}
