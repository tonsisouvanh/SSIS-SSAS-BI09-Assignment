-- database for NDS
USE MASTER
GO

drop database IF EXISTS DDSCovid19
go

CREATE DATABASE DDSCovid19
GO

USE DDSCovid19
GO



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


use DDSCovid19
go
