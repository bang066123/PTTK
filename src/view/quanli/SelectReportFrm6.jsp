<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Manager6" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn loại báo cáo thống kê</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f0f2f5; }
        .header { background: #1a73e8; color: white; padding: 15px 30px; }
        .header h1 { margin: 0; font-size: 20px; }
        .nav { background: #fff; border-bottom: 2px solid #1a73e8; padding: 0 30px; }
        .nav a { display: inline-block; padding: 15px 20px; text-decoration: none;
                 color: #333; font-weight: bold; border-bottom: 3px solid transparent; }
        .nav a:hover, .nav a.active { color: #1a73e8; border-bottom-color: #1a73e8; }
        .content { padding: 30px; }
        .form-box { background: white; border-radius: 8px; padding: 32px;
                    box-shadow: 0 2px 6px rgba(0,0,0,0.08); max-width: 520px; }
        .form-box h2 { margin-top: 0; color: #333; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 6px; color: #555; }
        /* cboReportType, inStartDate, inEndDate */
        .form-group select, .form-group input[type=date] {
            width: 100%; padding: 10px 12px; border: 1px solid #ccc;
            border-radius: 4px; font-size: 14px; box-sizing: border-box; }
        .form-group select:focus, .form-group input:focus {
            border-color: #1a73e8; outline: none; }
        .btn-row { display: flex; gap: 10px; margin-top: 24px; }
        /* btnSubmit */
        #btnSubmit { padding: 10px 28px; background: #1a73e8; color: white;
                     border: none; border-radius: 4px; font-size: 15px; cursor: pointer; }
        #btnSubmit:hover { background: #1557b0; }
        .btnBack { padding: 10px 20px; background: #eee; border: none; border-radius: 4px;
                   cursor: pointer; font-size: 15px; text-decoration: none; color: #333; }
        .btnBack:hover { background: #ddd; }
        .error { background: #fff5f5; border: 1px solid #fed7d7; color: #c53030;
                 padding: 12px 16px; border-radius: 4px; margin-bottom: 16px; }
    </style>
</head>
<body>

<%
    // Kiểm tra session quản lí
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm6.jsp");
        return;
    }

    // Lấy thông báo lỗi nếu có (ví dụ: chọn ngày không hợp lệ)
    String errorMsg = (String) request.getAttribute("errorMsg");
%>

<div class="header">
    <h1>📊 Chọn loại báo cáo thống kê</h1>
</div>
<div class="nav">
    <a href="ManagerMainFrm6.jsp">Trang chủ</a>
    <a href="SelectReportFrm6.jsp" class="active">Xem báo cáo thống kê</a>
</div>

<div class="content">
    <div class="form-box">
        <h2>Chọn loại báo cáo và khoảng thời gian</h2>

        <% if (errorMsg != null) { %>
            <div class="error">⚠️ <%= errorMsg %></div>
        <% } %>

        <!-- Bước 4-5: NV quản lí chọn và submit → gọi SupplierStatFrm6.jsp -->
        <form method="post" action="SupplierStatFrm6.jsp">

            <!-- cboReportType: Chọn loại thống kê -->
            <div class="form-group">
                <label for="cboReportType">Loại thống kê:</label>
                <select id="cboReportType" name="cboReportType" required>
                    <option value="">-- Chọn loại thống kê --</option>
                    <option value="supplier_import" selected>
                        Thống kê nhà cung cấp theo số lượng hàng nhập
                    </option>
                    <option value="product_revenue" disabled>
                        Thống kê mặt hàng theo doanh thu
                    </option>
                    <option value="customer_revenue" disabled>
                        Thống kê khách hàng theo doanh thu
                    </option>
                </select>
            </div>

            <!-- inStartDate: Chọn ngày bắt đầu -->
            <div class="form-group">
                <label for="inStartDate">Ngày bắt đầu:</label>
                <input type="date" id="inStartDate" name="inStartDate"
                       value="<%= request.getParameter("inStartDate") != null
                                  ? request.getParameter("inStartDate") : "" %>" required />
            </div>

            <!-- inEndDate: Chọn ngày kết thúc -->
            <div class="form-group">
                <label for="inEndDate">Ngày kết thúc:</label>
                <input type="date" id="inEndDate" name="inEndDate"
                       value="<%= request.getParameter("inEndDate") != null
                                  ? request.getParameter("inEndDate") : "" %>" required />
            </div>

            <div class="btn-row">
                <!-- btnSubmit: Nút xem thống kê -->
                <button type="submit" id="btnSubmit">📊 Xem thống kê</button>
                <!-- btnBack -->
                <a class="btnBack" href="ManagerMainFrm6.jsp">← Quay lại</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>

