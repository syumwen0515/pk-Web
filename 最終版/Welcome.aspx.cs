using System;
using System.Web;
using System.Web.UI;

namespace 最終版
{
    public partial class Welcome : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["UserId"] != null)
                {
                    string userId = Request.Cookies["UserId"].Value;
                    lblUserIdNavbar.Text = userId;
                }
                else
                {
                    lblUserIdNavbar.Text = "Guest";
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // 清除UserId的Cookie
            if (Request.Cookies["UserId"] != null)
            {
                HttpCookie cookie = new HttpCookie("UserId");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }

            // 重定向到index.aspx
            Response.Redirect("index.aspx");
        }
    }
}
