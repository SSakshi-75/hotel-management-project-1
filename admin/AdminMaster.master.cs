using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Close mobile sidebar on fresh page navigation
            Session["AdminSidebarOpen"] = false;
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ApplySidebarState();
    }

    private void ApplySidebarState()
    {
        bool isOpen = Session["AdminSidebarOpen"] != null && (bool)Session["AdminSidebarOpen"];
        if (isOpen)
        {
            adminSidebar.Attributes["class"] = "admin-sidebar open";
            sidebarOverlay.CssClass = "admin-sidebar-overlay active";
        }
        else
        {
            adminSidebar.Attributes["class"] = "admin-sidebar";
            sidebarOverlay.CssClass = "admin-sidebar-overlay";
        }
    }

    protected void btnSidebarToggle_Click(object sender, EventArgs e)
    {
        bool isOpen = Session["AdminSidebarOpen"] != null && (bool)Session["AdminSidebarOpen"];
        Session["AdminSidebarOpen"] = !isOpen;
    }

    protected void btnSidebarClose_Click(object sender, EventArgs e)
    {
        Session["AdminSidebarOpen"] = false;
    }
}
