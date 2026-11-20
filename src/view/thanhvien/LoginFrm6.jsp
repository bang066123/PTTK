<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager6, model.Account6" %>
<%
    // Xử lý đăng xuất
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session.invalidate();
        response.sendRedirect("LoginFrm6.jsp");
        return;
    }

    // Nếu đã đăng nhập, chuyển hướng về trang chủ tương ứng
    Object existingUser = session.getAttribute("manager");
    if (existingUser != null) {
        response.sendRedirect("../quanli/ManagerMainFrm6.jsp");
        return;
    }
    Object existingCustomer = session.getAttribute("customer");
    if (existingCustomer != null) {
        response.sendRedirect("../khachhang/CustomerMainFrm6.jsp");
        return;
    }

    // Xử lý đăng nhập POST
    String loginError = null;
    if ("POST".equals(request.getMethod())) {
        String txtUsername = request.getParameter("txtUsername");
        String txtPassword = request.getParameter("txtPassword");

        // --- Mock authentication ---
        // Tài khoản quản lí: admin / admin123
        // Tài khoản khách hàng: khachhang / kh123
        if ("admin".equals(txtUsername) && "admin123".equals(txtPassword)) {
            Manager6 mgr = new Manager6();
            mgr.setUsername(txtUsername);
            mgr.setFullName("Nguyễn Văn Quản Lí");
            mgr.setId(1);
            session.setAttribute("manager", mgr);
            response.sendRedirect("../quanli/ManagerMainFrm6.jsp");
            return;
        } else if ("khachhang".equals(txtUsername) && "kh123".equals(txtPassword)) {
            // Tài khoản demo khách hàng (Account6 cơ bản)
            Account6 kh = new Account6();
            kh.setUsername(txtUsername);
            kh.setFullName("Khách hàng Demo");
            session.setAttribute("customer", kh);
            response.sendRedirect("../khachhang/CustomerMainFrm6.jsp");
            return;
        } else {
            loginError = "Tên đăng nhập hoặc mật khẩu không đúng!";
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập — QLST Điện máy</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body {
            background: linear-gradient(135deg, #1a73e8 0%, #34a853 100%);
            min-height: 100vh; display: flex; align-items: center; justify-content: center;
        }
        .login-box {
            background: white; border-radius: 12px; box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            padding: 40px 36px; width: 380px;
        }
        .logo { text-align: center; margin-bottom: 24px; }
        .logo h1 { color: #1a73e8; font-size: 22px; margin-bottom: 4px; }
        .logo p  { color: #888; font-size: 13px; }
        label { display: block; font-size: 14px; color: #444; margin-bottom: 5px; margin-top: 14px; }
        /* txtUsername, txtPassword */
        #txtUsername, #txtPassword {
            width: 100%; padding: 10px 12px; border: 1px solid #ddd;
            border-radius: 6px; font-size: 15px; outline: none;
            transition: border-color 0.2s;
        }
        #txtUsername:focus, #txtPassword:focus { border-color: #1a73e8; }
        /* btnLogin */
        #btnLogin {
            width: 100%; margin-top: 22px; padding: 12px;
            background: #1a73e8; color: white; border: none;
            border-radius: 6px; font-size: 16px; cursor: pointer;
            transition: background 0.2s;
        }
        #btnLogin:hover { background: #1558b0; }
        .error-msg {
            background: #fce8e6; color: #d93025; border-radius: 5px;
            padding: 10px 14px; font-size: 14px; margin-top: 14px;
        }
        .demo-info {
            margin-top: 20px; padding: 10px 14px; background: #f8f9ff;
            border-radius: 6px; font-size: 12px; color: #666;
        }
        .demo-info strong { color: #1a73e8; }
    </style>
</head>
<body>

<div class="login-box">
    <div class="logo">
        <h1>🏪 QLST Điện máy</h1>
        <p>Hệ thống Quản lí Siêu thị Điện máy</p>
    </div>

    <%-- Form đăng nhập --%>
    <form action="LoginFrm6.jsp" method="post">
        <label for="txtUsername">Tên đăng nhập</label>
        <input type="text"     id="txtUsername" name="txtUsername"
               placeholder="Nhập tên đăng nhập" autocomplete="username" required>

        <label for="txtPassword">Mật khẩu</label>
        <input type="password" id="txtPassword" name="txtPassword"
               placeholder="Nhập mật khẩu" autocomplete="current-password" required>

        <%-- Hiển thị lỗi nếu có --%>
        <% if (loginError != null) { %>
            <div class="error-msg">⚠️ <%= loginError %></div>
        <% } %>

        <%-- btnLogin --%>
        <button type="submit" id="btnLogin">Đăng nhập</button>
    </form>

    <%-- Thông tin tài khoản demo --%>
    <div class="demo-info">
        <strong>Tài khoản demo:</strong><br>
        👔 Quản lí: <strong>admin</strong> / <strong>admin123</strong><br>
        🛒 Khách hàng: <strong>khachhang</strong> / <strong>kh123</strong>
    </div>
</div>

</body>
</html>

