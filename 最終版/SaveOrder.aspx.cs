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
                //HttpCookie userCookie = Request.Cookies["UserName"];
                //if (userCookie != null)
                //{
                //    userName = userCookie.Value;
                //}

                // 检查是否存在名为 "UserId" 的 cookie
                if (Request.Cookies["UserId"] != null)
                {
                    // 获取名为 "UserId" 的 cookie 的值
                    userName = Request.Cookies["UserId"].Value;
                }

                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
                using (OleDbConnection connection = new OleDbConnection(connectionString))
                {
                    connection.Open();
                    foreach (var order in orders)
                    {
                        string query = "INSERT INTO Orders (UserName, Product, Quantity, Price, TotalPrice) VALUES (@UserName, @Product, @Quantity, @Price, @TotalPrice)";
                        using (OleDbCommand command = new OleDbCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@UserName", userName);
                            command.Parameters.AddWithValue("@Product", order.name);
                            command.Parameters.AddWithValue("@Quantity", order.quantity);
                            command.Parameters.AddWithValue("@Price", order.price);
                            command.Parameters.AddWithValue("@TotalPrice", order.price * order.quantity);

                            command.ExecuteNonQuery();
                        }
                    }
                }
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
