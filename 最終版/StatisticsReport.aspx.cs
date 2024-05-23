using System;
using System.Data;
using System.Data.OleDb;
using System.Web.UI;

namespace 最終版
{
    public partial class StatisticsReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
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

        private void LoadStatistics()
        {
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // 獲取總訂單數
                    OleDbCommand totalOrdersCommand = new OleDbCommand("SELECT MAX(OrderNumber) FROM Orders", connection);
                    int totalOrders = (int)totalOrdersCommand.ExecuteScalar();
                    lblTotalOrders.Text = totalOrders.ToString();

                    // 獲取總收入
                    OleDbCommand totalRevenueCommand = new OleDbCommand("SELECT SUM(TotalPrice) FROM Orders", connection);
                    var totalRevenueResult = totalRevenueCommand.ExecuteScalar();
                    decimal totalRevenue = totalRevenueResult != DBNull.Value ? Convert.ToDecimal(totalRevenueResult) : 0;
                    lblTotalRevenue.Text = totalRevenue.ToString("C");

                    // 獲取最暢銷商品
                    OleDbCommand topProductCommand = new OleDbCommand("SELECT TOP 1 Product, SUM(Quantity) AS TotalQuantity FROM Orders GROUP BY Product ORDER BY TotalQuantity DESC", connection);
                    using (OleDbDataReader reader = topProductCommand.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string topProduct = reader["Product"].ToString();
                            lblTopProduct.Text = topProduct;
                        }
                    }
                }
                catch (Exception ex)
                {
                    // 錯誤處理
                    lblError.InnerText = "Error: " + ex.Message;
                }
            }
        }
    }
}
