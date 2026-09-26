using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_Settings : Page
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
            LoadHotelSettings();
        }
    }

    private void EnsureHotelSettingsTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

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

    private void LoadHotelSettings()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();
            string query = "SELECT TOP 1 HotelName, ContactEmail, PhoneNumber, LocationAddress, GoogleMapUrl, FormHeading, Currency, UpdatedAt FROM HotelSettings ORDER BY SettingID DESC";
            
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtHotelName.Text = reader["HotelName"] != DBNull.Value ? reader["HotelName"].ToString() : "";
                        txtContactEmail.Text = reader["ContactEmail"] != DBNull.Value ? reader["ContactEmail"].ToString() : "";
                        txtPhoneNumber.Text = reader["PhoneNumber"] != DBNull.Value ? reader["PhoneNumber"].ToString() : "";
                        txtLocationAddress.Text = reader["LocationAddress"] != DBNull.Value ? reader["LocationAddress"].ToString() : "";
                        txtMapUrl.Text = reader["GoogleMapUrl"] != DBNull.Value ? reader["GoogleMapUrl"].ToString() : "";
                        txtFormHeading.Text = reader["FormHeading"] != DBNull.Value ? reader["FormHeading"].ToString() : "Send a Message";
                        txtCurrency.Text = reader["Currency"] != DBNull.Value ? reader["Currency"].ToString() : "INR (₹)";

                        if (reader["UpdatedAt"] != DBNull.Value)
                        {
                            DateTime updated = Convert.ToDateTime(reader["UpdatedAt"]);
                            lblLastUpdated.Text = updated.ToString("dd MMM yyyy, hh:mm tt");
                        }
                    }
                    else
                    {
                        // Set defaults if empty
                        txtHotelName.Text = "Hotel Management Executive Portal";
                        txtContactEmail.Text = "";
                        txtPhoneNumber.Text = "";
                        txtLocationAddress.Text = "";
                        txtMapUrl.Text = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin";
                        txtFormHeading.Text = "Send a Message";
                        txtCurrency.Text = "INR (₹)";
                    }
                }
            }
        }
    }

    protected void btnSaveSettings_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            ShowStatusMessage("Database connection error.", false);
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
                                HotelName = @HotelName, 
                                ContactEmail = @ContactEmail, 
                                PhoneNumber = @PhoneNumber, 
                                LocationAddress = @LocationAddress, 
                                GoogleMapUrl = @GoogleMapUrl, 
                                FormHeading = @FormHeading, 
                                Currency = @Currency, 
                                UpdatedAt = GETDATE()";
                }
                else
                {
                    sql = @"INSERT INTO HotelSettings (HotelName, ContactEmail, PhoneNumber, LocationAddress, GoogleMapUrl, FormHeading, Currency, UpdatedAt) 
                            VALUES (@HotelName, @ContactEmail, @PhoneNumber, @LocationAddress, @GoogleMapUrl, @FormHeading, @Currency, GETDATE())";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@HotelName", txtHotelName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ContactEmail", txtContactEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@LocationAddress", txtLocationAddress.Text.Trim());
                    cmd.Parameters.AddWithValue("@GoogleMapUrl", txtMapUrl.Text.Trim());
                    cmd.Parameters.AddWithValue("@FormHeading", string.IsNullOrWhiteSpace(txtFormHeading.Text) ? "Send a Message" : txtFormHeading.Text.Trim());
                    cmd.Parameters.AddWithValue("@Currency", string.IsNullOrWhiteSpace(txtCurrency.Text) ? "INR (₹)" : txtCurrency.Text.Trim());

                    cmd.ExecuteNonQuery();
                }
            }

            lblLastUpdated.Text = DateTime.Now.ToString("dd MMM yyyy, hh:mm tt");
            ShowStatusMessage("Hotel settings and contact page configuration updated successfully!", true);
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error saving settings: " + ex.Message, false);
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

