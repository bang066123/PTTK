<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, model.Product6, java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm mặt hàng</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f0f2f5; }
        .header { background: #34a853; color: white; padding: 15px 30px; }
        .header h1 { margin: 0; font-size: 20px; }
        .nav { background: #fff; border-bottom: 2px solid #34a853; padding: 0 30px; }
        .nav a { display: inline-block; padding: 15px 20px; text-decoration: none;
                 color: #333; font-weight: bold; border-bottom: 3px solid transparent; }
        .nav a:hover, .nav a.active { color: #34a853; border-bottom-color: #34a853; }
        .content { padding: 30px; }
        .search-box { background: white; border-radius: 8px; padding: 24px;
                      box-shadow: 0 2px 6px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .search-box h2 { margin-top: 0; color: #333; }
        .search-row { display: flex; gap: 10px; align-items: center; }
        /* txtKeyword */
        #txtKeyword { flex: 1; padding: 10px 14px; border: 1px solid #ccc;
                      border-radius: 4px; font-size: 15px; }
        /* btnSearch */
        #btnSearch { padding: 10px 24px; background: #34a853; color: white;
                     border: none; border-radius: 4px; font-size: 15px; cursor: pointer; }
        #btnSearch:hover { background: #2d8e47; }
        .result-box { background: white; border-radius: 8px; padding: 24px;
                      box-shadow: 0 2px 6px rgba(0,0,0,0.08); }
        /* tblProductList */
        #tblProductList { width: 100%; border-collapse: collapse; }
        #tblProductList th { background: #34a853; color: white; padding: 10px 12px; text-align: left; }
        #tblProductList td { padding: 10px 12px; border-bottom: 1px solid #eee; }
        #tblProductList tr:hover td { background: #f5fbf6; }
        /* btnViewDetail */
        .btnViewDetail { padding: 5px 12px; background: #1a73e8; color: white;
                        border: none; border-radius: 3px; cursor: pointer; font-size: 13px; }
        .btnViewDetail:hover { background: #1557b0; }
        .no-result { color: #888; text-align: center; padding: 30px; }
        /* btnBack */
        .btnBack { display: inline-block; margin-top: 16px; padding: 8px 20px;
                   background: #eee; border: none; border-radius: 4px;
                   cursor: pointer; font-size: 14px; text-decoration: none; color: #333; }
        .btnBack:hover { background: #ddd; }
        .alert { padding: 12px 16px; border-radius: 4px; margin-bottom: 16px; }
        .alert-info { background: #e8f4fd; border: 1px solid #bee3f8; color: #2c7be5; }
        .price { color: #e53e3e; font-weight: bold; }
    </style>
</head>
<body>

<%
    // ==========================================
    // Bước 5: SearchProductFrm6 submit gọi lại chính nó để xử lí tìm kiếm
    // ==========================================
    String keyword = request.getParameter("txtKeyword");  // Thuộc tính ẩn txtKeyword
    List<Product6> listProduct = new ArrayList<>();        // Thuộc tính ẩn listProduct
    boolean searched = false;

    if (keyword != null && !keyword.trim().isEmpty()) {
        searched = true;
        // Bước 6: SearchProductFrm6 gọi ProductDAO yêu cầu tìm danh sách mặt hàng theo từ khóa
        ProductDAO productDAO = new ProductDAO();
        // Bước 7-11: ProductDAO gọi searchProduct(name) → Product6 đóng gói → trả về listProduct
        listProduct = productDAO.searchProduct(keyword.trim());
    }
%>

<div class="header">
    <h1>🔍 Tìm kiếm mặt hàng</h1>
</div>
<div class="nav">
    <a href="CustomerMainFrm6.jsp">Trang chủ</a>
    <a href="SearchProductFrm6.jsp" class="active">Tìm kiếm mặt hàng</a>
</div>

<div class="content">
    <div class="search-box">
        <h2>Tìm kiếm mặt hàng điện máy</h2>

        <!-- Bước 4-5: Form submit gọi lại SearchProductFrm6.jsp -->
        <form method="get" action="SearchProductFrm6.jsp">
            <div class="search-row">
                <!-- txtKeyword: Ô nhập từ khóa tìm kiếm -->
                <input type="text" id="txtKeyword" name="txtKeyword"
                       placeholder="Nhập tên mặt hàng cần tìm (vd: Tivi, Tủ lạnh...)"
                       value="<%= (keyword != null) ? keyword : "" %>" />
                <!-- btnSearch: Nút tìm kiếm -->
                <button type="submit" id="btnSearch">🔍 Tìm kiếm</button>
            </div>
        </form>
    </div>

    <!-- Bước 12: SearchProductFrm6 hiển thị bảng danh sách kết quả -->
    <% if (searched) { %>
    <div class="result-box">
        <% if (listProduct.isEmpty()) { %>
            <div class="no-result">
                ℹ️ Không tìm thấy mặt hàng nào có tên chứa "<strong><%= keyword %></strong>"
            </div>
        <% } else { %>
            <div class="alert alert-info">
                Tìm thấy <strong><%= listProduct.size() %></strong> mặt hàng
                có tên chứa "<strong><%= keyword %></strong>"
            </div>

            <!-- tblProductList: Bảng danh sách mặt hàng kết quả -->
            <table id="tblProductList">
                <thead>
                    <tr>
                        <th>TT</th>
                        <th>Mã MH</th>
                        <th>Tên mặt hàng</th>
                        <th>Đơn giá (VNĐ)</th>
                        <th>Số lượng tồn</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < listProduct.size(); i++) {
                        Product6 p = listProduct.get(i); %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= p.getId() %></td>
                        <td><%= p.getName() %></td>
                        <td class="price"><%= String.format("%,.0f", (double) p.getPrice()) %> đ</td>
                        <td><%= p.getStockQuantity() %></td>
                        <td>
                            <!-- btnViewDetail: Bước 13-14: click xem chi tiết -->
                            <form method="get" action="ProductDetailFrm6.jsp" style="display:inline">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <input type="hidden" name="keyword" value="<%= keyword %>">
                                <button class="btnViewDetail" type="submit">[ Chi tiết ]</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
    <% } %>

    <!-- btnBack: Quay lại trang chủ -->
    <a class="btnBack" href="CustomerMainFrm6.jsp">← Quay lại trang chủ</a>
</div>

</body>
</html>

