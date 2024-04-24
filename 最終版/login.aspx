<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="最終版.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登入以使用訂餐系統</title>
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
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            width: 100%;
            font-size: 24px;
            color: #fff !important;
            font-family: 標楷體;
        }
        .auto-style1 {
            text-align: center;
            font-family: 標楷體;
            font-weight: normal;
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
