<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager6" %>
<%
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm.jsp");
        return;
    }

    String errorMsg = (String) request.getAttribute("errorMsg");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn thống kê</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; min-height: 100vh; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 680px; padding: 35px 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 20px; color: #111; margin-bottom: 25px; text-align: center; font-weight: bold; }
        .form-row { display: flex; align-items: center; gap: 12px; margin-bottom: 25px; flex-wrap: wrap; }
        .form-row label { font-size: 14px; font-weight: bold; color: #333; white-space: nowrap; }
        .form-row select { flex: 2; min-width: 220px; padding: 8px 10px; border: 1px solid #777; border-radius: 3px; font-size: 13px; }
        .form-row input[type=date] { flex: 1; min-width: 130px; padding: 7px 10px; border: 1px solid #777; border-radius: 3px; font-size: 13px; }
        .btn-center { text-align: center; }
        #btnSubmit { padding: 8px 36px; background: #90caf9; color: #000; font-size: 14px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; }
        #btnSubmit:hover { background: #64b5f6; }
        .error { color: #d32f2f; margin-bottom: 15px; font-size: 14px; text-align: center; }
        .footer-nav { margin-top: 20px; text-align: center; font-size: 13px; }
        .footer-nav a { color: #555; text-decoration: none; }
        .footer-nav a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Chọn thống kê</h2>

        <% if (errorMsg != null) { %>
            <div class="error"><%= errorMsg %></div>
        <% } %>

        <form method="post" action="SupplierStatFrm.jsp">
            <div class="form-row">
                <label for="cboReportType">Loại TK:</label>
                <select id="cboReportType" name="cboReportType" required>
                    <option value="supplier_import" selected>Thống kê NCC theo SL hàng nhập</option>
                    <option value="product_revenue" disabled>Thống kê mặt hàng theo doanh thu</option>
                    <option value="customer_revenue" disabled>Thống kê khách hàng theo doanh thu</option>
                </select>

                <label for="inStartDate">Từ:</label>
                <input type="date" id="inStartDate" name="inStartDate" value="2026-01-01" required />

                <label for="inEndDate">Đến:</label>
                <input type="date" id="inEndDate" name="inEndDate" value="2026-12-31" required />
            </div>

            <div class="btn-center">
                <button type="submit" id="btnSubmit">Xem</button>
            </div>
        </form>

        <div class="footer-nav">
            <a href="ManagerMainFrm.jsp">Quay lại trang chủ</a>
        </div>
    </div>
</body>
</html>
