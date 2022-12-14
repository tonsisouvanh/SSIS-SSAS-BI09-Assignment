use SourceCOVID19
go
update CasesReport
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()

use SourceCOVID19
go
update Compiled_COVID_19_Case_Details_Canada
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()


use SourceCOVID19
go
update ongoing_outbreaks_phu
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()

use SourceCOVID19
go
update [public_health_unit]
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()


use SourceCOVID19
go
update [Public_Health_Units_GROUP]
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()


use SourceCOVID19
go
update vaccines_by_age_phu
set CreatedDate = GETDATE(), UpdatedDate = GETDATE()






-- SELECT STAGE
use StageCOVID19
go
select * from CASESREPORT_STAGE
select * from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE
select * from PUBLIC_HEALTH_UNIT_STAGE
select * from PUBLIC_HEALTH_UNITS_GROUP_STAGE
select * from VACCINES_BY_AGE_PHU_STAGE
select * from ONGOING_OUTBREAKS_PHU_STAGE



---- SELECT NDS
--use NDS
--go

--select * from ChiTietHoaDon where NguonDuLieu = 2
--select * from ChiTietHoaDon where NguonDuLieu = 1
--select * from CuaHang
--select * from HoaDon
--select * from KhachHang
--select * from LoaiCuaHang
--select * from LoaiSanPham
--select * from NguonDuLieu
--select * from Nuoc
--select * from SanPham
--select * from TrangThai


--use DDS
--go
--select * from Dim_ThanhPho 
--select * from Dim_LoaiCuaHang
--select * from Dim_CuaHang 
--select * from Dim_LoaiSanPham
--select * from Dim_SanPham
--select * from Dim_KhachHang where MaKHNK = '008V' and IDNguon = 1
--select * from Dim_KhachHang where IDNguon = 1
--select * from Fact_DoanhThu
--select * from Dim_NgayTrongThang
--select * from Dim_ThangTrongNam

--use Jade
----select *  from KhachHang_Jade where MaKH = '008V'
--update KhachHang_Jade set NgayCapNhat = getdate(),SoThich = 'Badminton', NgheNghiep = 'Power' where MaKH = '008V'


----Drop
--use DDS
--delete Fact_DoanhThu
--delete Dim_CuaHang
--delete Dim_KhachHang
--delete Dim_LoaiCuaHang
--delete Dim_SanPham
--delete Dim_LoaiSanPham
--delete Dim_NgayTrongThang
--delete Dim_ThangTrongNam
--delete Dim_ThanhPho
--delete TestDDS
--DBCC CHECKIDENT ('[Fact_DoanhThu]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_CuaHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_KhachHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_LoaiCuaHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_SanPham]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_LoaiSanPham]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_NgayTrongThang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_ThangTrongNam]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Dim_ThanhPho]', RESEED, 0);
--GO



--use NDS
--delete ChiTietHoaDon
--delete HoaDon
--delete CuaHang
--delete Nuoc
--delete LoaiCuaHang
--delete SanPham
--delete LoaiSanPham
--delete KhachHang
----delete NguonDuLieu
----delete TrangThai
--DBCC CHECKIDENT ('[HoaDon]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[CuaHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[Nuoc]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[LoaiCuaHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[SanPham]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[LoaiSanPham]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[KhachHang]', RESEED, 0);
--GO
--DBCC CHECKIDENT ('[ChiTietHoaDon]', RESEED, 0);
--GO