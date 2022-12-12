-- database for NDS
USE MASTER
GO
drop database IF EXISTS NDS
go
CREATE DATABASE NDS
GO
USE NDS
GO
CREATE TABLE PHU_GROUP(
GROUP_ID INT PRIMARY KEY IDENTITY (1,1),
GROUP_NAME VARCHAR(50),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE PHU_CITY(
CITY_ID INT PRIMARY KEY IDENTITY (1,1),
PHU_CITY VARCHAR(25),
PHU_GROUP INT,--
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE PHU_ADDRESS(
ADDRESS_ID INT PRIMARY KEY IDENTITY (1,1),
PHU_ADDRESS VARCHAR(50),
PHU_LATITUDE REAL,
PHU_LONGITUDE REAL,
PHU_CITY INT, --
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE PUBLIC_HEALTH_UNIT(
PHU_ID INT PRIMARY KEY IDENTITY (1,1),
PHU_IDNK INT,
PHU_NAME VARCHAR(65),
ADDRESS_ID INT, --
PHU_POSTAL_CODE VARCHAR (10),
PHU_WEBSITE VARCHAR(75),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE OUTBREAK_GROUP(
OUTBREAKGROUP_ID INT PRIMARY KEY IDENTITY (1,1),
OUTBREAK_GROUP VARCHAR(50),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE ONGOING_OUTBREAKS_PHU(
ID INT PRIMARY KEY IDENTITY (1,1),
PHU_ID INT, --
OUTBREAKGROUP_ID INT, --
ONGOING_OUTBREAK_DATE DATETIME,
NUMBER_ONGOING_OUTBREAKS INT,
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE AGE_GROUP(
AGEGROUP_ID INT PRIMARY KEY IDENTITY (1,1),
AGE_GROUP VARCHAR(50),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE VACCINES_BY_AGE_PHU(
VACCINESBY_GEPHU_ID INT PRIMARY KEY IDENTITY (1,1),
PHU_IDNK INT,
PHU_ID INT, --
INJECT_DATE DATETIME,
AGEGROUP_ID INT, --
AT_LEAST_ONE_DOSE_CUMULATIVE INT,
SECOND_DOSE_CUMULATIVE INT,
FULL_VACCINATED_CUMULATIVE INT,
THIRD_DOSE_CUMULATIVE INT,
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE GENDER(
GENDER_ID INT PRIMARY KEY IDENTITY (1,1),
GENDER VARCHAR(20),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE OUTCOME(
OUTCOME_ID INT PRIMARY KEY IDENTITY (1,1),
OUTCOME VARCHAR(15),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE EXPOSURE(
EXPOSURE_ID INT PRIMARY KEY IDENTITY (1,1),
EXPOSURE VARCHAR(50),
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)

CREATE TABLE COVID19_CASESREPORT_DETAIL(
CASEREPORT_ID INT PRIMARY KEY IDENTITY (1,1),
ROW_ID INT, --FROM SOURCE
AGEGROUP_ID INT, --
PHU_ID INT, --
GENDER_ID INT, --
OUTCOME_ID INT, --
EXPOSURE_ID INT, --
CASEREPORTED DATETIME,
SPECIMENDATE DATETIME,
TESTREPORTED DATETIME,
ACCURATEEPISODE DATETIME,
OUTBREAKRELATED INT,
CREATEDATE DATETIME,
UPDATEDATE DATETIME,
SOURCE_ID INT)
GO

--CREATE CONSTRAINT
