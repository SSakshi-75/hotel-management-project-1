using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_Dashboard : System.Web.UI.Page
{
    string connectionString =
        ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUsers();
            LoadUserLogins();
        }
    }

    private void LoadUsers()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
              SELECT UserId, FirstName, LastName, Email, Phone, CreatedAt
              FROM Users
              ORDER BY CreatedAt DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }
    }

    private void LoadUserLogins()
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
              SELECT LoginId, UserId, UserName, Email, LoginTime, Status
              FROM [Login]
              WHERE Role = 'Guest'
              ORDER BY LoginTime DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvLogins.DataSource = dt;
                gvLogins.DataBind();
            }
        }
    }
}