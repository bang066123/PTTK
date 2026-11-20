<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.Supplier6, model.ImportReceipt6" %>
<%@ page import="dao.ImportReceiptDAO" %>
<%
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm.jsp");
        return;
    }

    String idSupplierStr  = request.getParameter("idSupplier");
    String supplierName   = request.getParameter("supplierName");
    String inStartDate    = request.getParameter("startDate");
    String inEndDate      = request.getParameter("endDate");

    List<ImportReceipt6> listReceipt = null;
    String errorMsg = null;

    if (idSupplierStr != null) {
        try {
            int idSupplier = Integer.parseInt(idSupplierStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = (inStartDate != null && !inStartDate.isEmpty()) ? sdf.parse(inStartDate) : sdf.parse("2026-01-01");
            Date endDate   = (inEndDate != null && !inEndDate.isEmpty()) ? sdf.parse(inEndDate) : sdf.parse("2026-12-31");

            ImportReceiptDAO dao = new ImportReceiptDAO();
            listReceipt = dao.getImportReceiptBySupplier(idSupplier, startDate, endDate);
        } catch (Exception e) {
            errorMsg = "Lỗi xử lí: " + e.getMessage();
        }
    }

    SimpleDateFormat displayFmt = new SimpleDateFormat("dd/MM/yyyy");
    String displayStart = "01/01/26";
    String displayEnd   = "31/12/26";
    try {
        SimpleDateFormat shortFmt = new SimpleDateFormat("dd/MM/yy");
        if (inStartDate != null) displayStart = shortFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inStartDate));
        if (inEndDate   != null) displayEnd   = shortFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inEndDate));
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê các lần nhập của NCC</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; padding: 30px 20px; display: flex; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 750px; padding: 25px 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 19px; color: #111; text-align: center; margin-bottom: 15px; font-weight: bold; }
        .info-header { display: flex; justify-content: space-between; margin-bottom: 18px; font-size: 14px; font-weight: bold; color: #333; padding: 0 10px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 22px; }
        th, td { border: 1px solid #555; padding: 8px 12px; font-size: 13px; text-align: center; }
        th { background: #f5f5f5; font-weight: bold; }
        .amount { text-align: right; }
        .btn-receipt { padding: 4px 14px; background: #90caf9; color: #000; font-size: 12px; font-weight: bold; border: 1px solid #1976d2; border-radius: 3px; cursor: pointer; }
        .btn-receipt:hover { background: #64b5f6; }
        #btnBack { padding: 8px 24px; background: #90caf9; color: #000; font-size: 13px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; }
        #btnBack:hover { background: #64b5f6; }
        .error { color: #d32f2f; margin-bottom: 15px; font-size: 13px; text-align: center; }
        .no-data { text-align: center; color: #777; padding: 20px; }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Thống kê các lần nhập của NCC</h2>
        <div class="info-header">
            <span id="outSupplierInfo">NCC: <%= supplierName != null ? supplierName : "Samsung Vina" %></span>
            <span id="outTimeRange">Kì: <%= displayStart %> - <%= displayEnd %></span>
        </div>

        <% if (errorMsg != null) { %>
            <div class="error"><%= errorMsg %></div>
        <% } %>

        <% if (listReceipt == null || listReceipt.isEmpty()) { %>
            <div class="no-data">Không có phiếu nhập nào.</div>
        <% } else { %>
            <table id="tblImportReceiptList">
                <thead>
                    <tr>
                        <th style="width: 45px;">TT</th>
                        <th>Mã phiếu</th>
                        <th>Ngày nhập</th>
                        <th>Tổng tiền (VNĐ)</th>
                        <th style="width: 90px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% int stt = 1; for (ImportReceipt6 receipt : listReceipt) { %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td><strong>PN<%= String.format("%02d", receipt.getId()) %></strong></td>
                        <td><%= receipt.getImportDate() != null ? displayFmt.format(receipt.getImportDate()) : "—" %></td>
                        <td class="amount"><%= String.format("%,.0f", (double) receipt.getTotalAmount()).replace(',', '.') %></td>
                        <td>
                            <form action="ImportReceiptDetailFrm.jsp" method="get" style="margin:0;">
                                <input type="hidden" name="idReceipt"    value="<%= receipt.getId() %>">
                                <input type="hidden" name="idSupplier"   value="<%= idSupplierStr %>">
                                <input type="hidden" name="supplierName" value="<%= supplierName %>">
                                <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                                <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                                <button type="submit" class="btn-receipt btnViewReceipt">Hóa đơn</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <div>
            <form action="SupplierStatFrm.jsp" method="post">
                <input type="hidden" name="inStartDate"  value="<%= inStartDate %>">
                <input type="hidden" name="inEndDate"    value="<%= inEndDate %>">
                <button type="submit" id="btnBack">Quay lại</button>
            </form>
        </div>
    </div>
</body>
</html>
