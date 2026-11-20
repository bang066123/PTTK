package model;

public class CustomerStat6 extends Customer6 {
    private int transactionCount;
    private float revenue;

    public CustomerStat6() {
        super();
    }

    public CustomerStat6(int id, String username, String password, String name, String email,
                         String phoneNumber, Address6 address, int transactionCount, float revenue) {
        super(id, username, password, name, email, phoneNumber, address);
        this.transactionCount = transactionCount;
        this.revenue = revenue;
    }

    public int getTransactionCount() { return transactionCount; }
    public void setTransactionCount(int transactionCount) { this.transactionCount = transactionCount; }

    public float getRevenue() { return revenue; }
    public void setRevenue(float revenue) { this.revenue = revenue; }
}
