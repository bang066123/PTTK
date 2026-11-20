package model;

import java.util.Date;

public class Employee6 extends Account6 {
    private Date startDate;

    public Employee6() {
        super();
    }

    public Employee6(int id, String username, String password, String name, String email,
                     String phoneNumber, Address6 address, Date startDate) {
        super(id, username, password, name, email, phoneNumber, address);
        this.startDate = startDate;
    }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
}
