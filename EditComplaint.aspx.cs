using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class EditComplaint : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Authorization Check
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                LoadComplaintForEdit();
            }
        }

        private void LoadComplaintForEdit()
        {
            string idQueryStr = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(idQueryStr) || !int.TryParse(idQueryStr, out int complaintId))
            {
                pnlEditStatus.Visible = true;
                pnlEditStatus.CssClass = "alert-banner alert-danger";
                litEditStatus.Text = "⚠️ Invalid complaint ID specified.";
                btnSave.Enabled = false;
                return;
            }

            lblComplaintIdHeader.Text = complaintId.ToString();
            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString)) return;

            string sql = "SELECT StudentName, StudentEmail, Category, Description, Status FROM Complaints WHERE ComplaintId = @ComplaintId";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@ComplaintId", complaintId));
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtStudentName.Text = reader["StudentName"].ToString();
                                txtStudentEmail.Text = reader["StudentEmail"].ToString();
                                string category = reader["Category"].ToString();
                                string status = reader["Status"].ToString();
                                txtDescription.Text = reader["Description"].ToString();

                                if (ddlCategory.Items.FindByValue(category) != null)
                                {
                                    ddlCategory.SelectedValue = category;
                                }

                                if (ddlStatus.Items.FindByValue(status) != null)
                                {
                                    ddlStatus.SelectedValue = status;
                                }
                            }
                            else
                            {
                                pnlEditStatus.Visible = true;
                                pnlEditStatus.CssClass = "alert-banner alert-danger";
                                litEditStatus.Text = "❌ Complaint record not found.";
                                btnSave.Enabled = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlEditStatus.Visible = true;
                pnlEditStatus.CssClass = "alert-banner alert-danger";
                litEditStatus.Text = "❌ Database error: " + ex.Message;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string idQueryStr = Request.QueryString["ID"];
            if (string.IsNullOrEmpty(idQueryStr) || !int.TryParse(idQueryStr, out int complaintId)) return;

            string category = ddlCategory.SelectedValue;
            string status = ddlStatus.SelectedValue;

            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString)) return;

            string sql = "UPDATE Complaints SET Category = @Category, Status = @Status WHERE ComplaintId = @ComplaintId";

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@Category", category));
                        cmd.Parameters.Add(new SqlParameter("@Status", status));
                        cmd.Parameters.Add(new SqlParameter("@ComplaintId", complaintId));
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                string adminUser = Session["AdminUser"]?.ToString() ?? "Admin";
                XmlLogger.LogAction("EditComplaint", $"Admin '{adminUser}' updated Complaint #{complaintId} status to '{status}' (Category: '{category}').");

                pnlEditStatus.Visible = true;
                pnlEditStatus.CssClass = "alert-banner alert-success";
                litEditStatus.Text = $"✅ Complaint <strong>#{complaintId}</strong> updated successfully to status <strong>{status}</strong>!";
            }
            catch (Exception ex)
            {
                pnlEditStatus.Visible = true;
                pnlEditStatus.CssClass = "alert-banner alert-danger";
                litEditStatus.Text = "❌ Error saving updates: " + ex.Message;
            }
        }
    }
}
