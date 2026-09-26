using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Enquiries : System.Web.UI.Page
{
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!IsPostBack)
        {
            EnsureEnquiriesTableExists();
            EnsureHotelSettingsTableExists();
            LoadContactCards();
            LoadEnquiries();
        }
    }

    private void EnsureHotelSettingsTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string sql = @"
                    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HotelSettings')
                    BEGIN
                        CREATE TABLE HotelSettings (
                            SettingID INT IDENTITY(1,1) PRIMARY KEY,
                            HotelName NVARCHAR(200) NOT NULL DEFAULT 'Hotel Management Executive Portal',
                            ContactEmail NVARCHAR(150) NOT NULL DEFAULT '',
                            PhoneNumber NVARCHAR(50) NOT NULL DEFAULT '',
                            LocationAddress NVARCHAR(500) NOT NULL DEFAULT '',
                            GoogleMapUrl NVARCHAR(MAX) NOT NULL DEFAULT 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin',
                            FormHeading NVARCHAR(150) NOT NULL DEFAULT 'Send a Message',
                            Currency NVARCHAR(20) NOT NULL DEFAULT 'INR (₹)',
                            UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
                        );

                        INSERT INTO HotelSettings (HotelName, ContactEmail, PhoneNumber, LocationAddress, GoogleMapUrl, FormHeading, Currency)
                        VALUES ('Hotel Management Executive Portal', '', '', '', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin', 'Send a Message', 'INR (₹)');
                    END";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch { }
    }

    private void LoadContactCards()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT TOP 1 LocationAddress, PhoneNumber, ContactEmail, UpdatedAt FROM HotelSettings ORDER BY SettingID DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtCardLocation.Text = reader["LocationAddress"] != DBNull.Value ? reader["LocationAddress"].ToString() : "";
                            txtCardPhone.Text = reader["PhoneNumber"] != DBNull.Value ? reader["PhoneNumber"].ToString() : "";
                            txtCardEmail.Text = reader["ContactEmail"] != DBNull.Value ? reader["ContactEmail"].ToString() : "";

                            if (reader["UpdatedAt"] != DBNull.Value)
                            {
                                DateTime dt = Convert.ToDateTime(reader["UpdatedAt"]);
                                lblCardsLastUpdated.Text = "Last updated in database: " + dt.ToString("dd MMM yyyy, hh:mm tt");
                            }
                        }
                        else
                        {
                            txtCardLocation.Text = "";
                            txtCardPhone.Text = "";
                            txtCardEmail.Text = "";
                            lblCardsLastUpdated.Text = "Ready to add new details";
                        }
                    }
                }
            }
        }
        catch { }
    }

    protected void btnSaveContactCards_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            ShowMessage("Database connection error.", false);
            return;
        }

        string loc = txtCardLocation.Text.Trim();
        string ph = txtCardPhone.Text.Trim();
        string em = txtCardEmail.Text.Trim();

        if (string.IsNullOrEmpty(loc))
        {
            ShowMessage("Please enter the Location Address.", false);
            return;
        }
        if (string.IsNullOrEmpty(ph))
        {
            ShowMessage("Please enter the Phone Number.", false);
            return;
        }
        if (string.IsNullOrEmpty(em))
        {
            ShowMessage("Please enter the Contact Email.", false);
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string countSql = "SELECT COUNT(*) FROM HotelSettings";
                SqlCommand countCmd = new SqlCommand(countSql, con);
                int count = Convert.ToInt32(countCmd.ExecuteScalar());

                string sql;
                if (count > 0)
                {
                    sql = @"UPDATE HotelSettings SET 
                                LocationAddress = @LocationAddress, 
                                PhoneNumber = @PhoneNumber, 
                                ContactEmail = @ContactEmail, 
                                UpdatedAt = GETDATE()";
                }
                else
                {
                    sql = @"INSERT INTO HotelSettings (LocationAddress, PhoneNumber, ContactEmail, UpdatedAt) 
                            VALUES (@LocationAddress, @PhoneNumber, @ContactEmail, GETDATE())";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@LocationAddress", loc);
                    cmd.Parameters.AddWithValue("@PhoneNumber", ph);
                    cmd.Parameters.AddWithValue("@ContactEmail", em);
                    cmd.ExecuteNonQuery();
                }
            }

            lblCardsLastUpdated.Text = "Last updated: " + DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            txtCardLocation.Text = "";
            txtCardPhone.Text = "";
            txtCardEmail.Text = "";
            ShowMessage("Contact card details added and updated successfully on the public website!", true);
        }
        catch (Exception ex)
        {
            ShowMessage("Error saving contact cards: " + ex.Message, false);
        }
    }

    private void EnsureEnquiriesTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            string sql = @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ContactEnquiries')
                BEGIN
                    CREATE TABLE ContactEnquiries (
                        EnquiryID INT IDENTITY(1,1) PRIMARY KEY,
                        GuestName NVARCHAR(150) NOT NULL,
                        EmailAddress NVARCHAR(150) NOT NULL,
                        Subject NVARCHAR(250) NULL,
                        Message NVARCHAR(MAX) NOT NULL,
                        SubmittedAt DATETIME NOT NULL DEFAULT GETDATE(),
                        Status NVARCHAR(50) NOT NULL DEFAULT 'Unread'
                    );
                END";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.ExecuteNonQuery();
            }
        }
    }

    private void LoadEnquiries()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            // Load KPI counts
            string countSql = @"
                SELECT 
                    COUNT(*) AS TotalCount,
                    ISNULL(SUM(CASE WHEN Status = 'Unread' THEN 1 ELSE 0 END), 0) AS UnreadCount,
                    ISNULL(SUM(CASE WHEN CAST(SubmittedAt AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END), 0) AS TodayCount
                FROM ContactEnquiries";

            using (SqlCommand cmdCount = new SqlCommand(countSql, con))
            {
                using (SqlDataReader reader = cmdCount.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblTotalCount.InnerText = reader["TotalCount"] != DBNull.Value ? reader["TotalCount"].ToString() : "0";
                        lblUnreadCount.InnerText = reader["UnreadCount"] != DBNull.Value ? reader["UnreadCount"].ToString() : "0";
                        lblTodayCount.InnerText = reader["TodayCount"] != DBNull.Value ? reader["TodayCount"].ToString() : "0";
                    }
                }
            }

            // Load list
            string listSql = "SELECT EnquiryID, GuestName, EmailAddress, Subject, Message, SubmittedAt, Status FROM ContactEnquiries ORDER BY EnquiryID DESC";
            using (SqlCommand cmdList = new SqlCommand(listSql, con))
            {
                SqlDataAdapter da = new SqlDataAdapter(cmdList);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptEnquiries.DataSource = dt;
                    rptEnquiries.DataBind();
                    rptEnquiries.Visible = true;
                    pnlNoData.Visible = false;
                }
                else
                {
                    rptEnquiries.Visible = false;
                    pnlNoData.Visible = true;
                }
            }
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        LoadContactCards();
        LoadEnquiries();
        ShowMessage("Inbox and contact cards refreshed successfully!", true);
    }

    protected void rptEnquiries_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int enquiryId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ToggleStatus")
        {
            ToggleEnquiryStatus(enquiryId);
            LoadEnquiries();
        }
        else if (e.CommandName == "Delete")
        {
            DeleteEnquiry(enquiryId);
            LoadEnquiries();
        }
    }

    private void ToggleEnquiryStatus(int id)
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            // 1. Fetch current status & details of this enquiry
            string selectSql = "SELECT GuestName, EmailAddress, Subject, Message, Status FROM ContactEnquiries WHERE EnquiryID = @ID";
            string email = "";
            string msg = "";
            string name = "";
            string currentStatus = "Unread";

            using (SqlCommand selCmd = new SqlCommand(selectSql, con))
            {
                selCmd.Parameters.AddWithValue("@ID", id);
                using (SqlDataReader reader = selCmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        name = reader["GuestName"] != DBNull.Value ? reader["GuestName"].ToString() : "";
                        email = reader["EmailAddress"] != DBNull.Value ? reader["EmailAddress"].ToString() : "";
                        msg = reader["Message"] != DBNull.Value ? reader["Message"].ToString() : "";
                        currentStatus = reader["Status"] != DBNull.Value ? reader["Status"].ToString() : "Unread";
                    }
                }
            }

            string newStatus = (currentStatus == "Unread") ? "Read" : "Unread";
            int isReadInt = (newStatus == "Read") ? 1 : 0;

            // 2. Update ContactEnquiries table (Status = 'Read' / 'Unread')
            string sql = "UPDATE ContactEnquiries SET Status = @NewStatus WHERE EnquiryID = @ID";
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@NewStatus", newStatus);
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.ExecuteNonQuery();
            }

            // 3. Synchronize ContactMessages table so IsRead becomes 1 (or 0) in DB
            try
            {
                string sqlMsg = @"
                    UPDATE ContactMessages 
                    SET IsRead = @IsRead 
                    WHERE (Email = @Email AND Message = @Message)
                       OR ContactMessageId = (
                            SELECT TOP 1 ContactMessageId 
                            FROM ContactMessages 
                            WHERE Email = @Email 
                            ORDER BY ContactMessageId DESC
                       )";

                using (SqlCommand cmdMsg = new SqlCommand(sqlMsg, con))
                {
                    cmdMsg.Parameters.AddWithValue("@IsRead", isReadInt);
                    cmdMsg.Parameters.AddWithValue("@Email", email);
                    cmdMsg.Parameters.AddWithValue("@Message", msg);
                    cmdMsg.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
        ShowMessage("Enquiry status updated.", true);
    }

    private void DeleteEnquiry(int id)
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            string email = "";
            string msg = "";
            string selectSql = "SELECT EmailAddress, Message FROM ContactEnquiries WHERE EnquiryID = @ID";
            using (SqlCommand selCmd = new SqlCommand(selectSql, con))
            {
                selCmd.Parameters.AddWithValue("@ID", id);
                using (SqlDataReader r = selCmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        email = r["EmailAddress"] != DBNull.Value ? r["EmailAddress"].ToString() : "";
                        msg = r["Message"] != DBNull.Value ? r["Message"].ToString() : "";
                    }
                }
            }

            string sql = "DELETE FROM ContactEnquiries WHERE EnquiryID = @ID";
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.ExecuteNonQuery();
            }

            try
            {
                string sqlMsg = "DELETE FROM ContactMessages WHERE Email = @Email AND Message = @Message";
                using (SqlCommand cmdMsg = new SqlCommand(sqlMsg, con))
                {
                    cmdMsg.Parameters.AddWithValue("@Email", email);
                    cmdMsg.Parameters.AddWithValue("@Message", msg);
                    cmdMsg.ExecuteNonQuery();
                }
            }
            catch { }
        }
        ShowMessage("Enquiry deleted successfully.", true);
    }

    private void ShowMessage(string msg, bool isSuccess)
    {
        pnlEnquiryMsg.Visible = true;
        lblEnquiryMsg.Text = msg;
        if (isSuccess)
        {
            pnlEnquiryMsg.CssClass = "alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4";
        }
        else
        {
            pnlEnquiryMsg.CssClass = "alert alert-danger alert-dismissible fade show mb-4 shadow-sm rounded-4";
        }
    }
}
