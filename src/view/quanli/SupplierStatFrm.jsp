<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.SupplierStat6" %>
<%@ page import="dao.SupplierStatDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm.jsp");
        return;
    }

    String inStartDate = request.getParameter("inStartDate");
    String inEndDate   = request.getParameter("inEndDate");
    String cboReportType = request.getParameter("cboReportType");

    List<SupplierStat6> listSupplierStat = null;
    String errorMsg = null;
    int totalQuantity = 0;
    int totalImportCount = 0;

    if (inStartDate != null && inEndDate != null) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(inStartDate);
            Date endDate   = sdf.parse(inEndDate);

            SupplierStatDAO dao = new SupplierStatDAO();
            listSupplierStat = dao.getSupplierStat(startDate, endDate);

            if (listSupplierStat != null) {
                for (SupplierStat6 s : listSupplierStat) {
                    totalQuantity += s.getTotalImportQuantity();
                    totalImportCount += s.getImportCount();
                }
            }
        } catch (Exception e) {
            errorMsg = "Lỗi xử lí: " + e.getMessage();
        }
    }

    SimpleDateFormat displayFmt = new SimpleDateFormat("dd/MM/yyyy");
    String displayStart = "01/01/2026";
    String displayEnd   = "31/12/2026";
    try {
        if (inStartDate != null) displayStart = displayFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inStartDate));
        if (inEndDate   != null) displayEnd   = displayFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inEndDate));
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê nhà cung cấp theo số lượng hàng nhập</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; padding: 30px 20px; display: flex; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 850px; padding: 25px 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 19px; color: #111; text-align: center; margin-bottom: 12px; font-weight: bold; }
        #outTimeRange { text-align: center; font-size: 14px; color: #444; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 18px; }
        th, td { border: 1px solid #555; padding: 8px 10px; font-size: 13px; text-align: center; }
        th { background: #f5f5f5; font-weight: bold; }
        .text-left { text-align: left; }
        .btn-detail { padding: 4px 14px; background: #90caf9; color: #000; font-size: 12px; font-weight: bold; border: 1px solid #1976d2; border-radius: 3px; cursor: pointer; }
        .btn-detail:hover { background: #64b5f6; }
        .summary-row { font-size: 14px; font-weight: bold; color: #111; margin-bottom: 20px; text-align: center; }
        #btnBack { padding: 8px 24px; background: #90caf9; color: #000; font-size: 13px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; }
        #btnBack:hover { background: #64b5f6; }
        .error { color: #d32f2f; margin-bottom: 15px; font-size: 13px; text-align: center; }
        .no-data { text-align: center; color: #777; padding: 20px; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Thống kê nhà cung cấp theo số lượng hàng nhập</h2>
        <div id="outTimeRange">Từ ngày: <%= displayStart %> - Đến ngày: <%= displayEnd %></div>

        <% if (errorMsg != null) { %>
            <div class="error"><%= errorMsg %></div>
        <% } %>

        <% if (listSupplierStat == null || listSupplierStat.isEmpty()) { %>
            <div class="no-data">Không có dữ liệu thống kê.</div>
        <% } else { %>
            <table id="tblSupplierStatList">
                <thead>
                    <tr>
                        <th style="width: 45px;">TT</th>
                        <th>Tên nhà cung cấp</th>
                        <th>Địa chỉ</th>
                        <th>Số ĐT</th>
                        <th>Tổng SL nhập</th>
                        <th>Số lần</th>
                        <th style="width: 90px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% int stt = 1; for (SupplierStat6 sup : listSupplierStat) { %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td class="text-left"><strong><%= sup.getSupplierName() %></strong></td>
                        <td class="text-left"><%= sup.getAddress() != null ? (sup.getAddress().getCity() != null && !sup.getAddress().getCity().isEmpty() ? sup.getAddress().getCity() : sup.getAddress().getFullAddress()) : "Hà Nội" %></td>
                        <td><%= sup.getPhone() %></td>
                        <td><%= String.format("%,d", sup.getTotalImportQuantity()).replace(',', '.') %></td>
                        <td><%= sup.getImportCount() %></td>
                        <td>
                            <form action="SupplierImportHistoryFrm.jsp" method="post" style="margin:0;">
                                <input type="hidden" name="idSupplier"   value="<%= sup.getId() %>">
                                <input type="hidden" name="supplierName" value="<%= sup.getSupplierName() %>">
                                <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                                <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                                <button type="submit" class="btn-detail btnViewDetail">Chi tiết</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="summary-row">
                Tổng số lượng nhập: <%= String.format("%,d", totalQuantity).replace(',', '.') %> &nbsp;&nbsp;&nbsp;&nbsp; Tổng lần: <%= totalImportCount %>
            </div>
        <% } %>

        <div>
            <form action="SelectReportFrm.jsp" method="get">
                <button type="submit" id="btnBack">Quay lại</button>
            </form>
        </div>
    </div>
</body>
</html>
