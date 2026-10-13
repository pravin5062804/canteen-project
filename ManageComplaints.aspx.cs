using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanteenComplaintSystem
{
    public partial class ManageComplaints : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Authorization Check: Redirect unauthenticated users to AdminLogin.aspx
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx?ReturnUrl=ManageComplaints.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindComplaintsGrid();
                BindResolvedDataList();
                LoadSummaryCounts();
            }
        }

        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
        }

        private void BindComplaintsGrid()
        {
            string connString = GetConnectionString();
            if (string.IsNullOrEmpty(connString)) return;

            string selectedStatus = ddlStatusFilter.SelectedValue;
            string sql = "SELECT ComplaintId, StudentName, StudentEmail, Category, IncidentDate, Description, Status, SubmittedDate FROM Complaints";

            if (selectedStatus != "All")
            {
                sql += " WHERE Status = @StatusFilter";
            }
            sql += " ORDER BY ComplaintId DESC";

            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        if (selectedStatus != "All")
                        {
                            cmd.Parameters.Add(new SqlParameter("@StatusFilter", selectedStatus));
                        }

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }

                gvComplaints.DataSource = dt;
                gvComplaints.DataBind();
            }
            catch (Exception ex)
            {
                pnlAdminStatus.Visible = true;
                pnlAdminStatus.CssClass = "alert-banner alert-danger";
                lblAdminStatus.Text = "❌ Error loading complaints grid: " + ex.Message;
            }
        }

        private void BindResolvedDataList()
        {
            string connString = GetConnectionString();
            if (string.IsNullOrEmpty(connString)) return;

            string sql = "SELECT TOP 6 ComplaintId, StudentName, StudentEmail, Category, IncidentDate, Description, Status, SubmittedDate FROM Complaints WHERE Status = 'Resolved' ORDER BY SubmittedDate DESC";

            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
                    {
                        da.Fill(dt);
                    }
                }

                dlResolvedComplaints.DataSource = dt;
                dlResolvedComplaints.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("DataList bind error: " + ex.Message);
            }
        }

        private void LoadSummaryCounts()
        {
            string connString = GetConnectionString();
            if (string.IsNullOrEmpty(connString)) return;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Complaints WHERE Status = 'Pending'", conn))
                    {
                        lblCountPending.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }

                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Complaints WHERE Status = 'Resolved'", conn))
                    {
                        lblCountResolved.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }

                    using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Complaints", conn))
                    {
                        lblCountTotal.Text = cmd.ExecuteScalar()?.ToString() ?? "0";
                    }
                }
            }
            catch
            {
                lblCountPending.Text = "0";
                lblCountResolved.Text = "0";
                lblCountTotal.Text = "0";
            }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvComplaints.PageIndex = 0;
            BindComplaintsGrid();
        }

        protected void gvComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvComplaints.PageIndex = e.NewPageIndex;
            BindComplaintsGrid();
        }

        protected void gvComplaints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "MarkResolved")
            {
                int complaintId = Convert.ToInt32(e.CommandArgument);
                string connString = GetConnectionString();

                if (string.IsNullOrEmpty(connString)) return;

                string updateSql = "UPDATE Complaints SET Status = 'Resolved' WHERE ComplaintId = @ComplaintId";

                try
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand cmd = new SqlCommand(updateSql, conn))
                        {
                            cmd.Parameters.Add(new SqlParameter("@ComplaintId", complaintId));
                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Record XML Audit Log
                    string adminUser = Session["AdminUser"]?.ToString() ?? "Admin";
                    XmlLogger.LogAction("ResolveComplaint", $"Complaint #{complaintId} marked as 'Resolved' by Administrator '{adminUser}'.");

                    pnlAdminStatus.Visible = true;
                    pnlAdminStatus.CssClass = "alert-banner alert-success";
                    lblAdminStatus.Text = $"✅ Complaint <strong>#{complaintId}</strong> successfully marked as <strong>Resolved</strong>! Audit log updated.";

                    BindComplaintsGrid();
                    BindResolvedDataList();
                    LoadSummaryCounts();
                }
                catch (Exception ex)
                {
                    pnlAdminStatus.Visible = true;
                    pnlAdminStatus.CssClass = "alert-banner alert-danger";
                    lblAdminStatus.Text = $"❌ Failed to update complaint #{complaintId}: " + ex.Message;
                }
            }
        }

        public string GetStatusBadgeCss(object statusObj)
        {
            if (statusObj == null) return "badge badge-pending";
            string status = statusObj.ToString();

            switch (status)
            {
                case "Resolved":
                    return "badge badge-resolved";
                case "In Progress":
                    return "badge badge-in-progress";
                case "Rejected":
                    return "badge badge-rejected";
                default:
                    return "badge badge-pending";
            }
        }

        public string TruncateDescription(object descObj, int maxLen)
        {
            if (descObj == null) return string.Empty;
            string desc = descObj.ToString();
            if (desc.Length <= maxLen) return desc;
            return desc.Substring(0, maxLen) + "...";
        }
    }
}
