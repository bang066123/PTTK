package model;

public class Account6 {
    private int id;
    private String username;
    private String password;
    private String name;
    private String email;
    private String phoneNumber;
    private Address6 address;

    public Account6() {}

    public Account6(int id, String username, String password, String name, String email, String phoneNumber, Address6 address) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getFullName() { return name != null ? name : username; }
    public void setFullName(String fullName) { this.name = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public Address6 getAddress() { return address; }
    public void setAddress(Address6 address) { this.address = address; }
}
