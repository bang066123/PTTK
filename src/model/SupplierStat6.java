package model;

public class SupplierStat6 extends Supplier6 {
    private int totalImportQuantity;
    private int importCount;

    public SupplierStat6() {
        super();
    }

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
