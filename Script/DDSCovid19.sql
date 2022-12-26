-- database for NDS
USE MASTER
GO

drop database IF EXISTS DDSCovid19
go

CREATE DATABASE DDSCovid19
GO

USE DDSCovid19
GO

CREATE TABLE Dim_Dim_Severity(
	ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Severity VARCHAR(50)
)
GO

INSERT INTO Dim_Dim_Severity(Severity)
VALUES(N'Low')
INSERT INTO Dim_Dim_Severity(Severity)
VALUES(N'Average')
INSERT INTO Dim_Dim_Severity(Severity)
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
	PhuLongitude FLOAT,
	PhuLatitude FLOAT,
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


INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200101, '2020-01-01', 1, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200102, '2020-01-02', 2, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200103, '2020-01-03', 3, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200104, '2020-01-04', 4, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200105, '2020-01-05', 5, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200106, '2020-01-06', 6, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200107, '2020-01-07', 7, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200108, '2020-01-08', 8, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200109, '2020-01-09', 9, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200110, '2020-01-10', 10, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200111, '2020-01-11', 11, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200112, '2020-01-12', 12, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200113, '2020-01-13', 13, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200114, '2020-01-14', 14, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200115, '2020-01-15', 15, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200116, '2020-01-16', 16, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200117, '2020-01-17', 17, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200118, '2020-01-18', 18, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200119, '2020-01-19', 19, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200120, '2020-01-20', 20, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200121, '2020-01-21', 21, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200122, '2020-01-22', 22, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200123, '2020-01-23', 23, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200124, '2020-01-24', 24, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200125, '2020-01-25', 25, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200126, '2020-01-26', 26, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200127, '2020-01-27', 27, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200128, '2020-01-28', 28, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200129, '2020-01-29', 29, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200130, '2020-01-30', 30, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200131, '2020-01-31', 31, 1, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200201, '2020-02-01', 1, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200202, '2020-02-02', 2, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200203, '2020-02-03', 3, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200204, '2020-02-04', 4, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200205, '2020-02-05', 5, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200206, '2020-02-06', 6, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200207, '2020-02-07', 7, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200208, '2020-02-08', 8, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200209, '2020-02-09', 9, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200210, '2020-02-10', 10, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200211, '2020-02-11', 11, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200212, '2020-02-12', 12, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200213, '2020-02-13', 13, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200214, '2020-02-14', 14, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200215, '2020-02-15', 15, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200216, '2020-02-16', 16, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200217, '2020-02-17', 17, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200218, '2020-02-18', 18, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200219, '2020-02-19', 19, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200220, '2020-02-20', 20, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200221, '2020-02-21', 21, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200222, '2020-02-22', 22, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200223, '2020-02-23', 23, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200224, '2020-02-24', 24, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200225, '2020-02-25', 25, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200226, '2020-02-26', 26, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200227, '2020-02-27', 27, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200228, '2020-02-28', 28, 2, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200301, '2020-03-01', 1, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200302, '2020-03-02', 2, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200303, '2020-03-03', 3, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200304, '2020-03-04', 4, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200305, '2020-03-05', 5, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200306, '2020-03-06', 6, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200307, '2020-03-07', 7, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200308, '2020-03-08', 8, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200309, '2020-03-09', 9, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200310, '2020-03-10', 10, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200311, '2020-03-11', 11, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200312, '2020-03-12', 12, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200313, '2020-03-13', 13, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200314, '2020-03-14', 14, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200315, '2020-03-15', 15, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200316, '2020-03-16', 16, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200317, '2020-03-17', 17, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200318, '2020-03-18', 18, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200319, '2020-03-19', 19, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200320, '2020-03-20', 20, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200321, '2020-03-21', 21, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200322, '2020-03-22', 22, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200323, '2020-03-23', 23, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200324, '2020-03-24', 24, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200325, '2020-03-25', 25, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200326, '2020-03-26', 26, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200327, '2020-03-27', 27, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200328, '2020-03-28', 28, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200329, '2020-03-29', 29, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200330, '2020-03-30', 30, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200331, '2020-03-31', 31, 3, 1, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200401, '2020-04-01', 1, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200402, '2020-04-02', 2, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200403, '2020-04-03', 3, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200404, '2020-04-04', 4, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200405, '2020-04-05', 5, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200406, '2020-04-06', 6, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200407, '2020-04-07', 7, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200408, '2020-04-08', 8, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200409, '2020-04-09', 9, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200410, '2020-04-10', 10, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200411, '2020-04-11', 11, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200412, '2020-04-12', 12, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200413, '2020-04-13', 13, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200414, '2020-04-14', 14, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200415, '2020-04-15', 15, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200416, '2020-04-16', 16, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200417, '2020-04-17', 17, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200418, '2020-04-18', 18, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200419, '2020-04-19', 19, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200420, '2020-04-20', 20, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200421, '2020-04-21', 21, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200422, '2020-04-22', 22, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200423, '2020-04-23', 23, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200424, '2020-04-24', 24, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200425, '2020-04-25', 25, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200426, '2020-04-26', 26, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200427, '2020-04-27', 27, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200428, '2020-04-28', 28, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200429, '2020-04-29', 29, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200430, '2020-04-30', 30, 4, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200501, '2020-05-01', 1, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200502, '2020-05-02', 2, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200503, '2020-05-03', 3, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200504, '2020-05-04', 4, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200505, '2020-05-05', 5, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200506, '2020-05-06', 6, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200507, '2020-05-07', 7, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200508, '2020-05-08', 8, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200509, '2020-05-09', 9, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200510, '2020-05-10', 10, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200511, '2020-05-11', 11, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200512, '2020-05-12', 12, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200513, '2020-05-13', 13, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200514, '2020-05-14', 14, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200515, '2020-05-15', 15, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200516, '2020-05-16', 16, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200517, '2020-05-17', 17, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200518, '2020-05-18', 18, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200519, '2020-05-19', 19, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200520, '2020-05-20', 20, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200521, '2020-05-21', 21, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200522, '2020-05-22', 22, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200523, '2020-05-23', 23, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200524, '2020-05-24', 24, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200525, '2020-05-25', 25, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200526, '2020-05-26', 26, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200527, '2020-05-27', 27, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200528, '2020-05-28', 28, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200529, '2020-05-29', 29, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200530, '2020-05-30', 30, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200531, '2020-05-31', 31, 5, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200601, '2020-06-01', 1, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200602, '2020-06-02', 2, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200603, '2020-06-03', 3, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200604, '2020-06-04', 4, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200605, '2020-06-05', 5, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200606, '2020-06-06', 6, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200607, '2020-06-07', 7, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200608, '2020-06-08', 8, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200609, '2020-06-09', 9, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200610, '2020-06-10', 10, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200611, '2020-06-11', 11, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200612, '2020-06-12', 12, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200613, '2020-06-13', 13, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200614, '2020-06-14', 14, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200615, '2020-06-15', 15, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200616, '2020-06-16', 16, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200617, '2020-06-17', 17, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200618, '2020-06-18', 18, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200619, '2020-06-19', 19, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200620, '2020-06-20', 20, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200621, '2020-06-21', 21, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200622, '2020-06-22', 22, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200623, '2020-06-23', 23, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200624, '2020-06-24', 24, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200625, '2020-06-25', 25, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200626, '2020-06-26', 26, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200627, '2020-06-27', 27, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200628, '2020-06-28', 28, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200629, '2020-06-29', 29, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200630, '2020-06-30', 30, 6, 2, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200701, '2020-07-01', 1, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200702, '2020-07-02', 2, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200703, '2020-07-03', 3, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200704, '2020-07-04', 4, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200705, '2020-07-05', 5, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200706, '2020-07-06', 6, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200707, '2020-07-07', 7, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200708, '2020-07-08', 8, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200709, '2020-07-09', 9, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200710, '2020-07-10', 10, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200711, '2020-07-11', 11, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200712, '2020-07-12', 12, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200713, '2020-07-13', 13, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200714, '2020-07-14', 14, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200715, '2020-07-15', 15, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200716, '2020-07-16', 16, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200717, '2020-07-17', 17, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200718, '2020-07-18', 18, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200719, '2020-07-19', 19, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200720, '2020-07-20', 20, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200721, '2020-07-21', 21, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200722, '2020-07-22', 22, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200723, '2020-07-23', 23, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200724, '2020-07-24', 24, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200725, '2020-07-25', 25, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200726, '2020-07-26', 26, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200727, '2020-07-27', 27, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200728, '2020-07-28', 28, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200729, '2020-07-29', 29, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200730, '2020-07-30', 30, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200731, '2020-07-31', 31, 7, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200801, '2020-08-01', 1, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200802, '2020-08-02', 2, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200803, '2020-08-03', 3, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200804, '2020-08-04', 4, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200805, '2020-08-05', 5, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200806, '2020-08-06', 6, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200807, '2020-08-07', 7, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200808, '2020-08-08', 8, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200809, '2020-08-09', 9, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200810, '2020-08-10', 10, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200811, '2020-08-11', 11, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200812, '2020-08-12', 12, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200813, '2020-08-13', 13, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200814, '2020-08-14', 14, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200815, '2020-08-15', 15, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200816, '2020-08-16', 16, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200817, '2020-08-17', 17, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200818, '2020-08-18', 18, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200819, '2020-08-19', 19, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200820, '2020-08-20', 20, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200821, '2020-08-21', 21, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200822, '2020-08-22', 22, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200823, '2020-08-23', 23, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200824, '2020-08-24', 24, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200825, '2020-08-25', 25, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200826, '2020-08-26', 26, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200827, '2020-08-27', 27, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200828, '2020-08-28', 28, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200829, '2020-08-29', 29, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200830, '2020-08-30', 30, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200831, '2020-08-31', 31, 8, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200901, '2020-09-01', 1, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200902, '2020-09-02', 2, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200903, '2020-09-03', 3, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200904, '2020-09-04', 4, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200905, '2020-09-05', 5, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200906, '2020-09-06', 6, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200907, '2020-09-07', 7, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200908, '2020-09-08', 8, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200909, '2020-09-09', 9, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200910, '2020-09-10', 10, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200911, '2020-09-11', 11, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200912, '2020-09-12', 12, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200913, '2020-09-13', 13, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200914, '2020-09-14', 14, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200915, '2020-09-15', 15, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200916, '2020-09-16', 16, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200917, '2020-09-17', 17, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200918, '2020-09-18', 18, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200919, '2020-09-19', 19, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200920, '2020-09-20', 20, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200921, '2020-09-21', 21, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200922, '2020-09-22', 22, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200923, '2020-09-23', 23, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200924, '2020-09-24', 24, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200925, '2020-09-25', 25, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200926, '2020-09-26', 26, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200927, '2020-09-27', 27, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200928, '2020-09-28', 28, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200929, '2020-09-29', 29, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20200930, '2020-09-30', 30, 9, 3, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201001, '2020-10-01', 1, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201002, '2020-10-02', 2, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201003, '2020-10-03', 3, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201004, '2020-10-04', 4, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201005, '2020-10-05', 5, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201006, '2020-10-06', 6, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201007, '2020-10-07', 7, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201008, '2020-10-08', 8, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201009, '2020-10-09', 9, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201010, '2020-10-10', 10, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201011, '2020-10-11', 11, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201012, '2020-10-12', 12, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201013, '2020-10-13', 13, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201014, '2020-10-14', 14, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201015, '2020-10-15', 15, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201016, '2020-10-16', 16, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201017, '2020-10-17', 17, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201018, '2020-10-18', 18, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201019, '2020-10-19', 19, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201020, '2020-10-20', 20, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201021, '2020-10-21', 21, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201022, '2020-10-22', 22, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201023, '2020-10-23', 23, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201024, '2020-10-24', 24, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201025, '2020-10-25', 25, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201026, '2020-10-26', 26, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201027, '2020-10-27', 27, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201028, '2020-10-28', 28, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201029, '2020-10-29', 29, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201030, '2020-10-30', 30, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201031, '2020-10-31', 31, 10, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201101, '2020-11-01', 1, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201102, '2020-11-02', 2, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201103, '2020-11-03', 3, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201104, '2020-11-04', 4, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201105, '2020-11-05', 5, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201106, '2020-11-06', 6, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201107, '2020-11-07', 7, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201108, '2020-11-08', 8, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201109, '2020-11-09', 9, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201110, '2020-11-10', 10, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201111, '2020-11-11', 11, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201112, '2020-11-12', 12, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201113, '2020-11-13', 13, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201114, '2020-11-14', 14, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201115, '2020-11-15', 15, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201116, '2020-11-16', 16, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201117, '2020-11-17', 17, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201118, '2020-11-18', 18, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201119, '2020-11-19', 19, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201120, '2020-11-20', 20, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201121, '2020-11-21', 21, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201122, '2020-11-22', 22, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201123, '2020-11-23', 23, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201124, '2020-11-24', 24, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201125, '2020-11-25', 25, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201126, '2020-11-26', 26, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201127, '2020-11-27', 27, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201128, '2020-11-28', 28, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201129, '2020-11-29', 29, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201130, '2020-11-30', 30, 11, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201201, '2020-12-01', 1, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201202, '2020-12-02', 2, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201203, '2020-12-03', 3, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201204, '2020-12-04', 4, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201205, '2020-12-05', 5, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201206, '2020-12-06', 6, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201207, '2020-12-07', 7, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201208, '2020-12-08', 8, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201209, '2020-12-09', 9, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201210, '2020-12-10', 10, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201211, '2020-12-11', 11, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201212, '2020-12-12', 12, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201213, '2020-12-13', 13, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201214, '2020-12-14', 14, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201215, '2020-12-15', 15, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201216, '2020-12-16', 16, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201217, '2020-12-17', 17, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201218, '2020-12-18', 18, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201219, '2020-12-19', 19, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201220, '2020-12-20', 20, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201221, '2020-12-21', 21, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201222, '2020-12-22', 22, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201223, '2020-12-23', 23, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201224, '2020-12-24', 24, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201225, '2020-12-25', 25, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201226, '2020-12-26', 26, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201227, '2020-12-27', 27, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201228, '2020-12-28', 28, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201229, '2020-12-29', 29, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201230, '2020-12-30', 30, 12, 4, 2020);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20201231, '2020-12-31', 31, 12, 4, 2020);

INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210101, '2021-01-01', 1, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210102, '2021-01-02', 2, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210103, '2021-01-03', 3, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210104, '2021-01-04', 4, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210105, '2021-01-05', 5, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210106, '2021-01-06', 6, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210107, '2021-01-07', 7, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210108, '2021-01-08', 8, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210109, '2021-01-09', 9, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210110, '2021-01-10', 10, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210111, '2021-01-11', 11, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210112, '2021-01-12', 12, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210113, '2021-01-13', 13, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210114, '2021-01-14', 14, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210115, '2021-01-15', 15, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210116, '2021-01-16', 16, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210117, '2021-01-17', 17, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210118, '2021-01-18', 18, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210119, '2021-01-19', 19, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210120, '2021-01-20', 20, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210121, '2021-01-21', 21, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210122, '2021-01-22', 22, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210123, '2021-01-23', 23, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210124, '2021-01-24', 24, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210125, '2021-01-25', 25, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210126, '2021-01-26', 26, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210127, '2021-01-27', 27, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210128, '2021-01-28', 28, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210129, '2021-01-29', 29, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210130, '2021-01-30', 30, 1, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210131, '2021-01-31', 31, 1, 1, 2021);

INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210201, '2021-02-01', 1, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210202, '2021-02-02', 2, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210203, '2021-02-03', 3, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210204, '2021-02-04', 4, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210205, '2021-02-05', 5, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210206, '2021-02-06', 6, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210207, '2021-02-07', 7, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210208, '2021-02-08', 8, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210209, '2021-02-09', 9, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210210, '2021-02-10', 10, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210211, '2021-02-11', 11, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210212, '2021-02-12', 12, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210213, '2021-02-13', 13, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210214, '2021-02-14', 14, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210215, '2021-02-15', 15, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210216, '2021-02-16', 16, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210217, '2021-02-17', 17, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210218, '2021-02-18', 18, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210219, '2021-02-19', 19, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210220, '2021-02-20', 20, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210221, '2021-02-21', 21, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210222, '2021-02-22', 22, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210223, '2021-02-23', 23, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210224, '2021-02-24', 24, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210225, '2021-02-25', 25, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210226, '2021-02-26', 26, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210227, '2021-02-27', 27, 2, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210228, '2021-02-28', 28, 2, 1, 2021);

INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210301, '2021-03-01', 1, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210302, '2021-03-02', 2, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210303, '2021-03-03', 3, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210304, '2021-03-04', 4, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210305, '2021-03-05', 5, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210306, '2021-03-06', 6, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210307, '2021-03-07', 7, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210308, '2021-03-08', 8, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210309, '2021-03-09', 9, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210310, '2021-03-10', 10, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210311, '2021-03-11', 11, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210312, '2021-03-12', 12, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210313, '2021-03-13', 13, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210314, '2021-03-14', 14, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210315, '2021-03-15', 15, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210316, '2021-03-16', 16, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210317, '2021-03-17', 17, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210318, '2021-03-18', 18, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210319, '2021-03-19', 19, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210320, '2021-03-20', 20, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210321, '2021-03-21', 21, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210322, '2021-03-22', 22, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210323, '2021-03-23', 23, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210324, '2021-03-24', 24, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210325, '2021-03-25', 25, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210326, '2021-03-26', 26, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210327, '2021-03-27', 27, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210328, '2021-03-28', 28, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210329, '2021-03-29', 29, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210330, '2021-03-30', 30, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210331, '2021-03-31', 31, 3, 1, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210401, '2021-04-01', 1, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210402, '2021-04-02', 2, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210403, '2021-04-03', 3, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210404, '2021-04-04', 4, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210405, '2021-04-05', 5, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210406, '2021-04-06', 6, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210407, '2021-04-07', 7, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210408, '2021-04-08', 8, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210409, '2021-04-09', 9, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210410, '2021-04-10', 10, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210411, '2021-04-11', 11, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210412, '2021-04-12', 12, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210413, '2021-04-13', 13, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210414, '2021-04-14', 14, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210415, '2021-04-15', 15, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210416, '2021-04-16', 16, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210417, '2021-04-17', 17, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210418, '2021-04-18', 18, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210419, '2021-04-19', 19, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210420, '2021-04-20', 20, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210421, '2021-04-21', 21, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210422, '2021-04-22', 22, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210423, '2021-04-23', 23, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210424, '2021-04-24', 24, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210425, '2021-04-25', 25, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210426, '2021-04-26', 26, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210427, '2021-04-27', 27, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210428, '2021-04-28', 28, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210429, '2021-04-29', 29, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210430, '2021-04-30', 30, 4, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210501, '2021-05-01', 1, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210502, '2021-05-02', 2, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210503, '2021-05-03', 3, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210504, '2021-05-04', 4, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210505, '2021-05-05', 5, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210506, '2021-05-06', 6, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210507, '2021-05-07', 7, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210508, '2021-05-08', 8, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210509, '2021-05-09', 9, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210510, '2021-05-10', 10, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210511, '2021-05-11', 11, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210512, '2021-05-12', 12, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210513, '2021-05-13', 13, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210514, '2021-05-14', 14, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210515, '2021-05-15', 15, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210516, '2021-05-16', 16, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210517, '2021-05-17', 17, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210518, '2021-05-18', 18, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210519, '2021-05-19', 19, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210520, '2021-05-20', 20, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210521, '2021-05-21', 21, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210522, '2021-05-22', 22, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210523, '2021-05-23', 23, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210524, '2021-05-24', 24, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210525, '2021-05-25', 25, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210526, '2021-05-26', 26, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210527, '2021-05-27', 27, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210528, '2021-05-28', 28, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210529, '2021-05-29', 29, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210530, '2021-05-30', 30, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210531, '2021-05-31', 31, 5, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210601, '2021-06-01', 1, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210602, '2021-06-02', 2, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210603, '2021-06-03', 3, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210604, '2021-06-04', 4, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210605, '2021-06-05', 5, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210606, '2021-06-06', 6, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210607, '2021-06-07', 7, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210608, '2021-06-08', 8, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210609, '2021-06-09', 9, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210610, '2021-06-10', 10, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210611, '2021-06-11', 11, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210612, '2021-06-12', 12, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210613, '2021-06-13', 13, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210614, '2021-06-14', 14, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210615, '2021-06-15', 15, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210616, '2021-06-16', 16, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210617, '2021-06-17', 17, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210618, '2021-06-18', 18, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210619, '2021-06-19', 19, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210620, '2021-06-20', 20, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210621, '2021-06-21', 21, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210622, '2021-06-22', 22, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210623, '2021-06-23', 23, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210624, '2021-06-24', 24, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210625, '2021-06-25', 25, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210626, '2021-06-26', 26, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210627, '2021-06-27', 27, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210628, '2021-06-28', 28, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210629, '2021-06-29', 29, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210630, '2021-06-30', 30, 6, 2, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210701, '2021-07-01', 1, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210702, '2021-07-02', 2, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210703, '2021-07-03', 3, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210704, '2021-07-04', 4, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210705, '2021-07-05', 5, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210706, '2021-07-06', 6, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210707, '2021-07-07', 7, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210708, '2021-07-08', 8, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210709, '2021-07-09', 9, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210710, '2021-07-10', 10, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210711, '2021-07-11', 11, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210712, '2021-07-12', 12, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210713, '2021-07-13', 13, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210714, '2021-07-14', 14, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210715, '2021-07-15', 15, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210716, '2021-07-16', 16, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210717, '2021-07-17', 17, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210718, '2021-07-18', 18, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210719, '2021-07-19', 19, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210720, '2021-07-20', 20, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210721, '2021-07-21', 21, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210722, '2021-07-22', 22, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210723, '2021-07-23', 23, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210724, '2021-07-24', 24, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210725, '2021-07-25', 25, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210726, '2021-07-26', 26, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210727, '2021-07-27', 27, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210728, '2021-07-28', 28, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210729, '2021-07-29', 29, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210730, '2021-07-30', 30, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210731, '2021-07-31', 31, 7, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210801, '2021-08-01', 1, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210802, '2021-08-02', 2, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210803, '2021-08-03', 3, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210804, '2021-08-04', 4, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210805, '2021-08-05', 5, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210806, '2021-08-06', 6, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210807, '2021-08-07', 7, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210808, '2021-08-08', 8, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210809, '2021-08-09', 9, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210810, '2021-08-10', 10, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210811, '2021-08-11', 11, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210812, '2021-08-12', 12, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210813, '2021-08-13', 13, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210814, '2021-08-14', 14, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210815, '2021-08-15', 15, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210816, '2021-08-16', 16, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210817, '2021-08-17', 17, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210818, '2021-08-18', 18, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210819, '2021-08-19', 19, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210820, '2021-08-20', 20, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210821, '2021-08-21', 21, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210822, '2021-08-22', 22, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210823, '2021-08-23', 23, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210824, '2021-08-24', 24, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210825, '2021-08-25', 25, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210826, '2021-08-26', 26, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210827, '2021-08-27', 27, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210828, '2021-08-28', 28, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210829, '2021-08-29', 29, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210830, '2021-08-30', 30, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210831, '2021-08-31', 31, 8, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210901, '2021-09-01', 1, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210902, '2021-09-02', 2, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210903, '2021-09-03', 3, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210904, '2021-09-04', 4, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210905, '2021-09-05', 5, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210906, '2021-09-06', 6, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210907, '2021-09-07', 7, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210908, '2021-09-08', 8, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210909, '2021-09-09', 9, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210910, '2021-09-10', 10, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210911, '2021-09-11', 11, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210912, '2021-09-12', 12, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210913, '2021-09-13', 13, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210914, '2021-09-14', 14, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210915, '2021-09-15', 15, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210916, '2021-09-16', 16, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210917, '2021-09-17', 17, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210918, '2021-09-18', 18, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210919, '2021-09-19', 19, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210920, '2021-09-20', 20, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210921, '2021-09-21', 21, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210922, '2021-09-22', 22, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210923, '2021-09-23', 23, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210924, '2021-09-24', 24, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210925, '2021-09-25', 25, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210926, '2021-09-26', 26, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210927, '2021-09-27', 27, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210928, '2021-09-28', 28, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210929, '2021-09-29', 29, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20210930, '2021-09-30', 30, 9, 3, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211001, '2021-10-01', 1, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211002, '2021-10-02', 2, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211003, '2021-10-03', 3, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211004, '2021-10-04', 4, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211005, '2021-10-05', 5, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211006, '2021-10-06', 6, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211007, '2021-10-07', 7, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211008, '2021-10-08', 8, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211009, '2021-10-09', 9, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211010, '2021-10-10', 10, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211011, '2021-10-11', 11, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211012, '2021-10-12', 12, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211013, '2021-10-13', 13, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211014, '2021-10-14', 14, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211015, '2021-10-15', 15, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211016, '2021-10-16', 16, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211017, '2021-10-17', 17, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211018, '2021-10-18', 18, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211019, '2021-10-19', 19, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211020, '2021-10-20', 20, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211021, '2021-10-21', 21, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211022, '2021-10-22', 22, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211023, '2021-10-23', 23, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211024, '2021-10-24', 24, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211025, '2021-10-25', 25, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211026, '2021-10-26', 26, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211027, '2021-10-27', 27, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211028, '2021-10-28', 28, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211029, '2021-10-29', 29, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211030, '2021-10-30', 30, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211031, '2021-10-31', 31, 10, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211101, '2021-11-01', 1, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211102, '2021-11-02', 2, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211103, '2021-11-03', 3, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211104, '2021-11-04', 4, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211105, '2021-11-05', 5, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211106, '2021-11-06', 6, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211107, '2021-11-07', 7, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211108, '2021-11-08', 8, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211109, '2021-11-09', 9, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211110, '2021-11-10', 10, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211111, '2021-11-11', 11, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211112, '2021-11-12', 12, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211113, '2021-11-13', 13, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211114, '2021-11-14', 14, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211115, '2021-11-15', 15, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211116, '2021-11-16', 16, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211117, '2021-11-17', 17, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211118, '2021-11-18', 18, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211119, '2021-11-19', 19, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211120, '2021-11-20', 20, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211121, '2021-11-21', 21, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211122, '2021-11-22', 22, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211123, '2021-11-23', 23, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211124, '2021-11-24', 24, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211125, '2021-11-25', 25, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211126, '2021-11-26', 26, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211127, '2021-11-27', 27, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211128, '2021-11-28', 28, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211129, '2021-11-29', 29, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211130, '2021-11-30', 30, 11, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211201, '2021-12-01', 1, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211202, '2021-12-02', 2, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211203, '2021-12-03', 3, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211204, '2021-12-04', 4, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211205, '2021-12-05', 5, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211206, '2021-12-06', 6, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211207, '2021-12-07', 7, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211208, '2021-12-08', 8, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211209, '2021-12-09', 9, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211210, '2021-12-10', 10, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211211, '2021-12-11', 11, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211212, '2021-12-12', 12, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211213, '2021-12-13', 13, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211214, '2021-12-14', 14, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211215, '2021-12-15', 15, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211216, '2021-12-16', 16, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211217, '2021-12-17', 17, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211218, '2021-12-18', 18, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211219, '2021-12-19', 19, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211220, '2021-12-20', 20, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211221, '2021-12-21', 21, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211222, '2021-12-22', 22, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211223, '2021-12-23', 23, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211224, '2021-12-24', 24, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211225, '2021-12-25', 25, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211226, '2021-12-26', 26, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211227, '2021-12-27', 27, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211228, '2021-12-28', 28, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211229, '2021-12-29', 29, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211230, '2021-12-30', 30, 12, 4, 2021);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20211231, '2021-12-31', 31, 12, 4, 2021);


INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220101, '2022-01-01', 1, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220102, '2022-01-02', 2, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220103, '2022-01-03', 3, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220104, '2022-01-04', 4, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220105, '2022-01-05', 5, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220106, '2022-01-06', 6, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220107, '2022-01-07', 7, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220108, '2022-01-08', 8, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220109, '2022-01-09', 9, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220110, '2022-01-10', 10, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220111, '2022-01-11', 11, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220112, '2022-01-12', 12, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220113, '2022-01-13', 13, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220114, '2022-01-14', 14, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220115, '2022-01-15', 15, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220116, '2022-01-16', 16, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220117, '2022-01-17', 17, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220118, '2022-01-18', 18, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220119, '2022-01-19', 19, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220120, '2022-01-20', 20, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220121, '2022-01-21', 21, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220122, '2022-01-22', 22, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220123, '2022-01-23', 23, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220124, '2022-01-24', 24, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220125, '2022-01-25', 25, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220126, '2022-01-26', 26, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220127, '2022-01-27', 27, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220128, '2022-01-28', 28, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220129, '2022-01-29', 29, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220130, '2022-01-30', 30, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220131, '2022-01-31', 31, 1, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220201, '2022-02-01', 1, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220202, '2022-02-02', 2, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220203, '2022-02-03', 3, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220204, '2022-02-04', 4, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220205, '2022-02-05', 5, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220206, '2022-02-06', 6, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220207, '2022-02-07', 7, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220208, '2022-02-08', 8, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220209, '2022-02-09', 9, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220210, '2022-02-10', 10, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220211, '2022-02-11', 11, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220212, '2022-02-12', 12, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220213, '2022-02-13', 13, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220214, '2022-02-14', 14, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220215, '2022-02-15', 15, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220216, '2022-02-16', 16, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220217, '2022-02-17', 17, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220218, '2022-02-18', 18, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220219, '2022-02-19', 19, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220220, '2022-02-20', 20, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220221, '2022-02-21', 21, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220222, '2022-02-22', 22, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220223, '2022-02-23', 23, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220224, '2022-02-24', 24, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220225, '2022-02-25', 25, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220226, '2022-02-26', 26, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220227, '2022-02-27', 27, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220228, '2022-02-28', 28, 2, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220301, '2022-03-01', 1, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220302, '2022-03-02', 2, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220303, '2022-03-03', 3, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220304, '2022-03-04', 4, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220305, '2022-03-05', 5, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220306, '2022-03-06', 6, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220307, '2022-03-07', 7, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220308, '2022-03-08', 8, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220309, '2022-03-09', 9, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220310, '2022-03-10', 10, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220311, '2022-03-11', 11, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220312, '2022-03-12', 12, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220313, '2022-03-13', 13, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220314, '2022-03-14', 14, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220315, '2022-03-15', 15, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220316, '2022-03-16', 16, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220317, '2022-03-17', 17, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220318, '2022-03-18', 18, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220319, '2022-03-19', 19, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220320, '2022-03-20', 20, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220321, '2022-03-21', 21, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220322, '2022-03-22', 22, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220323, '2022-03-23', 23, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220324, '2022-03-24', 24, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220325, '2022-03-25', 25, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220326, '2022-03-26', 26, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220327, '2022-03-27', 27, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220328, '2022-03-28', 28, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220329, '2022-03-29', 29, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220330, '2022-03-30', 30, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220331, '2022-03-31', 31, 3, 1, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220401, '2022-04-01', 1, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220402, '2022-04-02', 2, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220403, '2022-04-03', 3, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220404, '2022-04-04', 4, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220405, '2022-04-05', 5, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220406, '2022-04-06', 6, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220407, '2022-04-07', 7, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220408, '2022-04-08', 8, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220409, '2022-04-09', 9, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220410, '2022-04-10', 10, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220411, '2022-04-11', 11, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220412, '2022-04-12', 12, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220413, '2022-04-13', 13, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220414, '2022-04-14', 14, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220415, '2022-04-15', 15, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220416, '2022-04-16', 16, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220417, '2022-04-17', 17, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220418, '2022-04-18', 18, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220419, '2022-04-19', 19, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220420, '2022-04-20', 20, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220421, '2022-04-21', 21, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220422, '2022-04-22', 22, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220423, '2022-04-23', 23, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220424, '2022-04-24', 24, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220425, '2022-04-25', 25, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220426, '2022-04-26', 26, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220427, '2022-04-27', 27, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220428, '2022-04-28', 28, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220429, '2022-04-29', 29, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220430, '2022-04-30', 30, 4, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220501, '2022-05-01', 1, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220502, '2022-05-02', 2, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220503, '2022-05-03', 3, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220504, '2022-05-04', 4, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220505, '2022-05-05', 5, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220506, '2022-05-06', 6, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220507, '2022-05-07', 7, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220508, '2022-05-08', 8, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220509, '2022-05-09', 9, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220510, '2022-05-10', 10, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220511, '2022-05-11', 11, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220512, '2022-05-12', 12, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220513, '2022-05-13', 13, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220514, '2022-05-14', 14, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220515, '2022-05-15', 15, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220516, '2022-05-16', 16, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220517, '2022-05-17', 17, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220518, '2022-05-18', 18, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220519, '2022-05-19', 19, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220520, '2022-05-20', 20, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220521, '2022-05-21', 21, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220522, '2022-05-22', 22, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220523, '2022-05-23', 23, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220524, '2022-05-24', 24, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220525, '2022-05-25', 25, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220526, '2022-05-26', 26, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220527, '2022-05-27', 27, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220528, '2022-05-28', 28, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220529, '2022-05-29', 29, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220530, '2022-05-30', 30, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220531, '2022-05-31', 31, 5, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220601, '2022-06-01', 1, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220602, '2022-06-02', 2, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220603, '2022-06-03', 3, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220604, '2022-06-04', 4, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220605, '2022-06-05', 5, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220606, '2022-06-06', 6, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220607, '2022-06-07', 7, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220608, '2022-06-08', 8, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220609, '2022-06-09', 9, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220610, '2022-06-10', 10, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220611, '2022-06-11', 11, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220612, '2022-06-12', 12, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220613, '2022-06-13', 13, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220614, '2022-06-14', 14, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220615, '2022-06-15', 15, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220616, '2022-06-16', 16, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220617, '2022-06-17', 17, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220618, '2022-06-18', 18, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220619, '2022-06-19', 19, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220620, '2022-06-20', 20, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220621, '2022-06-21', 21, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220622, '2022-06-22', 22, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220623, '2022-06-23', 23, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220624, '2022-06-24', 24, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220625, '2022-06-25', 25, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220626, '2022-06-26', 26, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220627, '2022-06-27', 27, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220628, '2022-06-28', 28, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220629, '2022-06-29', 29, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220630, '2022-06-30', 30, 6, 2, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220701, '2022-07-01', 1, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220702, '2022-07-02', 2, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220703, '2022-07-03', 3, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220704, '2022-07-04', 4, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220705, '2022-07-05', 5, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220706, '2022-07-06', 6, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220707, '2022-07-07', 7, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220708, '2022-07-08', 8, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220709, '2022-07-09', 9, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220710, '2022-07-10', 10, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220711, '2022-07-11', 11, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220712, '2022-07-12', 12, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220713, '2022-07-13', 13, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220714, '2022-07-14', 14, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220715, '2022-07-15', 15, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220716, '2022-07-16', 16, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220717, '2022-07-17', 17, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220718, '2022-07-18', 18, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220719, '2022-07-19', 19, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220720, '2022-07-20', 20, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220721, '2022-07-21', 21, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220722, '2022-07-22', 22, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220723, '2022-07-23', 23, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220724, '2022-07-24', 24, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220725, '2022-07-25', 25, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220726, '2022-07-26', 26, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220727, '2022-07-27', 27, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220728, '2022-07-28', 28, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220729, '2022-07-29', 29, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220730, '2022-07-30', 30, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220731, '2022-07-31', 31, 7, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220801, '2022-08-01', 1, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220802, '2022-08-02', 2, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220803, '2022-08-03', 3, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220804, '2022-08-04', 4, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220805, '2022-08-05', 5, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220806, '2022-08-06', 6, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220807, '2022-08-07', 7, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220808, '2022-08-08', 8, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220809, '2022-08-09', 9, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220810, '2022-08-10', 10, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220811, '2022-08-11', 11, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220812, '2022-08-12', 12, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220813, '2022-08-13', 13, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220814, '2022-08-14', 14, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220815, '2022-08-15', 15, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220816, '2022-08-16', 16, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220817, '2022-08-17', 17, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220818, '2022-08-18', 18, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220819, '2022-08-19', 19, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220820, '2022-08-20', 20, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220821, '2022-08-21', 21, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220822, '2022-08-22', 22, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220823, '2022-08-23', 23, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220824, '2022-08-24', 24, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220825, '2022-08-25', 25, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220826, '2022-08-26', 26, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220827, '2022-08-27', 27, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220828, '2022-08-28', 28, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220829, '2022-08-29', 29, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220830, '2022-08-30', 30, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220831, '2022-08-31', 31, 8, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220901, '2022-09-01', 1, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220902, '2022-09-02', 2, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220903, '2022-09-03', 3, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220904, '2022-09-04', 4, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220905, '2022-09-05', 5, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220906, '2022-09-06', 6, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220907, '2022-09-07', 7, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220908, '2022-09-08', 8, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220909, '2022-09-09', 9, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220910, '2022-09-10', 10, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220911, '2022-09-11', 11, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220912, '2022-09-12', 12, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220913, '2022-09-13', 13, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220914, '2022-09-14', 14, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220915, '2022-09-15', 15, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220916, '2022-09-16', 16, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220917, '2022-09-17', 17, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220918, '2022-09-18', 18, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220919, '2022-09-19', 19, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220920, '2022-09-20', 20, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220921, '2022-09-21', 21, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220922, '2022-09-22', 22, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220923, '2022-09-23', 23, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220924, '2022-09-24', 24, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220925, '2022-09-25', 25, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220926, '2022-09-26', 26, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220927, '2022-09-27', 27, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220928, '2022-09-28', 28, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220929, '2022-09-29', 29, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20220930, '2022-09-30', 30, 9, 3, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221001, '2022-10-01', 1, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221002, '2022-10-02', 2, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221003, '2022-10-03', 3, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221004, '2022-10-04', 4, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221005, '2022-10-05', 5, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221006, '2022-10-06', 6, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221007, '2022-10-07', 7, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221008, '2022-10-08', 8, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221009, '2022-10-09', 9, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221010, '2022-10-10', 10, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221011, '2022-10-11', 11, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221012, '2022-10-12', 12, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221013, '2022-10-13', 13, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221014, '2022-10-14', 14, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221015, '2022-10-15', 15, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221016, '2022-10-16', 16, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221017, '2022-10-17', 17, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221018, '2022-10-18', 18, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221019, '2022-10-19', 19, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221020, '2022-10-20', 20, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221021, '2022-10-21', 21, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221022, '2022-10-22', 22, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221023, '2022-10-23', 23, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221024, '2022-10-24', 24, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221025, '2022-10-25', 25, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221026, '2022-10-26', 26, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221027, '2022-10-27', 27, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221028, '2022-10-28', 28, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221029, '2022-10-29', 29, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221030, '2022-10-30', 30, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221031, '2022-10-31', 31, 10, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221101, '2022-11-01', 1, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221102, '2022-11-02', 2, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221103, '2022-11-03', 3, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221104, '2022-11-04', 4, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221105, '2022-11-05', 5, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221106, '2022-11-06', 6, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221107, '2022-11-07', 7, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221108, '2022-11-08', 8, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221109, '2022-11-09', 9, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221110, '2022-11-10', 10, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221111, '2022-11-11', 11, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221112, '2022-11-12', 12, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221113, '2022-11-13', 13, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221114, '2022-11-14', 14, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221115, '2022-11-15', 15, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221116, '2022-11-16', 16, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221117, '2022-11-17', 17, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221118, '2022-11-18', 18, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221119, '2022-11-19', 19, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221120, '2022-11-20', 20, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221121, '2022-11-21', 21, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221122, '2022-11-22', 22, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221123, '2022-11-23', 23, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221124, '2022-11-24', 24, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221125, '2022-11-25', 25, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221126, '2022-11-26', 26, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221127, '2022-11-27', 27, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221128, '2022-11-28', 28, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221129, '2022-11-29', 29, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221130, '2022-11-30', 30, 11, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221201, '2022-12-01', 1, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221202, '2022-12-02', 2, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221203, '2022-12-03', 3, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221204, '2022-12-04', 4, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221205, '2022-12-05', 5, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221206, '2022-12-06', 6, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221207, '2022-12-07', 7, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221208, '2022-12-08', 8, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221209, '2022-12-09', 9, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221210, '2022-12-10', 10, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221211, '2022-12-11', 11, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221212, '2022-12-12', 12, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221213, '2022-12-13', 13, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221214, '2022-12-14', 14, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221215, '2022-12-15', 15, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221216, '2022-12-16', 16, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221217, '2022-12-17', 17, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221218, '2022-12-18', 18, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221219, '2022-12-19', 19, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221220, '2022-12-20', 20, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221221, '2022-12-21', 21, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221222, '2022-12-22', 22, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221223, '2022-12-23', 23, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221224, '2022-12-24', 24, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221225, '2022-12-25', 25, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221226, '2022-12-26', 26, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221227, '2022-12-27', 27, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221228, '2022-12-28', 28, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221229, '2022-12-29', 29, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221230, '2022-12-30', 30, 12, 4, 2022);
INSERT INTO Dim_Date (DateID, FullDate, Day, Month, Quarter, Year) VALUES (20221231, '2022-12-31', 31, 12, 4, 2022);

--delete Dim_Date