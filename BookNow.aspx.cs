using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class BookNow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCategoryFilterPills();
        }
    }

    private void LoadCategoryFilterPills()
    {
        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
                ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
                : "";

            if (string.IsNullOrEmpty(connectionString)) return;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Query ONLY categories explicitly added by admin in RoomCategories
                string sql = @"
                    SELECT DISTINCT 
                        CategoryName, 
                        LOWER(REPLACE(LTRIM(RTRIM(CategoryName)), ' ', '-')) AS CategorySlug 
                    FROM RoomCategories 
                    WHERE LOWER(LTRIM(RTRIM(PublishingStatus))) = 'active'
                    ORDER BY CategoryName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptBookNowCategoryFilters.DataSource = reader;
                        rptBookNowCategoryFilters.DataBind();
                    }
                }
            }
        }
        catch { }
    }
}
