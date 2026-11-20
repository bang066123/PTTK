<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.ImportReceipt6, model.ImportReceiptDetail6" %>
<%@ page import="dao.ImportReceiptDAO, dao.ImportReceiptDetailDAO" %>
<%
    // Kiểm tra session manager
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm6.jsp");
        return;
    }

    // Bước 35 (Module 2): Lấy tham số từ SupplierImportHistoryFrm6 (GET)
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

            // Bước 36: Gọi lớp ImportReceiptDAO lấy thông tin phiếu nhập
            ImportReceiptDAO receiptDAO = new ImportReceiptDAO();
            receipt = receiptDAO.getReceiptById(idReceipt);

            // Bước 37: Gọi lớp ImportReceiptDetailDAO yêu cầu lấy chi tiết
            // Bước 38: Gọi hàm getDetailByReceipt()
            ImportReceiptDetailDAO detailDAO = new ImportReceiptDetailDAO();
            // Bước 39-41: Thực hiện, đóng gói và trả kết quả
            listDetail = detailDAO.getDetailByReceipt(idReceipt);

            if (listDetail != null) {
                for (ImportReceiptDetail6 d : listDetail) {
                    grandTotal += d.getImportPrice() * d.getImportQuantity();
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
    <title>Chi tiết phiếu nhập hàng</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; }
        .header {
            background: #1a73e8; color: white; padding: 14px 24px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .header h1 { font-size: 20px; }
        .header span { font-size: 14px; }
        .container { max-width: 980px; margin: 24px auto; padding: 0 16px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 28px; }
        .page-title { font-size: 20px; color: #1a73e8; font-weight: bold; margin-bottom: 18px; }
        /* outReceiptInfo */
        #outReceiptInfo {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 10px; background: #f8f9ff;
            border: 1px solid #c5cae9; border-radius: 6px;
            padding: 16px 20px; margin-bottom: 20px;
        }
        #outReceiptInfo .info-item { font-size: 14px; color: #444; }
        #outReceiptInfo .info-item span { font-weight: bold; color: #1a73e8; }
        .section-title { font-size: 15px; font-weight: bold; color: #333; margin-bottom: 10px; }
        .error { color: #d93025; background: #fce8e6; padding: 10px 16px; border-radius: 4px; margin-bottom: 14px; }
        /* tblReceiptDetailList */
        #tblReceiptDetailList { width: 100%; border-collapse: collapse; margin-bottom: 16px; }
        #tblReceiptDetailList th {
            background: #1a73e8; color: white; padding: 10px 12px;
            text-align: center; font-size: 14px;
        }
        #tblReceiptDetailList td {
            padding: 9px 12px; border-bottom: 1px solid #e0e0e0;
            font-size: 14px; text-align: center;
        }
        #tblReceiptDetailList td.text-left { text-align: left; }
        #tblReceiptDetailList td.amount   { text-align: right; }
        #tblReceiptDetailList tr:hover td { background: #f8f9ff; }
        /* outTotalAmount */
        #outTotalAmount {
            text-align: right; font-size: 16px; font-weight: bold;
            color: #1a73e8; padding: 10px 0; border-top: 2px solid #1a73e8;
            margin-bottom: 20px;
        }
        .btn { padding: 8px 18px; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; }
        /* btnPrintInvoice */
        #btnPrintInvoice { background: #1a73e8; color: white; margin-right: 10px; }
        #btnPrintInvoice:hover { background: #1558b0; }
        /* btnBack */
        #btnBack { background: #5f6368; color: white; }
        #btnBack:hover { background: #3c4043; }
        .actions { margin-top: 8px; display: flex; align-items: center; }
        .no-data { text-align: center; color: #888; padding: 32px; }

        /* Print styles */
        @media print {
            .header, .actions, #btnPrintInvoice, #btnBack { display: none; }
            body { background: white; }
            .card { box-shadow: none; }
            .container { margin: 0; max-width: 100%; }
        }
    </style>
</head>
<body>

<div class="header">
    <h1>🏪 Hệ thống Quản lí Siêu thị Điện máy</h1>
    <span>Xin chào, <%= manager.getFullName() %> | <a href="../thanhvien/LoginFrm6.jsp?action=logout" style="color:white;">Đăng xuất</a></span>
</div>

<div class="container">
    <div class="card">
        <div class="page-title">🧾 Chi tiết phiếu nhập hàng</div>

        <%-- Bước 42: Hiển thị thông tin chi tiết phiếu nhập cho NV quản lí --%>

        <% if (errorMsg != null) { %>
            <div class="error">⚠️ <%= errorMsg %></div>
        <% } %>

        <%-- outReceiptInfo: Thông tin phiếu nhập --%>
        <div id="outReceiptInfo">
            <div class="info-item">
                Mã phiếu: <span>PN<%= idReceiptStr != null ? String.format("%04d", Integer.parseInt(idReceiptStr)) : "—" %></span>
            </div>
            <div class="info-item">
                Ngày lập:
                <span>
                    <%= (receipt != null && receipt.getImportDate() != null)
                        ? displayFmt.format(receipt.getImportDate())
                        : "—" %>
                </span>
            </div>
            <div class="info-item">
                Nhà cung cấp: <span><%= supplierName != null ? supplierName : "—" %></span>
            </div>
            <div class="info-item">
                NV kho lập:
                <span>
                    <%= (receipt != null && receipt.getWarehouseStaff() != null)
                        ? receipt.getWarehouseStaff().getFullName()
                        : "—" %>
                </span>
            </div>
        </div>

        <div class="section-title">Danh sách mặt hàng nhập</div>

        <% if (listDetail == null || listDetail.isEmpty()) { %>
            <div class="no-data">Không có dữ liệu chi tiết cho phiếu nhập này.</div>
        <% } else { %>

        <%-- tblReceiptDetailList: Bảng chi tiết mặt hàng nhập --%>
        <table id="tblReceiptDetailList">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã mặt hàng</th>
                    <th>Tên mặt hàng</th>
                    <th>SL nhập</th>
                    <th>Đơn giá nhập (VNĐ)</th>
                    <th>Thành tiền (VNĐ)</th>
                </tr>
            </thead>
            <tbody>
                <% int stt = 1; for (ImportReceiptDetail6 d : listDetail) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td>MH<%= String.format("%04d", d.getProduct().getId()) %></td>
                    <td class="text-left"><%= d.getProduct().getName() %></td>
                    <td><%= d.getImportQuantity() %></td>
                    <td class="amount"><%= String.format("%,.0f", d.getImportPrice()) %> đ</td>
                    <td class="amount"><%= String.format("%,.0f", d.getImportPrice() * d.getImportQuantity()) %> đ</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <% } %>

        <%-- outTotalAmount: Tổng tiền --%>
        <div id="outTotalAmount">
            Tổng cộng: <%= String.format("%,.0f", grandTotal) %> đ
        </div>

        <div class="actions">
            <%-- btnPrintInvoice: In hóa đơn --%>
            <button type="button" class="btn" id="btnPrintInvoice" onclick="window.print()">🖨️ In hóa đơn</button>

            <%-- btnBack: Quay lại SupplierImportHistoryFrm6 --%>
            <form action="SupplierImportHistoryFrm6.jsp" method="post">
                <input type="hidden" name="idSupplier"   value="<%= idSupplierStr %>">
                <input type="hidden" name="supplierName" value="<%= supplierName %>">
                <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                <button type="submit" class="btn" id="btnBack">← Quay lại lịch sử nhập</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>

