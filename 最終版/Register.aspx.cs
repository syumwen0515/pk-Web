using System;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.Data;


namespace 最終版
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 在這裡處理頁面載入事件
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // 假設您的資料庫連接字串為 connectionString，並且有一個名為 client 的表格，包含 username 和 password 兩個欄位
            string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\網頁設計\最終版\最終版\Database1.accdb;";
            string query = "INSERT INTO client VALUES (@Username, @Password)";

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                using (OleDbCommand command = new OleDbCommand(query, connection))
                {
                    var usernameParameter = new OleDbParameter
                    {
                        DbType = DbType.AnsiString,
                        ParameterName = "@Username",
                        Value = username
                    };
                    command.Parameters.Add(usernameParameter);

                    var passwordParameter = new OleDbParameter
                    {
                        DbType = DbType.AnsiString,
                        ParameterName = "@Password",
                        Value = password
                    };
                    command.Parameters.Add(passwordParameter);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    connection.Close();

                    // 檢查是否成功添加新用戶
                    if (rowsAffected > 0)
                    {
                        // 注冊成功，可以執行其他操作，例如重定向到登錄頁面
                        Response.Redirect("RegistrationSuccess.aspx");
                    }
                    else
                    {
                        // 注冊失敗，顯示錯誤消息
                        lblMessage.Text = "Registration failed. Please try again.";
                        lblMessage.Visible = true;
                    }
                }
            }
        }
    }
}
