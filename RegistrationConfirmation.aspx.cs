using System;

public partial class RegistrationConfirmation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Register.aspx");
                return;
            }

            string userName = Convert.ToString(Session["UserName"]);

            lblWelcome.Text = "Welcome, " + userName + "!";
        }
    }
}
