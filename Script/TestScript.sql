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

select getdate()





-- SELECT STAGE
use StageCOVID19
go
select distinct GENDER from CASESREPORT_STAGE --age
select distinct OUTCOME from CASESREPORT_STAGE --age
select distinct CASEACQUISITION_INFO from CASESREPORT_STAGE --age

select distinct GENDER from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct CASE_STATUS from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct EXPOSURE from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age


use StageCOVID19  select * from CASESREPORT_STAGE --age
use StageCOVID19  select * from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
use StageCOVID19  select * from PUBLIC_HEALTH_UNIT_STAGE 
use StageCOVID19  select * from PUBLIC_HEALTH_UNITS_GROUP_STAGE
use StageCOVID19  select * from VACCINES_BY_AGE_PHU_STAGE --where DATE = '2021-09-17' and PHU_ID =2226 and AGE_GROUP = '18-29' order by PHU_ID --age
use StageCOVID19  select * from ONGOING_OUTBREAKS_PHU_STAGE





-- SELECT NDS
use NDSCovid19 select * from PHU_GROUP
use NDSCovid19 select * from PHU_CITY
--select a.PHU_CITY, b.GROUP_NAME from PHU_CITY a, PHU_GROUP b where a.PHU_GROUP_ID = b.ID
use NDSCovid19 select * from PUBLIC_HEALTH_UNIT order by PHU_NAME
use NDSCovid19 select * from OUTBREAK_GROUP
use NDSCovid19 select * from AGE_GROUP
use NDSCovid19 select * from VACCINES_BY_AGE_PHU --order by PHU_ID
use NDSCovid19 select * from OUTCOME
use NDSCovid19 select * from EXPOSURE
use NDSCovid19 select * from GENDER
use NDSCovid19 select * from COVID19_CASESREPORT_DETAIL
use NDSCovid19 select * from ONGOING_OUTBREAKS_PHU



select getdate()


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



--use NDSCovid19
use NDSCovid19 delete COVID19_CASESREPORT_DETAIL
use NDSCovid19 delete ONGOING_OUTBREAKS_PHU
use NDSCovid19 delete OUTBREAK_GROUP
use NDSCovid19 delete VACCINES_BY_AGE_PHU
use NDSCovid19 delete OUTCOME
use NDSCovid19 delete GENDER
use NDSCovid19 delete EXPOSURE
use NDSCovid19 delete PUBLIC_HEALTH_UNIT
use NDSCovid19 delete PHU_CITY
use NDSCovid19 delete PHU_GROUP
use NDSCovid19 delete AGE_GROUP


DBCC CHECKIDENT ('PUBLIC_HEALTH_UNIT', RESEED, 0);
GO
DBCC CHECKIDENT ('PHU_CITY', RESEED, 0);
GO
DBCC CHECKIDENT ('PHU_GROUP', RESEED, 0);
GO
DBCC CHECKIDENT ('OUTBREAK_GROUP', RESEED, 0);
GO
DBCC CHECKIDENT ('ONGOING_OUTBREAKS_PHU', RESEED, 0);
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
DBCC CHECKIDENT ('COVID19_CASESREPORT_DETAIL', RESEED, 0);
GO

