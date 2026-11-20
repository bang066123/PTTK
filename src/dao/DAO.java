package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Lớp DAO cơ sở — quản lí kết nối JDBC dùng chung cho toàn hệ thống.
 * Các lớp DAO cụ thể kế thừa lớp này để tái sử dụng kết nối.
 */
public class DAO {
    protected Connection con;

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/qlst_dien_may";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "password";
    private static final String DB_DRIVER   = "com.mysql.cj.jdbc.Driver";

    /**
     * Khởi tạo DAO: nạp driver và mở kết nối CSDL
     */
    public DAO() {
        try {
            Class.forName(DB_DRIVER);
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Không tìm thấy JDBC driver: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối CSDL: " + e.getMessage());
        }
    }

    /**
     * Đóng kết nối CSDL
     */
    public void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            System.err.println("Lỗi đóng kết nối: " + e.getMessage());
        }
    }

    public Connection getCon() { return con; }
}

