<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="最終版.Welcome" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Store</title>
<%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/bootstrap4.5.2.min.css" rel="stylesheet" />
    <style>
        .sidebar {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .category-link {
            display: block;
            margin-bottom: 10px;
            text-decoration: none;
            color: #343a40;
        }
        .cart-modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            display: none;
        }
        .cart-modal.show {
            display: block;
        }
    </style>
</head>
<body onload="showAllCategories()">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="index.aspx">熱食部購物系統</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="Welcome.aspx">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="GeneralReport.aspx">一般報表</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="StatisticsReport.aspx">統計報表</a>
                    </li>
                </ul>
                <span class="navbar-text">
                    Hi, <asp:Label ID="lblUserIdNavbar" runat="server" Text=""></asp:Label>!
                </span>
                <button type="button" class="btn btn-light ml-3" onclick="openCartModal()">購物車 <span id="lblCartCount" class="badge badge-pill badge-primary">0</span></button>
                <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger ml-3" Text="登出" OnClick="btnLogout_Click" />
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="sidebar">
                        <h5>分類</h5>
                        <a href="#" class="category-link" onclick="showAllCategories()">全部商品</a>
                        <a href="#" class="category-link" onclick="showCategory('主食')">主食</a>
                        <a href="#" class="category-link" onclick="showCategory('點心')">點心</a>
                        <a href="#" class="category-link" onclick="showCategory('飲料')">飲料</a>
                    </div>
                    <div class="sidebar mt-4">
                        <h5>購物清單</h5>
                        <ul id="cartItems"></ul>
                        <div>
                            <button class="btn btn-danger mt-2" type="button" onclick="clearCart()">清空</button>
                            <button class="btn btn-success mt-2" type="button" onclick="checkout()">送出</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row" id="productList">
                        <!-- 商品列表將在這裡顯示 -->
                    </div>
                </div>
            </div>
        </div>
    </form>

<%--    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
    <script src="js/jquery-3.5.1.slim.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js"></script>--%>
    <script src="js/popper2.6.0.min.js"></script>
<%--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>--%>
    <script src="js/bootstrap4.5.2.min.js"></script>
    <script>
        // 初始化購物車
        var cartItems = [];

        // 顯示所有商品
        function showAllCategories() {
            // 使用Fetch API發送請求以獲取所有產品數據
            fetch('/GetProducts.ashx')
                .then(response => response.json()) // 解析回應為JSON格式
                .then(data => {
                    // 獲取DOM中的商品列表元素
                    var productList = document.getElementById('productList');
                    productList.innerHTML = ''; // 清空現有的商品列表

                    // 遍歷每個產品數據
                    data.forEach(product => {
                        // 創建一個包含產品信息的div元素
                        var productDiv = document.createElement('div');
                        productDiv.className = 'col-md-4 category-' + product.Category;

                        // 創建卡片容器
                        var card = document.createElement('div');
                        card.className = 'card mb-4';

                        // 創建產品圖片元素
                        var img = document.createElement('img');
                        img.className = 'card-img-top';
                        img.src = product.ImageUrl; // 設置圖片URL
                        img.alt = product.ProductName; // 確保圖片有替代文字
                        card.appendChild(img);

                        // 創建卡片內容容器
                        var cardBody = document.createElement('div');
                        cardBody.className = 'card-body';

                        // 創建產品名稱元素
                        var title = document.createElement('h5');
                        title.className = 'card-title';
                        title.textContent = product.ProductName; // 設置產品名稱
                        cardBody.appendChild(title);

                        // 創建產品價格元素
                        var price = document.createElement('p');
                        price.className = 'card-text';
                        price.textContent = '$' + product.Price; // 設置產品價格
                        cardBody.appendChild(price);

                        // 創建數量選擇輸入組
                        var inputGroup = document.createElement('div');
                        inputGroup.className = 'input-group mb-3';

                        var inputGroupPrepend = document.createElement('div');
                        inputGroupPrepend.className = 'input-group-prepend';

                        var decrementButton = document.createElement('button');
                        decrementButton.className = 'btn btn-outline-secondary';
                        decrementButton.type = 'button';
                        decrementButton.textContent = '-';
                        decrementButton.onclick = function () {
                            decrementProductQuantity(product.ProductID); // 調用減少數量函數
                        };
                        inputGroupPrepend.appendChild(decrementButton);
                        inputGroup.appendChild(inputGroupPrepend);

                        var quantityInput = document.createElement('input');
                        quantityInput.id = 'product' + product.ProductID;
                        quantityInput.type = 'number';
                        quantityInput.className = 'form-control';
                        quantityInput.value = 1; // 設置初始數量
                        quantityInput.min = 1; // 設置最小數量
                        inputGroup.appendChild(quantityInput);

                        var inputGroupAppend = document.createElement('div');
                        inputGroupAppend.className = 'input-group-append';

                        var incrementButton = document.createElement('button');
                        incrementButton.className = 'btn btn-outline-secondary';
                        incrementButton.type = 'button';
                        incrementButton.textContent = '+';
                        incrementButton.onclick = function () {
                            incrementProductQuantity(product.ProductID); // 調用增加數量函數
                        };
                        inputGroupAppend.appendChild(incrementButton);
                        inputGroup.appendChild(inputGroupAppend);

                        cardBody.appendChild(inputGroup);

                        // 創建新增按鈕
                        var addButton = document.createElement('a');
                        addButton.href = '#';
                        addButton.className = 'btn btn-primary';
                        addButton.textContent = '新增';
                        addButton.onclick = function () {
                            addToCart(product.ProductName, product.Price, parseInt(quantityInput.value), 'addButton' + product.ProductID); // 調用新增到購物車函數
                        };
                        cardBody.appendChild(addButton);

                        // 將卡片內容添加到卡片容器
                        card.appendChild(cardBody);
                        // 將卡片容器添加到產品div
                        productDiv.appendChild(card);
                        // 將產品div添加到產品列表
                        productList.appendChild(productDiv);
                    });
                });
        }

        // 顯示特定分類的商品
        function showCategory(category) {
            var allProducts = document.querySelectorAll('.col-md-4');
            // 隱藏所有商品
            allProducts.forEach(function (product) {
                product.style.display = 'none';
            });

            // 顯示特定分類的商品
            var categoryProducts = document.querySelectorAll('.category-' + category);
            categoryProducts.forEach(function (product) {
                product.style.display = 'block';
            });
        }

        // 減少商品數量
        function decrementProductQuantity(productId) {
            var input = document.getElementById('product' + productId);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1; // 將數量減1
            }
        }

        // 增加商品數量
        function incrementProductQuantity(productId) {
            var input = document.getElementById('product' + productId);
            input.value = parseInt(input.value) + 1; // 將數量加1
        }

        // 將商品加入購物車
        function addToCart(productName, productPrice, quantity, buttonId) {
            // 檢查購物車中是否已經存在相同的商品
            var existingItem = cartItems.find(item => item.name === productName);
            if (existingItem) {
                existingItem.quantity = quantity; // 更新數量
            } else {
                cartItems.push({ name: productName, price: productPrice, quantity: quantity }); // 添加新商品
            }
            updateCart(); // 更新購物車
            document.getElementById(buttonId).style.display = 'none'; // 隱藏新增按鈕
        }

        // 清空購物車
        function clearCart() {
            cartItems = []; // 清空購物車數組
            updateCart(); // 更新購物車顯示
        }

        // 結帳
        function checkout() {
            if (cartItems.length === 0) {
                alert("購物車為空，請先添加商品！"); // 提示購物車為空
                return;
            }

            // 將資料轉換為JSON格式
            var orderData = JSON.stringify(cartItems);

            // 使用AJAX將資料傳送到後端
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "SaveOrder.aspx", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        // 成功訊息
                        var response = JSON.parse(xhr.responseText);
                        if (response.status === "success") {
                            alert("訂單已成功提交！");
                            clearCart(); // 清空購物車
                        } else {
                            alert("訂單提交失敗，請重試！");
                        }
                    } else {
                        alert("訂單提交失敗，請重試！");
                    }
                }
            };
            xhr.send(orderData); // 發送訂單數據
        }

        // 更新購物車顯示
        function updateCart() {
            var cartList = document.getElementById("cartItems");
            cartList.innerHTML = ""; // 清空現有的購物車列表

            // 遍歷購物車中的每個商品並顯示
            cartItems.forEach(function (item) {
                var listItem = document.createElement("li");
                listItem.textContent = item.name + " - $" + item.price + " x " + item.quantity; // 顯示商品信息
                cartList.appendChild(listItem); // 添加到購物車列表
            });

            // 計算總數量並顯示
            var totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
            document.getElementById("lblCartCount").textContent = totalQuantity; // 更新購物車數量顯示
        }
    </script>
</body>
</html>
