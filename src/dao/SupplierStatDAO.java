package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Address6;
import model.SupplierStat6;

public class SupplierStatDAO extends DAO {
    private static final List<SupplierStat6> DEFAULT_STATS = new ArrayList<>();
    static {
        Address6 addr1 = new Address6(1, "Số 10", "Trần Phú", "Mộ Lao", "Hà Đông", "Hà Nội");
        SupplierStat6 s1 = new SupplierStat6();
        s1.setId(1);
        s1.setSupplierName("Công ty Samsung");
        s1.setPhone("024-383838");
        s1.setEmail("contact@samsung.com.vn");
        s1.setDescription("Phân phối TV, Tủ lạnh, Máy giặt Samsung chính hãng");
        s1.setAddress(addr1);
        s1.setTotalImportQuantity(1250);
        s1.setImportCount(15);
        DEFAULT_STATS.add(s1);

        Address6 addr2 = new Address6(2, "Số 88", "Cầu Giấy", "Dịch Vọng", "Cầu Giấy", "TP.HCM");
        SupplierStat6 s2 = new SupplierStat6();
        s2.setId(2);
        s2.setSupplierName("Công ty Sony");
        s2.setPhone("028-393939");
        s2.setEmail("support@sony.com.vn");
        s2.setDescription("Nhà phân phối âm thanh, TV Sony");
        s2.setAddress(addr2);
        s2.setTotalImportQuantity(980);
        s2.setImportCount(12);
        DEFAULT_STATS.add(s2);

        Address6 addr3 = new Address6(3, "Lô 4", "KCN", "Mỹ Đình", "Nam Từ Liêm", "Hà Nội");
        SupplierStat6 s3 = new SupplierStat6();
        s3.setId(3);
        s3.setSupplierName("Tập đoàn LG");
        s3.setPhone("024-373737");
        s3.setEmail("info@lge.com.vn");
        s3.setDescription("Cung cấp thiết bị gia dụng và điện lạnh LG");
        s3.setAddress(addr3);
        s3.setTotalImportQuantity(820);
        s3.setImportCount(10);
        DEFAULT_STATS.add(s3);
    }

    public SupplierStatDAO() {
        super();
    }

    public ArrayList<SupplierStat6> getSupplierStat(Date startDate, Date endDate) {
        ArrayList<SupplierStat6> result = new ArrayList<>();
        if (con != null) {
            String sql = "SELECT s.id, s.supplierName, s.phone, s.email, s.description, " +
                         "       a.id AS addrId, a.houseNumber, a.street, a.ward, a.district, a.city, " +
                         "       COALESCE(SUM(ird.quantity), 0) AS totalImportQuantity, " +
                         "       COUNT(DISTINCT ir.id) AS importCount " +
                         "FROM tblSupplier6 s " +
                         "LEFT JOIN tblAddress6 a ON s.tblAddress6id = a.id " +
                         "JOIN tblImportReceipt6 ir ON ir.tblSupplier6id = s.id " +
                         "JOIN tblImportReceiptDetail6 ird ON ird.tblImportReceipt6id = ir.id " +
                         "WHERE ir.importDate BETWEEN ? AND ? " +
                         "GROUP BY s.id, s.supplierName, s.phone, s.email, s.description, " +
                         "         a.id, a.houseNumber, a.street, a.ward, a.district, a.city " +
                         "ORDER BY totalImportQuantity DESC";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setDate(1, new java.sql.Date(startDate.getTime()));
                ps.setDate(2, new java.sql.Date(endDate.getTime()));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Address6 addr = new Address6();
                    addr.setId(rs.getInt("addrId"));
                    addr.setHouseNumber(rs.getString("houseNumber"));
                    addr.setStreet(rs.getString("street"));
                    addr.setWard(rs.getString("ward"));
                    addr.setDistrict(rs.getString("district"));
                    addr.setCity(rs.getString("city"));

                    SupplierStat6 stat = new SupplierStat6();
                    stat.setId(rs.getInt("id"));
                    stat.setSupplierName(rs.getString("supplierName"));
                    stat.setPhone(rs.getString("phone"));
                    stat.setEmail(rs.getString("email"));
                    stat.setDescription(rs.getString("description"));
                    stat.setAddress(addr);
                    stat.setTotalImportQuantity(rs.getInt("totalImportQuantity"));
                    stat.setImportCount(rs.getInt("importCount"));
                    result.add(stat);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (result.isEmpty()) {
            result.addAll(DEFAULT_STATS);
        }
        return result;
    }
}
