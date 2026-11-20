package model;

import java.util.Date;

public class WarehouseStaff6 extends Employee6 {
    public WarehouseStaff6() {
        super();
    }

    public WarehouseStaff6(int id, String username, String password, String name, String email,
                          String phoneNumber, Address6 address, Date startDate) {
        super(id, username, password, name, email, phoneNumber, address, startDate);
    }
}
