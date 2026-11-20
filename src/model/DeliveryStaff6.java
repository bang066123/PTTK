package model;

public class DeliveryStaff6 {
    private int id;
    private String name;
    private String phone;

    public DeliveryStaff6() {}

    public DeliveryStaff6(int id, String name, String phone) {
        this.id = id;
        this.name = name;
        this.phone = phone;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
