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
select distinct GENDER from CASESREPORT_STAGE --age
select distinct OUTCOME from CASESREPORT_STAGE --age
select distinct CASEACQUISITION_INFO from CASESREPORT_STAGE --age

select distinct GENDER from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct CASE_STATUS from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select distinct EXPOSURE from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age


select * from CASESREPORT_STAGE --age
select * from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
select * from PUBLIC_HEALTH_UNIT_STAGE 
select * from PUBLIC_HEALTH_UNITS_GROUP_STAGE
select * from VACCINES_BY_AGE_PHU_STAGE --age
select * from ONGOING_OUTBREAKS_PHU_STAGE


--select distinct AGE from CASESREPORT_STAGE --age
--select distinct AGE_GROUP from COMPILED_COVID19_CASE_DETAILS_CANADA_STAGE --age
--select distinct AGE_GROUP from VACCINES_BY_AGE_PHU_STAGE

--select sum(cast(AT_LEAST_ONE_DOSE_CUMULATIVE as bigint)), AGE_GROUP from VACCINES_BY_AGE_PHU_STAGE
--group by AGE_GROUP

--select * from VACCINES_BY_AGE_PHU_STAGE where AGE_GROUP = 'Ontario_5plus'






-- SELECT NDS
use NDSCovid19
go
select * from PHU_GROUP
select * from PHU_CITY
select * from PUBLIC_HEALTH_UNIT order by PHU_NAME
select * from OUTBREAK_GROUP
select DISTINCT AGE_GROUP from AGE_GROUP
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
delete PUBLIC_HEALTH_UNIT
delete PHU_CITY
delete PHU_GROUP
delete OUTBREAK_GROUP
delete VACCINES_BY_AGE_PHU
delete OUTCOME
delete GENDER
delete EXPOSURE

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


UPDATE VACCINES_BY_AGE_PHU 
SET AGEGROUP_ID = ?,
	AT_LEAST_ONE_DOSE_CUMULATIVE = ?,
	SECOND_DOSE_CUMULATIVE = ?,
	FULL_VACCINATED_CUMULATIVE = ?,
	THIRD_DOSE_CUMULATIVE = ?,
	UPDATED_DATE = GETDATE()
WHERE ID = ? and SOURCE_ID = 1