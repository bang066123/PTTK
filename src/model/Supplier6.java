package model;

/**
 * Lớp thực thể nhà cung cấp
 */
public class Supplier6 {
    private int id;
    private String supplierName;
    private String phone;
    private String email;
    private String description;
    private Address6 address;

    public Supplier6() {}

    public Supplier6(int id, String supplierName, String phone, String email, String description, Address6 address) {
        this.id = id;
        this.supplierName = supplierName;
        this.phone = phone;
        this.email = email;
        this.description = description;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }

    // Alias
    public String getName() { return supplierName; }
    public void setName(String name) { this.supplierName = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Address6 getAddress() { return address; }
    public void setAddress(Address6 address) { this.address = address; }
}

