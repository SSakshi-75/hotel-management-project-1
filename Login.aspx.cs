using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;

public partial class Login : System.Web.UI.Page
{
    // ==========================================
    // PAGE LOAD
    // ==========================================

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();

        if (!IsPostBack)
        {
            txtEmail.Text = string.Empty;
            txtPassword.Attributes["value"] = string.Empty;
            txtPassword.Attributes["autocomplete"] = "new-password";
            txtEmail.Attributes["autocomplete"] = "off";

            string msg = Request["msg"];
            if (msg == "room")
            {
                lblMessage.Text = "<i class='bi bi-info-circle-fill me-1'></i> Please sign in or register to book a room.";
                lblMessage.CssClass = "alert alert-warning d-block small fw-bold py-2 mb-3";
            }
            else if (msg == "table")
            {
                lblMessage.Text = "<i class='bi bi-info-circle-fill me-1'></i> Please sign in or register to book a table.";
                lblMessage.CssClass = "alert alert-warning d-block small fw-bold py-2 mb-3";
            }
            else if (msg == "logout")
            {
                lblMessage.Text = "<i class='bi bi-check-circle-fill me-1'></i> You have been successfully logged out.";
                lblMessage.CssClass = "alert alert-success d-block small fw-bold py-2 mb-3";
            }

            string returnUrl = Request["returnUrl"];
            if (!string.IsNullOrEmpty(returnUrl) && lnkRegister != null)
            {
                lnkRegister.NavigateUrl = "~/Register.aspx?returnUrl=" + Server.UrlEncode(returnUrl);
            }
        }
    }


    // ==========================================
    // LOGIN BUTTON
    // ==========================================

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // ==========================================
        // CHECK ASP.NET VALIDATION
        // ==========================================

        if (!Page.IsValid)
        {
            return;
        }


        // ==========================================
        // GET VALUES FROM LOGIN FORM
        // ==========================================

        string email = txtEmail.Text.Trim();

        string password = txtPassword.Text;


        // ==========================================
        // GET DATABASE CONNECTION STRING
        // ==========================================

        string connectionString =
            ConfigurationManager
            .ConnectionStrings["HotelConnection"]
            .ConnectionString;


        // ==========================================
        // CREATE DATABASE CONNECTION
        // ==========================================

        using (SqlConnection con =
            new SqlConnection(connectionString))
        {


            // ==========================================
            // SQL QUERY
            // Find user by Email (case-insensitive)
            // ==========================================

            string query = @"
                SELECT
                    UserId,
                    FirstName,
                    LastName,
                    Email,
                    PasswordHash
                FROM Users
                WHERE LOWER(Email) = LOWER(@Email)";


            // ==========================================
            // CREATE SQL COMMAND
            // ==========================================

            using (SqlCommand cmd =
                new SqlCommand(query, con))
            {


                // ==========================================
                // SEND EMAIL TO SQL QUERY
                // ==========================================

                cmd.Parameters.AddWithValue(
                    "@Email",
                    email
                );


                // ==========================================
                // OPEN DATABASE CONNECTION
                // ==========================================

                con.Open();


                // ==========================================
                // EXECUTE QUERY
                // ==========================================

                using (SqlDataReader dr =
                    cmd.ExecuteReader())
                {


                    // ==========================================
                    // CHECK USER FOUND OR NOT
                    // ==========================================

                    if (dr.Read())
                    {


                        // ==========================================
                        // GET USER ID
                        // ==========================================

                        int userId =
                            Convert.ToInt32(
                                dr["UserId"]
                            );


                        // ==========================================
                        // GET FIRST NAME
                        // ==========================================

                        string firstName =
                            dr["FirstName"].ToString();


                        // ==========================================
                        // GET LAST NAME
                        // ==========================================

                        string lastName =
                            dr["LastName"].ToString();


                        // ==========================================
                        // GET EMAIL
                        // ==========================================

                        string userEmail =
                            dr["Email"].ToString();


                        // ==========================================
                        // GET STORED PASSWORD HASH
                        // ==========================================

                        string storedPasswordHash =
                            dr["PasswordHash"].ToString();


                        // ==========================================
                        // VERIFY PASSWORD
                        // ==========================================

                        bool passwordCorrect =
                            VerifyPassword(
                                password,
                                storedPasswordHash
                            );

                        if (!passwordCorrect && !string.IsNullOrEmpty(password) && password != password.Trim())
                        {
                            passwordCorrect =
                                VerifyPassword(
                                    password.Trim(),
                                    storedPasswordHash
                                );
                        }


                        // ==========================================
                        // PASSWORD CORRECT
                        // ==========================================

                        if (passwordCorrect)
                        {
                            dr.Close();

                            // ==========================================
                            // RECORD USER LOGIN IN DATABASE ([Login] & [Users])
                            // ==========================================
                            try
                            {
                                string logUserQuery = @"
                                    UPDATE Users 
                                    SET LastLogin = GETDATE() 
                                    WHERE UserId = @LogUserId;

                                    INSERT INTO [Login] (UserId, UserName, Email, LoginTime, Role, Status)
                                    VALUES (@LogUserId, @LogUserName, @LogEmail, GETDATE(), 'Guest', 'Logged In');";

                                using (SqlCommand logCmd = new SqlCommand(logUserQuery, con))
                                {
                                    logCmd.Parameters.AddWithValue("@LogUserId", userId);
                                    logCmd.Parameters.AddWithValue("@LogUserName", firstName + " " + lastName);
                                    logCmd.Parameters.AddWithValue("@LogEmail", userEmail);
                                    logCmd.ExecuteNonQuery();
                                }
                            }
                            catch { }

                            // ==========================================
                            // CREATE USER SESSION
                            // ==========================================

                            Session["UserId"] =
                                userId;


                            Session["UserName"] =
                                firstName + " " + lastName;


                            Session["UserEmail"] =
                                userEmail;


                            // ==========================================
                            // REDIRECT (RETURN URL OR CONFIRMATION)
                            // ==========================================

                            string returnUrl = Request["returnUrl"];
                            if (!string.IsNullOrEmpty(returnUrl))
                            {
                                Response.Redirect(returnUrl);
                            }
                            else
                            {
                                Response.Redirect("LoginConfirmation.aspx");
                            }
                        }


                        // ==========================================
                        // PASSWORD WRONG
                        // ==========================================

                        else
                        {
                            lblMessage.Text =
                                "Incorrect password. Please enter your correct password.";


                            lblMessage.CssClass =
                                "text-danger";
                        }
                    }


                    // ==========================================
                    // USER NOT FOUND IN USERS TABLE
                    // Check AdminLogin database table
                    // ==========================================

                    else
                    {
                        dr.Close();

                        string adminQuery = @"
                            SELECT AdminId, Email, PasswordHash
                            FROM AdminLogin
                            WHERE LOWER(Email) = LOWER(@Email)";

                        using (SqlCommand adminCmd = new SqlCommand(adminQuery, con))
                        {
                            adminCmd.Parameters.AddWithValue("@Email", email);

                            using (SqlDataReader adminDr = adminCmd.ExecuteReader())
                            {
                                if (adminDr.Read())
                                {
                                    int adminId = Convert.ToInt32(adminDr["AdminId"]);
                                    string adminEmail = adminDr["Email"].ToString();
                                    string storedAdminHash = adminDr["PasswordHash"].ToString();

                                    bool adminPassCorrect =
                                        storedAdminHash == password ||
                                        storedAdminHash == password.Trim() ||
                                        VerifyPassword(password, storedAdminHash);

                                    if (adminPassCorrect)
                                    {
                                        Session["AdminId"] = adminId;
                                        Session["AdminEmail"] = adminEmail;
                                        Session["UserName"] = "Administrator";
                                        Session["IsAdmin"] = true;
                                        Response.Redirect("~/admin/Dashboard.aspx");
                                        return;
                                    }
                                    else
                                    {
                                        lblMessage.Text = "Incorrect password. Please enter your correct password.";
                                        lblMessage.CssClass = "text-danger";
                                        return;
                                    }
                                }
                            }
                        }

                        lblMessage.Text =
                            "Email address not found. Please check your email or register.";


                        lblMessage.CssClass =
                            "text-danger";
                    }
                }
            }
        }
    }


    // ==========================================
    // VERIFY PASSWORD
    // ==========================================
    //
    // This method:
    //
    // 1. Gets stored PasswordHash
    // 2. Converts Base64 into bytes
    // 3. Gets the first 16 bytes as Salt
    // 4. Creates a new hash from entered password
    // 5. Compares both hashes
    //
    // ==========================================

    private bool VerifyPassword(
        string password,
        string storedHash)
    {
        try
        {
            if (string.IsNullOrEmpty(storedHash) || string.IsNullOrEmpty(password))
            {
                return false;
            }

            // ==========================================
            // FORMAT 1: SaltBase64:HashBase64 (Generated by Register.aspx)
            // ==========================================
            if (storedHash.Contains(":"))
            {
                string[] parts = storedHash.Split(':');
                if (parts.Length != 2)
                {
                    return false;
                }

                byte[] salt = Convert.FromBase64String(parts[0]);
                byte[] expectedHash = Convert.FromBase64String(parts[1]);

                using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000))
                {
                    byte[] actualHash = pbkdf2.GetBytes(expectedHash.Length);

                    if (actualHash.Length != expectedHash.Length)
                    {
                        return false;
                    }

                    int diff = 0;
                    for (int i = 0; i < actualHash.Length; i++)
                    {
                        diff |= (actualHash[i] ^ expectedHash[i]);
                    }

                    return diff == 0;
                }
            }
            else
            {
                // ==========================================
                // FORMAT 2: Raw Base64 (16 bytes Salt + Hash)
                // ==========================================
                byte[] hashBytes = Convert.FromBase64String(storedHash);
                if (hashBytes.Length < 16)
                {
                    return false;
                }

                byte[] salt = new byte[16];
                Array.Copy(hashBytes, 0, salt, 0, 16);

                int hashLen = hashBytes.Length - 16;
                using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, 100000))
                {
                    byte[] actualHash = pbkdf2.GetBytes(hashLen > 0 ? hashLen : 20);

                    for (int i = 0; i < actualHash.Length; i++)
                    {
                        if (hashBytes[i + 16] != actualHash[i])
                        {
                            return false;
                        }
                    }

                    return true;
                }
            }
        }
        catch
        {
            return false;
        }
    }
}
