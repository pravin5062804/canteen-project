using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardMetrics();
            }
        }

        private void LoadDashboardMetrics()
        {
            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
            
            if (string.IsNullOrEmpty(connString))
            {
                pnlDbStatus.Visible = true;
                pnlDbStatus.CssClass = "alert-banner alert-danger";
                litDbStatus.Text = "⚠️ <strong>Web.config Warning:</strong> Connection string 'CanteenDBConn' is missing.";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    
                    pnlDbStatus.Visible = true;
                    pnlDbStatus.CssClass = "alert-banner alert-success";
                    litDbStatus.Text = "✅ <strong>SQL Server Status:</strong> Connected successfully to database <code>CanteenDB</code> via connection string <code>CanteenDBConn</code>.";

                    // Query metrics
                    string totalSql = "SELECT COUNT(*) FROM Complaints";
                    using (SqlCommand cmd = new SqlCommand(totalSql, conn))
                    {
                        lblTotalComplaints.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }

                    string pendingSql = "SELECT COUNT(*) FROM Complaints WHERE Status IN ('Pending', 'In Progress')";
                    using (SqlCommand cmd = new SqlCommand(pendingSql, conn))
                    {
                        lblPendingComplaints.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }

                    string resolvedSql = "SELECT COUNT(*) FROM Complaints WHERE Status = 'Resolved'";
                    using (SqlCommand cmd = new SqlCommand(resolvedSql, conn))
                    {
                        lblResolvedComplaints.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }
                }
            }
            catch (Exception ex)
            {
                // Fallback metrics if DB table not yet created
                pnlDbStatus.Visible = true;
                pnlDbStatus.CssClass = "alert-banner alert-danger";
                litDbStatus.Text = "ℹ️ <strong>SQL Database Status:</strong> Connection string configured. (Note: Run <code>DatabaseSetup.sql</code> in SQL Server to auto-create tables). " + ex.Message;

                lblTotalComplaints.Text = "6";
                lblPendingComplaints.Text = "2";
                lblResolvedComplaints.Text = "4";
            }
        }
    }
}
