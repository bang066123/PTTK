package model;

public class ImportReceiptDetail6 {
    private int id;
    private int quantity;
    private float unitPrice;
    private Product6 product;

    public ImportReceiptDetail6() {}

    public ImportReceiptDetail6(int id, int quantity, float unitPrice, Product6 product) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.product = product;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public float getUnitPrice() { return unitPrice; }
    public void setUnitPrice(float unitPrice) { this.unitPrice = unitPrice; }

    public Product6 getProduct() { return product; }
    public void setProduct(Product6 product) { this.product = product; }

    public float getTotalPrice() { return quantity * unitPrice; }

    public int getImportQuantity() { return quantity; }
    public void setImportQuantity(int quantity) { this.quantity = quantity; }

    public float getImportPrice() { return unitPrice; }
    public void setImportPrice(float unitPrice) { this.unitPrice = unitPrice; }
}
