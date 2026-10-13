using System;
using System.Web.Security;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string user = Session["AdminUser"]?.ToString() ?? "Admin";
            XmlLogger.LogAction("AdminLogout", $"Administrator '{user}' logged out.");

            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();

            Response.Redirect("Default.aspx");
        }
    }
}
