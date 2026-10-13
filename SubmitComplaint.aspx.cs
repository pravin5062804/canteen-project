using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class SubmitComplaint : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                calIncidentDate.SelectedDate = DateTime.Today;
                lblSelectedDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        protected void calIncidentDate_SelectionChanged(object sender, EventArgs e)
        {
            lblSelectedDate.Text = calIncidentDate.SelectedDate.ToString("yyyy-MM-dd");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string category = ddlCategory.SelectedValue;
            DateTime incidentDate = calIncidentDate.SelectedDate != DateTime.MinValue ? calIncidentDate.SelectedDate : DateTime.Today;
            string description = txtDescription.Text.Trim();
            string status = "Pending";

            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;

            if (string.IsNullOrEmpty(connString))
            {
                pnlStatus.Visible = true;
                pnlStatus.CssClass = "alert-banner alert-danger";
                lblStatus.Text = "❌ Connection string 'CanteenDBConn' not found in Web.config.";
                return;
            }

            string insertSql = @"INSERT INTO Complaints (StudentName, StudentEmail, Category, IncidentDate, Description, Status, SubmittedDate)
                                VALUES (@StudentName, @StudentEmail, @Category, @IncidentDate, @Description, @Status, GETDATE());
                                SELECT SCOPE_IDENTITY();";

            try
            {
                int newId = 0;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(insertSql, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@StudentName", fullName));
                        cmd.Parameters.Add(new SqlParameter("@StudentEmail", email));
                        cmd.Parameters.Add(new SqlParameter("@Category", category));
                        cmd.Parameters.Add(new SqlParameter("@IncidentDate", incidentDate));
                        cmd.Parameters.Add(new SqlParameter("@Description", description));
                        cmd.Parameters.Add(new SqlParameter("@Status", status));

                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            newId = Convert.ToInt32(result);
                        }
                    }
                }

                // Invoke XmlLogger static class to record audit trail
                XmlLogger.LogAction("SubmitComplaint", $"New complaint #{newId} submitted by {fullName} ({email}) under category '{category}'.");

                pnlStatus.Visible = true;
                pnlStatus.CssClass = "alert-banner alert-success";
                lblStatus.Text = $"✅ <strong>Complaint Submitted Successfully!</strong> Your tracking reference ID is <strong>#{newId}</strong>. Audit log recorded.";

                // Reset Form
                txtFullName.Text = string.Empty;
                txtEmail.Text = string.Empty;
                ddlCategory.SelectedIndex = 0;
                txtDescription.Text = string.Empty;
                calIncidentDate.SelectedDate = DateTime.Today;
                lblSelectedDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
            catch (Exception ex)
            {
                // Fallback XML logging even if SQL server connection fails
                XmlLogger.LogAction("SubmitComplaint_AttemptFailed", $"Failed to submit complaint for {fullName}: {ex.Message}");

                pnlStatus.Visible = true;
                pnlStatus.CssClass = "alert-banner alert-danger";
                lblStatus.Text = "❌ <strong>Error Submitting Complaint:</strong> " + ex.Message + " (Logged to ActivityLog.xml)";
            }
        }
    }
}
