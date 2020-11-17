USE [InStock365]
GO

/****** Object:  Table [dbo].[TimeZone]    Script Date: 1/23/2015 9:12:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop TABLE [dbo].[TimeZone] ;
go
CREATE TABLE [dbo].[TimeZone](
	[TimeZone] [nvarchar](10) NOT NULL,
	[TZDesc] [nvarchar](100) NULL,
	[TZOffset] decimal (5,2) NULL,
	[TZCity] [nvarchar](50) NOT NULL,
	[RowNbr] int identity (0,1) NOT NULL
 CONSTRAINT [PK_TimeZone] PRIMARY KEY CLUSTERED 
(
	[TimeZone] ASC,
	[TZCity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TimeZone] ADD  CONSTRAINT [DF_TimeZone_TZCity]  DEFAULT ('-') FOR [TZCity]
GO

truncate table TimeZOne;
Go

insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'GMT', 'Greenwich Mean Time', 0) ;
GO

insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'UTC', 'Universal Coordinated Time', 0) ;
GO


insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'ECT', 'European Central Time', 1) ;
GO


insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'EET', 'Eastern European Time', 2) ;
GO


insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'ART', ' (Arabic) Egypt Standard Time', 2) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'EAT', 'Eastern African Time', 3) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'MET', 'Middle East Time', 3.5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'NET', 'Near East Time', 4) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'PLT', 'Pakistan Lahore Time', 5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'IST', 'India Standard Time', 5.5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'BST', 'Bangladesh Standard Time', 6) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'VST', 'Vietnam Standard Time', 7) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'CTT', 'China Taiwan Time', 8) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'JST', 'Japan Standard Time', 9) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'ACT', 'Australia Central Time', 9.5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'AET', 'Australia Eastern Time', 10) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'SST', 'Solomon Standard Time', 11) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'NST', 'New Zealand Standard Time', 12) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'MIT', 'Midway Islands Time', -11) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'HST', 'Hawaii Standard Time', -10) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'AST', 'Alaska Standard Time', -9) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'PST', 'Pacific Standard Time', -8) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'PNT', 'Phoenix Standard Time', -7) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'MST', 'Mountain Standard Time', -7) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'CST', 'Central Standard Time', -6) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'EST', 'Eastern Standard Time', -5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'IET', 'Indiana Eastern Standard Time', -5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'PRT', 'Puerto Rico and US Virgin Islands Time', -4) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'CNT', 'Canada Newfoundland Time', -3.5) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'AGT', 'Argentina Standard Time', -3) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'BET', 'Brazil Eastern Time', -3) ;
GO
insert into TimeZone (TimeZone,TZDesc,TZOffset) values (
'CAT', 'Central African Time', -1) ;
go

update TimeZone set TZCity = 'New York' where TimeZone = 'EST';
GO
update TimeZone set TZCity = 'Chicago' where TimeZone = 'CST';
GO
update TimeZone set TZCity = 'Denver' where TimeZone = 'MST';
GO
update TimeZone set TZCity = 'San Francisco' where TimeZone = 'PST';
GO
update TimeZone set TZCity = 'Indianapolis' where TimeZone = 'IET';
GO
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [TimeZone]
      ,[TZDesc]
      ,[TZOffset]
      ,[TZCity]
  FROM [InStock365].[dbo].[TimeZone]
  order by RowNbr