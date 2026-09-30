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
        if (Session["UserId"] != null)
        {
            phLoggedOut.Visible = false;
            phLoggedIn.Visible = true;

            string userName = Session["UserName"] != null ? Session["UserName"].ToString().Trim() : "Customer";
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
