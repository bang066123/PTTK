<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, model.Product6" %>
<%
    String idParam = request.getParameter("id");
    String keyword = request.getParameter("keyword");
    Product6 product = null;
    String errorMsg = null;

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            ProductDAO productDAO = new ProductDAO();
            product = productDAO.getProductDetail(id);
            if (product == null) {
                errorMsg = "Không tìm thấy mặt hàng.";
            }
        } catch (NumberFormatException e) {
            errorMsg = "Mã mặt hàng không hợp lệ.";
        }
    } else {
        errorMsg = "Vui lòng chọn mặt hàng.";
    }

    String backUrl = "SearchProductFrm.jsp";
    if (keyword != null && !keyword.trim().isEmpty()) {
        backUrl = "SearchProductFrm.jsp?txtKeyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết mặt hàng</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; padding: 40px 20px; display: flex; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 600px; padding: 30px 35px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 20px; color: #111; text-align: center; margin-bottom: 25px; font-weight: bold; }
        .info-row { display: flex; margin-bottom: 14px; font-size: 14px; line-height: 1.5; }
        .info-label { width: 130px; font-weight: bold; color: #333; flex-shrink: 0; }
        .info-val { color: #111; }
        #btnBack { padding: 8px 24px; background: #90caf9; color: #000; font-size: 13px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; }
        #btnBack:hover { background: #64b5f6; }
        .error { color: #d32f2f; margin-bottom: 15px; font-size: 14px; }
        .btn-container { margin-top: 25px; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Chi tiết mặt hàng</h2>

        <% if (errorMsg != null || product == null) { %>
            <div class="error"><%= errorMsg != null ? errorMsg : "Không có thông tin." %></div>
        <% } else { %>
            <div class="info-row">
                <div class="info-label">Mã mặt hàng:</div>
                <div class="info-val" id="outId">MH<%= String.format("%02d", product.getId()) %></div>
            </div>

            <div class="info-row">
                <div class="info-label">Tên mặt hàng:</div>
                <div class="info-val" id="outName"><strong><%= product.getName() %></strong></div>
            </div>

            <div class="info-row">
                <div class="info-label">Đơn giá:</div>
                <div class="info-val" id="outPrice"><%= String.format("%,.0f", (double) product.getPrice()).replace(',', '.') %> VNĐ</div>
            </div>

            <div class="info-row">
                <div class="info-label">SL tồn kho:</div>
                <div class="info-val" id="outStockQuantity"><%= product.getStockQuantity() %> chiếc</div>
            </div>

            <div class="info-row">
                <div class="info-label">Mô tả:</div>
                <div class="info-val" id="outDescription"><%= product.getDescription() %></div>
            </div>
        <% } %>

        <div class="btn-container">
            <a href="<%= backUrl %>" id="btnBack">Quay lại</a>
        </div>
    </div>
</body>
</html>
