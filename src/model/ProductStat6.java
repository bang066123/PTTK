package model;

public class ProductStat6 extends Product6 {
    private int totalQuantitySold;
    private float revenue;

    public ProductStat6() {
        super();
    }

    public ProductStat6(int id, String name, float price, int stockQuantity, String description,
                        int totalQuantitySold, float revenue) {
        super(id, name, price, stockQuantity, description);
        this.totalQuantitySold = totalQuantitySold;
        this.revenue = revenue;
    }

    public int getTotalQuantitySold() { return totalQuantitySold; }
    public void setTotalQuantitySold(int totalQuantitySold) { this.totalQuantitySold = totalQuantitySold; }

    public float getRevenue() { return revenue; }
    public void setRevenue(float revenue) { this.revenue = revenue; }
}
