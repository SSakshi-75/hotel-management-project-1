using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class Admin_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }

    [WebMethod]
    public static string ValidateAdmin(string email, string password)
    {
        try
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                return "EMPTY";
            }

            string connStr = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = "SELECT AdminId, Email, PasswordHash FROM AdminLogin WHERE LOWER(Email) = LOWER(@Email)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email.Trim());
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string stored = dr["PasswordHash"].ToString();
                            if (stored == password || stored == password.Trim())
                            {
                                HttpContext.Current.Session["AdminId"] = dr["AdminId"];
                                HttpContext.Current.Session["AdminEmail"] = dr["Email"].ToString();
                                HttpContext.Current.Session["UserName"] = "Administrator";
                                HttpContext.Current.Session["IsAdmin"] = true;
                                return "SUCCESS";
                            }
                            else
                            {
                                return "WRONG_PASSWORD";
                            }
                        }
                        else
                        {
                            return "NOT_FOUND";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            return "ERROR:" + ex.Message;
        }
    }
}
