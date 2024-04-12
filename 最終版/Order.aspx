<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="最終版.Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Order</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Order Details</h1>
            <div>
                <asp:Label ID="lblUserId" runat="server" Text=""></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblCartItems" runat="server" Text=""></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblTotalPrice" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>