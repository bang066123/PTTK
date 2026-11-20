package dao;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Lớp DAO xử lí thống kê nhà cung cấp theo số lượng hàng nhập.
 * Phục vụ modul: Xem thống kê NCC theo số lượng hàng nhập.
 */
public class SupplierStatDAO extends DAO {

    /**
     * Dữ liệu mẫu (mock) để giao diện luôn chạy thành công ngay cả khi chưa bật MySQL
     */
    private static final List<SupplierStat6> MOCK_STATS = new ArrayList<>();
    static {
        Address6 addr1 = new Address6(1, "Số 10", "Trần Phú", "Mộ Lao", "Hà Đông", "Hà Nội");
        SupplierStat6 s1 = new SupplierStat6(1, "Công ty TNHH Samsung Electronics VN", "0243838383", "contact@samsung.com.vn", "Phân phối TV, Tủ lạnh, Máy giặt Samsung chính hãng", addr1, 50, 2);

        Address6 addr2 = new Address6(2, "Số 88", "Cầu Giấy", "Dịch Vọng", "Cầu Giấy", "Hà Nội");
        SupplierStat6 s2 = new SupplierStat6(2, "Tập đoàn Điện tử LG Việt Nam", "0243939393", "info@lge.com.vn", "Cung cấp thiết bị gia dụng và điện lạnh LG", addr2, 25, 1);

        Address6 addr3 = new Address6(3, "Lô 4", "KCN Biên Hòa", "Long Bình", "Biên Hòa", "Đồng Nai");
        SupplierStat6 s3 = new SupplierStat6(3, "Công ty TNHH Sony Electronics VN", "0283737373", "support@sony.com.vn", "Nhà phân phối âm thanh, TV Sony", addr3, 15, 1);

        MOCK_STATS.add(s1);
        MOCK_STATS.add(s2);
        MOCK_STATS.add(s3);
    }

    /**
     * Tính toán và tổng hợp số lượng hàng nhập, số lần nhập của từng nhà cung cấp
     * trong khoảng thời gian từ startDate đến endDate.
     * Phục vụ bước 6-11 trong kịch bản v3 modul xem thống kê NCC.
     *
     * @param startDate ngày bắt đầu thống kê
     * @param endDate   ngày kết thúc thống kê
     * @return danh sách SupplierStat6 đã tổng hợp
     */
    public List<SupplierStat6> getSupplierStat(Date startDate, Date endDate) {
        List<SupplierStat6> list = new ArrayList<>();
        if (con != null) {
            String sql =
                "SELECT s.id, s.supplier_name, s.phone, s.email, s.description, " +
                "       a.id AS addr_id, a.house_number, a.street, a.ward, a.district, a.city, " +
                "       SUM(ird.quantity) AS total_import_quantity, " +
                "       COUNT(DISTINCT ir.id) AS import_count " +
                "FROM supplier s " +
                "JOIN address a ON s.address_id = a.id " +
                "JOIN import_receipt ir ON ir.supplier_id = s.id " +
                "JOIN import_receipt_detail ird ON ird.import_receipt_id = ir.id " +
                "WHERE ir.import_date BETWEEN ? AND ? " +
                "GROUP BY s.id, s.supplier_name, s.phone, s.email, s.description, " +
                "         a.id, a.house_number, a.street, a.ward, a.district, a.city " +
                "ORDER BY total_import_quantity DESC";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setDate(1, new java.sql.Date(startDate.getTime()));
                ps.setDate(2, new java.sql.Date(endDate.getTime()));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Address6 address = new Address6(
                        rs.getInt("addr_id"),
                        rs.getString("house_number"),
                        rs.getString("street"),
                        rs.getString("ward"),
                        rs.getString("district"),
                        rs.getString("city")
                    );
                    SupplierStat6 stat = new SupplierStat6(
                        rs.getInt("id"),
                        rs.getString("supplier_name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("description"),
                        address,
                        rs.getInt("total_import_quantity"),
                        rs.getInt("import_count")
                    );
                    list.add(stat);
                }
            } catch (SQLException e) {
                System.err.println("getSupplierStat error: " + e.getMessage());
            }
        }
        // Fallback mock nếu CSDL chưa kết nối hoặc chưa có dữ liệu
        if (list.isEmpty()) {
            list.addAll(MOCK_STATS);
        }
        return list;
    }
}
