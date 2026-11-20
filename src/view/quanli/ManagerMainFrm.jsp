<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager6" %>
<%
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ quản lí</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; min-height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 440px; padding: 45px 35px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 22px; color: #111; margin-bottom: 30px; font-weight: bold; }
        #btnViewReport { display: inline-block; width: 100%; padding: 14px 20px; background: #90caf9; color: #000; font-size: 16px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; text-decoration: none; transition: background 0.2s; }
        #btnViewReport:hover { background: #64b5f6; }
        .user-info { margin-top: 25px; font-size: 14px; color: #555; }
        .logout-link { color: #d32f2f; text-decoration: none; margin-left: 8px; font-weight: bold; }
        .logout-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Trang chủ quản lí</h2>
        <form action="SelectReportFrm.jsp" method="get">
            <button type="submit" id="btnViewReport">Xem báo cáo thống kê</button>
        </form>
        <div class="user-info">
            Quản lí: <strong><%= manager.getName() %></strong> | 
            <a href="../thanhvien/LoginFrm.jsp?action=logout" class="logout-link">Đăng xuất</a>
        </div>
    </div>
</body>
</html>
