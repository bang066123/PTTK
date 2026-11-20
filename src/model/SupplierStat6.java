package model;

/**
 * Lớp thực thể thống kê nhà cung cấp theo số lượng hàng nhập.
 * Kế thừa Supplier6, bổ sung 2 trường thống kê tổng hợp.
 */
public class SupplierStat6 extends Supplier6 {
    private int totalImportQuantity; // Tổng số lượng hàng nhập
    private int importCount;         // Số lần nhập hàng

    public SupplierStat6() { super(); }

    public SupplierStat6(int id, String supplierName, String phone, String email,
                         String description, Address6 address,
                         int totalImportQuantity, int importCount) {
        super(id, supplierName, phone, email, description, address);
        this.totalImportQuantity = totalImportQuantity;
        this.importCount = importCount;
    }

    public int getTotalImportQuantity() { return totalImportQuantity; }
    public void setTotalImportQuantity(int totalImportQuantity) { this.totalImportQuantity = totalImportQuantity; }

    public int getImportCount() { return importCount; }
    public void setImportCount(int importCount) { this.importCount = importCount; }
}

