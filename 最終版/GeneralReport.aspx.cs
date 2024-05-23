using System;
using System.Data;
using System.Data.OleDb;
using System.Web.UI;

namespace 最終版
{
    public partial class GeneralReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsernames();
                LoadOrderNumbers();
                LoadReport();
            }
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

        private void LoadUsernames()
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();
                OleDbCommand command = new OleDbCommand("SELECT DISTINCT UserName FROM Orders", connection);
                OleDbDataAdapter adapter = new OleDbDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                usernameFilter.DataSource = dt;
                usernameFilter.DataTextField = "UserName";
                usernameFilter.DataValueField = "UserName";
                usernameFilter.DataBind();

                // Add default "All" option
                usernameFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("全部", "All"));
            }
        }

        private void LoadOrderNumbers()
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();
                OleDbCommand command = new OleDbCommand("SELECT DISTINCT OrderNumber FROM Orders", connection);
                OleDbDataAdapter adapter = new OleDbDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                orderNumberFilter.DataSource = dt;
                orderNumberFilter.DataTextField = "OrderNumber";
                orderNumberFilter.DataValueField = "OrderNumber";
                orderNumberFilter.DataBind();

                // Add default "All" option
                orderNumberFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("全部", "All"));
            }
        }

        private void LoadReport()
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();
                OleDbCommand command = new OleDbCommand("SELECT * FROM Orders", connection);
                OleDbDataAdapter adapter = new OleDbDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void FilterReport(object sender, EventArgs e)
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT * FROM Orders WHERE 1=1";

                if (usernameFilter.SelectedValue != "All")
                {
                    query += " AND UserName = @UserName";
                }

                if (monthFilter.SelectedValue != "All")
                {
                    query += " AND FORMAT(OrderTime, 'm') = @Month";
                }

                if (orderNumberFilter.SelectedValue != "All")
                {
                    query += " AND OrderNumber = @OrderNumber";
                }

                OleDbCommand command = new OleDbCommand(query, connection);

                if (usernameFilter.SelectedValue != "All")
                {
                    command.Parameters.AddWithValue("@UserName", usernameFilter.SelectedValue);
                }

                if (monthFilter.SelectedValue != "All")
                {
                    command.Parameters.AddWithValue("@Month", monthFilter.SelectedValue);
                }

                if (orderNumberFilter.SelectedValue != "All")
                {
                    command.Parameters.AddWithValue("@OrderNumber", orderNumberFilter.SelectedValue);
                }

                OleDbDataAdapter adapter = new OleDbDataAdapter(command);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
    }
}
