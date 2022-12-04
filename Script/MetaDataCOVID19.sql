use master
go

IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'MetaDataCOVID19')
  begin
	use master
	drop database MetaDataCOVID19
 end

Create database MetaDataCOVID19
go


use MetaDataCOVID19
go

CREATE TABLE [dbo].[DataFlow](
	ID int IDENTITY(1,1) NOT NULL,
	Name nvarchar(50) NULL,
	LSET datetime NULL,
	CET datetime NULL,
	primary key(ID)
)

insert into DataFlow(Name,LSET,CET)
values('CasesReport',null,null)
insert into DataFlow(Name,LSET,CET)
values('Compiled_COVID19_Case_Details_Canada',null,null)
insert into DataFlow(Name,LSET,CET)
values('ongoing_outbreaks_phu',null,null)
insert into DataFlow(Name,LSET,CET)
values('public_health_unit',null,null)
insert into DataFlow(Name,LSET,CET)
values('Public_Health_Units_GROUP',null,null)
insert into DataFlow(Name,LSET,CET)
values('vaccines_by_age_phu',null,null)


select * from DataFlow

use master
go


