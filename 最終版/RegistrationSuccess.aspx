<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationSuccess.aspx.cs" Inherits="最終版.RegistrationSuccess" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>註冊成功！</title>
    <script>
        // 當頁面載入後開始倒數計時
        window.onload = function () {
            var seconds = 3; // 設置倒數秒數
            var countdown = setInterval(function () {
                document.getElementById('countdown').innerHTML = seconds;
                seconds--;
                if (seconds < 0) {
                    clearInterval(countdown);
                    // 跳轉至登入頁面
                    window.location.href = 'Login.aspx';
                }
            }, 1000);
        };
    </script>
    <style type="text/css">
        .auto-style1 {
            font-family: "jf金萱3.0 六分糖";
        }
        .auto-style2 {
            font-family: "jf金萱3.0 四分糖";
        }
    </style>
</head>
<body>
    <div>
        <h2 class="auto-style1">註冊成功！</h2>
        <p><span class="auto-style2">您將在 </span> <span id="countdown" class="auto-style2">3</span><span class="auto-style2"> 秒內重新導向至登入頁面。</span></p>
    </div>
</body>
</html>
