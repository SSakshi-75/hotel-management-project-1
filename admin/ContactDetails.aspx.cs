using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_ContactDetails : Page
{
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!IsPostBack)
        {
            EnsureHotelSettingsTableExists();
            LoadContactDetails();
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

    private void LoadContactDetails()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT TOP 1 HotelName, ContactEmail, PhoneNumber, LocationAddress, GoogleMapUrl, FormHeading, UpdatedAt FROM HotelSettings ORDER BY SettingID DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtLocationAddress.Text = reader["LocationAddress"] != DBNull.Value 
                                ? reader["LocationAddress"].ToString() 
                                : "";

                            txtPhoneNumber.Text = reader["PhoneNumber"] != DBNull.Value 
                                ? reader["PhoneNumber"].ToString() 
                                : "";

                            txtContactEmail.Text = reader["ContactEmail"] != DBNull.Value 
                                ? reader["ContactEmail"].ToString() 
                                : "";

                            txtHotelName.Text = reader["HotelName"] != DBNull.Value 
                                ? reader["HotelName"].ToString() 
                                : "Hotel Management Executive Portal";

                            txtFormHeading.Text = reader["FormHeading"] != DBNull.Value 
                                ? reader["FormHeading"].ToString() 
                                : "Send a Message";

                            txtGoogleMapUrl.Text = reader["GoogleMapUrl"] != DBNull.Value 
                                ? reader["GoogleMapUrl"].ToString() 
                                : "";

                            if (reader["UpdatedAt"] != DBNull.Value)
                            {
                                DateTime updated = Convert.ToDateTime(reader["UpdatedAt"]);
                                lblLastSaved.Text = updated.ToString("dd MMM yyyy, hh:mm tt");
                            }
                            else
                            {
                                lblLastSaved.Text = "Default";
                            }
                        }
                        else
                        {
                            // Populate default empty values
                            txtLocationAddress.Text = "";
                            txtPhoneNumber.Text = "";
                            txtContactEmail.Text = "";
                            txtHotelName.Text = "Hotel Management Executive Portal";
                            txtFormHeading.Text = "Send a Message";
                            lblLastSaved.Text = "Default Initialized";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error loading contact details: " + ex.Message, false);
        }
    }

    protected void btnSaveContactDetails_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            ShowStatusMessage("Database connection string not configured.", false);
            return;
        }

        string location = txtLocationAddress.Text.Trim();
        string phone = txtPhoneNumber.Text.Trim();
        string email = txtContactEmail.Text.Trim();

        if (string.IsNullOrEmpty(location))
        {
            ShowStatusMessage("Please provide a valid Location Address.", false);
            return;
        }

        if (string.IsNullOrEmpty(phone))
        {
            ShowStatusMessage("Please provide a valid Phone Number.", false);
            return;
        }

        if (string.IsNullOrEmpty(email))
        {
            ShowStatusMessage("Please provide a valid Contact Email Address.", false);
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string countQuery = "SELECT COUNT(*) FROM HotelSettings";
                SqlCommand countCmd = new SqlCommand(countQuery, con);
                int count = Convert.ToInt32(countCmd.ExecuteScalar());

                string sql;
                if (count > 0)
                {
                    sql = @"UPDATE HotelSettings SET 
                                LocationAddress = @LocationAddress, 
                                PhoneNumber = @PhoneNumber, 
                                ContactEmail = @ContactEmail, 
                                HotelName = @HotelName, 
                                FormHeading = @FormHeading, 
                                GoogleMapUrl = @GoogleMapUrl, 
                                UpdatedAt = GETDATE()";
                }
                else
                {
                    sql = @"INSERT INTO HotelSettings (LocationAddress, PhoneNumber, ContactEmail, HotelName, FormHeading, GoogleMapUrl, Currency, UpdatedAt) 
                            VALUES (@LocationAddress, @PhoneNumber, @ContactEmail, @HotelName, @FormHeading, @GoogleMapUrl, 'INR (₹)', GETDATE())";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@LocationAddress", location);
                    cmd.Parameters.AddWithValue("@PhoneNumber", phone);
                    cmd.Parameters.AddWithValue("@ContactEmail", email);
                    cmd.Parameters.AddWithValue("@HotelName", string.IsNullOrWhiteSpace(txtHotelName.Text) ? "Hotel Management Executive Portal" : txtHotelName.Text.Trim());
                    cmd.Parameters.AddWithValue("@FormHeading", string.IsNullOrWhiteSpace(txtFormHeading.Text) ? "Send a Message" : txtFormHeading.Text.Trim());
                    cmd.Parameters.AddWithValue("@GoogleMapUrl", txtGoogleMapUrl.Text.Trim());

                    cmd.ExecuteNonQuery();
                }
            }

            lblLastSaved.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            ShowStatusMessage("Location & Contact Card details have been successfully saved and updated on the website!", true);
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error saving contact details: " + ex.Message, false);
        }
    }

    private void ShowStatusMessage(string message, bool isSuccess)
    {
        pnlStatusMsg.Visible = true;
        lblStatusMessage.Text = message;
        if (isSuccess)
        {
            pnlStatusMsg.CssClass = "alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4";
            msgIcon.Attributes["class"] = "bi bi-check-circle-fill fs-4 text-success";
        }
        else
        {
            pnlStatusMsg.CssClass = "alert alert-danger alert-dismissible fade show mb-4 shadow-sm rounded-4";
            msgIcon.Attributes["class"] = "bi bi-exclamation-triangle-fill fs-4 text-danger";
        }
    }
}
