package model;

/**
 * Lớp thực thể chi tiết phiếu nhập hàng (một dòng mặt hàng trong phiếu nhập)
 */
public class ImportReceiptDetail6 {
    private int id;
    private int quantity;
    private float unitPrice;
    private float totalPrice;
    private Product6 product;
    private ImportReceipt6 importReceipt;

    public ImportReceiptDetail6() {}

    public ImportReceiptDetail6(int id, int quantity, float unitPrice, float totalPrice, Product6 product) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.product = product;
    }

    public ImportReceiptDetail6(int id, int quantity, float unitPrice, float totalPrice, Product6 product, ImportReceipt6 importReceipt) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.product = product;
        this.importReceipt = importReceipt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    // Alias cho JSP
    public int getImportQuantity() { return quantity; }
    public void setImportQuantity(int q) { this.quantity = q; }

    public float getUnitPrice() { return unitPrice; }
    public void setUnitPrice(float unitPrice) { this.unitPrice = unitPrice; }

    // Alias cho JSP
    public float getImportPrice() { return unitPrice; }
    public void setImportPrice(float p) { this.unitPrice = p; }

    public float getTotalPrice() { return totalPrice; }
    public void setTotalPrice(float totalPrice) { this.totalPrice = totalPrice; }

    public Product6 getProduct() { return product; }
    public void setProduct(Product6 product) { this.product = product; }

    public ImportReceipt6 getImportReceipt() { return importReceipt; }
    public void setImportReceipt(ImportReceipt6 importReceipt) { this.importReceipt = importReceipt; }
}
