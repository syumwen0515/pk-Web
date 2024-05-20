using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace 最終版
{
    public partial class checkout : System.Web.UI.Page
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

            // 從 URL 中獲取參數
            string checkoutDetails = Request.QueryString["checkoutDetails"];

            // 將購物清單資訊顯示在 Literal 控制項中
            checkoutDetailsLiteral.Text = checkoutDetails;
        }
    }
}