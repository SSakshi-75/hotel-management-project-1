using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Segregate customer and admin sessions:
        // The public website header must only display genuine logged-in customers/guests, NOT administrators.
        bool isAdminSession = Session["AdminId"] != null || 
                              (Session["IsAdmin"] != null && (bool)Session["IsAdmin"]);

        string userName = Session["UserName"] != null ? Session["UserName"].ToString().Trim() : "";
        bool isAdministratorName = string.Equals(userName, "Administrator", StringComparison.OrdinalIgnoreCase);

        if (Session["UserId"] != null && !isAdminSession && !isAdministratorName)
        {
            phLoggedOut.Visible = false;
            phLoggedIn.Visible = true;

            if (string.IsNullOrEmpty(userName))
            {
                userName = "Customer";
            }

            // Extract first name for desktop compact display
            string firstName = userName;
            int spaceIdx = userName.IndexOf(' ');
            if (spaceIdx > 0)
            {
                firstName = userName.Substring(0, spaceIdx);
            }

            litUserName.Text = Server.HtmlEncode(firstName);
            litUserNameMobile.Text = Server.HtmlEncode(userName);
        }
        else
        {
            phLoggedOut.Visible = true;
            phLoggedIn.Visible = false;
        }
    }
}
