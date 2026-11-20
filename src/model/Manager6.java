package model;

/**
 * Lớp thực thể nhân viên quản lí (kế thừa Employee6)
 */
public class Manager6 extends Employee6 {
    public Manager6() { super(); }

    public Manager6(int id, String username, String password, String email,
                    String phoneNumber, String fullName, String phone) {
        super(id, username, password, email, phoneNumber, "manager", fullName, phone);
    }
}

