CREATE DATABASE student_management;
USE student_management;
CREATE TABLE Class (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Teacher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    country VARCHAR(50) NOT NULL
);
INSERT INTO Class (name)
VALUES 
    ('Lớp 10A'),
    ('Lớp 11B');
INSERT INTO Teacher (name, age, country)
VALUES 
    ('Nguyễn Văn A', 40, 'Vietnam'),
    ('Trần Thị B', 30, 'Vietnam');
    SELECT * FROM Class;
SELECT * FROM Teacher;