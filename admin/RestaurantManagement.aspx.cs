using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RestaurantManagement : System.Web.UI.Page
{
    private string connectionString =
    ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMealSchedules();
        }
    }
    private void LoadMealSchedules()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("MealId", typeof(int));
        dt.Columns.Add("MealType", typeof(string));
        dt.Columns.Add("MealTitle", typeof(string));
        dt.Columns.Add("TimeSlot", typeof(string));
        dt.Columns.Add("Description", typeof(string));
        dt.Columns.Add("VenuLocation", typeof(string));
        dt.Columns.Add("MealIcon", typeof(string));

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
               SELECT MealId, MealType, MealTitle, TimeSlot, Description, VenuLocation, MealIcon FROM MealSchedules ORDER BY MealId ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            int mealId = Convert.ToInt32(dr["MealId"]);
                            string mealType = dr["MealType"] != DBNull.Value ? dr["MealType"].ToString() : "";
                            string mealTitle = dr["MealTitle"] != DBNull.Value ? dr["MealTitle"].ToString() : "";
                            string timeSlot = dr["TimeSlot"] != DBNull.Value ? dr["TimeSlot"].ToString() : "";
                            string description = dr["Description"] != DBNull.Value ? dr["Description"].ToString() : "";
                            string venuLocation = dr["VenuLocation"] != DBNull.Value ? dr["VenuLocation"].ToString() : "";
                            string mealIcon = dr["MealIcon"] != DBNull.Value ? dr["MealIcon"].ToString() : "bi bi-clock-history";

                            dt.Rows.Add(mealId, mealType, mealTitle, timeSlot, description, venuLocation, mealIcon);

                            if (mealId == 1)
                            {
                                txtBreakfastTitle.Text = mealTitle;
                                txtBreakfastTime.Text = timeSlot;
                                txtBreakfastDesc.Text = description;
                                txtBreakfastVenue.Text = venuLocation;
                            }
                            else if (mealId == 2)
                            {
                                txtLunchTitle.Text = mealTitle;
                                txtLunchTime.Text = timeSlot;
                                txtLunchDesc.Text = description;
                                txtLunchVenue.Text = venuLocation;
                            }
                            else if (mealId == 3)
                            {
                                txtHighTeaTitle.Text = mealTitle;
                                txtHighTeaTime.Text = timeSlot;
                                txtHighTeaDesc.Text = description;
                                txtHighTeaVenue.Text = venuLocation;
                            }
                            else if (mealId == 4)
                            {
                                txtDinnerTitle.Text = mealTitle;
                                txtDinnerTime.Text = timeSlot;
                                txtDinnerDesc.Text = description;
                                txtDinnerVenue.Text = venuLocation;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Non-blocking fallback
        }

        if (dt.Rows.Count == 0)
        {
            // Fallback default 4 meal schedules
            dt.Rows.Add(1, "Breakfast", txtBreakfastTitle.Text.Trim().Length > 0 ? txtBreakfastTitle.Text.Trim() : "Royal Breakfast", txtBreakfastTime.Text.Trim().Length > 0 ? txtBreakfastTime.Text.Trim() : "07:00 AM - 10:30 AM", txtBreakfastDesc.Text.Trim().Length > 0 ? txtBreakfastDesc.Text.Trim() : "Grand international buffet with live dosa, egg, pancake & cold-pressed juice stations.", txtBreakfastVenue.Text.Trim().Length > 0 ? txtBreakfastVenue.Text.Trim() : "The Royal Kitchen", "bi bi-cup-hot-fill");
            dt.Rows.Add(2, "Lunch", txtLunchTitle.Text.Trim().Length > 0 ? txtLunchTitle.Text.Trim() : "Imperial Lunch", txtLunchTime.Text.Trim().Length > 0 ? txtLunchTime.Text.Trim() : "12:30 PM - 03:30 PM", txtLunchDesc.Text.Trim().Length > 0 ? txtLunchDesc.Text.Trim() : "Executive thalis, gourmet business lunch combos, and a la carte Awadhi specialties.", txtLunchVenue.Text.Trim().Length > 0 ? txtLunchVenue.Text.Trim() : "The Royal Kitchen", "bi bi-sun-fill");
            dt.Rows.Add(3, "High Tea", txtHighTeaTitle.Text.Trim().Length > 0 ? txtHighTeaTitle.Text.Trim() : "Royal High Tea", txtHighTeaTime.Text.Trim().Length > 0 ? txtHighTeaTime.Text.Trim() : "04:00 PM - 06:30 PM", txtHighTeaDesc.Text.Trim().Length > 0 ? txtHighTeaDesc.Text.Trim() : "Classic British tiered scones, Indian street-delight tidbits & hand-plucked tea blends.", txtHighTeaVenue.Text.Trim().Length > 0 ? txtHighTeaVenue.Text.Trim() : "The Royal Kitchen", "bi bi-flower2");
            dt.Rows.Add(4, "Dinner", txtDinnerTitle.Text.Trim().Length > 0 ? txtDinnerTitle.Text.Trim() : "Grand Dinner", txtDinnerTime.Text.Trim().Length > 0 ? txtDinnerTime.Text.Trim() : "07:00 PM - 11:30 PM", txtDinnerDesc.Text.Trim().Length > 0 ? txtDinnerDesc.Text.Trim() : "Atmospheric candlelit dining, live classical sitar music, slow-braised curries & fine wine.", txtDinnerVenue.Text.Trim().Length > 0 ? txtDinnerVenue.Text.Trim() : "All Venues Open", "bi bi-moon-stars-fill");
        }

        rptMealSchedules.DataSource = dt;
        rptMealSchedules.DataBind();
    }

    // ==========================================
    // SAVE / UPDATE ALL 4 MEAL SCHEDULES
    // ==========================================
    protected void btnSaveMealSchedule_Click(object sender, EventArgs e)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. BREAKFAST
                UpdateMealSchedule(
                    con,
                    1,
                    "Breakfast",
                    txtBreakfastTitle.Text.Trim(),
                    txtBreakfastTime.Text.Trim(),
                    txtBreakfastDesc.Text.Trim(),
                    txtBreakfastVenue.Text.Trim(),
                    "bi bi-cup-hot-fill"
                );

                // 2. LUNCH
                UpdateMealSchedule(
                    con,
                    2,
                    "Lunch",
                    txtLunchTitle.Text.Trim(),
                    txtLunchTime.Text.Trim(),
                    txtLunchDesc.Text.Trim(),
                    txtLunchVenue.Text.Trim(),
                    "bi bi-sun-fill"
                );

                // 3. HIGH TEA
                UpdateMealSchedule(
                    con,
                    3,
                    "High Tea",
                    txtHighTeaTitle.Text.Trim(),
                    txtHighTeaTime.Text.Trim(),
                    txtHighTeaDesc.Text.Trim(),
                    txtHighTeaVenue.Text.Trim(),
                    "bi bi-flower2"
                );

                // 4. DINNER
                UpdateMealSchedule(
                    con,
                    4,
                    "Dinner",
                    txtDinnerTitle.Text.Trim(),
                    txtDinnerTime.Text.Trim(),
                    txtDinnerDesc.Text.Trim(),
                    txtDinnerVenue.Text.Trim(),
                    "bi bi-moon-stars-fill"
                );
            }

            // SUCCESS MESSAGE
            pnlStatusMsg.Visible = true;
            lblStatusMessage.Text = "Updated successfully";

            // Refresh Repeater Data
            LoadMealSchedules();

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "MealSaved",
                "showConfirmation('Updated successfully');",
                true
            );
        }
        catch (Exception ex)
        {
            // ERROR MESSAGE
            pnlStatusMsg.Visible = true;
            lblStatusMessage.Text = "Error saving meal schedule: " + ex.Message;
        }
    }

    // ==========================================
    // UPDATE OR INSERT ONE MEAL RECORD (UPSERT)
    // ==========================================
    private void UpdateMealSchedule(
        SqlConnection con,
        int mealId,
        string mealType,
        string mealTitle,
        string timeSlot,
        string description,
        string venuLocation,
        string mealIcon)
    {
        string query = @"
            IF EXISTS (SELECT 1 FROM MealSchedules WHERE MealId = @MealId)
            BEGIN
                UPDATE MealSchedules
                SET
                    MealType = @MealType,
                    MealTitle = @MealTitle,
                    TimeSlot = @TimeSlot,
                    Description = @Description,
                    VenuLocation = @VenuLocation,
                    MealIcon = @MealIcon
                WHERE MealId = @MealId
            END
            ELSE
            BEGIN
                INSERT INTO MealSchedules (MealId, MealType, MealTitle, TimeSlot, Description, VenuLocation, MealIcon)
                VALUES (@MealId, @MealType, @MealTitle, @TimeSlot, @Description, @VenuLocation, @MealIcon)
            END";

        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@MealId", mealId);
            cmd.Parameters.AddWithValue("@MealType", mealType);
            cmd.Parameters.AddWithValue("@MealTitle", mealTitle);
            cmd.Parameters.AddWithValue("@TimeSlot", timeSlot);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@VenuLocation", venuLocation);
            cmd.Parameters.AddWithValue("@MealIcon", mealIcon);

            cmd.ExecuteNonQuery();
        }
    }

    protected void rptMealSchedules_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int mealId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteMeal")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "DELETE FROM MealSchedules WHERE MealId = @MealId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@MealId", mealId);
                        cmd.ExecuteNonQuery();
                    }
                }

                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Deleted successfully";

                LoadMealSchedules();

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "MealDeleted",
                    "showConfirmation('Deleted successfully');",
                    true
                );
            }
            catch (Exception ex)
            {
                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Error deleting meal schedule: " + ex.Message;
            }
        }
        else if (e.CommandName == "EditMeal")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = "SELECT MealId, MealTitle, TimeSlot, Description, VenuLocation FROM MealSchedules WHERE MealId = @MealId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@MealId", mealId);
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                string title = dr["MealTitle"].ToString();
                                string time = dr["TimeSlot"].ToString();
                                string desc = dr["Description"].ToString();
                                string venue = dr["VenuLocation"].ToString();

                                if (mealId == 1)
                                {
                                    txtBreakfastTitle.Text = title;
                                    txtBreakfastTime.Text = time;
                                    txtBreakfastDesc.Text = desc;
                                    txtBreakfastVenue.Text = venue;
                                    txtBreakfastTitle.Focus();
                                }
                                else if (mealId == 2)
                                {
                                    txtLunchTitle.Text = title;
                                    txtLunchTime.Text = time;
                                    txtLunchDesc.Text = desc;
                                    txtLunchVenue.Text = venue;
                                    txtLunchTitle.Focus();
                                }
                                else if (mealId == 3)
                                {
                                    txtHighTeaTitle.Text = title;
                                    txtHighTeaTime.Text = time;
                                    txtHighTeaDesc.Text = desc;
                                    txtHighTeaVenue.Text = venue;
                                    txtHighTeaTitle.Focus();
                                }
                                else if (mealId == 4)
                                {
                                    txtDinnerTitle.Text = title;
                                    txtDinnerTime.Text = time;
                                    txtDinnerDesc.Text = desc;
                                    txtDinnerVenue.Text = venue;
                                    txtDinnerTitle.Focus();
                                }

                                pnlStatusMsg.Visible = true;
                                lblStatusMessage.Text = "Meal #" + mealId + " (" + title + ") details loaded into the form above. Modify values and click 'Save Meal Hours & Schedule' to update.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Non-blocking
            }
        }
    }
}
