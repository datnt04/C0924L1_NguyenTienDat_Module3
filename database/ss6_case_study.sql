CREATE DATABASE case_study;
USE case_study;
CREATE TABLE vi_tri (
    ma_vi_tri INT PRIMARY KEY,
    ten_vi_tri VARCHAR(45)
);

CREATE TABLE trinh_do (
    ma_trinh_do INT PRIMARY KEY,
    ten_trinh_do VARCHAR(45)
);

CREATE TABLE bo_phan (
    ma_bo_phan INT PRIMARY KEY,
    ten_bo_phan VARCHAR(45)
);

CREATE TABLE kieu_thue (
    ma_kieu_thue INT PRIMARY KEY,
    ten_kieu_thue VARCHAR(45)
);

CREATE TABLE loai_dich_vu (
    ma_loai_dich_vu INT PRIMARY KEY,
    ten_loai_dich_vu VARCHAR(45)
);

CREATE TABLE dich_vu_di_kem (
    ma_dich_vu_di_kem INT PRIMARY KEY,
    ten_dich_vu_di_kem VARCHAR(45),
    don_vi VARCHAR(45),
    gia DOUBLE
);

CREATE TABLE dich_vu (
    ma_dich_vu INT PRIMARY KEY,
    ten_dich_vu VARCHAR(45),
    dien_tich INT,
    chi_phi_thue DOUBLE,
    so_nguoi_toi_da INT,
    ma_loai_dich_vu INT,
    ma_kieu_thue INT,
    FOREIGN KEY (ma_loai_dich_vu) REFERENCES loai_dich_vu(ma_loai_dich_vu),
    FOREIGN KEY (ma_kieu_thue) REFERENCES kieu_thue(ma_kieu_thue)
);

CREATE TABLE nhan_vien (
    ma_nhan_vien INT PRIMARY KEY,
    ho_ten VARCHAR(45),
    ngay_sinh DATE,
    so_cmnd VARCHAR(45),
    luong DOUBLE,
    so_dien_thoai VARCHAR(45),
    email VARCHAR(45),
    ma_vi_tri INT,
    ma_trinh_do INT,
    ma_bo_phan INT,
    FOREIGN KEY (ma_vi_tri) REFERENCES vi_tri(ma_vi_tri),
    FOREIGN KEY (ma_trinh_do) REFERENCES trinh_do(ma_trinh_do),
    FOREIGN KEY (ma_bo_phan) REFERENCES bo_phan(ma_bo_phan)
);

CREATE TABLE loai_khach (
    ma_loai_khach INT PRIMARY KEY,
    ten_loai_khach VARCHAR(45)
);

CREATE TABLE khach_hang (
    ma_khach_hang INT PRIMARY KEY,
    ma_loai_khach INT,
    ho_ten VARCHAR(45),
    ngay_sinh DATE,
    gioi_tinh BIT(1),
    so_cmnd VARCHAR(45),
    so_dien_thoai VARCHAR(45),
    email VARCHAR(45),
    dia_chi VARCHAR(45),
    FOREIGN KEY (ma_loai_khach) REFERENCES loai_khach(ma_loai_khach)
);

CREATE TABLE hop_dong (
    ma_hop_dong INT PRIMARY KEY,
    ngay_bat_dau DATE,
    ngay_ket_thuc DATE,
    tien_coc DOUBLE,
    tong_tien DOUBLE,
    ma_khach_hang INT,
    ma_dich_vu INT,
    FOREIGN KEY (ma_khach_hang) REFERENCES khach_hang(ma_khach_hang),
    FOREIGN KEY (ma_dich_vu) REFERENCES dich_vu(ma_dich_vu)
);

CREATE TABLE hop_dong_chi_tiet (
    ma_hop_dong_chi_tiet INT PRIMARY KEY,
    ma_hop_dong INT,
    ma_dich_vu_di_kem INT,
    so_luong INT,
    FOREIGN KEY (ma_hop_dong) REFERENCES hop_dong(ma_hop_dong),
    FOREIGN KEY (ma_dich_vu_di_kem) REFERENCES dich_vu_di_kem(ma_dich_vu_di_kem)
);
-- insert
INSERT INTO vi_tri VALUES
(1, 'Lễ tân'),
(2, 'Phục vụ'), 
(3, 'Chuyên viên'), 
(4, 'Giám sát'), 
(5, 'Quản lý'), 
(6, 'Giám đốc');

INSERT INTO trinh_do VALUES
(1, 'Trung cấp'), 
(2, 'Cao đẳng'), 
(3, 'Đại học'), 
(4, 'Sau đại học');

INSERT INTO bo_phan VALUES
(1, 'Sale – Marketing'), 
(2, 'Hành Chính'), 
(3, 'Phục vụ'), 
(4, 'Quản lý');

INSERT INTO kieu_thue VALUES
(1, 'Theo giờ'), 
(2, 'Theo ngày'), 
(3, 'Theo tháng'), 
(4, 'Theo năm');

INSERT INTO loai_dich_vu VALUES
(1, 'Villa'), 
(2, 'House'), 
(3, 'Room');

INSERT INTO dich_vu_di_kem VALUES
(1, 'Massage', 'Lượt', 500000), 
(2, 'Karaoke', 'Giờ', 100000), 
(3, 'Thức ăn', 'Suất', 200000), 
(4, 'Nước uống', 'Ly', 50000), 
(5, 'Thuê xe', 'Ngày', 700000);


INSERT INTO nhan_vien VALUES
(1, 'Nguyễn Tiến Đạt', '1990-05-15', '123456789', 20000000, '0912345678', 'tien.dat@example.com', 3, 2, 1),
(2, 'Nguyễn Thị Lan', '1992-08-20', '987654321', 18000000, '0934567890', 'thi.lan@example.com', 2, 3, 2),
(3, 'Trần Văn Hoàng', '1985-12-30', '654987321', 25000000, '0903456789', 'hoang.tran@example.com', 5, 3, 4),
(4, 'Lê Thị Mai', '1993-06-18', '852963741', 17000000, '0976543210', 'mai.le@example.com', 1, 2, 3),
(5, 'Phạm Hữu Nghĩa', '1988-07-21', '963852741', 23000000, '0912340000', 'nghia.pham@example.com', 4, 4, 1),
(6, 'Hương', '1988-07-21', '963852741', 23000000, '0912340000', 'nghia.pham@example.com', 4, 4, 1);

INSERT INTO loai_khach VALUES
(1, 'Diamond'), 
(2, 'Platinum'), 
(3, 'Gold'), 
(4, 'Silver'), 
(5, 'Member');

INSERT INTO khach_hang VALUES
(1, 1, 'Nguyễn Văn Hùng', '1985-06-12', 1, '123654789', '0987654321', 'hung.nguyen@example.com', 'Đà Nẵng'),
(2, 2, 'Trần Thị Thu', '1990-09-18', 0, '987123654', '0976543210', 'thu.tran@example.com', 'Hà Nội'),
(3, 3, 'Lê Minh Tuấn', '1992-03-25', 1, '321654987', '0965234789', 'tuan.le@example.com', 'Hải Phòng'),
(4, 4, 'Phạm Thị Hồng', '1987-07-09', 0, '741852963', '0956321478', 'hong.pham@example.com', 'Quảng Trị'),
(5, 5, 'Hoàng Văn Nam', '1995-11-30', 1, '852963741', '0987412356', 'nam.hoang@example.com', 'Huế');

INSERT INTO dich_vu VALUES
(1, 'Villa Biển', 120, 5000000, 6, 1, 4),
(2, 'House Garden', 80, 3000000, 4, 2, 3),
(3, 'Deluxe Room', 40, 1500000, 2, 3, 2),
(4, 'Penthouse Luxury', 150, 8000000, 8, 1, 4),
(5, 'Standard House', 70, 2500000, 3, 2, 3),
(6, 'Suite Room', 50, 2000000, 2, 3, 2);

INSERT INTO hop_dong VALUES
(1, '2024-01-01', '2024-06-30', 1000000, 7000000, 1, 1),
(2, '2024-02-10', '2024-08-10', 1500000, 9000000, 2, 2),
(3, '2024-03-15', '2024-09-15', 2000000, 12000000, 3, 3),
(4, '2024-04-20', '2024-10-20', 2500000, 15000000, 4, 4),
(5, '2024-05-25', '2024-11-25', 3000000, 18000000, 5, 5);


INSERT INTO hop_dong_chi_tiet VALUES
(1, 1, 1, 2),
(2, 2, 3, 4),
(3, 3, 5, 1);

-- câu 2
SELECT * 
FROM nhan_vien
WHERE (ho_ten LIKE 'H%' OR ho_ten LIKE 'T%' OR ho_ten LIKE 'K%')
AND LENGTH(ho_ten) <= 15;



-- cau 3

SELECT * 
FROM khach_hang
WHERE (YEAR(CURDATE()) - YEAR(ngay_sinh)) BETWEEN 18 AND 50
AND (dia_chi = 'Đà Nẵng' OR dia_chi = 'Quảng Trị');

-- cau 4
SELECT kh.ma_khach_hang, kh.ho_ten, COUNT(hd.ma_hop_dong) AS so_lan_dat_phong
FROM khach_hang kh
JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
WHERE lk.ten_loai_khach = 'Diamond'
GROUP BY kh.ma_khach_hang, kh.ho_ten
ORDER BY so_lan_dat_phong ASC;

-- cau5 
SELECT 
    kh.ma_khach_hang, 
    kh.ho_ten, 
    lk.ten_loai_khach, 
    hd.ma_hop_dong, 
    dv.ten_dich_vu, 
    hd.ngay_bat_dau AS ngay_lam_hop_dong, 
    hd.ngay_ket_thuc, 
    (dv.chi_phi_thue + IFNULL(SUM(hdct.so_luong * dvdk.gia), 0)) AS tong_tien
FROM khach_hang kh
LEFT JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
LEFT JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
LEFT JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
LEFT JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY kh.ma_khach_hang, kh.ho_ten, lk.ten_loai_khach, hd.ma_hop_dong, dv.ten_dich_vu, hd.ngay_bat_dau, hd.ngay_ket_thuc, dv.chi_phi_thue
ORDER BY kh.ma_khach_hang;
-- cau 6

SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue, ldv.ten_loai_dich_vu
FROM dich_vu dv
JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
LEFT JOIN hop_dong hd ON dv.ma_dich_vu = hd.ma_dich_vu 
    AND YEAR(hd.ngay_bat_dau) = 2021 
    AND MONTH(hd.ngay_bat_dau) BETWEEN 1 AND 3
WHERE hd.ma_hop_dong IS NULL;

-- cau 7
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.so_nguoi_toi_da, dv.chi_phi_thue, ldv.ten_loai_dich_vu
FROM dich_vu dv
JOIN loai_dich_vu ldv ON dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
JOIN hop_dong hd_2020 ON dv.ma_dich_vu = hd_2020.ma_dich_vu AND YEAR(hd_2020.ngay_bat_dau) = 2020
LEFT JOIN hop_dong hd_2021 ON dv.ma_dich_vu = hd_2021.ma_dich_vu AND YEAR(hd_2021.ngay_bat_dau) = 2021
WHERE hd_2021.ma_hop_dong IS NULL;

-- cau 8 
SELECT DISTINCT ho_ten FROM khach_hang;
SELECT ho_ten FROM khach_hang GROUP BY ho_ten;
SELECT ho_ten FROM khach_hang kh1
WHERE NOT EXISTS (
    SELECT 1 FROM khach_hang kh2 WHERE kh1.ho_ten = kh2.ho_ten AND kh1.ma_khach_hang > kh2.ma_khach_hang
);

-- cau 9
SELECT 
    MONTH(hd.ngay_bat_dau) AS thang, 
    COUNT(DISTINCT hd.ma_khach_hang) AS so_luong_khach_hang,
    SUM(hd.tong_tien) AS doanh_thu
FROM hop_dong hd
WHERE YEAR(hd.ngay_bat_dau) = 2021
GROUP BY MONTH(hd.ngay_bat_dau)
ORDER BY thang;

-- cau 10 
SELECT 
    hd.ma_hop_dong, 
    hd.ngay_bat_dau AS ngay_lam_hop_dong, 
    hd.ngay_ket_thuc, 
    hd.tien_coc, 
    IFNULL(SUM(hdct.so_luong), 0) AS so_luong_dich_vu_di_kem
FROM hop_dong hd
LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
GROUP BY hd.ma_hop_dong, hd.ngay_bat_dau, hd.ngay_ket_thuc, hd.tien_coc
ORDER BY hd.ma_hop_dong;




