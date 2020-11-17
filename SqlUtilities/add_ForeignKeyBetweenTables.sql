
use KenticoCMS_DataMart
go

IF OBJECT_ID('tempdb..#PK_COLS') IS NOT NULL DROP TABLE #PK_COLS

SELECT COLUMN_NAME into #PK_COLS
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
AND TABLE_NAME = 'BASE_hfit_PPTEligibility' AND TABLE_SCHEMA = 'dbo'

select * from #PK_COLS

ALTER TABLE dbo.BASE_CMS_UserSite 
ADD CONSTRAINT FK_BASE_CMS_UserSite FOREIGN KEY (SVR, DBNAME, userid) 
    REFERENCES dbo.BASE_CMS_User (SVR, DBNAME, userid) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE dbo.BASE_CMS_UserSite 
ADD CONSTRAINT FK_BASE_CMS_UserSite_SITE FOREIGN KEY (SVR, DBNAME, SiteID) 
    REFERENCES dbo.BASE_CMS_Site (SVR, DBNAME, SiteID) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;
GO
select count(*) from BASE_HFit_TrackerBloodPressure
select count(*) from FACT_HFit_TrackerBloodPressure

ALTER TABLE dbo.BASE_HFit_TrackerBloodPressure 
ADD CONSTRAINT FK_BASE_HFit_TrackerBloodPressure_PPT FOREIGN KEY (SVR, DBNAME, UserID) 
    REFERENCES dbo.BASE_hfit_PPTEligibility (SVR, DBNAME, UserID) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;
GO

--************************************************************************
SELECT name
FROM sys.key_constraints
WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = N'BASE_HFit_PPTEligibility';
GO
-- Delete the primary key constraint.
ALTER TABLE [dbo].[BASE_HFit_PPTEligibility]
DROP CONSTRAINT PK__BASE_hfi__B4CDD17A32D40CFA; 
GO
--************************************************************************

update [dbo].FACT_TrackerData set UserID = -1  where UserID is null
update [dbo].FACT_TrackerData set ItemID = -1  where ItemID is null
ALTER TABLE [dbo].FACT_TrackerData alter column TrackerName nvarchar(100) not null ;
ALTER TABLE [dbo].FACT_TrackerData alter column SVR nvarchar(100) not null ;
ALTER TABLE [dbo].FACT_TrackerData alter column DBNAME nvarchar(100) not null ;
ALTER TABLE [dbo].FACT_TrackerData alter column ItemID int not null ;
ALTER TABLE [dbo].FACT_TrackerData alter column UserID int not null ;


ALTER TABLE [dbo].FACT_TrackerData ADD  PRIMARY KEY CLUSTERED 
(
	TrackerName, SVR, DBNAME, UserID, ItemID
)


ALTER TABLE [dbo].[BASE_HFit_PPTEligibility] DISABLE CHANGE_TRACKING;

ALTER TABLE [dbo].[BASE_HFit_PPTEligibility] DROP CONSTRAINT [PKEY_BASE_hfit_PPTEligibility]
ALTER TABLE [dbo].[BASE_HFit_PPTEligibility] alter column UserID int not null

ALTER TABLE [dbo].[BASE_HFit_PPTEligibility] ADD  PRIMARY KEY CLUSTERED 
(
	SVR, DBNAME, UserID, PPTID
)

ALTER TABLE dbo.BASE_HFit_PPTEligibility
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)

USE [KenticoCMS_DataMart]
GO

/****** Object:  Index [PI_FACT_TrackerData]    Script Date: 1/8/2016 8:08:18 AM ******/
DROP INDEX [PI_FACT_TrackerData] ON [dbo].[FACT_TrackerData] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PI_FACT_TrackerData]    Script Date: 1/8/2016 8:08:18 AM ******/
CREATE UNIQUE CLUSTERED INDEX [PI_FACT_TrackerData] ON [dbo].[FACT_TrackerData]
(
	[TrackerName] ASC,
	[SVR] ASC,
	[DBNAME] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF, FILLFACTOR = 80) ON [PRIMARY]
GO



USE [KenticoCMS_DataMart]
GO

/****** Object:  Index [PI00_BASE_hfit_PPTEligibility]    Script Date: 1/8/2016 7:33:38 AM ******/
DROP INDEX [PI00_BASE_hfit_PPTEligibility] ON [dbo].[BASE_hfit_PPTEligibility]
GO

/****** Object:  Index [PI00_BASE_hfit_PPTEligibility]    Script Date: 1/8/2016 7:33:38 AM ******/
CREATE NONCLUSTERED INDEX [PI00_BASE_hfit_PPTEligibility] ON [dbo].[BASE_hfit_PPTEligibility]
(
	[DBNAME] ASC,
	[SVR] ASC,
	[UserID] ASC
)
INCLUDE ( 	[BenefitGrp],
	[BenefitStatus],
	[BirthDate],
	[City],
	[ClientCMElig],
	[ClientHRAElig],
	[ClientIncentiveElig],
	[ClientLMElig],
	[ClientPlatformElig],
	[ClientScreeningElig],
	[Company],
	[CompanyCd],
	[CoverageType],
	[DepartmentCd],
	[DepartmentName],
	[Division],
	[EmployeeStatus],
	[EmployeeType],
	[FirstName],
	[Gender],
	[HireDate],
	[JobCd],
	[JobTitle],
	[LastName],
	[LocationCd],
	[LocationName],
	[MaritalStatus],
	[MiddleInit],
	[PayCd],
	[PayGrp],
	[PersonStatus],
	[PersonType],
	[PlanEndDate],
	[PlanName],
	[PlanStartDate],
	[PlanType],
	[PostalCode],
	[PPTID],
	[State],
	[TeamName],
	[UnionCd]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [KenticoCMS_DataMart]
GO

/****** Object:  Index [CI_BASE_hfit_PPTEligibility]    Script Date: 1/8/2016 7:34:18 AM ******/
DROP INDEX [CI_BASE_hfit_PPTEligibility] ON [dbo].[BASE_hfit_PPTEligibility]
GO

/****** Object:  Index [CI_BASE_hfit_PPTEligibility]    Script Date: 1/8/2016 7:34:18 AM ******/
CREATE NONCLUSTERED INDEX [CI_BASE_hfit_PPTEligibility] ON [dbo].[BASE_hfit_PPTEligibility]
(
	[SVR] ASC,
	[DBNAME] ASC,
	[PPTID] ASC
)
INCLUDE ( 	[HashCode],
	[LASTMODIFIEDDATE]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO




-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
