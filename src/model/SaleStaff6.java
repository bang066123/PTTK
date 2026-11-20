package model;

import java.util.Date;

public class SaleStaff6 extends Employee6 {
    public SaleStaff6() {
        super();
    }

    public SaleStaff6(int id, String username, String password, String name, String email,
                      String phoneNumber, Address6 address, Date startDate) {
        super(id, username, password, name, email, phoneNumber, address, startDate);
    }
}
