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
                    OleDbCommand totalOrdersCommand = new OleDbCommand("SELECT COUNT(*) FROM Orders", connection);
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
