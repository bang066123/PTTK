CREATE DATABASE IF NOT EXISTS qlst_dien_may CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE qlst_dien_may;

DROP TABLE IF EXISTS tblTransactionDetail6;
DROP TABLE IF EXISTS tblSaleOrder6;
DROP TABLE IF EXISTS tblOnlineOrder6;
DROP TABLE IF EXISTS tblTransaction6;
DROP TABLE IF EXISTS tblImportReceiptDetail6;
DROP TABLE IF EXISTS tblImportReceipt6;
DROP TABLE IF EXISTS tblProduct6;
DROP TABLE IF EXISTS tblSupplier6;
DROP TABLE IF EXISTS tblDeliveryStaff6;
DROP TABLE IF EXISTS tblSaleStaff6;
DROP TABLE IF EXISTS tblWarehouseStaff6;
DROP TABLE IF EXISTS tblManager6;
DROP TABLE IF EXISTS tblEmployee6;
DROP TABLE IF EXISTS tblCustomer6;
DROP TABLE IF EXISTS tblAccount6;
DROP TABLE IF EXISTS tblAddress6;

CREATE TABLE tblAddress6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    houseNumber VARCHAR(255),
    street VARCHAR(255),
    ward VARCHAR(255),
    district VARCHAR(255),
    city VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblAccount6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phoneNumber VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    tblAddress6id INT,
    CONSTRAINT fk_account_address FOREIGN KEY (tblAddress6id) REFERENCES tblAddress6(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblCustomer6 (
    tblAccount6id INT PRIMARY KEY,
    CONSTRAINT fk_customer_account FOREIGN KEY (tblAccount6id) REFERENCES tblAccount6(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblEmployee6 (
    tblAccount6id INT PRIMARY KEY,
    startDate DATE NOT NULL,
    tblManager6id INT NULL,
    CONSTRAINT fk_employee_account FOREIGN KEY (tblAccount6id) REFERENCES tblAccount6(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblManager6 (
    tblEmployee6id INT PRIMARY KEY,
    CONSTRAINT fk_manager_employee FOREIGN KEY (tblEmployee6id) REFERENCES tblEmployee6(tblAccount6id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE tblEmployee6
    ADD CONSTRAINT fk_employee_manager FOREIGN KEY (tblManager6id) REFERENCES tblManager6(tblEmployee6id) ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE tblWarehouseStaff6 (
    tblEmployee6id INT PRIMARY KEY,
    CONSTRAINT fk_warehousestaff_employee FOREIGN KEY (tblEmployee6id) REFERENCES tblEmployee6(tblAccount6id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblSaleStaff6 (
    tblEmployee6id INT PRIMARY KEY,
    CONSTRAINT fk_salestaff_employee FOREIGN KEY (tblEmployee6id) REFERENCES tblEmployee6(tblAccount6id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblDeliveryStaff6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblSupplier6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplierName VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    description VARCHAR(255),
    tblAddress6id INT,
    CONSTRAINT fk_supplier_address FOREIGN KEY (tblAddress6id) REFERENCES tblAddress6(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblProduct6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL,
    stockQuantity INT NOT NULL DEFAULT 0,
    description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblImportReceipt6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importDate DATE NOT NULL,
    tblSupplier6id INT NOT NULL,
    WarehouseStaff6id INT NOT NULL,
    CONSTRAINT fk_importreceipt_supplier FOREIGN KEY (tblSupplier6id) REFERENCES tblSupplier6(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_importreceipt_warehousestaff FOREIGN KEY (WarehouseStaff6id) REFERENCES tblWarehouseStaff6(tblEmployee6id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblImportReceiptDetail6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL,
    tblImportReceipt6id INT NOT NULL,
    tblProduct6id INT NOT NULL,
    CONSTRAINT fk_detail_receipt FOREIGN KEY (tblImportReceipt6id) REFERENCES tblImportReceipt6(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detail_product FOREIGN KEY (tblProduct6id) REFERENCES tblProduct6(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblTransaction6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    createdDate DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblOnlineOrder6 (
    tblTransaction6id INT PRIMARY KEY,
    status VARCHAR(255) NOT NULL DEFAULT 'CHO_DUYET',
    tblCustomer6id INT NOT NULL,
    tblDeliveryStaff6id INT,
    tblAddress6id INT,
    WarehouseStaff6id INT,
    CONSTRAINT fk_onlineorder_trans FOREIGN KEY (tblTransaction6id) REFERENCES tblTransaction6(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_onlineorder_customer FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(tblAccount6id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_onlineorder_delivery FOREIGN KEY (tblDeliveryStaff6id) REFERENCES tblDeliveryStaff6(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_onlineorder_address FOREIGN KEY (tblAddress6id) REFERENCES tblAddress6(id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_onlineorder_warehouse FOREIGN KEY (WarehouseStaff6id) REFERENCES tblWarehouseStaff6(tblEmployee6id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblSaleOrder6 (
    tblTransaction6id INT PRIMARY KEY,
    tblCustomer6id INT NULL,
    SaleStaff6id INT NOT NULL,
    CONSTRAINT fk_saleorder_trans FOREIGN KEY (tblTransaction6id) REFERENCES tblTransaction6(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_saleorder_customer FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(tblAccount6id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_saleorder_salestaff FOREIGN KEY (SaleStaff6id) REFERENCES tblSaleStaff6(tblEmployee6id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblTransactionDetail6 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL,
    tblProduct6id INT NOT NULL,
    tblTransaction6id INT NOT NULL,
    CONSTRAINT fk_transdetail_product FOREIGN KEY (tblProduct6id) REFERENCES tblProduct6(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transdetail_trans FOREIGN KEY (tblTransaction6id) REFERENCES tblTransaction6(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO tblAddress6 (id, houseNumber, street, ward, district, city) VALUES
(1, 'Số 10', 'Trần Phú', 'Mộ Lao', 'Hà Đông', 'Hà Nội'),
(2, 'Số 88', 'Cầu Giấy', 'Dịch Vọng', 'Cầu Giấy', 'TP.HCM'),
(3, 'Lô 4', 'KCN', 'Mỹ Đình', 'Nam Từ Liêm', 'Hà Nội'),
(4, 'Số 25', 'Nguyễn Trãi', 'Thanh Xuân Trung', 'Thanh Xuân', 'Hà Nội'),
(5, 'Số 102', 'Lê Lợi', 'Bến Nghé', 'Quận 1', 'TP. Hồ Chí Minh');

INSERT INTO tblAccount6 (id, username, password, email, phoneNumber, name, address, tblAddress6id) VALUES
(1, 'admin', 'admin123', 'admin@sieuthidienmay.com', '0901234567', 'Nguyễn Văn Quản Lí', 'Hà Nội', 4),
(2, 'warehousestaff', 'ws123', 'kho@sieuthidienmay.com', '0987654321', 'Trần Văn Kho', 'Hà Nội', 1),
(3, 'salestaff', 'sale123', 'banhang@sieuthidienmay.com', '0912345678', 'Lê Thị Bán Hàng', 'Hà Nội', 2),
(4, 'khachhang', 'kh123', 'customer@gmail.com', '0933333333', 'Phạm Khách Hàng', 'Hà Nội', 5);

INSERT INTO tblCustomer6 (tblAccount6id) VALUES (4);

INSERT INTO tblEmployee6 (tblAccount6id, startDate, tblManager6id) VALUES (1, '2023-01-15', NULL);
INSERT INTO tblManager6 (tblEmployee6id) VALUES (1);
UPDATE tblEmployee6 SET tblManager6id = 1 WHERE tblAccount6id = 1;

INSERT INTO tblEmployee6 (tblAccount6id, startDate, tblManager6id) VALUES (2, '2023-06-01', 1);
INSERT INTO tblWarehouseStaff6 (tblEmployee6id) VALUES (2);

INSERT INTO tblEmployee6 (tblAccount6id, startDate, tblManager6id) VALUES (3, '2023-09-01', 1);
INSERT INTO tblSaleStaff6 (tblEmployee6id) VALUES (3);

INSERT INTO tblDeliveryStaff6 (id, name, phone) VALUES
(1, 'Hoàng Văn Giao', '0944444444'),
(2, 'Vũ Đình Vận', '0955555555');

INSERT INTO tblSupplier6 (id, supplierName, phone, email, description, tblAddress6id) VALUES
(1, 'Công ty Samsung', '024-383838', 'contact@samsung.com.vn', 'Phân phối TV, Tủ lạnh, Máy giặt Samsung chính hãng', 1),
(2, 'Công ty Sony', '028-393939', 'support@sony.com.vn', 'Nhà phân phối âm thanh, TV Sony', 2),
(3, 'Tập đoàn LG', '024-373737', 'info@lge.com.vn', 'Cung cấp thiết bị gia dụng và điện lạnh LG', 3);

INSERT INTO tblProduct6 (id, name, price, stockQuantity, description) VALUES
(1, 'Smart Tivi Samsung 55 inch Crystal UHD', 12500000, 25, 'Độ phân giải 4K, HDR10+, Smart Tizen OS, bảo hành 24 tháng.'),
(2, 'Smart Tivi Sony 4K 65 inch', 18200000, 14, 'Màn hình 4K HDR, âm thanh vòm Dolby Atmos, Google TV.'),
(3, 'Android Tivi Casper 43 inch', 6800000, 30, 'Độ phân giải Full HD, hệ điều hành Android, thiết kế tràn viền.'),
(4, 'Smart Tivi Samsung QLED 4K 65 inch', 22900000, 20, 'Bộ xử lý Quantum 4K Lite, Quantum HDR 100% dải màu'),
(5, 'Tủ lạnh Samsung Inverter 380L', 16000000, 15, 'Công nghệ SpaceMax, làm lạnh vòm All-around Cooling.'),
(6, 'Tủ lạnh Samsung Inverter 236 lít RT22FARBDSA', 6290000, 30, 'Digital Inverter tiết kiệm điện, bộ lọc khử mùi Deodorizer'),
(7, 'Máy giặt Samsung EcoBubble 9.5 kg WW95TA046AX', 8990000, 18, 'Giặt bong bóng siêu mịn EcoBubble, diệt khuẩn hơi nước.'),
(8, 'Smart Tivi LG 4K 55 inch NanoCell 55NANO76SQA', 13900000, 25, 'Bộ xử lý α5 Gen5 AI 4K, công nghệ màu NanoCell chân thực');

INSERT INTO tblImportReceipt6 (id, importDate, tblSupplier6id, WarehouseStaff6id) VALUES
(1, '2026-02-15', 1, 2),
(5, '2026-04-28', 1, 2),
(12, '2026-08-10', 1, 2),
(2, '2026-03-20', 2, 2),
(3, '2026-05-15', 3, 2);

INSERT INTO tblImportReceiptDetail6 (id, quantity, unitPrice, tblImportReceipt6id, tblProduct6id) VALUES
(1, 20, 10500000, 1, 1),
(2, 15, 16000000, 1, 5),
(3, 10, 18200000, 5, 2),
(4, 25, 12500000, 12, 1);

INSERT INTO tblTransaction6 (id, createdDate) VALUES
(1, '2026-03-20'),
(2, '2026-03-22');

INSERT INTO tblSaleOrder6 (tblTransaction6id, tblCustomer6id, SaleStaff6id) VALUES
(1, 4, 3);
INSERT INTO tblTransactionDetail6 (id, quantity, unitPrice, tblProduct6id, tblTransaction6id) VALUES
(1, 1, 12500000, 1, 1);

INSERT INTO tblOnlineOrder6 (tblTransaction6id, status, tblCustomer6id, tblDeliveryStaff6id, tblAddress6id, WarehouseStaff6id) VALUES
(2, 'DA_DUYET', 4, 1, 5, 2);
INSERT INTO tblTransactionDetail6 (id, quantity, unitPrice, tblProduct6id, tblTransaction6id) VALUES
(2, 1, 6290000, 3, 2);
