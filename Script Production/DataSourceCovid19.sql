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
