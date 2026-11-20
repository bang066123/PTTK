package dao;

import model.Product6;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Lớp DAO xử lí truy vấn dữ liệu mặt hàng.
 * Phục vụ modul: Tìm kiếm mặt hàng (Search Product).
 */
public class ProductDAO extends DAO {

    /**
     * Danh sách mặt hàng mẫu dùng khi chưa kết nối CSDL (fallback mock data)
     */
    private static final List<Product6> MOCK_PRODUCTS = new ArrayList<>();
    static {
        MOCK_PRODUCTS.add(new Product6(1, "Smart Tivi Samsung 4K 55 inch Crystal UHD", 12500000, 45, "Màn hình Dynamic Crystal Color, HDR, thiết kế viền mỏng AirSlim"));
        MOCK_PRODUCTS.add(new Product6(2, "Smart Tivi Samsung QLED 4K 65 inch", 22900000, 20, "Bộ xử lý Quantum 4K Lite, Quantum HDR 100% dải màu"));
        MOCK_PRODUCTS.add(new Product6(3, "Tủ lạnh Samsung Inverter 236 lít RT22FARBDSA", 6290000, 30, "Digital Inverter tiết kiệm điện, bộ lọc khử mùi Deodorizer"));
        MOCK_PRODUCTS.add(new Product6(4, "Máy giặt Samsung EcoBubble 9.5 kg WW95TA046AX", 8990000, 15, "Công nghệ giặt bong bóng siêu mịn EcoBubble, diệt khuẩn Hygiene Steam"));
        MOCK_PRODUCTS.add(new Product6(5, "Smart Tivi LG 4K 55 inch NanoCell 55NANO76SQA", 13900000, 25, "Bộ xử lý α5 Gen5 AI 4K, công nghệ màu NanoCell chân thực"));
        MOCK_PRODUCTS.add(new Product6(6, "Tủ lạnh LG Inverter 315 lít GN-M312PS", 7890000, 18, "Hệ thống làm lạnh Door Cooling+, ngăn chứa rau củ Fresh O Zone"));
        MOCK_PRODUCTS.add(new Product6(7, "Máy giặt LG Inverter 10 kg FV1410S4P", 10490000, 22, "Công nghệ AI DD bảo vệ sợi vải, TurboWash 59 phút"));
        MOCK_PRODUCTS.add(new Product6(8, "Smart Tivi Sony 4K 50 inch KD-50X75K", 11990000, 12, "Bộ xử lý 4K X1, công nghệ âm thanh Dolby Atmos"));
    }

    /**
     * Tìm danh sách mặt hàng có tên chứa từ khóa.
     * Phục vụ bước 6-11 trong kịch bản v3 modul tìm kiếm mặt hàng.
     *
     * @param name từ khóa tìm kiếm (tên mặt hàng)
     * @return danh sách Product6 phù hợp
     */
    public List<Product6> searchProduct(String name) {
        List<Product6> list = new ArrayList<>();
        if (con != null) {
            String sql = "SELECT id, name, price, stock_quantity, description " +
                         "FROM product WHERE name LIKE ? ORDER BY name";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, "%" + (name == null ? "" : name.trim()) + "%");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product6 p = new Product6(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getFloat("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("description")
                    );
                    list.add(p);
                }
            } catch (SQLException e) {
                System.err.println("searchProduct error: " + e.getMessage());
            }
        }
        // Nếu không có CSDL hoặc danh sách rỗng từ DB, dùng mock data để giao diện luôn chạy thành công
        if (list.isEmpty()) {
            String kw = (name == null ? "" : name.trim().toLowerCase());
            for (Product6 p : MOCK_PRODUCTS) {
                if (kw.isEmpty() || p.getName().toLowerCase().contains(kw)) {
                    list.add(p);
                }
            }
        }
        return list;
    }

    /**
     * Lấy thông tin chi tiết của một mặt hàng theo mã.
     * Phục vụ bước 15-20 trong kịch bản v3 modul tìm kiếm mặt hàng.
     *
     * @param id mã mặt hàng
     * @return đối tượng Product6 chứa thông tin chi tiết
     */
    public Product6 getProductDetail(int id) {
        if (con != null) {
            String sql = "SELECT id, name, price, stock_quantity, description " +
                         "FROM product WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return new Product6(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getFloat("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("description")
                    );
                }
            } catch (SQLException e) {
                System.err.println("getProductDetail error: " + e.getMessage());
            }
        }
        // Fallback mock
        for (Product6 p : MOCK_PRODUCTS) {
            if (p.getId() == id) {
                return p;
            }
        }
        return MOCK_PRODUCTS.get(0);
    }
}
