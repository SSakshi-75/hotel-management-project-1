using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;

public partial class Register : System.Web.UI.Page
{
    string connectionString =
        ConfigurationManager
        .ConnectionStrings["HotelConnection"]
        .ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtEmail.Text = string.Empty;
            txtPassword.Attributes["value"] = string.Empty;
            txtConfirmPassword.Attributes["value"] = string.Empty;
            txtPassword.Attributes["autocomplete"] = "new-password";
            txtConfirmPassword.Attributes["autocomplete"] = "new-password";
            txtEmail.Attributes["autocomplete"] = "off";
        }
    }


    // Password validation
    protected void cvPassword_ServerValidate(
        object source,
        System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        args.IsValid = args.Value.Length >= 8;
    }


    // Terms validation
    protected void cvTerms_ServerValidate(
        object source,
        System.Web.UI.WebControls.ServerValidateEventArgs args)
    {
        args.IsValid = chkTerms.Checked;
    }


    protected void btnRegister_Click(object sender, EventArgs e)
    {
        Page.Validate();

        if (!Page.IsValid)
        {
            return;
        }


        // Get values from form

        string firstName = txtFirstName.Text.Trim();

        string lastName = txtLastName.Text.Trim();

        string email = txtEmail.Text.Trim();

        string phone = txtPhone.Text.Trim();

        string password = txtPassword.Text;


        using (SqlConnection con =
            new SqlConnection(connectionString))
        {
            con.Open();


            // Check email already exists

            string checkQuery =
                "SELECT COUNT(*) FROM Users WHERE Email = @Email";


            using (SqlCommand checkCmd =
                new SqlCommand(checkQuery, con))
            {
                checkCmd.Parameters.AddWithValue(
                    "@Email",
                    email);


                int count =
                    Convert.ToInt32(
                        checkCmd.ExecuteScalar());


                if (count > 0)
                {
                    lblMessage.Text =
                        "This email address is already registered.";

                    lblMessage.CssClass =
                        "text-danger";

                    return;
                }
            }


            // Password Hash

            string passwordHash =
                HashPassword(password);


            // Insert User

            string insertQuery = @"

                INSERT INTO Users
                (
                    FirstName,
                    LastName,
                    Email,
                    Phone,
                    PasswordHash
                )

                OUTPUT INSERTED.UserId

                VALUES
                (
                    @FirstName,
                    @LastName,
                    @Email,
                    @Phone,
                    @PasswordHash
                )";


            using (SqlCommand cmd =
                new SqlCommand(insertQuery, con))
            {
                cmd.Parameters.AddWithValue(
                    "@FirstName",
                    firstName);

                cmd.Parameters.AddWithValue(
                    "@LastName",
                    lastName);

                cmd.Parameters.AddWithValue(
                    "@Email",
                    email);

                cmd.Parameters.AddWithValue(
                    "@Phone",
                    phone);

                cmd.Parameters.AddWithValue(
                    "@PasswordHash",
                    passwordHash);


                // Get new UserId

                int userId =
                    Convert.ToInt32(
                        cmd.ExecuteScalar());


                // =================================
                // CREATE SESSION
                // =================================

                Session["UserId"] = userId;

                Session["UserName"] =
                    firstName + " " + lastName;

                Session["UserEmail"] =
                    email;


                // =================================
                // CONFIRMATION PAGE
                // =================================

                Response.Redirect(
                    "RegistrationConfirmation.aspx");
            }
        }
    }


    // =====================================
    // PASSWORD HASHING
    // =====================================

    private string HashPassword(string password)
    {
        byte[] salt = new byte[16];


        using (var rng =
            RandomNumberGenerator.Create())
        {
            rng.GetBytes(salt);
        }


        using (var pbkdf2 =
            new Rfc2898DeriveBytes(
                password,
                salt,
                100000))
        {
            byte[] hash =
                pbkdf2.GetBytes(32);


            return
                Convert.ToBase64String(salt)
                + ":"
                + Convert.ToBase64String(hash);
        }
    }
}
