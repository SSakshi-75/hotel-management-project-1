using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

public partial class Admin_RoomRates : Page
{
    string connString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRoomRates();
        }
    }

    private void LoadRoomRates()
    {
        if (string.IsNullOrEmpty(connString)) return;

        using (SqlConnection conn = new SqlConnection(connString))
        {
            string query = "SELECT RoomID, RoomName, RoomCategory, PricePerNight, ISNULL(IsActive, 1) as IsActive FROM Rooms ORDER BY RoomID DESC";
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    rptRoomRates.DataSource = dt;
                    rptRoomRates.DataBind();
                }
            }
        }
    }

    protected string GetStatusBadge(object isActiveObj)
    {
        bool isActive = Convert.ToBoolean(isActiveObj);
        if (isActive)
        {
            return "<span class=\"badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-2 fw-semibold\">Active</span>";
        }
        else
        {
            return "<span class=\"badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3 py-2 fw-semibold\">Inactive</span>";
        }
    }
}
