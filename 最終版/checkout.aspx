<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="最終版.checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Checkout Details</h1>
            <div>
                <asp:Literal ID="checkoutDetailsLiteral" runat="server"></asp:Literal>
            </div>
            <asp:Label ID="lblUserIdNavbar" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
