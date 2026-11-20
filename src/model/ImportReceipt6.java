package model;

import java.util.Date;
import java.util.List;

/**
 * Lớp thực thể phiếu nhập hàng
 */
public class ImportReceipt6 {
    private int id;
    private Date importDate;
    private float totalAmount;
    private Supplier6 supplier;
    private WarehouseStaff6 warehouseStaff;
    private List<ImportReceiptDetail6> listReceiptDetail;

    public ImportReceipt6() {}

    public ImportReceipt6(int id, Date importDate, float totalAmount,
                          Supplier6 supplier, WarehouseStaff6 warehouseStaff) {
        this.id = id;
        this.importDate = importDate;
        this.totalAmount = totalAmount;
        this.supplier = supplier;
        this.warehouseStaff = warehouseStaff;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getImportDate() { return importDate; }
    public void setImportDate(Date importDate) { this.importDate = importDate; }

    public float getTotalAmount() { return totalAmount; }
    public void setTotalAmount(float totalAmount) { this.totalAmount = totalAmount; }

    public Supplier6 getSupplier() { return supplier; }
    public void setSupplier(Supplier6 supplier) { this.supplier = supplier; }

    public WarehouseStaff6 getWarehouseStaff() { return warehouseStaff; }
    public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) { this.warehouseStaff = warehouseStaff; }

    public List<ImportReceiptDetail6> getListReceiptDetail() { return listReceiptDetail; }
    public void setListReceiptDetail(List<ImportReceiptDetail6> listReceiptDetail) { this.listReceiptDetail = listReceiptDetail; }
}

