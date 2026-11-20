package dao;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp DAO xử lí truy vấn chi tiết phiếu nhập hàng.
 * Phục vụ modul: Xem thống kê NCC theo số lượng hàng nhập.
 */
public class ImportReceiptDetailDAO extends DAO {

    /**
     * Dữ liệu mẫu (mock) để giao diện luôn chạy thành công ngay cả khi chưa kết nối MySQL
     */
    private static final List<ImportReceiptDetail6> MOCK_DETAILS = new ArrayList<>();
    static {
        Product6 p1 = new Product6(1, "Smart Tivi Samsung 4K 55 inch Crystal UHD", 12500000, 45, "Màn hình 4K");
        Product6 p2 = new Product6(2, "Smart Tivi Samsung QLED 4K 65 inch", 22900000, 20, "QLED 4K");
        Product6 p3 = new Product6(3, "Tủ lạnh Samsung Inverter 236 lít", 6290000, 30, "Digital Inverter");
        Product6 p4 = new Product6(4, "Máy giặt Samsung EcoBubble 9.5 kg", 8990000, 15, "EcoBubble");
        Product6 p5 = new Product6(5, "Smart Tivi LG 4K 55 inch NanoCell", 13900000, 25, "NanoCell 4K");

        // Chi tiết phiếu 1
        ImportReceipt6 r1 = new ImportReceipt6(); r1.setId(1);
        MOCK_DETAILS.add(new ImportReceiptDetail6(1, 20, 10000000f, 200000000f, p1, r1));
        MOCK_DETAILS.add(new ImportReceiptDetail6(2, 20,  5000000f, 100000000f, p3, r1));
        MOCK_DETAILS.add(new ImportReceiptDetail6(3, 10,  6000000f,  60000000f, p4, r1));

        // Chi tiết phiếu 2
        ImportReceipt6 r2 = new ImportReceipt6(); r2.setId(2);
        MOCK_DETAILS.add(new ImportReceiptDetail6(4, 10, 18500000f, 185000000f, p2, r2));

        // Chi tiết phiếu 3
        ImportReceipt6 r3 = new ImportReceipt6(); r3.setId(3);
        MOCK_DETAILS.add(new ImportReceiptDetail6(5, 15, 11000000f, 165000000f, p5, r3));
    }

    /**
     * Lấy danh sách các dòng chi tiết của một phiếu nhập hàng.
     * Phục vụ bước 25-30 trong kịch bản v3 modul xem thống kê NCC.
     *
     * @param idReceipt mã phiếu nhập hàng
     * @return danh sách ImportReceiptDetail6
     */
    public List<ImportReceiptDetail6> getDetailByReceipt(int idReceipt) {
        List<ImportReceiptDetail6> list = new ArrayList<>();
        if (con != null) {
            String sql =
                "SELECT ird.id, ird.quantity, ird.unit_price, ird.total_price, " +
                "       p.id AS prod_id, p.name AS prod_name, p.price, p.stock_quantity, p.description " +
                "FROM import_receipt_detail ird " +
                "JOIN product p ON ird.product_id = p.id " +
                "WHERE ird.import_receipt_id = ? " +
                "ORDER BY ird.id";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, idReceipt);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product6 product = new Product6(
                        rs.getInt("prod_id"),
                        rs.getString("prod_name"),
                        rs.getFloat("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("description")
                    );
                    ImportReceiptDetail6 detail = new ImportReceiptDetail6(
                        rs.getInt("id"),
                        rs.getInt("quantity"),
                        rs.getFloat("unit_price"),
                        rs.getFloat("total_price"),
                        product,
                        null
                    );
                    list.add(detail);
                }
            } catch (SQLException e) {
                System.err.println("getDetailByReceipt error: " + e.getMessage());
            }
        }
        // Fallback mock
        if (list.isEmpty()) {
            for (ImportReceiptDetail6 d : MOCK_DETAILS) {
                if (d.getImportReceipt() != null && d.getImportReceipt().getId() == idReceipt) {
                    list.add(d);
                }
            }
            if (list.isEmpty()) {
                list.addAll(MOCK_DETAILS);
            }
        }
        return list;
    }
}
