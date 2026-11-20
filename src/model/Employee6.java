package model;

/**
 * Lớp thực thể nhân viên (kế thừa Account6)
 */
public class Employee6 extends Account6 {
    private String fullName;
    private String phone;

    public Employee6() { super(); }

    public Employee6(int id, String username, String password, String email,
                     String phoneNumber, String role, String fullName, String phone) {
        super(id, username, password, email, phoneNumber, role);
        this.fullName = fullName;
        this.phone = phone;
    }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}

