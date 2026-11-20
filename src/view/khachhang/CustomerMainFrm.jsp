<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Customer6, model.Account6" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ khách hàng</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; min-height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 440px; padding: 45px 35px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 22px; color: #111; margin-bottom: 30px; font-weight: bold; }
        #btnSearchProduct { display: inline-block; width: 100%; padding: 14px 20px; background: #90caf9; color: #000; font-size: 16px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; text-decoration: none; transition: background 0.2s; }
        #btnSearchProduct:hover { background: #64b5f6; }
        .user-info { margin-top: 25px; font-size: 14px; color: #555; }
        .logout-link { color: #d32f2f; text-decoration: none; margin-left: 8px; font-weight: bold; }
        .logout-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
<%
    String customerName = "Khách";
    Object customerObj = session.getAttribute("customer");
    if (customerObj instanceof Customer6) {
        customerName = ((Customer6) customerObj).getName();
    } else if (customerObj instanceof Account6) {
        customerName = ((Account6) customerObj).getName();
    }
%>
    <div class="window-box">
        <h2>Trang chủ khách hàng</h2>
        <form action="SearchProductFrm.jsp" method="get">
            <button type="submit" id="btnSearchProduct">Tìm kiếm mặt hàng</button>
        </form>
        <div class="user-info">
            Xin chào: <strong><%= customerName %></strong>
            <% if (session.getAttribute("customer") != null) { %>
                | <a href="../thanhvien/LoginFrm.jsp?action=logout" class="logout-link">Đăng xuất</a>
            <% } else { %>
                | <a href="../thanhvien/LoginFrm.jsp" style="color:#1976d2; text-decoration:none; margin-left:8px; font-weight:bold;">Đăng nhập</a>
            <% } %>
        </div>
    </div>
</body>
</html>
