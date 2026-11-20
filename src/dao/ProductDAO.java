package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product6;

public class ProductDAO extends DAO {
    private static final List<Product6> DEFAULT_PRODUCTS = new ArrayList<>();
    static {
        DEFAULT_PRODUCTS.add(new Product6(1, "Smart Tivi Samsung 55 inch Crystal UHD", 12500000f, 25, "Độ phân giải 4K, HDR10+, Smart Tizen OS, bảo hành 24 tháng."));
        DEFAULT_PRODUCTS.add(new Product6(2, "Smart Tivi Sony 4K 65 inch", 18200000f, 14, "Màn hình 4K HDR, âm thanh vòm Dolby Atmos, Google TV."));
        DEFAULT_PRODUCTS.add(new Product6(3, "Android Tivi Casper 43 inch", 6800000f, 30, "Độ phân giải Full HD, hệ điều hành Android, thiết kế tràn viền."));
        DEFAULT_PRODUCTS.add(new Product6(4, "Smart Tivi Samsung QLED 4K 65 inch", 22900000f, 20, "Bộ xử lý Quantum 4K Lite, Quantum HDR 100% dải màu"));
        DEFAULT_PRODUCTS.add(new Product6(5, "Tủ lạnh Samsung Inverter 380L", 16000000f, 15, "Công nghệ SpaceMax, làm lạnh vòm All-around Cooling."));
        DEFAULT_PRODUCTS.add(new Product6(6, "Tủ lạnh Samsung Inverter 236 lít RT22FARBDSA", 6290000f, 30, "Digital Inverter tiết kiệm điện, bộ lọc khử mùi Deodorizer"));
        DEFAULT_PRODUCTS.add(new Product6(7, "Máy giặt Samsung EcoBubble 9.5 kg WW95TA046AX", 8990000f, 18, "Giặt bong bóng siêu mịn EcoBubble, diệt khuẩn hơi nước."));
        DEFAULT_PRODUCTS.add(new Product6(8, "Smart Tivi LG 4K 55 inch NanoCell 55NANO76SQA", 13900000f, 25, "Bộ xử lý α5 Gen5 AI 4K, công nghệ màu NanoCell chân thực"));
    }

    public ProductDAO() {
        super();
    }

    public ArrayList<Product6> searchProduct(String name) {
        ArrayList<Product6> result = new ArrayList<>();
        if (con != null) {
            String sql = "SELECT id, name, price, stockQuantity, description FROM tblProduct6 WHERE LOWER(name) LIKE ?";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, "%" + (name == null ? "" : name.trim().toLowerCase()) + "%");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product6 p = new Product6();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getFloat("price"));
                    p.setStockQuantity(rs.getInt("stockQuantity"));
                    p.setDescription(rs.getString("description"));
                    result.add(p);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (result.isEmpty()) {
            String kw = (name == null ? "" : name.trim().toLowerCase());
            for (Product6 p : DEFAULT_PRODUCTS) {
                if (kw.isEmpty() || p.getName().toLowerCase().contains(kw)) {
                    result.add(p);
                }
            }
        }
        return result;
    }

    public Product6 getProductDetail(int id) {
        if (con != null) {
            String sql = "SELECT id, name, price, stockQuantity, description FROM tblProduct6 WHERE id = ?";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Product6 p = new Product6();
                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setPrice(rs.getFloat("price"));
                    p.setStockQuantity(rs.getInt("stockQuantity"));
                    p.setDescription(rs.getString("description"));
                    return p;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        for (Product6 p : DEFAULT_PRODUCTS) {
            if (p.getId() == id) {
                return p;
            }
        }
        return DEFAULT_PRODUCTS.get(0);
    }
}
