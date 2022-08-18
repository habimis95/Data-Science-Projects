CREATE DATABASE QuanLySinhVien

CREATE TABLE Khoa(
	KhoaID  CHAR(2) PRIMARY KEY,
	TenKhoa VARCHAR(50)
)

ALTER TABLE khoa
ALTER COLUMN TenKhoa NVARCHAR(50)

CREATE TABLE MonHoc(
	MonHocID  CHAR(2) PRIMARY KEY,
	TenMonHoc VARCHAR(50)
)


CREATE TABLE SinhVien(
	SinhVienID  CHAR(3) PRIMARY KEY,
	HoSinhVien VARCHAR(30),
	TenSinhVien VARCHAR(20),
	NgaySinh DATETIME,
	GioiTinh BIT,
	DiaChi VARCHAR(50),
	HocBong INT,
	KhoaID CHAR(2)
	
)

CREATE TABLE KetQua(
	SinhVienID CHAR(3),
	MonHocID CHAR(2),
	Diem REAL,
	PRIMARY KEY(SinhVienID, MonHocID)
)


INSERT INTO khoa(KhoaID, TenKhoa)
VALUES ('CN,'Khoa Công Nghệ Thông Tin') 


