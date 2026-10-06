using System;
using System.Web;
using System.Web.Security;

public partial class admin_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // ==========================================
        // 1. PREVENT BROWSER CACHE
        // ==========================================
        // Logout ke baad browser Back button se
        // purana admin page display na ho.
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));


        // ==========================================
        // 2. CLEAR ADMIN SESSION
        // ==========================================
        // Admin ki saari session information clear.
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();


        // ==========================================
        // 3. EXPIRE ASP.NET SESSION COOKIE
        // ==========================================
        if (Request.Cookies["ASP.NET_SessionId"] != null)
        {
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires =
                DateTime.Now.AddMonths(-20);
        }


        // ==========================================
        // 4. LOGOUT FROM FORMS AUTHENTICATION
        // ==========================================
        try
        {
            FormsAuthentication.SignOut();
        }
        catch
        {
            // Forms Authentication enabled na ho
            // to error ignore kar do.
        }


        // ==========================================
        // 5. REDIRECT TO ADMIN LOGIN
        // ==========================================
        Response.Redirect("Login.aspx", true);
    }
}

