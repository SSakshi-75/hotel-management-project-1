using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Dining : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDiningMenuItems();
        }
    }

    private void LoadDiningMenuItems()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
                SELECT
                    MenuItemId,
                    Category,
                    ItemName,
                    Price,
                    DietaryType,
                    Badge,
                    Description,
                    PairingNote,
                    ImageUrl
                FROM MenuItems
                WHERE IsActive = 1
                ORDER BY MenuItemId ASC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptDiningMenu.DataSource = dt;
                    rptDiningMenu.DataBind();

                    if (phNoDishes != null)
                    {
                        phNoDishes.Visible = (dt.Rows.Count == 0);
                    }
                }
            }
        }
    }
}
