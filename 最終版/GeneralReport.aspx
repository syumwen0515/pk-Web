<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GeneralReport.aspx.cs" Inherits="最終版.GeneralReport" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一般報表</title>
<%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/bootstrap4.5.2.min.css" rel="stylesheet" />
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="Welcome.aspx">熱食部購物系統</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="Welcome.aspx">Home</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="GeneralReport.aspx">一般報表 <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="StatisticsReport.aspx">統計報表</a>
                </li>
            </ul>
            <span class="navbar-text">
                Hi, <asp:Label ID="lblUserIdNavbar" runat="server" Text=""></asp:Label>!
            </span>
        </div>
    </nav>
    <div class="container mt-5">
        <h1 class="mb-4">一般報表</h1>
        <form id="form1" runat="server">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label for="usernameFilter">選擇用戶名</label>
                    <asp:DropDownList ID="usernameFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterReport"></asp:DropDownList>
                </div>
                <div class="form-group col-md-4">
                    <label for="monthFilter">選擇月份</label>
                    <asp:DropDownList ID="monthFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterReport">
                        <asp:ListItem Value="All">全部</asp:ListItem>
                        <asp:ListItem Value="1">1月</asp:ListItem>
                        <asp:ListItem Value="2">2月</asp:ListItem>
                        <asp:ListItem Value="3">3月</asp:ListItem>
                        <asp:ListItem Value="4">4月</asp:ListItem>
                        <asp:ListItem Value="5">5月</asp:ListItem>
                        <asp:ListItem Value="6">6月</asp:ListItem>
                        <asp:ListItem Value="7">7月</asp:ListItem>
                        <asp:ListItem Value="8">8月</asp:ListItem>
                        <asp:ListItem Value="9">9月</asp:ListItem>
                        <asp:ListItem Value="10">10月</asp:ListItem>
                        <asp:ListItem Value="11">11月</asp:ListItem>
                        <asp:ListItem Value="12">12月</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group col-md-4">
                    <label for="orderNumberFilter">選擇訂單編號</label>
                    <asp:DropDownList ID="orderNumberFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterReport"></asp:DropDownList>
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered grid-view"></asp:GridView>
        </form>
    </div>

    <!-- 引入 Bootstrap JS（如果需要） -->
<%--    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
    <script src="js/jquery-3.5.1.slim.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>--%>
    <script src="js/popper2.6.0.min.js"></script>
<%--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
    <script src="js/bootstrap4.5.2.min.js"></script>
</body>
</html>
