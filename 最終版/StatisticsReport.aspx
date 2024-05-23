<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatisticsReport.aspx.cs" Inherits="最終版.StatisticsReport" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>統計報表</title>
<%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/bootstrap4.5.2.min.css" rel="stylesheet" />
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
                <li class="nav-item">
                    <a class="nav-link" href="GeneralReport.aspx">一般報表</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="StatisticsReport.aspx">統計報表 <span class="sr-only">(current)</span></a>
                </li>
            </ul>
            <span class="navbar-text">
                Hi, <asp:Label ID="lblUserIdNavbar" runat="server" Text=""></asp:Label>!
            </span>
        </div>
    </nav>
    <div class="container mt-5">
        <h1 class="mb-4">統計報表</h1>
        <form id="form1" runat="server">
            <div class="alert alert-danger" runat="server" id="lblError" visible="false"></div>
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">總訂單數</h5>
                            <p class="card-text"><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">總收入</h5>
                            <p class="card-text"><asp:Label ID="lblTotalRevenue" runat="server" Text="$0.00"></asp:Label></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">最暢銷商品</h5>
                            <p class="card-text"><asp:Label ID="lblTopProduct" runat="server" Text="None"></asp:Label></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <h3>訂單分佈</h3>
                    <canvas id="ordersChart"></canvas>
                </div>
                <div class="col-md-6">
                    <h3>收入分佈</h3>
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </form>
    </div>

    <!-- 引入 Bootstrap JS（如果需要） -->
<%--    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
    <script src="js/jquery-3.5.1.slim.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>--%>
    <script src="js/popper2.6.0.min.js"></script>
<%--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
    <script src="js/bootstrap4.5.2.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>--%>
    <script src="js/chart.js"></script>
    <script>
        // 在頁面加載時獲取數據並繪製圖表
        document.addEventListener('DOMContentLoaded', function () {
            fetch('/GetStatisticsData.ashx')
                .then(response => response.json())
                .then(data => {
                    var ordersCtx = document.getElementById('ordersChart').getContext('2d');
                    var revenueCtx = document.getElementById('revenueChart').getContext('2d');

                    var ordersChart = new Chart(ordersCtx, {
                        type: 'pie',
                        data: {
                            labels: data.products,
                            datasets: [{
                                label: '訂單數',
                                data: data.orderCounts,
                                backgroundColor: [
                                    'rgba(255, 99, 132, 0.2)',
                                    'rgba(54, 162, 235, 0.2)',
                                    'rgba(255, 206, 86, 0.2)',
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(153, 102, 255, 0.2)',
                                    'rgba(255, 159, 64, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(255, 99, 132, 1)',
                                    'rgba(54, 162, 235, 1)',
                                    'rgba(255, 206, 86, 1)',
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(153, 102, 255, 1)',
                                    'rgba(255, 159, 64, 1)'
                                ],
                                borderWidth: 1
                            }]
                        }
                    });

                    var revenueChart = new Chart(revenueCtx, {
                        type: 'bar',
                        data: {
                            labels: data.products,
                            datasets: [{
                                label: '收入',
                                data: data.revenues,
                                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                });
        });
    </script>
</body>
</html>
