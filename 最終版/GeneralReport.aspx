<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneralReport.aspx.cs" Inherits="最終版.GeneralReport" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一般報表</title>
    <link href="css/4.0.0.bootstrap.min.css" rel="stylesheet" />
    <style>
        .grid-view th {
            background-color: #343a40;
            color: white;
        }
        .grid-view tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">一般報表</h1>
        <form id="form1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" CssClass="table table-striped grid-view"></asp:GridView>
        </form>
    </div>

    <!-- 引入 Bootstrap JS（如果需要） -->
    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/popper1.min.js"></script>
    <script src="js/4.0.0.bootstrap.min.js"></script>
</body>
</html>
