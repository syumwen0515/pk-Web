using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Web.Script.Serialization;

namespace 最終版
{
    public class GetStatisticsData : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            List<string> products = new List<string>();
            List<int> orderCounts = new List<int>();
            List<decimal> revenues = new List<decimal>();

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();

                // 獲取產品訂單數和收入
                OleDbCommand command = new OleDbCommand("SELECT Product, SUM(Quantity) AS TotalQuantity, SUM(TotalPrice) AS TotalRevenue FROM Orders GROUP BY Product", connection);
                using (OleDbDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        products.Add(reader["Product"].ToString());
                        orderCounts.Add(Convert.ToInt32(reader["TotalQuantity"]));
                        revenues.Add(Convert.ToDecimal(reader["TotalRevenue"]));
                    }
                }
            }

            var data = new
            {
                products = products,
                orderCounts = orderCounts,
                revenues = revenues
            };

            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(data));
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
