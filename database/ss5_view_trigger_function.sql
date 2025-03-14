CREATE DATABASE IF NOT EXISTS demo;
USE demo;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50),
    productName VARCHAR(100),
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription VARCHAR(255),
    productStatus VARCHAR(10) 
);
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES 
    ('P001', 'Laptop Dell XPS', 1200.00, 10, 'Laptop cao cấp', 'active'),
    ('P002', 'iPhone 13', 999.99, 20, 'Điện thoại thông minh', 'active'),
    ('P003', 'Samsung TV', 799.50, 5, 'Smart TV 4K', 'inactive'),
    ('P004', 'Sony Headphones', 199.99, 30, 'Tai nghe không dây', 'active');
    
    
CREATE UNIQUE INDEX i_productCode ON Products(productCode);

CREATE INDEX i_name_price ON Products(productName, productPrice);
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'Laptop Dell XPS' AND productPrice = 1200.00;

CREATE VIEW product_view AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

ALTER VIEW product_view AS
SELECT productCode, productName, productPrice, productStatus, productAmount
FROM Products;

DROP VIEW IF EXISTS product_view;


DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;
-- them san pham moi  
DELIMITER //
CREATE PROCEDURE AddProduct(
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description VARCHAR(255),
    IN p_status VARCHAR(10)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_description, p_status);
END //
DELIMITER ;
-- SP sửa thông tin sản phẩm
DELIMITER //
CREATE PROCEDURE UpdateProduct(
    IN p_id INT,
    IN p_code VARCHAR(50),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10,2),
    IN p_amount INT,
    IN p_description VARCHAR(255),
    IN p_status VARCHAR(10)
)
BEGIN
    UPDATE Products 
    SET productCode = p_code,
        productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_description,
        productStatus = p_status
    WHERE Id = p_id;
END //
DELIMITER ;

-- SP xóa sản phẩm
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN p_id INT)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //
DELIMITER ;
