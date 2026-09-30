using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // Optional: Record customer logout in [Login] audit table if logged in
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                string userName = Convert.ToString(Session["UserName"]);
                string userEmail = Convert.ToString(Session["UserEmail"]);

                string connStr = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
                    ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
                    : null;

                if (!string.IsNullOrEmpty(connStr))
                {
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        con.Open();
                        string logOutQuery = @"INSERT INTO [Login] (UserId, UserName, Email, LoginTime, Role, Status)
                                               VALUES (@UserId, @UserName, @Email, GETDATE(), 'Guest', 'Logged Out');";
                        using (SqlCommand cmd = new SqlCommand(logOutQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.Parameters.AddWithValue("@UserName", string.IsNullOrEmpty(userName) ? "Guest" : userName);
                            cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(userEmail) ? "" : userEmail);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }
        catch
        {
            // Silently continue session cleanup
        }

        // ==========================================
        // CLEAR AND ABANDON SESSION
        // ==========================================
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();

        // ==========================================
        // EXPIRE SESSION COOKIE
        // ==========================================
        if (Request.Cookies["ASP.NET_SessionId"] != null)
        {
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
        }

        // ==========================================
        // EXPIRE USER AUTH COOKIE IF ANY
        // ==========================================
        if (Request.Cookies["UserCookie"] != null)
        {
            Response.Cookies["UserCookie"].Value = string.Empty;
            Response.Cookies["UserCookie"].Expires = DateTime.Now.AddDays(-1);
        }

        try
        {
            FormsAuthentication.SignOut();
        }
        catch { }

        // ==========================================
        // REDIRECT TO LOGIN WITH LOGOUT NOTIFICATION
        // ==========================================
        Response.Redirect("Login.aspx?msg=logout", true);
    }
}
