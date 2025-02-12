create database don_hang1;
use don_hang1;
CREATE TABLE phieu_xuat (
    so_px INT PRIMARY KEY,
    ngay_xuat DATE
);
CREATE TABLE phieu_nhap (
    so_pn INT PRIMARY KEY,
    ngay_nhap DATE
);
CREATE TABLE vat_tu (
    ma_vtu INT PRIMARY KEY,
    ten_vtu VARCHAR(100),
    dg_nhap DECIMAL(10, 2),
    sl_nhap INT
);
CREATE TABLE chi_tiet_phieu_xuat (
    so_px INT,
    ma_vtu INT,
    sl_xuat INT,
    PRIMARY KEY (so_px, ma_vtu),
    FOREIGN KEY (so_px) REFERENCES phieu_xuat(so_px),
    FOREIGN KEY (ma_vtu) REFERENCES vat_tu(ma_vtu)
);
CREATE TABLE chi_tiet_phieu_nhap (
    so_pn INT,
    ma_vtu INT,
    sl_nhap INT,
    PRIMARY KEY (so_pn, ma_vtu),
    FOREIGN KEY (so_pn) REFERENCES phieu_nhap(so_pn),
    FOREIGN KEY (ma_vtu) REFERENCES vat_tu(ma_vtu)
);
CREATE TABLE don_hang (
    so_dh INT PRIMARY KEY,
    ngay_dh DATE
);
CREATE TABLE chi_tiet_don_hang (
    so_dh INT,
    ma_vtu INT,
    sl_xuat INT,
    PRIMARY KEY (so_dh, ma_vtu),
    FOREIGN KEY (so_dh) REFERENCES don_hang(so_dh),
    FOREIGN KEY (ma_vtu) REFERENCES vat_tu(ma_vtu)
);
CREATE TABLE nha_cc (
    ma_ncc INT PRIMARY KEY,
    ten_ncc VARCHAR(100),
    dia_chi VARCHAR(100),
    sdt VARCHAR(20)
);
CREATE TABLE cung_cap (
    ma_ncc INT,
    ma_vtu INT,
    PRIMARY KEY (ma_ncc, ma_vtu),
    FOREIGN KEY (ma_ncc) REFERENCES nha_cc(ma_ncc),
    FOREIGN KEY (ma_vtu) REFERENCES vat_tu(ma_vtu)
);


