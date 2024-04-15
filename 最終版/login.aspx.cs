using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.OleDb;


namespace 最終版
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // 將使用者 ID 儲存在 Cookie 中
            HttpCookie cookie = new HttpCookie("UserId");
            cookie.Value = username;

            // 在這裡進行使用者名稱和密碼的驗證
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            string query = "SELECT Count(*) FROM client WHERE username = @Username AND password = @Password";

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                using (OleDbCommand command = new OleDbCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    connection.Close();

                    if (count > 0)
                    {
                        // 將使用者 ID 儲存在 Cookie 中
                        Response.Cookies.Add(cookie);
                        // 登入成功，導向到下一個頁面或者執行其他操作
                        Response.Redirect("Welcome.aspx");
                    }
                    else
                    {
                        // 登入失敗，顯示錯誤訊息
                        lblMessage.Text = "使用者帳號或密碼錯誤！";
                        lblMessage.Visible = true;
                    }
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // 在這裡處理註冊按鈕的點擊事件
            // 可以是導向到註冊頁面的重定向，或者其他相關操作
        }
    }
}