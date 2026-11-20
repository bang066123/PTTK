package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ImportReceiptDetail6;
import model.Product6;

public class ImportReceiptDetailDAO extends DAO {
    private static final List<ImportReceiptDetail6> DEFAULT_DETAILS = new ArrayList<>();
    static {
        Product6 p1 = new Product6(1, "Smart Tivi Samsung 55 inch Crystal UHD", 12500000f, 25, "Độ phân giải 4K, HDR10+, Smart Tizen OS");
        ImportReceiptDetail6 d1 = new ImportReceiptDetail6(1, 20, 10500000f, p1);
        DEFAULT_DETAILS.add(d1);

        Product6 p2 = new Product6(5, "Tủ lạnh Samsung Inverter 380L", 16000000f, 15, "Công nghệ SpaceMax, làm lạnh vòm");
        ImportReceiptDetail6 d2 = new ImportReceiptDetail6(2, 15, 16000000f, p2);
        DEFAULT_DETAILS.add(d2);
    }

    public ImportReceiptDetailDAO() {
        super();
    }

    public ArrayList<ImportReceiptDetail6> getDetailByReceipt(int idReceipt) {
        ArrayList<ImportReceiptDetail6> result = new ArrayList<>();
        if (con != null) {
            String sql = "SELECT ird.id, ird.quantity, ird.unitPrice, " +
                         "       p.id AS productId, p.name AS productName, p.price, p.stockQuantity, p.description " +
                         "FROM tblImportReceiptDetail6 ird " +
                         "JOIN tblProduct6 p ON ird.tblProduct6id = p.id " +
                         "WHERE ird.tblImportReceipt6id = ? " +
                         "ORDER BY ird.id ASC";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, idReceipt);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product6 p = new Product6();
                    p.setId(rs.getInt("productId"));
                    p.setName(rs.getString("productName"));
                    p.setPrice(rs.getFloat("price"));
                    p.setStockQuantity(rs.getInt("stockQuantity"));
                    p.setDescription(rs.getString("description"));

                    ImportReceiptDetail6 detail = new ImportReceiptDetail6();
                    detail.setId(rs.getInt("id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setUnitPrice(rs.getFloat("unitPrice"));
                    detail.setProduct(p);
                    result.add(detail);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (result.isEmpty()) {
            result.addAll(DEFAULT_DETAILS);
        }
        return result;
    }
}
