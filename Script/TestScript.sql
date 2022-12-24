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





-- @@@@@@@@@@@@@ STAGE @@@@@@@@@@@@@
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





-- @@@@@@@@@@@@@ NDS Covid19 @@@@@@@@@@@@@
-- SELECT
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


--DELETE
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




-- @@@@@@@@@@@@@ DDS @@@@@@@@@@@@@
-- SELECT DDS
use DDSCovid19 select * from Dim_PHUCity
use DDSCovid19 select * from Dim_PHU
use DDSCovid19 select * from Dim_OngoingOutbreak order by OutbreakName, ongoingoutbreakdate, numberongoingoutbreak
use DDSCovid19 select * from Dim_AgeGroup
use DDSCovid19 select * from Fact_Vaccination
use DDSCovid19 select * from Dim_Date





-- DELETE
use DDSCovid19 delete Fact_Vaccination
use DDSCovid19 delete Dim_PHU
use DDSCovid19 delete Dim_PHUCity
use DDSCovid19 delete Dim_OngoingOutbreak
use DDSCovid19 delete Dim_AgeGroup



DBCC CHECKIDENT ('Dim_PHU', RESEED, 0);
GO
DBCC CHECKIDENT ('Dim_PHUCity', RESEED, 0);
GO
DBCC CHECKIDENT ('Dim_OngoingOutbreak', RESEED, 0);
GO
DBCC CHECKIDENT ('Dim_AgeGroup', RESEED, 0);
GO
DBCC CHECKIDENT ('Fact_Vaccination', RESEED, 0);
GO







-- QUERY
use NDSCovid19
go

select * from COVID19_CASESREPORT_DETAIL where OUTBREAKRELATED = 'Yes'

select * from OUTCOME

select  PHU_ID,AGEGROUP_ID,OUTCOME_ID,EXPOSURE_ID,GENDER_ID,YEAR(CASEREPORTED),count(*) as caseNO from COVID19_CASESREPORT_DETAIL
where OUTCOME_ID = 1
group by PHU_ID, OUTCOME_ID,AGEGROUP_ID,EXPOSURE_ID,GENDER_ID,YEAR(CASEREPORTED)
order by YEAR(CASEREPORTED) asc


select a.*, b.OUTBREAK_GROUP, b.OUTBREAK_GROUP_IDNK from ONGOING_OUTBREAKS_PHU a inner join OUTBREAK_GROUP b
on a.ONGOING_OUTBREAKS_PHU_ID = b.ID


select distinct b.OUTBREAK_GROUP,b.OUTBREAK_GROUP_IDNK,a.ONGOING_OUTBREAK_DATE from ONGOING_OUTBREAKS_PHU a inner join OUTBREAK_GROUP b
on a.ONGOING_OUTBREAKS_PHU_ID = b.ID
order by b.OUTBREAK_GROUP,b.OUTBREAK_GROUP_IDNK,a.ONGOING_OUTBREAK_DATE


use NDSCovid19
go
select a.INJECT_DATE, a.PHU_IDNK,
	a.AT_LEAST_ONE_DOSE_CUMULATIVE,
	a.SECOND_DOSE_CUMULATIVE,
	a.THIRD_DOSE_CUMULATIVE,
	a.FULL_VACCINATED_CUMULATIVE,
	a.AGEGROUP_ID,
	c.AGE_GROUP,
	b.PHU_NAME 
	from VACCINES_BY_AGE_PHU a inner join PUBLIC_HEALTH_UNIT b
on a.PHU_ID = b.ID
inner join AGE_GROUP c
on a.AGEGROUP_ID = c.ID
where a.UPDATED_DATE >= ?
order by a.INJECT_DATE