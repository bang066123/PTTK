<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, model.Product6" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết mặt hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f0f2f5; }
        .header { background: #34a853; color: white; padding: 15px 30px; }
        .header h1 { margin: 0; font-size: 20px; }
        .nav { background: #fff; border-bottom: 2px solid #34a853; padding: 0 30px; }
        .nav a { display: inline-block; padding: 15px 20px; text-decoration: none;
                 color: #333; font-weight: bold; border-bottom: 3px solid transparent; }
        .nav a:hover { color: #34a853; border-bottom-color: #34a853; }
        .content { padding: 30px; }
        .detail-box { background: white; border-radius: 8px; padding: 32px;
                      box-shadow: 0 2px 6px rgba(0,0,0,0.08); max-width: 600px; }
        .detail-box h2 { margin-top: 0; color: #333; border-bottom: 2px solid #34a853;
                         padding-bottom: 12px; }
        .field { display: flex; padding: 12px 0; border-bottom: 1px solid #f0f0f0; }
        .field:last-of-type { border-bottom: none; }
        .field .label { width: 180px; font-weight: bold; color: #666; flex-shrink: 0; }
        /* outId, outName, outPrice, outStockQuantity, outDescription */
        .field .value { flex: 1; color: #333; }
        .price { color: #e53e3e; font-size: 20px; font-weight: bold; }
        .stock-ok { color: #34a853; }
        .stock-low { color: #e53e3e; }
        /* btnBack */
        .btnBack { display: inline-block; margin-top: 20px; padding: 10px 24px;
                   background: #eee; border: none; border-radius: 4px;
                   cursor: pointer; font-size: 14px; text-decoration: none; color: #333; }
        .btnBack:hover { background: #ddd; }
        .error { background: #fff5f5; border: 1px solid #fed7d7; color: #c53030;
                 padding: 16px; border-radius: 6px; margin-bottom: 16px; }
        .badge { background: #34a853; color: white; padding: 2px 10px;
                 border-radius: 12px; font-size: 12px; vertical-align: middle; }
    </style>
</head>
<body>

<%
    // ==========================================
    // Bước 15-20: ProductDetailFrm6 gọi ProductDAO.getProductDetail(id)
    // ==========================================
    String idParam = request.getParameter("id");
    String keyword = request.getParameter("keyword"); // để nút Back quay lại đúng trang
    Product6 product = null;    // Thuộc tính ẩn: product : Product6
    String errorMsg = null;

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            // Bước 15-16: ProductDetailFrm6 gọi ProductDAO.getProductDetail(id)
            ProductDAO productDAO = new ProductDAO();
            // Bước 17-20: ProductDAO → Product6 đóng gói → trả về product
            product = productDAO.getProductDetail(id);
            if (product == null) {
                errorMsg = "Không tìm thấy thông tin mặt hàng có mã: " + id;
            }
        } catch (NumberFormatException e) {
            errorMsg = "Mã mặt hàng không hợp lệ.";
        }
    } else {
        errorMsg = "Vui lòng chọn mặt hàng từ danh sách tìm kiếm.";
    }

    String backUrl = "SearchProductFrm6.jsp";
    if (keyword != null && !keyword.trim().isEmpty()) {
        backUrl = "SearchProductFrm6.jsp?txtKeyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
    }
%>

<div class="header">
    <h1>📦 Thông tin chi tiết mặt hàng</h1>
</div>
<div class="nav">
    <a href="CustomerMainFrm6.jsp">Trang chủ</a>
    <a href="SearchProductFrm6.jsp">Tìm kiếm mặt hàng</a>
</div>

<div class="content">
    <% if (errorMsg != null) { %>
        <div class="error">⚠️ <%= errorMsg %></div>
        <a class="btnBack" href="<%= backUrl %>">← Quay lại danh sách tìm kiếm</a>
    <% } else { %>

    <!-- Bước 21: ProductDetailFrm6 hiển thị đầy đủ thông tin chi tiết mặt hàng -->
    <div class="detail-box">
        <h2>Chi tiết mặt hàng <span class="badge"><%= product.getId() %></span></h2>

        <!-- outId: Mã mặt hàng -->
        <div class="field">
            <div class="label">Mã mặt hàng:</div>
            <div class="value" id="outId"><%= product.getId() %></div>
        </div>

        <!-- outName: Tên mặt hàng -->
        <div class="field">
            <div class="label">Tên mặt hàng:</div>
            <div class="value" id="outName"><strong><%= product.getName() %></strong></div>
        </div>

        <!-- outPrice: Đơn giá -->
        <div class="field">
            <div class="label">Đơn giá:</div>
            <div class="value" id="outPrice">
                <span class="price"><%= String.format("%,.0f", (double) product.getPrice()) %> đ</span>
            </div>
        </div>

        <!-- outStockQuantity: Số lượng tồn kho -->
        <div class="field">
            <div class="label">Số lượng tồn kho:</div>
            <div class="value" id="outStockQuantity">
                <span class="<%= product.getStockQuantity() > 0 ? "stock-ok" : "stock-low" %>">
                    <%= product.getStockQuantity() %> sản phẩm
                    <%= product.getStockQuantity() > 0 ? "(Còn hàng)" : "(Hết hàng)" %>
                </span>
            </div>
        </div>

        <!-- outDescription: Mô tả chi tiết -->
        <div class="field">
            <div class="label">Mô tả:</div>
            <div class="value" id="outDescription">
                <%= (product.getDescription() != null && !product.getDescription().isEmpty())
                    ? product.getDescription() : "<em style='color:#aaa'>Không có mô tả</em>" %>
            </div>
        </div>

        <!-- btnBack: Quay lại danh sách tìm kiếm -->
        <a class="btnBack" href="<%= backUrl %>">← Quay lại danh sách tìm kiếm</a>
    </div>

    <% } %>
</div>

</body>
</html>

