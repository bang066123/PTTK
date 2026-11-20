<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="dao.ProductDAO, model.Product6" %>
<%
    String keyword = request.getParameter("txtKeyword");
    List<Product6> listProduct = new ArrayList<>();
    boolean searched = false;

    if (keyword != null) {
        searched = true;
        ProductDAO productDAO = new ProductDAO();
        listProduct = productDAO.searchProduct(keyword.trim());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm mặt hàng</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; padding: 30px 20px; display: flex; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 850px; padding: 25px 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 20px; color: #111; text-align: center; margin-bottom: 20px; font-weight: bold; }
        .search-row { display: flex; align-items: center; justify-content: center; gap: 12px; margin-bottom: 25px; }
        .search-row label { font-size: 14px; font-weight: bold; color: #333; }
        #txtKeyword { width: 360px; padding: 7px 12px; border: 1px solid #777; border-radius: 3px; font-size: 14px; }
        #btnSearch { padding: 7px 22px; background: #90caf9; color: #000; font-size: 14px; font-weight: bold; border: 1px solid #1976d2; border-radius: 3px; cursor: pointer; }
        #btnSearch:hover { background: #64b5f6; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 22px; }
        th, td { border: 1px solid #555; padding: 8px 10px; font-size: 13px; text-align: center; }
        th { background: #f5f5f5; font-weight: bold; }
        .text-left { text-align: left; }
        .amount { text-align: right; }
        .btn-detail { padding: 4px 14px; background: #90caf9; color: #000; font-size: 12px; font-weight: bold; border: 1px solid #1976d2; border-radius: 3px; cursor: pointer; }
        .btn-detail:hover { background: #64b5f6; }
        #btnBack { padding: 8px 24px; background: #90caf9; color: #000; font-size: 13px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; }
        #btnBack:hover { background: #64b5f6; }
        .no-data { text-align: center; color: #777; padding: 20px; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Tìm kiếm mặt hàng</h2>

        <form method="get" action="SearchProductFrm.jsp">
            <div class="search-row">
                <label for="txtKeyword">Từ khóa:</label>
                <input type="text" id="txtKeyword" name="txtKeyword" value="<%= (keyword != null) ? keyword : "Tivi" %>" required />
                <button type="submit" id="btnSearch">Tìm kiếm</button>
            </div>
        </form>

        <% if (searched) { %>
            <% if (listProduct.isEmpty()) { %>
                <div class="no-data">Không tìm thấy mặt hàng nào phù hợp.</div>
            <% } else { %>
                <table id="tblProductList">
                    <thead>
                        <tr>
                            <th style="width: 45px;">TT</th>
                            <th style="width: 80px;">Mã MH</th>
                            <th>Tên mặt hàng</th>
                            <th>Đơn giá (VNĐ)</th>
                            <th style="width: 75px;">SL tồn</th>
                            <th style="width: 90px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int stt = 1; for (Product6 p : listProduct) { %>
                        <tr>
                            <td><%= stt++ %></td>
                            <td>MH<%= String.format("%02d", p.getId()) %></td>
                            <td class="text-left"><strong><%= p.getName() %></strong></td>
                            <td class="amount"><%= String.format("%,.0f", (double) p.getPrice()).replace(',', '.') %></td>
                            <td><%= p.getStockQuantity() %></td>
                            <td>
                                <form action="ProductDetailFrm.jsp" method="get" style="margin:0;">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <input type="hidden" name="keyword" value="<%= keyword %>">
                                    <button type="submit" class="btn-detail btnViewDetail">Chi tiết</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        <% } %>

        <div>
            <form action="CustomerMainFrm.jsp" method="get">
                <button type="submit" id="btnBack">Quay lại</button>
            </form>
        </div>
    </div>
</body>
</html>
