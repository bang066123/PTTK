<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.Supplier6, model.ImportReceipt6" %>
<%@ page import="dao.ImportReceiptDAO" %>
<%
    // Kiểm tra session manager
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm6.jsp");
        return;
    }

    // Bước 25 (Module 2): Lấy tham số từ SupplierStatFrm6 (POST)
    String idSupplierStr  = request.getParameter("idSupplier");
    String supplierName   = request.getParameter("supplierName");
    String inStartDate    = request.getParameter("startDate");
    String inEndDate      = request.getParameter("endDate");
    // Lấy thêm thông tin NCC (email, phone, address) nếu có
    String supplierPhone  = request.getParameter("supplierPhone");
    String supplierEmail  = request.getParameter("supplierEmail");
    String supplierAddr   = request.getParameter("supplierAddr");

    List<ImportReceipt6> listReceipt = null;
    String errorMsg = null;
    double grandTotal = 0;

    if (idSupplierStr != null && inStartDate != null && inEndDate != null) {
        try {
            int idSupplier = Integer.parseInt(idSupplierStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(inStartDate);
            Date endDate   = sdf.parse(inEndDate);

            // Bước 26: Gọi lớp ImportReceiptDAO yêu cầu lấy danh sách phiếu nhập
            // Bước 27: Gọi hàm getImportReceiptBySupplier()
            ImportReceiptDAO dao = new ImportReceiptDAO();
            // Bước 28-30: Thực hiện, đóng gói và trả kết quả
            listReceipt = dao.getImportReceiptBySupplier(idSupplier, startDate, endDate);

            if (listReceipt != null) {
                for (ImportReceipt6 r : listReceipt) {
                    grandTotal += r.getTotalAmount();
                }
            }
        } catch (Exception e) {
            errorMsg = "Lỗi xử lí: " + e.getMessage();
        }
    }

    SimpleDateFormat displayFmt = new SimpleDateFormat("dd/MM/yyyy");
    String displayStart = "";
    String displayEnd   = "";
    try {
        if (inStartDate != null) displayStart = displayFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inStartDate));
        if (inEndDate   != null) displayEnd   = displayFmt.format(new SimpleDateFormat("yyyy-MM-dd").parse(inEndDate));
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử nhập hàng của NCC</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; }
        .header {
            background: #1a73e8; color: white; padding: 14px 24px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .header h1 { font-size: 20px; }
        .header span { font-size: 14px; }
        .container { max-width: 1050px; margin: 24px auto; padding: 0 16px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 24px; }
        .page-title { font-size: 20px; color: #1a73e8; font-weight: bold; margin-bottom: 16px; }
        /* outSupplierInfo */
        #outSupplierInfo {
            background: #f8f9ff; border: 1px solid #c5cae9;
            border-radius: 6px; padding: 14px 18px; margin-bottom: 14px;
        }
        #outSupplierInfo h3 { color: #1a73e8; margin-bottom: 8px; font-size: 16px; }
        #outSupplierInfo p  { font-size: 14px; color: #444; margin: 3px 0; }
        /* outTimeRange */
        #outTimeRange {
            background: #e8f0fe; border-left: 4px solid #1a73e8;
            padding: 9px 14px; margin-bottom: 18px; border-radius: 4px;
            font-size: 14px; color: #333;
        }
        .error { color: #d93025; background: #fce8e6; padding: 10px 16px; border-radius: 4px; margin-bottom: 14px; }
        /* tblImportReceiptList */
        #tblImportReceiptList { width: 100%; border-collapse: collapse; margin-bottom: 16px; }
        #tblImportReceiptList th {
            background: #1a73e8; color: white; padding: 10px 12px;
            text-align: center; font-size: 14px;
        }
        #tblImportReceiptList td {
            padding: 9px 12px; border-bottom: 1px solid #e0e0e0;
            font-size: 14px; text-align: center;
        }
        #tblImportReceiptList tr:hover td { background: #f8f9ff; }
        .total-row td { font-weight: bold; background: #f0f4ff !important; border-top: 2px solid #1a73e8; }
        .btn { padding: 7px 16px; border: none; border-radius: 5px; cursor: pointer; font-size: 13px; }
        /* btnViewReceipt */
        .btnViewReceipt { background: #34a853; color: white; }
        .btnViewReceipt:hover { background: #1e8e3e; }
        /* btnBack */
        #btnBack { background: #5f6368; color: white; }
        #btnBack:hover { background: #3c4043; }
        .actions { margin-top: 8px; }
        .no-data { text-align: center; color: #888; padding: 32px; }
        .amount { text-align: right !important; }
    </style>
</head>
<body>

<div class="header">
    <h1>🏪 Hệ thống Quản lí Siêu thị Điện máy</h1>
    <span>Xin chào, <%= manager.getFullName() %> | <a href="../thanhvien/LoginFrm6.jsp?action=logout" style="color:white;">Đăng xuất</a></span>
</div>

<div class="container">
    <div class="card">
        <div class="page-title">📋 Lịch sử nhập hàng của nhà cung cấp</div>

        <%-- Bước 31: Hiển thị thông tin NCC và danh sách phiếu nhập cho NV quản lí --%>

        <%-- outSupplierInfo: Thông tin nhà cung cấp --%>
        <div id="outSupplierInfo">
            <h3>🏭 Thông tin nhà cung cấp</h3>
            <p><strong>Tên NCC:</strong> <%= supplierName != null ? supplierName : "—" %></p>
            <% if (supplierPhone != null && !supplierPhone.isEmpty()) { %>
            <p><strong>SĐT:</strong> <%= supplierPhone %></p>
            <% } %>
            <% if (supplierEmail != null && !supplierEmail.isEmpty()) { %>
            <p><strong>Email:</strong> <%= supplierEmail %></p>
            <% } %>
            <% if (supplierAddr != null && !supplierAddr.isEmpty()) { %>
            <p><strong>Địa chỉ:</strong> <%= supplierAddr %></p>
            <% } %>
        </div>

        <%-- outTimeRange: Khoảng thời gian --%>
        <div id="outTimeRange">
            <strong>Khoảng thời gian:</strong> Từ <%= displayStart %> đến <%= displayEnd %>
        </div>

        <% if (errorMsg != null) { %>
            <div class="error">⚠️ <%= errorMsg %></div>
        <% } %>

        <% if (listReceipt == null || listReceipt.isEmpty()) { %>
            <div class="no-data">Không có phiếu nhập nào trong khoảng thời gian đã chọn.</div>
        <% } else { %>

        <%-- tblImportReceiptList: Danh sách phiếu nhập --%>
        <table id="tblImportReceiptList">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Mã phiếu nhập</th>
                    <th>Ngày nhập</th>
                    <th>Tổng tiền (VNĐ)</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% int stt = 1; for (ImportReceipt6 receipt : listReceipt) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><strong>PN<%= String.format("%04d", receipt.getId()) %></strong></td>
                    <td>
                        <%= receipt.getImportDate() != null
                            ? displayFmt.format(receipt.getImportDate())
                            : "—" %>
                    </td>
                    <td class="amount">
                        <%= String.format("%,.0f", receipt.getTotalAmount()) %> đ
                    </td>
                    <td>
                        <%-- Bước 32: NV quản lí click Hóa đơn → gọi ImportReceiptDetailFrm6 --%>
                        <%-- btnViewReceipt --%>
                        <form action="ImportReceiptDetailFrm6.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="idReceipt"    value="<%= receipt.getId() %>">
                            <input type="hidden" name="idSupplier"   value="<%= idSupplierStr %>">
                            <input type="hidden" name="supplierName" value="<%= supplierName %>">
                            <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                            <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                            <button type="submit" class="btn btnViewReceipt">🧾 Hóa đơn</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <%-- Dòng tổng --%>
                <tr class="total-row">
                    <td colspan="3" style="text-align:right;">Tổng tiền nhập:</td>
                    <td class="amount"><%= String.format("%,.0f", grandTotal) %> đ</td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        <% } %>

        <div class="actions">
            <%-- btnBack: Quay lại SupplierStatFrm6 với tham số ngày --%>
            <form action="SupplierStatFrm6.jsp" method="post">
                <input type="hidden" name="inStartDate"  value="<%= inStartDate %>">
                <input type="hidden" name="inEndDate"    value="<%= inEndDate %>">
                <button type="submit" class="btn" id="btnBack">← Quay lại danh sách NCC</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>

