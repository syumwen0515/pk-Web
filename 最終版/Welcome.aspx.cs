using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 最終版
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 检查是否存在名为 "UserId" 的 cookie
            if (Request.Cookies["UserId"] != null)
            {
                // 获取名为 "UserId" 的 cookie 的值
                string userId = Request.Cookies["UserId"].Value;

                // 将用户 ID 设置为 lblUserIdNavbar 的文本
                lblUserIdNavbar.Text = userId;
            }
            else
            {
                // 如果不存在名为 "UserId" 的 cookie，则将文本设置为默认值或者空字符串
                lblUserIdNavbar.Text = "Guest";
            }
        }
        
    }
}