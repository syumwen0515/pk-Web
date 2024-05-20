using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Web.Script.Serialization;

namespace 最終版
{
    public class GetProducts : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            List<Product> products = new List<Product>();

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open();

                OleDbCommand command = new OleDbCommand("SELECT * FROM Products", connection);
                using (OleDbDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Product product = new Product
                        {
                            ProductID = (int)reader["ProductID"],
                            ProductName = reader["ProductName"].ToString(),
                            Category = reader["Category"].ToString(),
                            Price = (decimal)reader["Price"],
                            ImageUrl = reader["ImageUrl"].ToString()
                        };
                        products.Add(product);
                    }
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(products));
        }

        public bool IsReusable
        {
            get { return false; }
        }

        public class Product
        {
            public int ProductID { get; set; }
            public string ProductName { get; set; }
            public string Category { get; set; }
            public decimal Price { get; set; }
            public string ImageUrl { get; set; }
        }
    }
}
