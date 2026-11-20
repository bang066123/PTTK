package model;

import java.util.Date;

public class SaleOrder6 extends Transaction6 {
    private SaleStaff6 saleStaff;
    private Customer6 customer;

    public SaleOrder6() {
        super();
    }

    public SaleOrder6(int id, Date createdDate, float totalAmount, SaleStaff6 saleStaff, Customer6 customer) {
        super(id, createdDate, totalAmount);
        this.saleStaff = saleStaff;
        this.customer = customer;
    }

    public SaleStaff6 getSaleStaff() { return saleStaff; }
    public void setSaleStaff(SaleStaff6 saleStaff) { this.saleStaff = saleStaff; }

    public Customer6 getCustomer() { return customer; }
    public void setCustomer(Customer6 customer) { this.customer = customer; }
}
