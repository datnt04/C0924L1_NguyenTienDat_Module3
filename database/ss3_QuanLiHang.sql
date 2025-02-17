create database quan_li_hang;
use quan_li_hang;
CREATE TABLE customer (
    c_id INT PRIMARY KEY,
    name VARCHAR(25),
    c_age TINYINT
);

INSERT INTO customer (c_id, name, c_age) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 30),
(3, 'Hong Ha', 50);

CREATE TABLE `order` (
    o_id INT PRIMARY KEY,
    c_id INT,
    o_date DATETIME,
    o_total_price INT,
    FOREIGN KEY (c_id) REFERENCES customer(c_id)
);

INSERT INTO `order` (o_id, c_id, o_date, o_total_price) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

CREATE TABLE product (
    p_id INT PRIMARY KEY,
    p_name VARCHAR(25),
    p_price INT
);

INSERT INTO product (p_id, p_name, p_price) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 7),
(3, 'Dieu Hoa', 5),
(4, 'Quat', 2),
(5, 'Bep Dien', 6);

CREATE TABLE order_detail (
    o_id INT,
    p_id INT,
    od_qty INT,
    FOREIGN KEY (o_id) REFERENCES `order`(o_id),
    FOREIGN KEY (p_id) REFERENCES product(p_id)
);

INSERT INTO order_detail (o_id, p_id, od_qty) VALUES
(1, 1, 2),
(1, 3, 4),
(2, 2, 1),
(2, 5, 3),
(3, 1, 1),
(3, 4, 2);
SELECT o.o_id, o.o_date, o.o_total_price
FROM `order` o;


SELECT c.name, p.p_name
FROM customer c
JOIN `order` o ON c.c_id = o.c_id
JOIN order_detail od ON o.o_id = od.o_id
JOIN product p ON od.p_id = p.p_id
GROUP BY c.name, p.p_name;

SELECT DISTINCT c.name
FROM customer c
INNER JOIN `order` o ON c.c_id = o.c_id
INNER JOIN order_detail od ON o.o_id = od.o_id;

select o.o_id, o.o_date, 
       sum(od.od_qty * p.p_price) as total_price
from `order` o
join order_detail od on o.o_id = od.o_id
join product p on od.p_id = p.p_id
group by o.o_id, o.o_date;

