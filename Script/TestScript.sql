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
use DDSCovid19 select * from Dim_Gender
use DDSCovid19 select * from Dim_Exposure
use DDSCovid19 select * from Dim_Outcome
use DDSCovid19 select * from Dim_Level
use DDSCovid19 select * from Fact_Covid19_CaseReport

















-- DELETE
use DDSCovid19 delete Fact_Covid19_CaseReport
use DDSCovid19 delete Fact_Vaccination
use DDSCovid19 delete Dim_PHU
use DDSCovid19 delete Dim_PHUCity
use DDSCovid19 delete Dim_OngoingOutbreak
use DDSCovid19 delete Dim_AgeGroup
use DDSCovid19 delete Dim_Gender
use DDSCovid19 delete Dim_Exposure
use DDSCovid19 delete Dim_Outcome






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
DBCC CHECKIDENT ('Dim_Gender', RESEED, 0);
GO
DBCC CHECKIDENT ('Dim_Outcome', RESEED, 0);
GO
DBCC CHECKIDENT ('Dim_Exposure', RESEED, 0);
GO
DBCC CHECKIDENT ('Fact_Covid19_CaseReport', RESEED, 0);
GO





--use DDSCovid19 
--select d.Year,d.Quarter, sum(Fatal)
--from Fact_Covid19_CaseReport a inner join Dim_Date d on a.DateID = d.DateID
--group by d.year,d.Quarter
--order by d.Year,d.Quarter