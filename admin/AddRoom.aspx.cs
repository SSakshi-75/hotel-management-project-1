using System;
using System.Web.UI;

public partial class Admin_AddRoom : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Initial form setup for admin frontend
        }
    }

    protected void btnSaveRoom_Click(object sender, EventArgs e)
    {
        // Frontend submit feedback
        pnlSuccessMessage.Visible = true;
    }
}
