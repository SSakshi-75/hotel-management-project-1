using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_Users : Page
{
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!IsPostBack)
        {
            LoadUsers();
            LoadUserLogins();
        }
    }

    private void LoadUsers()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

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

                if (lblTotalGuests != null)
                {
                    lblTotalGuests.InnerText = dt.Rows.Count.ToString();
                }
            }
        }
    }

    private void LoadUserLogins()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

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

                if (lblTotalLogins != null)
                {
                    lblTotalLogins.InnerText = dt.Rows.Count.ToString();
                }
            }
        }
    }
}
