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
values('CasesReport_Ontario',null,null)
insert into DataFlow(Name,LSET,CET)
values('Compiled_COVID19_Case_Details_Canada',null,null)
insert into DataFlow(Name,LSET,CET)
values('ongoing_outbreaks_phu_Ontario',null,null)
insert into DataFlow(Name,LSET,CET)
values('public_health_unit_Ontario',null,null)
insert into DataFlow(Name,LSET,CET)
values('Public_Health_Units_GROUP_Ontario',null,null)
insert into DataFlow(Name,LSET,CET)
values('vaccines_by_age_phu_Ontario',null,null)

--update DataFlow
--set Name = '' where ID = 1
--update DataFlow
--set Name = '' where ID = 2
--update DataFlow
--set Name = '' where ID = 3
--update DataFlow
--set Name = '' where ID = 4
--update DataFlow
--set Name = '' where ID = 5
--update DataFlow
--set Name = '' where ID = 6


select * from DataFlow

use master
go
