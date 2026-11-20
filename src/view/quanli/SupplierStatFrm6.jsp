<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Date, java.text.SimpleDateFormat" %>
<%@ page import="model.Manager6, model.SupplierStat6" %>
<%@ page import="dao.SupplierStatDAO" %>
<%
    // Bước 15 (Module 2): Kiểm tra session manager
    Manager6 manager = (Manager6) session.getAttribute("manager");
    if (manager == null) {
        response.sendRedirect("../thanhvien/LoginFrm6.jsp");
        return;
    }

    // Bước 15: Lấy tham số từ SelectReportFrm6 (POST)
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

            // Bước 16: Gọi lớp TKNhacungcapDAO (SupplierStatDAO) yêu cầu lấy thống kê
            // Bước 17: Lớp SupplierStatDAO gọi hàm getSupplierStat()
            SupplierStatDAO dao = new SupplierStatDAO();
            // Bước 18-20: Hàm thực hiện, đóng gói và trả kết quả
            listSupplierStat = dao.getSupplierStat(startDate, endDate);

            if (listSupplierStat != null) {
                for (SupplierStat6 s : listSupplierStat) {
                    totalQuantity    += s.getTotalImportQuantity();
                    totalImportCount += s.getImportCount();
                }
            }
        } catch (Exception e) {
            errorMsg = "Lỗi xử lí: " + e.getMessage();
        }
    }

    // Format ngày hiển thị
    String displayStart = (inStartDate != null) ? inStartDate.replace("-", "/") : "";
    String displayEnd   = (inEndDate   != null) ? inEndDate.replace("-", "/")   : "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê nhà cung cấp</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background: #f0f4ff; }
        .header {
            background: #1a73e8; color: white; padding: 14px 24px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .header h1 { font-size: 20px; }
        .header span { font-size: 14px; }
        .container { max-width: 1100px; margin: 24px auto; padding: 0 16px; }
        .card { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); padding: 24px; }
        .page-title { font-size: 22px; color: #1a73e8; font-weight: bold; margin-bottom: 8px; }
        /* outTimeRange */
        #outTimeRange {
            background: #e8f0fe; border-left: 4px solid #1a73e8;
            padding: 10px 16px; margin-bottom: 20px; border-radius: 4px;
            font-size: 15px; color: #333;
        }
        .error { color: #d93025; background: #fce8e6; padding: 10px 16px; border-radius: 4px; margin-bottom: 16px; }
        /* tblSupplierStatList */
        #tblSupplierStatList {
            width: 100%; border-collapse: collapse; margin-bottom: 16px;
        }
        #tblSupplierStatList th {
            background: #1a73e8; color: white; padding: 10px 12px;
            text-align: center; font-size: 14px;
        }
        #tblSupplierStatList td {
            padding: 9px 12px; border-bottom: 1px solid #e0e0e0;
            font-size: 14px; text-align: center;
        }
        #tblSupplierStatList tr:hover td { background: #f8f9ff; }
        #tblSupplierStatList td.text-left { text-align: left; }
        .total-row td { font-weight: bold; background: #f0f4ff !important; }
        /* Buttons */
        .btn { padding: 7px 16px; border: none; border-radius: 5px; cursor: pointer; font-size: 13px; }
        /* btnViewDetail */
        .btnViewDetail { background: #1a73e8; color: white; }
        .btnViewDetail:hover { background: #1558b0; }
        /* btnBack */
        #btnBack { background: #5f6368; color: white; margin-top: 8px; }
        #btnBack:hover { background: #3c4043; }
        .actions { margin-top: 8px; }
        .no-data { text-align: center; color: #888; padding: 32px; }
    </style>
</head>
<body>

<div class="header">
    <h1>🏪 Hệ thống Quản lí Siêu thị Điện máy</h1>
    <span>Xin chào, <%= manager.getFullName() %> | <a href="../thanhvien/LoginFrm6.jsp?action=logout" style="color:white;">Đăng xuất</a></span>
</div>

<div class="container">
    <div class="card">
        <div class="page-title">📊 Thống kê nhà cung cấp theo số lượng hàng nhập</div>

        <%-- Bước 21: Trang hiển thị thông tin thống kê cho NV quản lí --%>

        <%-- outTimeRange: Hiển thị khoảng thời gian --%>
        <div id="outTimeRange">
            <strong>Khoảng thời gian:</strong> Từ <%= displayStart %> đến <%= displayEnd %>
            &nbsp;|&nbsp; <strong>Loại báo cáo:</strong> <%= cboReportType != null ? cboReportType : "" %>
        </div>

        <% if (errorMsg != null) { %>
            <div class="error">⚠️ <%= errorMsg %></div>
        <% } %>

        <% if (listSupplierStat == null || listSupplierStat.isEmpty()) { %>
            <div class="no-data">Không có dữ liệu thống kê cho khoảng thời gian đã chọn.</div>
        <% } else { %>

        <%-- tblSupplierStatList: Bảng danh sách thống kê nhà cung cấp --%>
        <table id="tblSupplierStatList">
            <thead>
                <tr>
                    <th>TT</th>
                    <th>Tên nhà cung cấp</th>
                    <th>Địa chỉ</th>
                    <th>SĐT</th>
                    <th>Tổng SL nhập</th>
                    <th>Số lần nhập</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <% int stt = 1; for (SupplierStat6 sup : listSupplierStat) { %>
                <tr>
                    <td><%= stt++ %></td>
                    <td class="text-left"><strong><%= sup.getSupplierName() %></strong></td>
                    <td class="text-left"><%= sup.getAddress() != null ? sup.getAddress().getFullAddress() : "" %></td>
                    <td><%= sup.getPhone() %></td>
                    <td><%= sup.getTotalImportQuantity() %></td>
                    <td><%= sup.getImportCount() %></td>
                    <td>
                        <%-- Bước 22: NV quản lí click Chi tiết → gọi SupplierImportHistoryFrm6 --%>
                        <%-- btnViewDetail --%>
                        <form action="SupplierImportHistoryFrm6.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="idSupplier"   value="<%= sup.getId() %>">
                            <input type="hidden" name="supplierName" value="<%= sup.getSupplierName() %>">
                            <input type="hidden" name="startDate"    value="<%= inStartDate %>">
                            <input type="hidden" name="endDate"      value="<%= inEndDate %>">
                            <button type="submit" class="btn btnViewDetail">Chi tiết</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                <%-- Dòng tổng kết --%>
                <tr class="total-row">
                    <td colspan="4" style="text-align:right;">Tổng cộng:</td>
                    <td><%= totalQuantity %></td>
                    <td><%= totalImportCount %></td>
                    <td></td>
                </tr>
            </tbody>
        </table>

        <% } %>

        <div class="actions">
            <%-- btnBack: Quay lại SelectReportFrm6 --%>
            <form action="SelectReportFrm6.jsp" method="get">
                <button type="submit" class="btn" id="btnBack">← Quay lại</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>

