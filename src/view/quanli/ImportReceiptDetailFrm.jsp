<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.ImportReceipt6, model.ImportReceiptDetail6" %>
<%@ page import="dao.ImportReceiptDAO, dao.ImportReceiptDetailDAO" %>
<%
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm.jsp");
        return;
    }

    String idReceiptStr  = request.getParameter("idReceipt");
    String idSupplierStr = request.getParameter("idSupplier");
    String supplierName  = request.getParameter("supplierName");
    String inStartDate   = request.getParameter("startDate");
    String inEndDate     = request.getParameter("endDate");

    ImportReceipt6             receipt    = null;
    List<ImportReceiptDetail6> listDetail = null;
    String errorMsg  = null;
    double grandTotal = 0;

    if (idReceiptStr != null) {
        try {
            int idReceipt = Integer.parseInt(idReceiptStr);

            ImportReceiptDAO receiptDAO = new ImportReceiptDAO();
            receipt = receiptDAO.getReceiptById(idReceipt);

            ImportReceiptDetailDAO detailDAO = new ImportReceiptDetailDAO();
            listDetail = detailDAO.getDetailByReceipt(idReceipt);

            if (listDetail != null) {
                for (ImportReceiptDetail6 d : listDetail) {
                    grandTotal += (double) d.getUnitPrice() * d.getQuantity();
                }
            }
        } catch (Exception e) {
            errorMsg = "Lỗi xử lí: " + e.getMessage();
        }
    }

    SimpleDateFormat displayFmt = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn nhập hàng</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; padding: 30px 20px; display: flex; justify-content: center; }
        .window-box { background: white; border: 2px solid #333; border-radius: 6px; width: 780px; padding: 25px 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        h2 { font-size: 19px; color: #111; text-align: center; margin-bottom: 20px; font-weight: bold; }
        #outReceiptInfo { margin-bottom: 18px; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px 24px; font-size: 14px; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 18px; }
        th, td { border: 1px solid #555; padding: 8px 10px; font-size: 13px; text-align: center; }
        th { background: #f5f5f5; font-weight: bold; }
        .text-left { text-align: left; }
        .amount { text-align: right; }
        #outTotalAmount { font-size: 15px; font-weight: bold; text-align: center; margin-bottom: 25px; color: #111; }
        .btn-row { display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 8px 24px; background: #90caf9; color: #000; font-size: 13px; font-weight: bold; border: 1px solid #1976d2; border-radius: 4px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #64b5f6; }
        .error { color: #d32f2f; margin-bottom: 15px; font-size: 13px; text-align: center; }
        .no-data { text-align: center; color: #777; padding: 20px; }
        @media print {
            body { background: white; padding: 0; }
            .window-box { border: none; box-shadow: none; width: 100%; }
            .btn-row { display: none; }
        }
    </style>
</head>
<body>
    <div class="window-box">
        <h2>Hóa đơn nhập hàng</h2>

        <% if (errorMsg != null) { %>
            <div class="error"><%= errorMsg %></div>
        <% } %>

        <div id="outReceiptInfo">
            <div class="info-grid">
                <div>Mã phiếu: <strong>PN<%= (idReceiptStr != null) ? String.format("%02d", Integer.parseInt(idReceiptStr)) : "01" %></strong></div>
                <div>Ngày lập: <strong><%= (receipt != null && receipt.getImportDate() != null) ? displayFmt.format(receipt.getImportDate()) : "15/02/2026" %></strong></div>
                <div>Nhà cung cấp: <strong><%= (supplierName != null && !supplierName.isEmpty()) ? supplierName : "Công ty TNHH Samsung Vina" %></strong></div>
                <div>NV lập phiếu: <strong><%= (receipt != null && receipt.getWarehouseStaff() != null) ? receipt.getWarehouseStaff().getName() : "Nguyễn Văn Kho" %></strong></div>
            </div>
        </div>

        <% if (listDetail == null || listDetail.isEmpty()) { %>
            <div class="no-data">Không có dữ liệu chi tiết hóa đơn.</div>
        <% } else { %>
            <table id="tblReceiptDetailList">
                <thead>
                    <tr>
                        <th style="width: 45px;">TT</th>
                        <th>Mã MH</th>
                        <th>Tên mặt hàng</th>
                        <th>Số lượng</th>
                        <th>Đơn giá nhập (VNĐ)</th>
                        <th>Thành tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <% int stt = 1; for (ImportReceiptDetail6 d : listDetail) { %>
                    <tr>
                        <td><%= stt++ %></td>
                        <td>MH<%= String.format("%02d", d.getProduct().getId()) %></td>
                        <td class="text-left"><%= d.getProduct().getName() %></td>
                        <td><%= d.getQuantity() %></td>
                        <td class="amount"><%= String.format("%,.0f", (double) d.getUnitPrice()).replace(',', '.') %></td>
                        <td class="amount"><%= String.format("%,.0f", (double) d.getUnitPrice() * d.getQuantity()).replace(',', '.') %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div id="outTotalAmount">
                Tổng tiền thanh toán: <%= String.format("%,.0f", grandTotal).replace(',', '.') %> VNĐ
            </div>
        <% } %>

        <div class="btn-row">
            <form action="SupplierImportHistoryFrm.jsp" method="post" style="margin:0;">
                <input type="hidden" name="idSupplier"   value="<%= idSupplierStr %>">
                <input type="hidden" name="supplierName" value="<%= supplierName %>">
                <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                <button type="submit" id="btnBack" class="btn">Quay lại</button>
            </form>

            <button type="button" id="btnPrintInvoice" class="btn" onclick="window.print()">In hóa đơn</button>
        </div>
    </div>
</body>
</html>
