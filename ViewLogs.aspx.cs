using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace CanteenComplaintSystem
{
    public partial class ViewLogs : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Authorization Check: Lock activity log viewer behind Admin authentication
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx?ReturnUrl=ViewLogs.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindXmlLogGrid();
            }
        }

        private void BindXmlLogGrid()
        {
            string xmlFilePath = Server.MapPath("~/App_Data/ActivityLog.xml");

            if (!File.Exists(xmlFilePath))
            {
                pnlLogStatus.Visible = true;
                pnlLogStatus.CssClass = "alert-banner alert-danger";
                litLogStatus.Text = "ℹ️ <strong>XML Log File Not Found:</strong> <code>App_Data/ActivityLog.xml</code> has not been created yet.";
                gvActivityLogs.DataSource = null;
                gvActivityLogs.DataBind();
                return;
            }

            try
            {
                XDocument doc = XDocument.Load(xmlFilePath);

                var logEntries = doc.Descendants("LogEntry")
                    .Select(x => new
                    {
                        Timestamp = x.Element("Timestamp")?.Value ?? string.Empty,
                        Action = x.Element("Action")?.Value ?? string.Empty,
                        Details = x.Element("Details")?.Value ?? string.Empty
                    })
                    .OrderByDescending(x => x.Timestamp)
                    .ToList();

                gvActivityLogs.DataSource = logEntries;
                gvActivityLogs.DataBind();

                pnlLogStatus.Visible = false;
            }
            catch (Exception ex)
            {
                pnlLogStatus.Visible = true;
                pnlLogStatus.CssClass = "alert-banner alert-danger";
                litLogStatus.Text = "❌ <strong>Error Reading XML Logs:</strong> " + ex.Message;
            }
        }

        protected void gvActivityLogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvActivityLogs.PageIndex = e.NewPageIndex;
            BindXmlLogGrid();
        }

        protected void btnRefreshLogs_Click(object sender, EventArgs e)
        {
            gvActivityLogs.PageIndex = 0;
            BindXmlLogGrid();
        }
    }
}
