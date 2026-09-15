using System;

public partial class LoginConfirmation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string userName = Convert.ToString(Session["UserName"]);

            lblWelcome.Text = "Welcome back, " + userName + "!";
        }
    }
}
