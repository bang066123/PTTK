package model;

import java.util.Date;

public class OnlineOrder6 extends Transaction6 {
    private String status;
    private Customer6 customer;
    private WarehouseStaff6 warehouseStaff;
    private DeliveryStaff6 deliveryStaff;
    private Address6 address;

    public OnlineOrder6() {
        super();
    }

    public OnlineOrder6(int id, Date createdDate, float totalAmount, String status,
                        Customer6 customer, WarehouseStaff6 warehouseStaff,
                        DeliveryStaff6 deliveryStaff, Address6 address) {
        super(id, createdDate, totalAmount);
        this.status = status;
        this.customer = customer;
        this.warehouseStaff = warehouseStaff;
        this.deliveryStaff = deliveryStaff;
        this.address = address;
    }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Customer6 getCustomer() { return customer; }
    public void setCustomer(Customer6 customer) { this.customer = customer; }

    public WarehouseStaff6 getWarehouseStaff() { return warehouseStaff; }
    public void setWarehouseStaff(WarehouseStaff6 warehouseStaff) { this.warehouseStaff = warehouseStaff; }

    public DeliveryStaff6 getDeliveryStaff() { return deliveryStaff; }
    public void setDeliveryStaff(DeliveryStaff6 deliveryStaff) { this.deliveryStaff = deliveryStaff; }

    public Address6 getAddress() { return address; }
    public void setAddress(Address6 address) { this.address = address; }
}
