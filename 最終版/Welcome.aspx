<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="最終版.Welcome" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Store</title>
    <!-- 引入 Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* 自訂樣式 */
        /* 在這裡添加您的自訂 CSS */

        /* 左側分類區塊 */
        .sidebar {
            background-color: #f8f9fa; /* 側邊欄背景色 */
            padding: 20px;
        }

        /* 分類連結樣式 */
        .category-link {
            display: block;
            margin-bottom: 10px;
            text-decoration: none;
            color: #343a40; /* 分類連結文字顏色 */
        }

        /* 購物車浮動視窗樣式 */
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
<body>
    <!-- 導覽列 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Online Store</a>
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
                    <a class="nav-link" href="#">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Contact</a>
                </li>
            </ul>
            <!-- 顯示使用者 ID -->
            <span class="navbar-text">
                Hi, <asp:Label ID="lblUserIdNavbar" runat="server" Text=""></asp:Label>!
            </span>
            <!-- 購物車按鈕 -->
            <button type="button" class="btn btn-light ml-3" onclick="openCartModal()">Cart <span id="lblCartCount" class="badge badge-pill badge-primary">0</span></button>
        </div>
    </nav>

    <!-- 主要內容 -->
<div class="container">
    <div class="row">
        <!-- 側邊欄 -->
        <div class="col-md-3">
            <div class="sidebar">
                <h5>Categories</h5>
                <a href="#" class="category-link">All Products</a>
                <a href="#" class="category-link">Main Dishes</a>
                <a href="#" class="category-link">Snacks</a>
                <a href="#" class="category-link">Drinks</a>
                <!-- 在這裡添加其他分類連結 -->
            </div>
            <!-- 購物車 -->
            <div class="sidebar mt-4">
                <h5>Shopping Cart</h5>
                <ul id="cartItems">
                    <!-- 在此顯示購物車項目 -->
                </ul>
                <div>
                    <button class="btn btn-danger mt-2" onclick="clearCart()">Clear Cart</button>
                    <button class="btn btn-success mt-2" onclick="checkout()">Checkout</button>
                </div>
            </div>
        </div>

        <!-- 主要內容區域 -->
        <div class="col-md-9">
            <!-- 範例商品模板 -->
            <div class="row">
                <div class="col-md-4">
                    <div class="card mb-4">
                        <img class="card-img-top" src="https://via.placeholder.com/150" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title">Product Name 1</h5>
                            <p class="card-text">$9.99</p>
                            <!-- 商品數量 -->
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-secondary" type="button" onclick="decrementProductQuantity('product1')">-</button>
                                </div>
                                <input id="product1" type="number" class="form-control" value="1" min="1">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" onclick="incrementProductQuantity('product1')">+</button>
                                </div>
                            </div>
                            <!-- Add to Cart 按鈕 -->
                            <a href="#" class="btn btn-primary" onclick="addToCart('Product Name 1', 9.99, parseInt(document.getElementById('product1').value), 'addButton1')">Add to Cart</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <img class="card-img-top" src="https://via.placeholder.com/150" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title">Product Name 2</h5>
                            <p class="card-text">$99.99</p>
                            <!-- 商品數量 -->
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <button class="btn btn-outline-secondary" type="button" onclick="decrementProductQuantity('product2')">-</button>
                                </div>
                                <input id="product2" type="number" class="form-control" value="1" min="1">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" onclick="incrementProductQuantity('product2')">+</button>
                                </div>
                            </div>
                            <!-- Add to Cart 按鈕 -->
                            <a href="#" class="btn btn-primary" onclick="addToCart('Product Name 2', 99.99, parseInt(document.getElementById('product2').value), 'addButton2')">Add to Cart</a>
                        </div>
                    </div>
                </div>
                <!-- 添加更多範例商品模板 -->
            </div>
        </div>
    </div>
</div>


    <!-- 引入 Bootstrap JS（如果需要） -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <!-- JavaScript for handling cart modal -->
    <script>
        // 商品數量
        var productQuantities = {
            product1: 0,
            product2: 0,
            product3: 0
        };

        // 增加商品數量
        function incrementQuantity(productId) {
            productQuantities[productId]++;
            document.getElementById(productId).value = productQuantities[productId];
        }

        // 減少商品數量
        function decrementQuantity(productId) {
            if (productQuantities[productId] > 0) {
                productQuantities[productId]--;
                document.getElementById(productId).value = productQuantities[productId];
            }
        }

        // 開啟購物車
        function openCartModal() {
            document.getElementById("cartModal").classList.add("show");
        }

        // 關閉購物車
        function closeCartModal() {
            document.getElementById("cartModal").classList.remove("show");
        }

        // 商品清單
        var cartItems = [];

        // 加入購物車
        function addToCart(productName, productPrice, quantity, buttonId) {
            // 檢查商品是否已存在於購物車中，若存在則增加數量，否則新增商品
            var existingItem = cartItems.find(item => item.name === productName);
            if (existingItem) {
                existingItem.quantity = quantity; // 增加商品數量
            } else {
                cartItems.push({ name: productName, price: productPrice, quantity: quantity }); // 新增商品
            }

            // 更新購物車視窗內容
            updateCart();

            // 隱藏添加到購物車按鈕
            document.getElementById(buttonId).style.display = 'none';
        }

        // 清空購物車
        function clearCart() {
            cartItems = []; // 清空購物車清單
            updateCart(); // 更新購物車視窗
        }

        // 結帳
        function checkout() {
            // 在這裡添加結帳的相關邏輯，例如導向結帳頁面或彈出結帳提示
            alert("Checkout function triggered. Implement your checkout logic here.");
        }

        // 更新購物車視窗
        function updateCart() {
            var cartList = document.getElementById("cartItems");
            cartList.innerHTML = ""; // 清空原本的內容

            // 將每個商品加入購物車清單中
            cartItems.forEach(function (item) {
                var listItem = document.createElement("li");
                listItem.textContent = item.name + " - $" + item.price + " x " + item.quantity;
                cartList.appendChild(listItem);
            });

            // 更新購物車商品數量
            var totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
            document.getElementById("lblCartCount").textContent = totalQuantity;
        }

        // 減少商品數量
        function decrementProductQuantity(productId) {
            var input = document.getElementById(productId);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }

        // 增加商品數量
        function incrementProductQuantity(productId) {
            var input = document.getElementById(productId);
            input.value = parseInt(input.value) + 1;
        }
    </script>
</body>
</html>