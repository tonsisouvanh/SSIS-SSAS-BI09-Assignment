-- NEW VERSION --
use master
go


create database StageCOVID19
go

use StageCOVID19
go

CREATE TABLE CasesReport_Stage (
    [Outcome] varchar(25),
    [Age] varchar(50),
    [Gender] varchar(15),
    [Reporting_PHU] varchar(250),
    [SpecimenDate] date,
    [CaseReported_Date] date,
    [PHUCity] varchar(55),
    [TestReported_Date] date,
    [CaseAcquisition_info] varchar(25),
    [AccurateEpisode_Dt] date,
    [PHU_Address] varchar(30),
    [PHU_Website] varchar(250),
    [OutbreakRelated] varchar(3),
    [PHU_Latitude] real,
    [PHU_Longitude] real,
    [PHU_Postal_Code] varchar(7)
)


CREATE TABLE Compiled_COVID19_Case_Details_Canada_Stage (
    [row_id] int,
    [health_region] varchar(150),
    [age_group] varchar(25),
    [gender] varchar(15),
    [exposure] varchar(45),
    [case_status] varchar(15),
    [date_reported] datetime,
    [province] varchar(35),
)


CREATE TABLE ongoing_outbreaks_phu_Stage (
    [date] date,
    [phu_num] int,
    [outbreak_group] varchar(35),
    [number_ongoing_outbreaks] int
)

CREATE TABLE vaccines_by_age_phu_Stage (
    [Date] date,
    [PHU_ID] int,
    [Agegroup] varchar(150),
    [At_least_one_dose_cumulative] int,
    [Second_dose_cumulative] int,
    [fully_vaccinated_cumulative] int,
    [third_dose_cumulative] int
)


CREATE TABLE public_health_unit_Stage (
    [Reporting_PHU_Latitude] float,
    [Reporting_PHU_Longitude] float,
    [PHU_ID] int,
    [Reporting_PHU_Address] varchar(255),
    [Reporting_PHU] varchar(255),
    [Reporting_PHU_City] varchar(255),
    [Reporting_PHU_Website] varchar(255),
    [Reporting_PHU_Postal_Code] varchar(255),
)

CREATE TABLE Public_Health_Units_GROUP_Stage (
    [PHU_Group] varchar(250),
    [PHU_City] varchar(250),
    [PHU_region] varchar(250)
)

