package model;

import java.util.Date;

public class Manager6 extends Employee6 {
    public Manager6() {
        super();
    }

    public Manager6(int id, String username, String password, String name, String email,
                    String phoneNumber, Address6 address, Date startDate) {
        super(id, username, password, name, email, phoneNumber, address, startDate);
    }
}
