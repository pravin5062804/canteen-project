using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class ComplaintDetails : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindComplaintDetails();
            }
        }

        private void BindComplaintDetails()
        {
            string idQueryStr = Request.QueryString["ID"];

            if (string.IsNullOrEmpty(idQueryStr) || !int.TryParse(idQueryStr, out int complaintId))
            {
                pnlDetailsError.Visible = true;
                litDetailsError.Text = "⚠️ <strong>Invalid QueryString:</strong> Please specify a valid complaint ID (e.g. <code>ComplaintDetails.aspx?ID=1</code>).";
                dvComplaintDetails.Visible = false;
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString))
            {
                pnlDetailsError.Visible = true;
                litDetailsError.Text = "❌ Connection string 'CanteenDBConn' is missing from Web.config.";
                dvComplaintDetails.Visible = false;
                return;
            }

            string sql = "SELECT ComplaintId, StudentName, StudentEmail, Category, IncidentDate, Description, Status, SubmittedDate FROM Complaints WHERE ComplaintId = @ComplaintId";

            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@ComplaintId", complaintId));
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }

                if (dt.Rows.Count > 0)
                {
                    dvComplaintDetails.DataSource = dt;
                    dvComplaintDetails.DataBind();
                    dvComplaintDetails.Visible = true;

                    // Log audit view activity
                    XmlLogger.LogAction("ViewComplaintDetails", $"Viewed detailed record for Complaint #{complaintId}.");
                }
                else
                {
                    pnlDetailsError.Visible = true;
                    litDetailsError.Text = $"❌ <strong>Record Not Found:</strong> No complaint was found matching ID #{complaintId}.";
                    dvComplaintDetails.Visible = false;
                }
            }
            catch (Exception ex)
            {
                pnlDetailsError.Visible = true;
                litDetailsError.Text = "❌ <strong>Database Error:</strong> " + ex.Message;
                dvComplaintDetails.Visible = false;
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
    }
}
