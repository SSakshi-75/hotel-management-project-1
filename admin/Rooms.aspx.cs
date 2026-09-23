using System;
using System.Web.UI;

public partial class Admin_Rooms : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("ManageHotel.aspx", true);
    }
}
