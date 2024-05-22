using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Web;
using System.Web.Script.Serialization;

namespace 最終版
{
    // 定義一個處理HTTP請求的類
    public class GetProducts : IHttpHandler
    {
        // 處理HTTP請求的方法
        public void ProcessRequest(HttpContext context)
        {
            // 設置回應的內容類型為JSON
            context.Response.ContentType = "application/json";

            // 定義資料庫連接字串
            string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\\網頁設計\\最終版\\最終版\\Database1.accdb;";
            // 創建一個用於存儲產品的列表
            List<Product> products = new List<Product>();

            // 使用OleDbConnection連接到資料庫
            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                connection.Open(); // 開啟資料庫連接

                // 創建OleDbCommand來執行SQL查詢
                OleDbCommand command = new OleDbCommand("SELECT * FROM Products", connection);
                // 使用OleDbDataReader讀取查詢結果
                using (OleDbDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read()) // 讀取每一行數據
                    {
                        // 創建一個新的Product對象並設置其屬性
                        Product product = new Product
                        {
                            ProductID = (int)reader["ProductID"],
                            ProductName = reader["ProductName"].ToString(),
                            Category = reader["Category"].ToString(),
                            Price = (decimal)reader["Price"],
                            ImageUrl = reader["ImageUrl"].ToString()
                        };
                        products.Add(product); // 將產品添加到列表中
                    }
                }
            }

            // 使用JavaScriptSerializer將產品列表序列化為JSON格式
            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(products)); // 將JSON回應寫入HTTP回應
        }

        // 指示此HTTP處理程序是否可重用
        public bool IsReusable
        {
            get { return false; } // 此處返回false，表示每次請求都創建一個新的處理程序實例
        }

        // 定義一個Product類來表示產品數據
        public class Product
        {
            public int ProductID { get; set; } // 產品ID
            public string ProductName { get; set; } // 產品名稱
            public string Category { get; set; } // 產品類別
            public decimal Price { get; set; } // 產品價格
            public string ImageUrl { get; set; } // 產品圖片URL
        }
    }
}
