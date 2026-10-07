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

                    int totalPlans = dt.Rows.Count;
                    int activePlans = 0;
                    decimal minRate = decimal.MaxValue;
                    decimal maxRate = 0;

                    foreach (DataRow row in dt.Rows)
                    {
                        bool active = row["IsActive"] != DBNull.Value && Convert.ToBoolean(row["IsActive"]);
                        if (active) activePlans++;

                        if (row["PricePerNight"] != DBNull.Value)
                        {
                            decimal price = Convert.ToDecimal(row["PricePerNight"]);
                            if (price < minRate) minRate = price;
                            if (price > maxRate) maxRate = price;
                        }
                    }

                    if (minRate == decimal.MaxValue) minRate = 0;

                    kpiTotalPlans.InnerText = totalPlans.ToString();
                    kpiActivePlans.InnerText = activePlans + " Active";
                    kpiMinRate.InnerText = "₹" + minRate.ToString("N0");
                    kpiMaxRate.InnerText = "₹" + maxRate.ToString("N0");
                    litActiveTariffs.Text = activePlans + " Plans";
                    lblTariffPill.InnerHtml = "<i class=\"bi bi-shield-check me-1\"></i> " + activePlans + " Active / " + totalPlans + " Total";
                }
            }
        }
    }

    public string GetStatusBadge(object isActiveObj)
    {
        bool isActive = isActiveObj != null && isActiveObj != DBNull.Value && Convert.ToBoolean(isActiveObj);
        if (isActive)
        {
            return "<span class=\"badge-hotel-live\"><span class=\"status-dot-pulse\"></span> Active</span>";
        }
        else
        {
            return "<span class=\"badge bg-secondary text-white px-2.5 py-1 rounded-pill small\"><i class=\"bi bi-eye-slash-fill me-1\"></i> Inactive</span>";
        }
    }

    public string GetCategoryBadgeClass(object categoryObj)
    {
        if (categoryObj == null || categoryObj == DBNull.Value)
        {
            return "badge-category-deluxe";
        }

        string cat = categoryObj.ToString().Trim().ToUpper();
        if (cat.Contains("PENTHOUSE")) return "badge-category-penthouse";
        if (cat.Contains("FAMILY")) return "badge-category-family";
        if (cat.Contains("EXECUTIVE")) return "badge-category-executive";
        return "badge-category-deluxe";
    }
}
