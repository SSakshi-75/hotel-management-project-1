using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Contact : System.Web.UI.Page
{
    // ==========================================
    // DATABASE CONNECTION
    // ==========================================
    private string connectionString =
        ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";


    // ==========================================
    // PAGE LOAD
    // ==========================================
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadContactCards();
        }
    }


    // ==========================================
    // LOAD CONTACT CARDS (LOCATION & PHONE/EMAIL)
    // ==========================================
    private void LoadContactCards()
    {
        if (string.IsNullOrEmpty(connectionString))
        {
            BindDefaultCards();
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Try loading from HotelSettings (Managed via Admin Panel)
                string querySettings = @"
                    SELECT TOP 1
                        LocationAddress,
                        PhoneNumber,
                        ContactEmail,
                        FormHeading,
                        GoogleMapUrl
                    FROM HotelSettings
                    ORDER BY SettingID DESC";

                bool loaded = false;
                using (SqlCommand cmd = new SqlCommand(querySettings, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string loc = dr["LocationAddress"] != DBNull.Value ? dr["LocationAddress"].ToString() : "";
                            string phone = dr["PhoneNumber"] != DBNull.Value ? dr["PhoneNumber"].ToString() : "";
                            string email = dr["ContactEmail"] != DBNull.Value ? dr["ContactEmail"].ToString() : "";
                            string heading = dr["FormHeading"] != DBNull.Value ? dr["FormHeading"].ToString() : "";
                            string mapUrl = dr["GoogleMapUrl"] != DBNull.Value ? dr["GoogleMapUrl"].ToString() : "";

                            BindCards(loc, phone, email);
                            if (!string.IsNullOrEmpty(heading))
                            {
                                litFormHeading.Text = heading;
                            }
                            if (!string.IsNullOrEmpty(mapUrl))
                            {
                                iframeMap.Attributes["src"] = mapUrl;
                            }
                            loaded = true;
                        }
                    }
                }

                // 2. If not found in HotelSettings, check ContactCards
                if (!loaded)
                {
                    string queryCards = @"
                        SELECT TOP 1
                            LocationAddress,
                            PhoneNumber,
                            ContactEmail
                        FROM ContactCards
                        WHERE IsActive = 1
                        ORDER BY ContactCardId DESC";

                    using (SqlCommand cmdCards = new SqlCommand(queryCards, con))
                    {
                        using (SqlDataReader drCards = cmdCards.ExecuteReader())
                        {
                            if (drCards.Read())
                            {
                                string loc = drCards["LocationAddress"].ToString();
                                string phone = drCards["PhoneNumber"].ToString();
                                string email = drCards["ContactEmail"].ToString();
                                BindCards(loc, phone, email);
                                loaded = true;
                            }
                        }
                    }
                }

                // 3. Fallback blank if database tables are empty
                if (!loaded)
                {
                    BindDefaultCards();
                }
            }
        }
        catch (Exception ex)
        {
            BindDefaultCards();
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    private void BindCards(string location, string phone, string email)
    {
        rptLocation.DataSource = new[]
        {
            new { LocationAddress = location }
        };
        rptLocation.DataBind();

        rptPhoneEmail.DataSource = new[]
        {
            new { PhoneNumber = phone, ContactEmail = email }
        };
        rptPhoneEmail.DataBind();
    }

    private void BindDefaultCards()
    {
        BindCards("", "", "");
    }


    // ==========================================
    // SEND CONTACT MESSAGE (SAVES TO DB & NOTIFIES ADMIN)
    // ==========================================
    protected void btnSendMessage_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txtContactName.Text.Trim();
            string email = txtContactEmail.Text.Trim();
            string subject = txtContactSubject.Text.Trim();
            string message = txtContactMessage.Text.Trim();

            // ==========================================
            // BASIC VALIDATION
            // ==========================================
            if (string.IsNullOrEmpty(name))
            {
                ShowMessage("Please enter your name.", false);
                return;
            }

            if (string.IsNullOrEmpty(email))
            {
                ShowMessage("Please enter your email address.", false);
                return;
            }

            if (string.IsNullOrEmpty(message))
            {
                ShowMessage("Please enter your message.", false);
                return;
            }

            if (string.IsNullOrEmpty(subject))
            {
                subject = "General Enquiry";
            }

            // ==========================================
            // SAVE IN DATABASE (BOTH TABLES FOR ADMIN & PERSISTENCE)
            // ==========================================
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Insert into ContactEnquiries (Visible to Admin in Admin Panel -> Enquiries -> Contact Messages)
                string queryEnquiry = @"
                    INSERT INTO ContactEnquiries
                    (
                        GuestName,
                        EmailAddress,
                        Subject,
                        Message,
                        SubmittedAt,
                        Status
                    )
                    VALUES
                    (
                        @GuestName,
                        @EmailAddress,
                        @Subject,
                        @Message,
                        GETDATE(),
                        'Unread'
                    )";

                using (SqlCommand cmdEnquiry = new SqlCommand(queryEnquiry, con))
                {
                    cmdEnquiry.Parameters.AddWithValue("@GuestName", name);
                    cmdEnquiry.Parameters.AddWithValue("@EmailAddress", email);
                    cmdEnquiry.Parameters.AddWithValue("@Subject", subject);
                    cmdEnquiry.Parameters.AddWithValue("@Message", message);
                    cmdEnquiry.ExecuteNonQuery();
                }

                // 2. Also insert into ContactMessages (ensures both database tables are synchronized)
                try
                {
                    string queryMsg = @"
                        INSERT INTO ContactMessages
                        (
                            Name,
                            Email,
                            Subject,
                            Message,
                            CreatedAt,
                            IsRead
                        )
                        VALUES
                        (
                            @Name,
                            @Email,
                            @Subject,
                            @Message,
                            GETDATE(),
                            0
                        )";

                    using (SqlCommand cmdMsg = new SqlCommand(queryMsg, con))
                    {
                        cmdMsg.Parameters.AddWithValue("@Name", name);
                        cmdMsg.Parameters.AddWithValue("@Email", email);
                        cmdMsg.Parameters.AddWithValue("@Subject", subject);
                        cmdMsg.Parameters.AddWithValue("@Message", message);
                        cmdMsg.ExecuteNonQuery();
                    }
                }
                catch
                {
                    // Secondary table fallback
                }
            }

            // ==========================================
            // CLEAR FORM INPUTS
            // ==========================================
            txtContactName.Text = "";
            txtContactEmail.Text = "";
            txtContactSubject.Text = "";
            txtContactMessage.Text = "";

            // ==========================================
            // SUCCESS CONFIRMATION (SHOWN FOR 2 SECONDS)
            // ==========================================
            ShowMessage(
                "Thank you! Your message has been sent successfully. We will get back to you shortly.",
                true
            );
        }
        catch (Exception ex)
        {
            ShowMessage(
                "Something went wrong while sending your message. Please try again.",
                false
            );

            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }


    // ==========================================
    // SHOW SUCCESS / ERROR MESSAGE
    // ==========================================
    private void ShowMessage(string message, bool success)
    {
        pnlContactMsg.Visible = true;
        lblContactMsg.Text = message;

        if (success)
        {
            msgIconContact.Attributes["class"] =
                "bi bi-check-circle-fill fs-4 text-success";

            pnlContactMsg.CssClass =
                "alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4 position-relative overflow-hidden";

            // Script: Shows confirmation prominently for 2 seconds (2000ms), then smoothly fades out & disappears
            string script = @"
                (function() {
                    function initAlert() {
                        var alertElem = document.getElementById('" + pnlContactMsg.ClientID + @"');
                        if (!alertElem) return;

                        try {
                            alertElem.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        } catch(e) {}

                        var timerBar = alertElem.querySelector('.alert-timer-bar');
                        if (timerBar) {
                            timerBar.style.display = 'block';
                            timerBar.style.width = '100%';
                            timerBar.style.transition = 'width 2s linear';
                            setTimeout(function() {
                                timerBar.style.width = '0%';
                            }, 20);
                        }

                        // Show confirmation for 2 seconds, then smoothly fade out
                        setTimeout(function() {
                            alertElem.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                            alertElem.style.opacity = '0';
                            alertElem.style.transform = 'translateY(-10px)';
                            setTimeout(function() {
                                alertElem.style.display = 'none';
                            }, 500);
                        }, 2000);
                    }

                    if (document.readyState === 'loading') {
                        document.addEventListener('DOMContentLoaded', initAlert);
                    } else {
                        initAlert();
                    }
                })();";

            ClientScript.RegisterStartupScript(this.GetType(), "AutoDismissAlert2Sec", script, true);
        }
        else
        {
            msgIconContact.Attributes["class"] =
                "bi bi-exclamation-triangle-fill fs-4 text-danger";

            pnlContactMsg.CssClass =
                "alert alert-danger alert-dismissible fade show mb-4 shadow-sm rounded-4";

            string hideBarScript = @"
                (function() {
                    var bar = document.querySelector('.alert-timer-bar');
                    if (bar) bar.style.display = 'none';
                })();";
            ClientScript.RegisterStartupScript(this.GetType(), "HideTimerBar", hideBarScript, true);
        }
    }
}