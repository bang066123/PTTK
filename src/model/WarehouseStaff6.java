package model;

/**
 * Lớp thực thể nhân viên kho (kế thừa Employee6)
 */
public class WarehouseStaff6 extends Employee6 {
    public WarehouseStaff6() { super(); }

    public WarehouseStaff6(int id, String username, String password, String email,
                           String phoneNumber, String fullName, String phone) {
        super(id, username, password, email, phoneNumber, "warehousestaff", fullName, phone);
    }
}

