CREATE DATABASE QuanLySinhVien

CREATE TABLE Khoa(
	KhoaID  CHAR(2) PRIMARY KEY,
	TenKhoa VARCHAR(50)
)

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
VALUES ('CN','Khoa Công Nghệ Thông Tin'),
		 ('TO','Khoa Toán'),
		 ('VL','Khoa Lý') ; 

INSERT INTO monhoc(MonHocID, TenMonHoc)
VALUES ('CO','Cơ Lý Thuyết'),
		 ('CS','Cơ Sở Dữ Liệu'),
		 ('CT','Cấu Trúc Dữ Liệu'),
		 ('LT','Lượng Tử'),
		 ('RR','Toán Rời Rạc'),
		 ('TC','Toán Cao Cấp'),
		 ('TT','Trí Tuệ Nhân Tạo'); 

INSERT INTO SinhVien(SinhVienID, HoSinhVien, TenSinhVien, NgaySinh, GioiTinh, HocBong, KhoaID)
VALUES ('C00','Nguyễn Thị','Trang','1991-08-13',False,'100000','CN'),
		 ('C01','Hà','Tuấn','1991-02-24',True,'0','CN'),
		 ('C02','Trần Ngọc','Hòa','1990-06-11',False,'120000','CN'),
		 ('C03','Bùi Thị','Thảo','1990-02-26',False,'100000','CN'),
		 ('C04','Nguyễn Hoàng','Hưng','1990-03-19',True,'150000','CN'),
		 ('T00','Lê','Tuấn','1991-02-15',True,'0','TO'),
		 ('T01','Bùi Minh','Khánh','1990-04-09',True,'120000','TO'),
		 ('T02','Trần Thị','Lan','1990-03-04',False,'100000','TO'),
		 ('T03','Lê','Thiện','1991-05-18',True,'0','TO'),
		 ('T04','Lê Thị','Thảo','1991-03-27',False,'120000','TO'); 
		 
INSERT INTO ketqua(SinhVienID, MonHocID, Diem)
VALUES('C00','CS',10),
		('C00','CT',9),
		('C00','TT',7),
		('C00','RR',8.5),
		('C01','CS',7),
		('C01','CT',6),
		('C01','TT',7),
		('C01','RR',9),
		('C02','CS',7.5),
		('C02','CT',4),
		('C02','TT',5),
		('C02','RR',3),
		('C03','CS',9),
		('C03','CT',1),
		('C03','TT',8.5),
		('C03','RR',9),
		('C04','CS',2),
		('C04','CT',1);
		
#4. Truy vấn dữ liệu trên một bảng
#a.
SELECT sinhvienID AS 'Mã', HoSinhVien AS 'Họ tên', NgaySinh AS 'Ngày sinh', GioiTinh AS 'Giới tính', HocBong AS 'Học bổng'
FROM sinhvien
#b. 
SELECT sinhvienID AS 'Mã', HoSinhVien AS 'Họ tên', NgaySinh AS 'Ngày sinh', GioiTinh AS 'Giới tính', HocBong AS 'Học bổng'
FROM sinhvien
WHERE KhoaID='CN' AND HocBong>'3000000'
#c.
SELECT sinhvienID AS 'Mã', HoSinhVien AS 'Họ tên', NgaySinh AS 'Ngày sinh', GioiTinh AS 'Giới tính', HocBong AS 'Học bổng'
FROM sinhvien
WHERE HocBong BETWEEN '100000' AND  '120000'
#d. 
SELECT sinhvienID AS 'Mã', HoSinhVien AS 'Họ tên', NgaySinh AS 'Ngày sinh', GioiTinh AS 'Giới tính', HocBong AS 'Học bổng'
FROM sinhvien
WHERE HocBong >'0' AND NgaySinh BETWEEN '1990-06-01' AND '1991-06-30'
#e
SELECT  *
FROM sinhvien
LIMIT 10

#5. Truy vấn cập nhật dữ liệu
#a.
UPDATE sinhvien 
SET NgaySinh = '1980-07-05'
WHERE HoSinhVien='Hà' AND  TenSinhVien='Tuấn'
#b.
UPDATE sinhvien
SET HocBong=(HocBong + HocBong*0.05)
WHERE KhoaId='CN' AND HocBong>0
#c.
UPDATE sinhvien
SET HocBong=50000
WHERE GioiTinh=FALSE AND HocBong='0' AND KhoaID='CN'
#d.
UPDATE ketqua
SET Diem=(Diem + 5)
WHERE MonHocID='TT'
#e.
#f.
#g.
#h.
