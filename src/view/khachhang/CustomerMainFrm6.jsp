<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager6" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - Khách hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f0f2f5; }
        .header { background: #34a853; color: white; padding: 15px 30px;
                  display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; font-size: 20px; }
        .nav { background: #fff; border-bottom: 2px solid #34a853; padding: 0 30px; }
        .nav a { display: inline-block; padding: 15px 20px; text-decoration: none;
                 color: #333; font-weight: bold; border-bottom: 3px solid transparent; }
        .nav a:hover, .nav a.active { color: #34a853; border-bottom-color: #34a853; }
        .content { padding: 40px 30px; }
        .card-grid { display: flex; gap: 20px; flex-wrap: wrap; }
        .card { background: white; border-radius: 8px; padding: 30px; width: 200px;
                text-align: center; box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                cursor: pointer; text-decoration: none; color: #333;
                transition: box-shadow 0.2s; }
        .card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.18); }
        .card .icon { font-size: 48px; margin-bottom: 10px; }
        .card h3 { margin: 0; font-size: 15px; color: #34a853; }
        .logout { background: none; border: 1px solid white; color: white;
                  padding: 7px 16px; border-radius: 4px; cursor: pointer; font-size: 14px; }
        .logout:hover { background: rgba(255,255,255,0.15); }
    </style>
</head>
<body>
<%
    // Khách hàng có thể dùng mà không cần đăng nhập (tìm kiếm mặt hàng)
    String customerName = "Khách";
    Object customer = session.getAttribute("customer");
    if (customer != null) {
        customerName = customer.toString();
    }
%>

<div class="header">
    <h1>🏪 Siêu thị Điện máy</h1>
    <div>
        <span>Xin chào, <strong><%= customerName %></strong></span>
        &nbsp;&nbsp;
        <% if (session.getAttribute("customer") != null) { %>
            <form style="display:inline" method="post" action="../thanhvien/LoginFrm6.jsp">
                <input type="hidden" name="action" value="logout">
                <button class="logout" type="submit">Đăng xuất</button>
            </form>
        <% } else { %>
            <a href="../thanhvien/LoginFrm6.jsp" style="color:white;">Đăng nhập</a>
        <% } %>
    </div>
</div>

<div class="nav">
    <a href="CustomerMainFrm6.jsp" class="active">Trang chủ</a>
    <a href="SearchProductFrm6.jsp">Tìm kiếm mặt hàng</a>
</div>

<div class="content">
    <h2>Chức năng khách hàng</h2>
    <div class="card-grid">
        <!-- btnSearchProduct: Tìm kiếm mặt hàng -->
        <a class="card" href="SearchProductFrm6.jsp">
            <div class="icon">🔍</div>
            <h3>Tìm kiếm mặt hàng</h3>
        </a>
    </div>
</div>

</body>
</html>

