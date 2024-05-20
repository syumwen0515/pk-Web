<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="最終版.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登入以使用訂餐系統</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="css/4.0.0.bootstrap.min.css" rel="stylesheet" />
    <style>
        /* 設置全局樣式 */
        body {
            font-family: Arial, sans-serif; /* 使用 Arial 字體 */
            background-color: #222; /* 將背景色更改為灰黑色 */
        }
        /* 登入容器的樣式 */
        .login-container {
            margin-top: 100px; /* 上方留出一些空間 */
        }
        /* 登入表單的樣式 */
        div.login-form > div.card {
            background-color: #f2f2f2 !important; /* 設置登入表單的背景色 */
            border-radius: 5px; /* 圓角邊框 */
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1); /* 添加陰影效果 */
        }
        /* 登入表單內容的樣式 */
        .login-form .card-body {
            padding: 40px; /* 內容區塊的內邊距 */
        }
        /* 表單組件的樣式 */
        .login-form .card-body .form-group {
            margin-bottom: 20px; /* 表單組件之間的間距 */
        }
        /* 卡片頁腳的樣式 */
        .login-form .card-footer {
            background-color: transparent; /* 頁腳背景色透明 */
            border-top: none; /* 去除上邊框 */
            text-align: center; /* 文字置中對齊 */
        }
        /* 左側文字的樣式 */
        .left-text {
            position: absolute; /* 絕對定位 */
            top: 50%; /* 上方位置置中 */
            left: 0; /* 與左側對齊 */
            transform: translate(0, -50%); /* 使用 transform 屬性垂直置中 */
            text-align: center; /* 文字水平置中 */
            width: 100%; /* 寬度 100% */
            font-size: 24px; /* 文字大小 */
            color: #fff !important; /* 文字顏色 */
            font-family: 標楷體; /* 使用標楷體字型 */
        }
        /* 標題的樣式 */
        .auto-style1 {
            text-align: center; /* 文字置中對齊 */
            font-family: 標楷體; /* 使用標楷體字型 */
            font-weight: normal; /* 字重設置為正常 */
        }
        @media (max-width: 768px) {
            .left-text {
                position: relative; /* 相對定位 */
                transform: none; /* 清除 transform 屬性 */
                top: auto; /* 清除 top 屬性 */
                left: auto; /* 清除 left 屬性 */
                margin-top: 0; /* 清除上邊距 */
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row login-container">
                <!-- 左側放置文字 -->
                <div class="col-md-6 position-relative"> <!-- 添加 position-relative 類別 -->
                    <div class="left-text">
                        歡迎使用熱食部訂餐系統
                    </div>
                </div>
                <!-- 右側放置登入表單 -->
                <div class="col-md-6">
                    <div class="login-form">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="auto-style1">登入</h2>
                            </div>
                            <div class="card-body">
                                <!-- 登入表單內容 -->
                                <div class="form-group">
                                    <label for="txtUsername">Username:</label>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="txtPassword">Password:</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnLogin" runat="server" Text="登入" OnClick="btnLogin_Click" CssClass="btn btn-primary btn-block" />
                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false" CssClass="text-danger mt-2"></asp:Label>
                            </div>
                            <div class="card-footer">
                                <!-- 登入頁腳 -->
                                <div class="text-center">
                                    <a href="Register.aspx">註冊</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- 引入 Bootstrap JS（如果需要） -->
    <script src="js/4.0.0.bootstrap.min.js"></script>
</body>
</html>
