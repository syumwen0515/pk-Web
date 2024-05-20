<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="最終版.Welcome" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Store</title>
    <link href="css/4.0.0.bootstrap.min.css" rel="stylesheet" />
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
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="index.aspx">熱食部購物系統</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
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
                        <button class="btn btn-danger mt-2" onclick="clearCart()">清空</button>
                        <button class="btn btn-success mt-2" onclick="checkout()">送出</button>
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

    <script src="js/jquery-3.2.1.slim.min.js"></script>
    <script src="js/popper1.min.js"></script>
    <script src="js/4.0.0.bootstrap.min.js"></script>
    <script>
        // 初始化購物車
        var cartItems = [];

        // 顯示所有商品
        function showAllCategories() {
            fetch('/GetProducts.ashx')
                .then(response => response.json())
                .then(data => {
                    var productList = document.getElementById('productList');
                    productList.innerHTML = ''; // 清空現有的商品列表
                    data.forEach(product => {
                        var productDiv = document.createElement('div');
                        productDiv.className = 'col-md-4 category-' + product.Category;

                        var card = document.createElement('div');
                        card.className = 'card mb-4';

                        var img = document.createElement('img');
                        img.className = 'card-img-top';
                        img.src = product.ImageUrl;
                        img.alt = product.ProductName;  // 確保圖片有替代文字
                        card.appendChild(img);

                        var cardBody = document.createElement('div');
                        cardBody.className = 'card-body';

                        var title = document.createElement('h5');
                        title.className = 'card-title';
                        title.textContent = product.ProductName;
                        cardBody.appendChild(title);

                        var price = document.createElement('p');
                        price.className = 'card-text';
                        price.textContent = '$' + product.Price;
                        cardBody.appendChild(price);

                        var inputGroup = document.createElement('div');
                        inputGroup.className = 'input-group mb-3';

                        var inputGroupPrepend = document.createElement('div');
                        inputGroupPrepend.className = 'input-group-prepend';

                        var decrementButton = document.createElement('button');
                        decrementButton.className = 'btn btn-outline-secondary';
                        decrementButton.type = 'button';
                        decrementButton.textContent = '-';
                        decrementButton.onclick = function () {
                            decrementProductQuantity(product.ProductID);
                        };
                        inputGroupPrepend.appendChild(decrementButton);
                        inputGroup.appendChild(inputGroupPrepend);

                        var quantityInput = document.createElement('input');
                        quantityInput.id = 'product' + product.ProductID;
                        quantityInput.type = 'number';
                        quantityInput.className = 'form-control';
                        quantityInput.value = 1;
                        quantityInput.min = 1;
                        inputGroup.appendChild(quantityInput);

                        var inputGroupAppend = document.createElement('div');
                        inputGroupAppend.className = 'input-group-append';

                        var incrementButton = document.createElement('button');
                        incrementButton.className = 'btn btn-outline-secondary';
                        incrementButton.type = 'button';
                        incrementButton.textContent = '+';
                        incrementButton.onclick = function () {
                            incrementProductQuantity(product.ProductID);
                        };
                        inputGroupAppend.appendChild(incrementButton);
                        inputGroup.appendChild(inputGroupAppend);

                        cardBody.appendChild(inputGroup);

                        var addButton = document.createElement('a');
                        addButton.href = '#';
                        addButton.className = 'btn btn-primary';
                        addButton.textContent = '新增';
                        addButton.onclick = function () {
                            addToCart(product.ProductName, product.Price, parseInt(quantityInput.value), 'addButton' + product.ProductID);
                        };
                        cardBody.appendChild(addButton);

                        card.appendChild(cardBody);
                        productDiv.appendChild(card);
                        productList.appendChild(productDiv);
                    });
                });
        }

        // 顯示特定分類的商品
        function showCategory(category) {
            var allProducts = document.querySelectorAll('.col-md-4');
            allProducts.forEach(function (product) {
                product.style.display = 'none';
            });

            var categoryProducts = document.querySelectorAll('.category-' + category);
            categoryProducts.forEach(function (product) {
                product.style.display = 'block';
            });
        }

        function decrementProductQuantity(productId) {
            var input = document.getElementById('product' + productId);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }

        function incrementProductQuantity(productId) {
            var input = document.getElementById('product' + productId);
            input.value = parseInt(input.value) + 1;
        }

        function addToCart(productName, productPrice, quantity, buttonId) {
            var existingItem = cartItems.find(item => item.name === productName);
            if (existingItem) {
                existingItem.quantity = quantity;
            } else {
                cartItems.push({ name: productName, price: productPrice, quantity: quantity });
            }
            updateCart();
            document.getElementById(buttonId).style.display = 'none';
        }

        function clearCart() {
            cartItems = [];
            updateCart();
        }

        // 結帳
        function checkout() {
            if (cartItems.length === 0) {
                alert("購物車為空，請先添加商品！");
                return;
            }

            // 將資料轉換為JSON
            var orderData = JSON.stringify(cartItems);

            // 使用AJAX將資料傳送到後端
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "SaveOrder.aspx", true);
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // 成功訊息
                    alert("訂單已成功提交！");
                    clearCart(); // 清空購物車
                }
            };
            xhr.send(orderData);
        }

        function updateCart() {
            var cartList = document.getElementById("cartItems");
            cartList.innerHTML = "";
            cartItems.forEach(function (item) {
                var listItem = document.createElement("li");
                listItem.textContent = item.name + " - $" + item.price + " x " + item.quantity;
                cartList.appendChild(listItem);
            });
            var totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
            document.getElementById("lblCartCount").textContent = totalQuantity;
        }
    </script>
</body>
</html>
