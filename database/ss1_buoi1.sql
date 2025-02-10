CREATE DATABASE student_management;
USE student_management;
CREATE TABLE class (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE teacher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    country VARCHAR(50) NOT NULL
);
INSERT INTO class (name)
VALUES 
    ('Lớp 10A'),
    ('Lớp 11B');
INSERT INTO teacher (name, age, country)
VALUES 
    ('Nguyễn Văn A', 40, 'Vietnam'),
    ('Trần Thị B', 30, 'Vietnam');
    SELECT * FROM class;
SELECT * FROM teacher;