<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationSuccess.aspx.cs" Inherits="最終版.RegistrationSuccess" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Success</title>
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
</head>
<body>
    <div>
        <h2>Registration Successful!</h2>
        <p>You will be redirected to the login page in <span id="countdown">3</span> seconds.</p>
    </div>
</body>
</html>
