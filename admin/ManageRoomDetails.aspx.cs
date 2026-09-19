using System;
using System.Web.UI;

public partial class Admin_ManageRoomDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Initial form load
        }
    }

    protected void btnSaveDetails_Click(object sender, EventArgs e)
    {
        pnlSuccess.Visible = true;
    }
}
