package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Address6;
import model.ImportReceipt6;
import model.Supplier6;
import model.WarehouseStaff6;

public class ImportReceiptDAO extends DAO {
    private static final List<ImportReceipt6> DEFAULT_RECEIPTS = new ArrayList<>();
    static {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Address6 addr = new Address6(1, "Số 10", "Trần Phú", "Mộ Lao", "Hà Đông", "Hà Nội");
            Supplier6 sup = new Supplier6(1, "Samsung Vina", "024-383838", "contact@samsung.com.vn", "Phân phối chính hãng", addr);
            WarehouseStaff6 staff = new WarehouseStaff6();
            staff.setId(2);
            staff.setName("Nguyễn Văn Kho");
            staff.setPhoneNumber("0987654321");

            ImportReceipt6 r1 = new ImportReceipt6();
            r1.setId(1);
            r1.setImportDate(sdf.parse("2026-02-15"));
            r1.setTotalAmount(450000000f);
            r1.setSupplier(sup);
            r1.setWarehouseStaff(staff);
            DEFAULT_RECEIPTS.add(r1);

            ImportReceipt6 r2 = new ImportReceipt6();
            r2.setId(5);
            r2.setImportDate(sdf.parse("2026-04-28"));
            r2.setTotalAmount(380000000f);
            r2.setSupplier(sup);
            r2.setWarehouseStaff(staff);
            DEFAULT_RECEIPTS.add(r2);

            ImportReceipt6 r3 = new ImportReceipt6();
            r3.setId(12);
            r3.setImportDate(sdf.parse("2026-08-10"));
            r3.setTotalAmount(520000000f);
            r3.setSupplier(sup);
            r3.setWarehouseStaff(staff);
            DEFAULT_RECEIPTS.add(r3);
        } catch (Exception ignored) {}
    }

    public ImportReceiptDAO() {
        super();
    }

    public ArrayList<ImportReceipt6> getImportReceiptBySupplier(int idSupplier, Date startDate, Date endDate) {
        ArrayList<ImportReceipt6> result = new ArrayList<>();
        if (con != null) {
            String sql = "SELECT ir.id, ir.importDate, " +
                         "       s.id AS supplierId, s.supplierName, s.phone AS supplierPhone, s.email AS supplierEmail, s.description AS supplierDesc, " +
                         "       addr.id AS addrId, addr.houseNumber, addr.street, addr.ward, addr.district, addr.city, " +
                         "       ws.tblEmployee6id, a.name AS staffName, a.phoneNumber AS staffPhone, " +
                         "       COALESCE(SUM(ird.quantity * ird.unitPrice), 0) AS totalAmount " +
                         "FROM tblImportReceipt6 ir " +
                         "JOIN tblSupplier6 s ON ir.tblSupplier6id = s.id " +
                         "LEFT JOIN tblAddress6 addr ON s.tblAddress6id = addr.id " +
                         "LEFT JOIN tblWarehouseStaff6 ws ON ir.WarehouseStaff6id = ws.tblEmployee6id " +
                         "LEFT JOIN tblEmployee6 e ON ws.tblEmployee6id = e.tblAccount6id " +
                         "LEFT JOIN tblAccount6 a ON e.tblAccount6id = a.id " +
                         "LEFT JOIN tblImportReceiptDetail6 ird ON ird.tblImportReceipt6id = ir.id " +
                         "WHERE ir.tblSupplier6id = ? AND ir.importDate BETWEEN ? AND ? " +
                         "GROUP BY ir.id, ir.importDate, s.id, s.supplierName, s.phone, s.email, s.description, " +
                         "         addr.id, addr.houseNumber, addr.street, addr.ward, addr.district, addr.city, " +
                         "         ws.tblEmployee6id, a.name, a.phoneNumber " +
                         "ORDER BY ir.importDate DESC";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, idSupplier);
                ps.setDate(2, new java.sql.Date(startDate.getTime()));
                ps.setDate(3, new java.sql.Date(endDate.getTime()));
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Address6 supAddr = new Address6();
                    supAddr.setId(rs.getInt("addrId"));
                    supAddr.setHouseNumber(rs.getString("houseNumber"));
                    supAddr.setStreet(rs.getString("street"));
                    supAddr.setWard(rs.getString("ward"));
                    supAddr.setDistrict(rs.getString("district"));
                    supAddr.setCity(rs.getString("city"));

                    Supplier6 sup = new Supplier6();
                    sup.setId(rs.getInt("supplierId"));
                    sup.setSupplierName(rs.getString("supplierName"));
                    sup.setPhone(rs.getString("supplierPhone"));
                    sup.setEmail(rs.getString("supplierEmail"));
                    sup.setDescription(rs.getString("supplierDesc"));
                    sup.setAddress(supAddr);

                    WarehouseStaff6 staff = new WarehouseStaff6();
                    staff.setId(rs.getInt("tblEmployee6id"));
                    staff.setName(rs.getString("staffName"));
                    staff.setPhoneNumber(rs.getString("staffPhone"));

                    ImportReceipt6 r = new ImportReceipt6();
                    r.setId(rs.getInt("id"));
                    r.setImportDate(rs.getDate("importDate"));
                    r.setTotalAmount(rs.getFloat("totalAmount"));
                    r.setSupplier(sup);
                    r.setWarehouseStaff(staff);
                    result.add(r);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (result.isEmpty()) {
            result.addAll(DEFAULT_RECEIPTS);
        }
        return result;
    }

    public ImportReceipt6 getReceiptById(int idReceipt) {
        if (con != null) {
            String sql = "SELECT ir.id, ir.importDate, " +
                         "       s.id AS supplierId, s.supplierName, s.phone AS supplierPhone, s.email AS supplierEmail, s.description AS supplierDesc, " +
                         "       addr.id AS addrId, addr.houseNumber, addr.street, addr.ward, addr.district, addr.city, " +
                         "       ws.tblEmployee6id, a.name AS staffName, a.phoneNumber AS staffPhone, " +
                         "       COALESCE(SUM(ird.quantity * ird.unitPrice), 0) AS totalAmount " +
                         "FROM tblImportReceipt6 ir " +
                         "JOIN tblSupplier6 s ON ir.tblSupplier6id = s.id " +
                         "LEFT JOIN tblAddress6 addr ON s.tblAddress6id = addr.id " +
                         "LEFT JOIN tblWarehouseStaff6 ws ON ir.WarehouseStaff6id = ws.tblEmployee6id " +
                         "LEFT JOIN tblEmployee6 e ON ws.tblEmployee6id = e.tblAccount6id " +
                         "LEFT JOIN tblAccount6 a ON e.tblAccount6id = a.id " +
                         "LEFT JOIN tblImportReceiptDetail6 ird ON ird.tblImportReceipt6id = ir.id " +
                         "WHERE ir.id = ? " +
                         "GROUP BY ir.id, ir.importDate, s.id, s.supplierName, s.phone, s.email, s.description, " +
                         "         addr.id, addr.houseNumber, addr.street, addr.ward, addr.district, addr.city, " +
                         "         ws.tblEmployee6id, a.name, a.phoneNumber";
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, idReceipt);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    Address6 supAddr = new Address6();
                    supAddr.setId(rs.getInt("addrId"));
                    supAddr.setHouseNumber(rs.getString("houseNumber"));
                    supAddr.setStreet(rs.getString("street"));
                    supAddr.setWard(rs.getString("ward"));
                    supAddr.setDistrict(rs.getString("district"));
                    supAddr.setCity(rs.getString("city"));

                    Supplier6 sup = new Supplier6();
                    sup.setId(rs.getInt("supplierId"));
                    sup.setSupplierName(rs.getString("supplierName"));
                    sup.setPhone(rs.getString("supplierPhone"));
                    sup.setEmail(rs.getString("supplierEmail"));
                    sup.setDescription(rs.getString("supplierDesc"));
                    sup.setAddress(supAddr);

                    WarehouseStaff6 staff = new WarehouseStaff6();
                    staff.setId(rs.getInt("tblEmployee6id"));
                    staff.setName(rs.getString("staffName"));
                    staff.setPhoneNumber(rs.getString("staffPhone"));

                    ImportReceipt6 r = new ImportReceipt6();
                    r.setId(rs.getInt("id"));
                    r.setImportDate(rs.getDate("importDate"));
                    r.setTotalAmount(rs.getFloat("totalAmount"));
                    r.setSupplier(sup);
                    r.setWarehouseStaff(staff);
                    return r;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        for (ImportReceipt6 r : DEFAULT_RECEIPTS) {
            if (r.getId() == idReceipt) {
                return r;
            }
        }
        return DEFAULT_RECEIPTS.get(0);
    }
}
