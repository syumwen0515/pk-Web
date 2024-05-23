using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Web;
using System.Web.UI;

namespace 最終版
{
    public partial class SaveOrder : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                string jsonString;
                using (var reader = new System.IO.StreamReader(Request.InputStream))
                {
                    jsonString = reader.ReadToEnd();
                }

                var orders = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Order>>(jsonString);

                // 從Cookie中讀取使用者名稱
                string userName = "Guest";

                // 檢查是否存在名為 "UserId" 的 cookie
                if (Request.Cookies["UserId"] != null)
                {
                    // 獲取名為 "UserId" 的 cookie 的值
                    userName = Request.Cookies["UserId"].Value;
                }

                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
                using (OleDbConnection connection = new OleDbConnection(connectionString))
                {
                    connection.Open();

                    // 查詢當前最大的訂單編號
                    string maxOrderNumberQuery = "SELECT MAX(OrderNumber) FROM Orders";
                    int maxOrderNumber = 0;
                    using (OleDbCommand maxOrderNumberCommand = new OleDbCommand(maxOrderNumberQuery, connection))
                    {
                        var result = maxOrderNumberCommand.ExecuteScalar();
                        if (result != DBNull.Value)
                        {
                            maxOrderNumber = Convert.ToInt32(result);
                        }
                    }

                    // 生成新的訂單編號
                    maxOrderNumber++;

                    foreach (var order in orders)
                    {
                        string query = "INSERT INTO Orders (OrderNumber, UserName, Product, Quantity, Price, TotalPrice, OrderTime) VALUES (@OrderNumber, @UserName, @Product, @Quantity, @Price, @TotalPrice, @OrderTime)";
                        using (OleDbCommand command = new OleDbCommand(query, connection))
                        {
                            command.Parameters.Add(new OleDbParameter("@OrderNumber", OleDbType.Integer)).Value = maxOrderNumber;
                            command.Parameters.Add(new OleDbParameter("@UserName", OleDbType.VarChar)).Value = userName;
                            command.Parameters.Add(new OleDbParameter("@Product", OleDbType.VarChar)).Value = order.name;
                            command.Parameters.Add(new OleDbParameter("@Quantity", OleDbType.Integer)).Value = order.quantity;
                            command.Parameters.Add(new OleDbParameter("@Price", OleDbType.Decimal)).Value = order.price;
                            command.Parameters.Add(new OleDbParameter("@TotalPrice", OleDbType.Decimal)).Value = order.price * order.quantity;
                            command.Parameters.Add(new OleDbParameter("@OrderTime", OleDbType.Date)).Value = DateTime.Now; // 記錄當前時間

                            command.ExecuteNonQuery();
                        }
                    }
                }

                // 返回成功響應
                Response.ContentType = "application/json";
                Response.Write("{\"status\":\"success\"}");
                Response.End();
            }
        }

        public class Order
        {
            public string name { get; set; }
            public decimal price { get; set; }
            public int quantity { get; set; }
        }
    }
}
