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
select distinct GENDER from CASESREPORT_STAGE --age
select distinct OUTCOME from CASESREPORT_STAGE --age
select distinct CASEACQUISITION_INFO from CASESREPORT_STAGE --age

select distinct GENDER from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct CASE_STATUS from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct EXPOSURE from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age

use StageCOVID19
go
select * from CASESREPORT_STAGE --age
select * from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select * from PUBLIC_HEALTH_UNIT_STAGE 
select * from PUBLIC_HEALTH_UNITS_GROUP_STAGE
select distinct AGE_GROUP from VACCINES_BY_AGE_PHU_STAGE --age
select * from ONGOING_OUTBREAKS_PHU_STAGE





-- SELECT NDS
use NDSCovid19
go
select * from PHU_GROUP
select a.PHU_CITY, b.GROUP_NAME from PHU_CITY a, PHU_GROUP b where a.PHU_GROUP_ID = b.ID
select * from PUBLIC_HEALTH_UNIT order by PHU_NAME
select * from OUTBREAK_GROUP
select * from AGE_GROUP
select * from VACCINES_BY_AGE_PHU

select * from OUTCOME
select * from EXPOSURE
select * from GENDER
select * from COVID19_CASESREPORT_DETAIL



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



use NDSCovid19
delete OUTBREAK_GROUP
delete VACCINES_BY_AGE_PHU
delete OUTCOME
delete GENDER
delete EXPOSURE
delete PUBLIC_HEALTH_UNIT
delete PHU_CITY
delete PHU_GROUP
delete AGE_GROUP

DBCC CHECKIDENT ('PUBLIC_HEALTH_UNIT', RESEED, 0);
GO
DBCC CHECKIDENT ('PHU_CITY', RESEED, 0);
GO
DBCC CHECKIDENT ('PHU_GROUP', RESEED, 0);
GO

DBCC CHECKIDENT ('OUTBREAK_GROUP', RESEED, 0);
GO
DBCC CHECKIDENT ('VACCINES_BY_AGE_PHU', RESEED, 0);
GO

DBCC CHECKIDENT ('OUTCOME', RESEED, 0);
GO
DBCC CHECKIDENT ('EXPOSURE', RESEED, 0);
GO
DBCC CHECKIDENT ('GENDER', RESEED, 0);
GO
DBCC CHECKIDENT ('AGE_GROUP', RESEED, 0);
GO