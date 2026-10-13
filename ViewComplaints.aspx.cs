using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CanteenComplaintSystem
{
    public partial class ViewComplaints : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPublicComplaints();
            }
        }

        private void BindPublicComplaints()
        {
            string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString)) return;

            string sql = "SELECT ComplaintId, StudentName, StudentEmail, Category, IncidentDate, Description, Status, SubmittedDate FROM Complaints ORDER BY ComplaintId DESC";

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

                gvPublicComplaints.DataSource = dt;
                gvPublicComplaints.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("View complaints error: " + ex.Message);
            }
        }

        protected void gvPublicComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPublicComplaints.PageIndex = e.NewPageIndex;
            BindPublicComplaints();
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
