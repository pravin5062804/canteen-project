using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace CanteenComplaintSystem
{
    public partial class AdminLogin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUser"] != null)
            {
                Response.Redirect("ManageComplaints.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Default fallback check for default admin
            bool isAuthenticated = false;

            if (username.Equals("admin", StringComparison.OrdinalIgnoreCase) && password == "admin123")
            {
                isAuthenticated = true;
            }
            else
            {
                // Check database Users table
                string connString = ConfigurationManager.ConnectionStrings["CanteenDBConn"]?.ConnectionString;
                if (!string.IsNullOrEmpty(connString))
                {
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(connString))
                        {
                            string sql = "SELECT COUNT(*) FROM Users WHERE Username = @Username AND (Role = 'Admin' OR Role = 'Administrator')";
                            using (SqlCommand cmd = new SqlCommand(sql, conn))
                            {
                                cmd.Parameters.Add(new SqlParameter("@Username", username));
                                conn.Open();
                                int count = Convert.ToInt32(cmd.ExecuteScalar());
                                if (count > 0 && password == "admin123")
                                {
                                    isAuthenticated = true;
                                }
                            }
                        }
                    }
                    catch
                    {
                        // Fallback
                    }
                }
            }

            if (isAuthenticated)
            {
                Session["AdminUser"] = username;
                Session["AdminRole"] = "Admin";
                FormsAuthentication.SetAuthCookie(username, false);

                XmlLogger.LogAction("AdminLoginSuccess", $"Administrator '{username}' authenticated successfully.");

                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    Response.Redirect("ManageComplaints.aspx");
                }
            }
            else
            {
                XmlLogger.LogAction("AdminLoginFailed", $"Failed authentication attempt for username '{username}'.");
                pnlLoginError.Visible = true;
                litLoginError.Text = "❌ <strong>Authentication Failed:</strong> Invalid username or password.";
            }
        }
    }
}
