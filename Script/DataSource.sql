-- NEW VERSION --
use master
go

drop database IF EXISTS SourceCOVID19
go

create database SourceCOVID19
go

use SourceCOVID19
go

CREATE TABLE CasesReport (
    Outcome varchar(25),
    Age varchar(35),
    Gender varchar(15),
    Reporting_PHU varchar(250),
    SpecimenDate date,
    CaseReported_Date date,
    PHUCity varchar(55),
    TestReported_Date date,
    CaseAcquisition_info varchar(25),
    AccurateEpisode_Dt date,
    PHU_Address varchar(30),
    PHU_Website varchar(250),
    OutbreakRelated varchar(3),
    PHU_Latitude real,
    PHU_Longitude real,
    PHU_Postal_Code varchar(10),
	CreatedDate datetime,
	UpdatedDate datetime
)


CREATE TABLE Compiled_COVID_19_Case_Details_Canada (
    row_id int,
    health_region varchar(65),
    age_group varchar(35),
    gender varchar(15),
    exposure varchar(45),
    case_status varchar(15),
    date_reported datetime,
    province varchar(35),
	CreatedDate datetime,
	UpdatedDate datetime
)


CREATE TABLE ongoing_outbreaks_phu (
    date date,
    phu_num int,
    outbreak_group varchar(35),
    number_ongoing_outbreaks int,
	CreatedDate datetime,
	UpdatedDate datetime
)

CREATE TABLE vaccines_by_age_phu (
    Date date,
    PHU_ID int,
    Agegroup varchar(35),
    At_least_one_dose_cumulative int,
    Second_dose_cumulative int,
    fully_vaccinated_cumulative int,
    third_dose_cumulative int,
	CreatedDate datetime,
	UpdatedDate datetime
)


CREATE TABLE public_health_unit (
    Reporting_PHU_Latitude float,
    Reporting_PHU_Longitude float,
    PHU_ID int,
    Reporting_PHU_Address varchar(255),
    Reporting_PHU varchar(255),
    Reporting_PHU_City varchar(255),
    Reporting_PHU_Website varchar(255),
    Reporting_PHU_Postal_Code varchar(10),
	CreatedDate datetime,
	UpdatedDate datetime
)

CREATE TABLE Public_Health_Units_GROUP (
    PHU_Group varchar(250),
    PHU_City varchar(250),
    PHU_region varchar(65),
	CreatedDate datetime,
	UpdatedDate datetime
)



use SourceCOVID19
go
select * from Compiled_COVID_19_Case_Details_Canada
select * from CasesReport
select * from ongoing_outbreaks_phu
select * from vaccines_by_age_phu
select * from public_health_unit
select * from Public_Health_Units_GROUP



use SourceCOVID19
go
delete public_health_unit
delete CasesReport
delete Compiled_COVID_19_Case_Details_Canada
delete ongoing_outbreaks_phu
delete Public_Health_Units_GROUP
delete vaccines_by_age_phu


-- ========================== QUERY ================================


--select * from vaccines_by_age_phu order by PHU_ID
--select * from public_health_unit order by PHU_ID
--select * from CasesReport
--select * from [Compiled_COVID-19_Case_Details_Canada]

--select distinct Reporting_PHU from public_health_unit

--where PHU_ID = 2244 
--order by Reporting_PHU asc

--select count(*) from vaccines_by_age_phu where PHU_ID = 2227

--order by Date,PHU_ID,Agegroup
--order by At_least_one_dose_cumulative

--where Agegroup = '30-39yrs' order by At_least_one_dose_cumulative

--select * from CasesReport
--select * from [Compiled_COVID-19_Case_Details_Canada] 
--select * from vaccines_by_age_phu where Agegroup = '40-49yrs' order by PHU_ID, Date asc
--select outbreak_group, phu_num from ongoing_outbreaks_phu
--where phu_num = 2227
--order by outbreak_group asc

--select distinct Agegroup from vaccines_by_age_phu

--select csv.PHU_ID, xls.PHU_ID,csv.Date,csv.Agegroup from vaccines_by_age_phu_CSV csv inner join vaccines_by_age_phu_XLSX xls
--on csv.PHU_ID = xls.PHU_ID
--where csv.PHU_ID = 2258

--select * from vaccines_by_age_phu_CSV



-- ========================== PROC & FUCN ================================

--if(OBJECT_ID('sp_AddPhuGroup') is not null)
--	drop proc sp_AddPhuGroup
--go
--CREATE PROCEDURE sp_AddPhuGroup 
--	@group nvarchar(125), 
--	@phu nvarchar(525)
--AS
--BEGIN
--		INSERT INTO Public_Health_Units_GROUP(PHU_Group,PHU_region)
--		SELECT @group,VALUE FROM 
--		STRING_SPLIT(@phu, '|');
--END;
--GO


--begin
--declare @groups varchar(255)
--declare @regions varchar(550)
--SET @groups=?
--SET @regions=?
--	INSERT INTO Public_Health_Units_GROUP(PHU_Group,PHU_region)
--	SELECT @groups,VALUE FROM 
--	STRING_SPLIT(@regions, '|');
--end;