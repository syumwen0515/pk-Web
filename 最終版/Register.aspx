<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="最終版.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="css/4.0.0.bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #222; /* 將背景色更改為灰黑色 */
        }
        .login-container {
            margin-top: 100px; /* 上方留出一些空間 */
        }
        div.login-form > div.card {
            background-color: #f2f2f2 !important; /* 設置登入表單的背景色 */
            border-radius: 5px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }

        .login-form .card-body {
            padding: 40px;
        }
        .login-form .card-body .form-group {
            margin-bottom: 20px;
        }
        .login-form .card-footer {
            background-color: transparent;
            border-top: none;
            text-align: center;
        }
        /* 左側文字設置 */
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
        .auto-style1 {
            text-align: center;
            font-family: 標楷體;
            font-weight: normal;
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
                <!-- 右側放置註冊表單 -->
                <div class="col-md-6">
                    <div class="login-form">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="auto-style1">註冊</h2>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="txtUsername">Username:</label>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="txtPassword">Password:</label>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnRegister" runat="server" Text="註冊" OnClick="btnRegister_Click" CssClass="btn btn-primary btn-block" />
                                <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false" CssClass="text-success mt-2"></asp:Label>
                            </div>
                            <div class="card-footer">
                                <div class="text-center">
                                    <a href="login.aspx">登入</a>
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
