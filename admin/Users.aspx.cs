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

    protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteUser")
        {
            int userId = Convert.ToInt32(e.CommandArgument);
            if (string.IsNullOrEmpty(connectionString)) return;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Delete user's logins first, then the user (assuming no cascade delete)
                string query = "DELETE FROM [Login] WHERE UserId = @UserId; DELETE FROM Users WHERE UserId = @UserId;";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                }
            }

            LoadUsers();
            LoadUserLogins();

            // Inject script to show confirmation toast for 2 seconds
            string toastScript = @"
                var toast = document.createElement('div');
                toast.innerHTML = '<i class=""bi bi-check-circle-fill me-2""></i> User deleted successfully!';
                toast.style.position = 'fixed';
                toast.style.bottom = '30px';
                toast.style.right = '30px';
                toast.style.backgroundColor = '#047857';
                toast.style.color = '#fff';
                toast.style.padding = '15px 25px';
                toast.style.borderRadius = '10px';
                toast.style.boxShadow = '0 10px 30px rgba(0,0,0,0.15)';
                toast.style.fontWeight = '600';
                toast.style.zIndex = '9999';
                toast.style.opacity = '1';
                toast.style.transition = 'opacity 0.5s ease-in-out';
                document.body.appendChild(toast);
                
                setTimeout(function() {
                    toast.style.opacity = '0';
                    setTimeout(function() {
                        toast.remove();
                    }, 500);
                }, 2000);
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "DeleteToast", toastScript, true);
        }
    }
}
