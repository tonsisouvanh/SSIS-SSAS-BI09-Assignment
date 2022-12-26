-- database for NDS
USE MASTER
GO

drop database IF EXISTS DDSCovid19
go

CREATE DATABASE DDSCovid19
GO

USE DDSCovid19
GO

CREATE TABLE Dim_Level(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Level VARCHAR(50)
)
GO

INSERT INTO Dim_Level(Level)
VALUES(N'Low')
INSERT INTO Dim_Level(Level)
VALUES(N'Average')
INSERT INTO Dim_Level(Level)
VALUES(N'High')

CREATE TABLE Dim_OngoingOutbreak(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	OutbreakID INT,
	OutbreakName VARCHAR(50),
	OngoingOutbreakDate DATE,
	NumberOngoingOutbreak INT,
	SourceID INT,
	Status BIT,
)


CREATE TABLE Dim_AgeGroup(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	AgeGroup VARCHAR(35) NULL,
	SourceID INT NULL,
	Status BIT,
)

CREATE TABLE Dim_Gender(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Gender VARCHAR(20) NULL,
	SourceID INT NULL,
	Status BIT,
)

CREATE TABLE Dim_Outcome(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Outcome VARCHAR(15) NULL,
	SourceID INT NULL,
	Status BIT,
)

CREATE TABLE Dim_Exposure(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Exposure VARCHAR(50) NULL,
	SourceID INT NULL,
	Status BIT,
)

CREATE TABLE Dim_PHUCity(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PhuCityName VARCHAR(25) NULL,
	PhuGroupName VARCHAR(50) NULL,
	SourceID INT NULL,
	Status BIT,
)


CREATE TABLE Dim_PHU(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PhuID INT,
	PhuCityID INT, --FK
	PhuName VARCHAR(65) NULL,
	PhuWebsite VARCHAR(75),
	PhuPostCode VARCHAR(10),
	PhuAddress VARCHAR(40),
	PhuLongitude REAL,
	PhuLatitude REAL,
	SourceID INT NULL,
	Status BIT,
)

ALTER TABLE Dim_PHU
ADD CONSTRAINT FK_DimPhu_DimPhuCity
FOREIGN KEY (PhuCityID) REFERENCES Dim_PHUCity(ID);


CREATE TABLE [dbo].[Dim_Date](
	--ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[DateID] INT PRIMARY KEY NOT NULL,
	[FullDate] DATE NOT NULL,
	[Day] INT NULL,
	[Month] INT NULL,
	[Quarter] INT NULL,
	[Year] INT NULL,
)
GO

--CREATE TABLE Dim_QuarterInYear(
--	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	QuarterNumber INT,
--	YearNumber INT,
--	SourceID INT NULL,
--	Status BIT,
--)


--CREATE TABLE Dim_MonthInQuarter(
--	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	MonthNumber INT,
--	EnglishMonthName VARCHAR(25),
--	QuarterInYearID INT, --FK
--	SourceID INT NULL,
--	Status BIT,
--)


--ALTER TABLE Dim_MonthInQuarter
--ADD CONSTRAINT FK_MonthInQuarter_QuarterInYear
--FOREIGN KEY (QuarterInYearID) REFERENCES Dim_QuarterInYear(ID);


--CREATE TABLE Dim_DayInMonth(
--	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	DayNumber INT,
--	EnglishDayName VARCHAR(25),
--	MonthInQuarterID INT, --FK
--	SourceID INT NULL,
--	Status BIT,
--)

--ALTER TABLE Dim_DayInMonth
--ADD CONSTRAINT FK_DayInMonth_MonthInQuarter
--FOREIGN KEY (MonthInQuarterID) REFERENCES Dim_MonthInQuarter(ID);



-- Fact
CREATE TABLE Fact_Vaccination(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	DateID INT , --FK
	PhuID INT, --FK
	AgeGroup VARCHAR(35),

	At_least_one_dose_cumulative INT,
	Second_dose_cumulative INT,
	Third_dose_cumulative INT,
	Fully_vaccinated_cumulative INT,

	SourceID INT ,
	Status BIT,
)

ALTER TABLE Fact_Vaccination
ADD CONSTRAINT FK_FactVaccination_DimDate
FOREIGN KEY (DateID) REFERENCES Dim_Date(DateID);

ALTER TABLE Fact_Vaccination
ADD CONSTRAINT FK_FactVaccination_DimPHU
FOREIGN KEY (PhuID) REFERENCES Dim_PHU(ID);


CREATE TABLE Fact_Covid19_CaseReport(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	PhuID INT , --FK
	DateID INT , --FK
	AgeGroupID INT , --FK
	--OutcomeID INT , --FK
	GenderID INT , --FK
	ExposureID INT , --FK
	OngoingOutrbeakID INT , --FK

	Positive INT,
	Fatal INT,
	Resolved INT,
)

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_PHU
FOREIGN KEY (PhuID) REFERENCES Dim_PHU(ID);

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_DimDate
FOREIGN KEY (DateID) REFERENCES Dim_Date(DateID);

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_DimAgeGroup
FOREIGN KEY (AgeGroupID) REFERENCES Dim_AgeGroup(ID);

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_DimGender
FOREIGN KEY (GenderID) REFERENCES Dim_Gender(ID);

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_DimExposire
FOREIGN KEY (ExposureID) REFERENCES Dim_Exposure(ID);

ALTER TABLE Fact_Covid19_CaseReport
ADD CONSTRAINT FK_FactCovid19CaseReport_DimOngoingOutrbeak
FOREIGN KEY (OngoingOutrbeakID) REFERENCES Dim_OngoingOutbreak(ID);


use DDSCovid19
go
