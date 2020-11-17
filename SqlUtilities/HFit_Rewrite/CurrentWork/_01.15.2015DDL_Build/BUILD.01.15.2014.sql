

--***************************************************************
--***************************************************************

GO
PRINT 'Creating table HFit_LKP_GoalCloseReason for SR-47923 ';
GO

-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923

IF EXISTS (SELECT name
			 FROM sys.tables
			 WHERE name = 'HFit_LKP_GoalCloseReason') 
	BEGIN
		PRINT 'Dropping table HFit_LKP_GoalCloseReason';
		DROP TABLE dbo.HFit_LKP_GoalCloseReason;
	END;
GO
CREATE TABLE dbo.HFit_LKP_GoalCloseReason (
	ItemID int IDENTITY (1, 1) NOT NULL, 
	CloseReasonID int NOT NULL, 
	CloseReason varchar (250) NOT NULL, 
	ItemCreatedBy int NULL, 
	ItemCreatedWhen datetime2 (7) NULL, 
	ItemModifiedBy int NULL, 
	ItemModifiedWhen datetime2 (7) NULL, 
	ItemOrder int NULL, 
	ItemGUID uniqueidentifier NOT NULL, 
	CONSTRAINT PK_HFit_LKP_GoalCloseReason PRIMARY KEY CLUSTERED (CloseReasonID ASC) 
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY]) 
ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
ALTER TABLE dbo.HFit_LKP_GoalCloseReason
ADD CONSTRAINT DEFAULT_HFit_LKP_GoalCloseReason_ItemGUID DEFAULT '00000000-0000-0000-0000-000000000000' FOR ItemGUID;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI_HFit_LKP_GoalCloseReason') 
	BEGIN
		PRINT 'Creating index [CI_HFit_LKP_GoalCloseReason]';
		CREATE UNIQUE NONCLUSTERED INDEX CI_HFit_LKP_GoalCloseReason ON dbo.HFit_LKP_GoalCloseReason (CloseReasonID ASC) INCLUDE (CloseReason) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;
	END;
GO
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (0, 'Not Set', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (1, 'Achieved Personal target', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (2, 'Change In Tx Plan', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (3, 'Setback', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (4, 'Not Interested', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (5, 'Not Eligible', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
INSERT INTO dbo.HFit_LKP_GoalCloseReason (CloseReasonID, CloseReason, ItemCreatedBy, ItemCreatedWhen, ItemModifiedBy, ItemModifiedWhen, ItemOrder, ItemGUID) 
VALUES
	   (6, 'Program Period End', -1, GETDATE () , -1, GETDATE () , 0, NEWID ()) ;
GO
--SELECT * FROM HFit_LKP_GoalCloseReason;
GO
PRINT 'Created HFit_LKP_GoalCloseReason';
GO

--***************************************************************
--***************************************************************


GO
print ('FROM Create_HFit_LKP_TrackerVendor_Table.SQL') ;

if not exists (select name from sys.tables where name = 'HFit_LKP_TrackerVendor')
BEGIN
print ('Creating table [HFit_LKP_TrackerVendor]') ;
CREATE TABLE [dbo].[HFit_LKP_TrackerVendor](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [varchar](32) NOT NULL,
	[ItemCreatedBy] [int] NULL,
	[ItemCreatedWhen] [datetime2](7) NULL,
	[ItemModifiedBy] [int] NULL,
	[ItemModifiedWhen] [datetime2](7) NULL,
	[ItemOrder] [int] NULL,
	[ItemGUID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_HFit_LKP_TrackerVendor] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] ;

ALTER TABLE [dbo].[HFit_LKP_TrackerVendor] ADD  CONSTRAINT [DEFAULT_HFit_LKP_TrackerVendor_ItemGUID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [ItemGUID];

insert into HFit_LKP_TrackerVendor ([VendorName]) values ('crossover');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('meds');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('labcorp');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('quest_diag');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('staywell');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('walgreens_health');
insert into HFit_LKP_TrackerVendor ([VendorName]) values ('supervalu');

END
GO
--select * from HFit_LKP_TrackerVendor
print ('CREATED table [HFit_LKP_TrackerVendor]') ;
GO


--***************************************************************
--***************************************************************



GO

Print ('From SynchronizeTrackerTables.SQL') ;
Print ('BEGIN Synchronize Tracker Tables') ;
GO

SET NOEXEC OFF;
SET ANSI_WARNINGS ON;
SET XACT_ABORT ON;
SET IMPLICIT_TRANSACTIONS OFF;
SET ARITHABORT ON;
SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SET NUMERIC_ROUNDABORT OFF;
SET CONCAT_NULL_YIELDS_NULL ON;
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
GO

-- Add Default Constraint DEFAULT_HFit_TrackerSugaryDrinks_EventDate to [dbo].[HFit_TrackerSugaryDrinks]
-- Verify Column VendorID to [dbo].[HFit_TrackerBodyFat]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerBodyFat]';
GO
If NOT exists (select COLUMN_NAME from information_schema.COLUMNS where TABLE_NAME = 'HFit_TrackerBodyFat' and COLUMN_NAME = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerBodyFat ADD VendorID int NULL;
END 
GO

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerBMI]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBMI' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerBMI ADD VendorID int NULL;
END
GO
-- Verify Column VendorID to [dbo].[HFit_TrackerBloodSugarAndGlucose]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerBloodSugarAndGlucose]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBloodSugarAndGlucose' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerBloodSugarAndGlucose ADD VendorID int NULL;
END
GO

-- Verify Column IncludeTime to [dbo].[HFit_TrackerBloodSugarAndGlucose]

PRINT 'Verify Column IncludeTime to [dbo].[HFit_TrackerBloodSugarAndGlucose]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBloodSugarAndGlucose' and column_name = 'IncludeTime')
BEGIN
ALTER TABLE dbo.HFit_TrackerBloodSugarAndGlucose ADD IncludeTime bit NOT NULL CONSTRAINT DEFAULT_HFit_TrackerBloodSugarAndGlucose_IncludeTime DEFAULT 0;
END
GO
-- Verify Column VendorID to [dbo].[HFit_TrackerBloodPressure]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerBloodPressure]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBloodPressure' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerBloodPressure ADD VendorID int NULL;
END
GO

-- Verify Column IncludeTime to [dbo].[HFit_TrackerBloodPressure]

PRINT 'Verify Column IncludeTime to [dbo].[HFit_TrackerBloodPressure]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBloodPressure' and column_name = 'IncludeTime')
BEGIN
ALTER TABLE dbo.HFit_TrackerBloodPressure ADD IncludeTime bit NOT NULL CONSTRAINT DEFAULT_HFit_TrackerBloodPressure_IncludeTime DEFAULT 0;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerCholesterol]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerCholesterol]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerCholesterol' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerCholesterol ADD VendorID int NULL;
END
GO

-- Create Index idx_HFit_TrackerCholesterol_UserIDEventDate on [dbo].[HFit_TrackerCholesterol]

PRINT 'Create Index idx_HFit_TrackerCholesterol_UserIDEventDate on [dbo].[HFit_TrackerCholesterol]';
GO
if not exists (select name from sys.indexes where name = 'idx_HFit_TrackerCholesterol_UserIDEventDate')
BEGIN
CREATE NONCLUSTERED INDEX idx_HFit_TrackerCholesterol_UserIDEventDate ON dbo.HFit_TrackerCholesterol (EventDate, UserID) ;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerBodyMeasurements]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerBodyMeasurements]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerBodyMeasurements' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerBodyMeasurements ADD VendorID int NULL;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerHbA1c]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerHbA1c]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerHbA1c' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerHbA1c ADD VendorID int NULL;
END
GO
-- Verify Column VendorID to [dbo].[HFit_TrackerHeight]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerHeight]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerHeight' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerHeight ADD VendorID int NULL;
END
GO
-- Verify Column VendorID to [dbo].[HFit_TrackerTests]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerTests]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerTests' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerTests ADD VendorID int NULL;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerWeight]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerWeight]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerWeight' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerWeight ADD VendorID int NULL;
END
GO

-- Verify Column IncludeTime to [dbo].[HFit_TrackerWeight]

PRINT 'Verify Column IncludeTime to [dbo].[HFit_TrackerWeight]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerWeight' and column_name = 'IncludeTime')
BEGIN
ALTER TABLE dbo.HFit_TrackerWeight ADD IncludeTime bit NOT NULL CONSTRAINT DEFAULT_HFit_TrackerWeight_IncludeTime DEFAULT 0;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerRestingHeartRate]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerRestingHeartRate]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerRestingHeartRate' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerRestingHeartRate ADD VendorID int NULL;
END
GO
-- Verify Column IncludeTime to [dbo].[HFit_TrackerRestingHeartRate]

PRINT 'Verify Column IncludeTime to [dbo].[HFit_TrackerRestingHeartRate]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerRestingHeartRate' and column_name = 'IncludeTime')
BEGIN
ALTER TABLE dbo.HFit_TrackerRestingHeartRate ADD IncludeTime bit NOT NULL CONSTRAINT DEFAULT_HFit_TrackerRestingHeartRate_IncludeTime DEFAULT 0;
END
GO

-- Verify Column VendorID to [dbo].[HFit_TrackerShots]

PRINT 'Verify Column VendorID to [dbo].[HFit_TrackerShots]';
GO
if NOT EXISTS (Select COLUMN_NAME from information_schema.COLUMNS where table_name = 'HFit_TrackerShots' and column_name = 'VendorID')
BEGIN
ALTER TABLE dbo.HFit_TrackerShots ADD VendorID int NULL;
END
GO

---- Create Foreign Key FK_HFit_TrackerBloodPressure_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBloodPressure]

--PRINT 'Create Foreign Key FK_HFit_TrackerBloodPressure_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBloodPressure]';
--GO
--if NOT EXISTS (Select name from sys.objects where name = 'FK_HFit_TrackerBloodPressure_HFit_LKP_TrackerVendor')
--BEGIN
--ALTER TABLE dbo.HFit_TrackerBloodPressure
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerBloodPressure_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerBloodPressure CHECK CONSTRAINT FK_HFit_TrackerBloodPressure_HFit_LKP_TrackerVendor;
--END
--GO

---- Create Foreign Key FK_HFit_TrackerBloodSugarAndGlucose_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBloodSugarAndGlucose]

--PRINT 'Create Foreign Key FK_HFit_TrackerBloodSugarAndGlucose_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBloodSugarAndGlucose]';
--GO
--if NOT EXISTS (Select name from sys.objects where name = 'FK_HFit_TrackerBloodSugarAndGlucose_HFit_LKP_TrackerVendor')
--BEGIN
--ALTER TABLE dbo.HFit_TrackerBloodSugarAndGlucose
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerBloodSugarAndGlucose_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerBloodSugarAndGlucose CHECK CONSTRAINT FK_HFit_TrackerBloodSugarAndGlucose_HFit_LKP_TrackerVendor;
--END
--GO

---- Create Foreign Key FK_HFit_TrackerBMI_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBMI]

--PRINT 'Create Foreign Key FK_HFit_TrackerBMI_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBMI]';
--GO
--if NOT EXISTS (Select name from sys.objects where name = 'FK_HFit_TrackerBMI_HFit_LKP_TrackerVendor')
--BEGIN
--ALTER TABLE dbo.HFit_TrackerBMI
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerBMI_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerBMI CHECK CONSTRAINT FK_HFit_TrackerBMI_HFit_LKP_TrackerVendor;
--END
--GO

---- Create Foreign Key FK_HFit_TrackerBodyFat_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBodyFat]

--PRINT 'Create Foreign Key FK_HFit_TrackerBodyFat_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBodyFat]';
--GO
--ALTER TABLE dbo.HFit_TrackerBodyFat
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerBodyFat_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerBodyFat CHECK CONSTRAINT FK_HFit_TrackerBodyFat_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerBodyMeasurements_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBodyMeasurements]

--PRINT 'Create Foreign Key FK_HFit_TrackerBodyMeasurements_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerBodyMeasurements]';
--GO
--ALTER TABLE dbo.HFit_TrackerBodyMeasurements
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerBodyMeasurements_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerBodyMeasurements CHECK CONSTRAINT FK_HFit_TrackerBodyMeasurements_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerCholesterol_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerCholesterol]

--PRINT 'Create Foreign Key FK_HFit_TrackerCholesterol_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerCholesterol]';
--GO
--ALTER TABLE dbo.HFit_TrackerCholesterol
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerCholesterol_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerCholesterol CHECK CONSTRAINT FK_HFit_TrackerCholesterol_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerHBA1C_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerHbA1c]

--PRINT 'Create Foreign Key FK_HFit_TrackerHBA1C_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerHbA1c]';
--GO
--ALTER TABLE dbo.HFit_TrackerHbA1c
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerHBA1C_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerHbA1c CHECK CONSTRAINT FK_HFit_TrackerHBA1C_HFit_LKP_TrackerVendor;
--GO
---- Create Foreign Key FK_HFit_TrackerHeight_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerHeight]

--PRINT 'Create Foreign Key FK_HFit_TrackerHeight_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerHeight]';
--GO
--ALTER TABLE dbo.HFit_TrackerHeight
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerHeight_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerHeight CHECK CONSTRAINT FK_HFit_TrackerHeight_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerRestingHeartRate_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerRestingHeartRate]

--PRINT 'Create Foreign Key FK_HFit_TrackerRestingHeartRate_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerRestingHeartRate]';
--GO
--ALTER TABLE dbo.HFit_TrackerRestingHeartRate
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerRestingHeartRate_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerRestingHeartRate CHECK CONSTRAINT FK_HFit_TrackerRestingHeartRate_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerShots_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerShots]

--PRINT 'Create Foreign Key FK_HFit_TrackerShots_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerShots]';
--GO
--ALTER TABLE dbo.HFit_TrackerShots
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerShots_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerShots CHECK CONSTRAINT FK_HFit_TrackerShots_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerTests_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerTests]

--PRINT 'Create Foreign Key FK_HFit_TrackerTests_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerTests]';
--GO
--ALTER TABLE dbo.HFit_TrackerTests
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerTests_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerTests CHECK CONSTRAINT FK_HFit_TrackerTests_HFit_LKP_TrackerVendor;
--GO

---- Create Foreign Key FK_HFit_TrackerWeight_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerWeight]

--PRINT 'Create Foreign Key FK_HFit_TrackerWeight_HFit_LKP_TrackerVendor on [dbo].[HFit_TrackerWeight]';
--GO
--ALTER TABLE dbo.HFit_TrackerWeight
--		WITH CHECK
--ADD CONSTRAINT FK_HFit_TrackerWeight_HFit_LKP_TrackerVendor FOREIGN KEY (VendorID) REFERENCES dbo.HFit_LKP_TrackerVendor (ItemID) ;
--ALTER TABLE dbo.HFit_TrackerWeight CHECK CONSTRAINT FK_HFit_TrackerWeight_HFit_LKP_TrackerVendor;
--GO

GO

Print ('COMPLETED Synchronize Tracker Tables') ;



--***************************************************************
--***************************************************************

GO
print ('FROM Create_HFit_LKP_EDW_RejectMPI_Table.sql') ;
PRINT 'Creating table HFit_LKP_EDW_RejectMPI for CR47516';
GO

-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923

IF EXISTS (SELECT name
			 FROM sys.tables
			 WHERE name = 'HFit_LKP_EDW_RejectMPI') 
	BEGIN
		PRINT 'Dropping table HFit_LKP_EDW_RejectMPI';
		DROP TABLE dbo.HFit_LKP_EDW_RejectMPI;
	END;
GO

CREATE TABLE dbo.HFit_LKP_EDW_RejectMPI (
	ItemID int IDENTITY (1, 1) NOT NULL, 
	RejectMPICode int NOT NULL,
	RejectUserGUID uniqueidentifier NULL, 
	ItemCreatedBy int NULL, 
	ItemCreatedWhen datetime2 (7) NULL, 
	ItemModifiedBy int NULL, 
	ItemModifiedWhen datetime2 (7) NULL, 
	ItemOrder int NULL, 
	ItemGUID uniqueidentifier NOT NULL, 
	CONSTRAINT PK_HFit_LKP_EDW_RejectMPI PRIMARY KEY CLUSTERED (ItemID) 
		WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
		ON [PRIMARY]) 
ON [PRIMARY];
GO
SET ANSI_PADDING OFF;
GO
ALTER TABLE dbo.HFit_LKP_EDW_RejectMPI
ADD CONSTRAINT DEFAULT_HFit_LKP_EDW_RejectMPI_ItemGUID DEFAULT newid() FOR ItemGUID;
GO

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_LKP_EDW_RejectMPI_MPI_GUID') 
	BEGIN
		PRINT 'Creating index [PI_HFit_LKP_EDW_RejectMPI_MPI_GUID]';
		CREATE UNIQUE NONCLUSTERED INDEX [PI_HFit_LKP_EDW_RejectMPI_MPI_GUID] ON [dbo].[HFit_LKP_EDW_RejectMPI]
			(
				[RejectMPICode] ASC,
				[RejectUserGUID] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END;
GO

if exists (select name from sys.objects where name = 'proc_AddRejectMPI')
begin 
	DROP PROCEDURE proc_AddRejectMPI ;
END
go
PRINT 'CREATING proc_AddRejectMPI ';
go

create proc proc_AddRejectMPI  (@MpiToReject as int)
as 
BEGIN	
	INSERT INTO [dbo].[HFit_LKP_EDW_RejectMPI]
           (
				[RejectMPICode],ItemCreatedWhen, ItemModifiedWhen
           )
     VALUES
           (
				@MpiToReject, getdate(),getdate()
		   );
END
go
PRINT 'INSERTING ROW proc_AddRejectMPI ';
exec proc_AddRejectMPI -991100
GO
--select * from [HFit_LKP_EDW_RejectMPI]
--GO
PRINT 'CREATING proc_DelRejectMPI ';
go
if exists (select name from sys.objects where name = 'proc_DelRejectMPI')
begin 
	DROP PROCEDURE proc_DelRejectMPI ;
END
go

create proc proc_DelRejectMPI  (@MpiToReject as int)
as 
BEGIN	
	delete from [dbo].[HFit_LKP_EDW_RejectMPI] where RejectMPICode = @MpiToReject ;
END
go
PRINT 'DELETING ROW proc_DelRejectMPI ';
exec proc_DelRejectMPI -991100
GO
--select * from [HFit_LKP_EDW_RejectMPI]
--GO

PRINT 'CREATED PROC proc_AddRejectMPI';
PRINT 'CREATED PROC proc_DelRejectMPI';
PRINT 'CREATED table HFit_LKP_EDW_RejectMPI for CR47516 ';
GO


--***************************************************************
--***************************************************************

--	select Table_NAme, Column_NAme, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where CHARACTER_MAXIMUM_LENGTH < 0 Order by Data_Type
--where Table_Name = 'HFit_CoachingTermsAndConditionsSettings' ;

--	select * FROM Information_Schema.Columns where Table_Name = 'EDW_TEST_DEL' ;
--	select Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where Table_Name = 'EDW_TEST_DEL' ;
--	select Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE FROM Information_Schema.Columns where Table_Name = 'HFit_CoachingTermsAndConditionsSettings' ;

IF EXISTS (SELECT name
			 FROM sys.objects
			 WHERE name = 'Proc_Attach_Delete_Audit') 
	BEGIN
		DROP PROCEDURE Proc_Attach_Delete_Audit;
	END;
GO

CREATE PROCEDURE Proc_Attach_Delete_Audit (
	   @Tbl AS nvarchar (500)) 
AS
	 BEGIN

/**************************************************************
This procedure will copy a table and recreate it using only the
raw column data types to recreate the MIRROR table. No defaults, 
identities, or constraints are copied over. All columns are 
defined as NULLABLE. This new table has the parent table's name
with a suffix of "_DelAudit".

A column "RowDeletionDate" is added to the new table and is 
defaulted to getdate(). An index is applied to this column so
that max perfomance can be acheived when pulling a particular
datetime.

A trigger is added to the parent table using the parent name 
plus a suffix of "_DelTRIG". This trigger only fires when a 
delete operation is completed. It then copies the deleted rows
into the "_DelAudit" table.
**************************************************************/

/***************************
Declare the needed variables
***************************/

		 --DECLARE @Tbl AS nvarchar (500) = 'EDW_TEST_DEL';
		 DECLARE @Trktbl AS nvarchar (500) = '';
		 DECLARE @Deltriggername AS nvarchar (500) = '';
		 DECLARE @Mysql AS nvarchar (2000) = '';
		 DECLARE @CreateDDL AS nvarchar (max) = '';
		 DECLARE @SelectCOLS AS nvarchar (max) = '';

		 DECLARE @Colname AS nvarchar (254) = '';
		 DECLARE @Dtype AS nvarchar (254) = '';
		 DECLARE @CHARACTER_MAXIMUM_LENGTH AS INT;
		 DECLARE @NUMERIC_PRECISION AS INT;
		 DECLARE @NUMERIC_SCALE AS INT;

/*****************
Set initial values
*****************/

		 SET @Trktbl = @Tbl + '_DelAudit';
		 SET @Deltriggername = @Tbl + '_DelTRIG';

		 IF EXISTS (SELECT Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 PRINT 'Dropping table ' + @Trktbl;
				 SET @Mysql = 'DROP TABLE ' + @Trktbl;
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Dropped table ' + @Trktbl;
			 END;

		 IF OBJECT_ID (@Deltriggername , 'TR') IS NOT NULL
			 BEGIN
				 PRINT 'Dropping TRIGGER ' + @Deltriggername;
				 SET @Mysql = 'DROP TRIGGER ' + @Deltriggername;
				 EXEC Sp_Executesql @Mysql;
			 END;

		 SET @CreateDDL = 'CREATE TABLE ' + @Trktbl + '(';
		 DECLARE Col_Cursor CURSOR
			 FOR SELECT Column_Name, Data_Type, CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
				   FROM Information_Schema.Columns
				   WHERE Table_Name = @Tbl;
		 OPEN Col_Cursor;
		 FETCH Next FROM Col_Cursor INTO @Colname , @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE ;

		 WHILE @@Fetch_Status = 0
			 BEGIN
				 SET @SelectCOLS = @SelectCOLS + QUOTENAME (@Colname) + ',' ;
				 SET @CreateDDL = @CreateDDL + QUOTENAME (@Colname) + ' ' + QUOTENAME (@Dtype) ;
				 IF (@Dtype = 'float' )
				 BEGIN
					PRINT ('FLOAT DDL: ' + @CreateDDL);		 
				 END
				 ELSE IF (@Dtype = 'int' OR @Dtype = 'bigint' OR @Dtype = 'tinyint' OR @Dtype = 'smallint')
				 BEGIN
					PRINT (@Dtype + ': INT DDL: ' + @CreateDDL);		 
				 END
				 ELSE IF (@Dtype = 'nvarchar' OR  @Dtype = 'varchar')
				 BEGIN
					PRINT (@Dtype + ' DDL: ' + @CreateDDL);		 
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE IF (@Dtype = 'varbinary')
				 BEGIN
					PRINT (@Dtype + ' DDL: ' + @CreateDDL);		 
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE IF (@CHARACTER_MAXIMUM_LENGTH is not null)
				 BEGIN
					PRINT ('00 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@NUMERIC_PRECISION is not null AND @NUMERIC_SCALE is not null)
				 BEGIN
					PRINT ('01 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@NUMERIC_PRECISION as nvarchar(50)) + ', ' +cast(@NUMERIC_SCALE as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@NUMERIC_PRECISION is not null AND @NUMERIC_SCALE is null)
				 BEGIN
					PRINT ('02 - DDL: ' + @CreateDDL);		 
					SET @CreateDDL = @CreateDDL + '(' + cast(@NUMERIC_PRECISION as nvarchar(50)) + ', ' +cast(@NUMERIC_SCALE as nvarchar(50)) + ') ' ;
				 END
				 ELSE IF (@CHARACTER_MAXIMUM_LENGTH is not null)
				 BEGIN
					PRINT ('03 - DDL: ' + @CreateDDL);	
					IF (@CHARACTER_MAXIMUM_LENGTH = -1)	 
						SET @CreateDDL = @CreateDDL + '(max) ';
					ELSE
						SET @CreateDDL = @CreateDDL + '(' + cast(@CHARACTER_MAXIMUM_LENGTH as nvarchar(50)) + ') ';
				 END
				 ELSE 
				 BEGIN
					PRINT ('04 - DDL: ' + @CreateDDL);		 
				 END
				 
				 SET @CreateDDL = @CreateDDL + ' NULL, ';
				 -- PRINT ('05 - DDL: ' + @CreateDDL);		 
				 
				 FETCH Next FROM Col_Cursor INTO @Colname , @Dtype, @CHARACTER_MAXIMUM_LENGTH, @NUMERIC_PRECISION, @NUMERIC_SCALE ;
				 /*
				 --TURN On these statements when needed to track individual items.
				 print (@Colname) ;
				 print (@Dtype) ;
				 print ( @CHARACTER_MAXIMUM_LENGTH) ;
				 print ( @NUMERIC_PRECISION) ;
				 print ( @NUMERIC_SCALE ) ;
				 */
			 END;

		 CLOSE Col_Cursor;
		 DEALLOCATE Col_Cursor;

		 --Strip off the last COMMA

		 SET @SelectCOLS = RTRIM (@SelectCOLS) ;
		 SET @CreateDDL = RTRIM (@CreateDDL) ;
		 SET @CreateDDL = LEFT (@CreateDDL , LEN (@CreateDDL) - 1) ;
		 SET @CreateDDL = @CreateDDL + ')';

		 PRINT ('____________________________________________________________');		 
		 PRINT ('1 - Creating table ' + @Trktbl);		 
		 PRINT ('2- DLL: ' );
		 PRINT ('3- ' + @CreateDDL);

		 EXEC Sp_Executesql @CreateDDL;
		 PRINT ('____________________________________________________________');		 

		 IF EXISTS (SELECT Name
					  FROM Sys.Tables
					  WHERE Name = @Trktbl) 
			 BEGIN
				 SET @Mysql = 'alter table ' + @Trktbl + ' add RowDeletionDate datetime default getdate() ';
				 EXEC Sp_Executesql @Mysql;
				 PRINT 'Added RowDeletionDate: ';
			 END;

		 SET @CreateDDL = 'CREATE NONCLUSTERED INDEX [PI_' + @Trktbl + '] ON [' + @Trktbl + '] ';
		 SET @CreateDDL = @CreateDDL + '(';
		 SET @CreateDDL = @CreateDDL + '	[RowDeletionDate] ASC ';
		 SET @CreateDDL = @CreateDDL + ')';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added RowDeletionDate INDEX ';

		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE TRIGGER ' + @Tbl + '_DelTRIG ';
		 SET @CreateDDL = @CreateDDL + '    ON ' + @Tbl;
		 SET @CreateDDL = @CreateDDL + '    FOR DELETE ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + '	INSERT INTO ' + @Trktbl + ' SELECT '+@SelectCOLS+' getdate() from deleted ';
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added ' + @Tbl + ' TRIGGER';
		 print (@CreateDDL) ;

		 declare @viewname as nvarchar(250) = '' ;
		 set @viewname = 'view_EDW_' + @Tbl + '_DelAudit ';
		 if exists(Select name from sys.views where name = @viewname)
		 BEGIN
			set @Mysql = 'drop view ' + @viewname ;
			EXEC Sp_Executesql @Mysql;
			print ('Dropped existing view ' + @viewname) ;
		 END

		 SET @CreateDDL = '';
		 SET @CreateDDL = @CreateDDL + 'CREATE VIEW view_EDW_' + @Tbl + '_DelAudit ';
		 SET @CreateDDL = @CreateDDL + 'AS ';
		 SET @CreateDDL = @CreateDDL + ' SELECT * from ' + @Trktbl;
		 EXEC Sp_Executesql @CreateDDL;
		 PRINT 'Added VIEW: ' + @viewname ;
		 print (@CreateDDL) ;
	 END;

GO

--*********************************************************
--TEST THE PROC
--*********************************************************
if exists (select name from sys.tables where name = 'Edw_Test_Del')
BEGIN
	DROP TABLE Edw_Test_Del;
END
GO

CREATE TABLE Dbo.Edw_Test_Del (Todaydate datetime2 (7) NULL
							 , Rowidnbr int IDENTITY (1 , 1) 
											NOT NULL
							 , Tguid uniqueidentifier NULL
							 , DecVal decimal (10,2)
							 ,FloatVal float
							 ,charVal char(50)
							 ,nvcVal nvarchar(1000)
							 ,vcVal varchar(1000)) ;

GO

ALTER TABLE Dbo.Edw_Test_Del
ADD CONSTRAINT Df_Edw_Test_Del_Todaydate DEFAULT GETDATE () FOR Todaydate;
GO

ALTER TABLE Dbo.Edw_Test_Del
ADD CONSTRAINT Df_Edw_Test_Del_Tguid DEFAULT NEWID () FOR Tguid;
GO

EXEC Proc_Attach_Delete_Audit 'EDW_TEST_DEL';
--EXEC Proc_Attach_Delete_Audit 'HFit_CoachingTermsAndConditionsSettings';
--EXEC Proc_Attach_Delete_Audit 'HFit_CoachingHealthInterest';
--EXEC Proc_Attach_Delete_Audit 'OM_Contact';
GO

INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal) 
VALUES
	   (NEWID (), 600.238, 'DMiller', 'DMiller', 'DMiller', 126.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 500.23, 'DMiller', 'DMiller', 'DMiller', 226.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 400.23, 'DMiller', 'DMiller', 'DMiller', 326.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 300.23, 'DMiller', 'DMiller', 'DMiller', 426.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 200.23, 'DMiller', 'DMiller', 'DMiller', 526.3345 ) ;
INSERT INTO Edw_Test_Del (Tguid, DecVal, charVal, nvcVal, vcVal, FloatVal)   
VALUES
	   (NEWID (), 100.23, 'DMiller', 'DMiller', 'DMiller', 626.3345 ) ;

DELETE FROM Edw_Test_Del
  WHERE Tguid IN (SELECT TOP 1 Tguid
					FROM Edw_Test_Del
					ORDER BY Tguid DESC) ;

--DELETE FROM Edw_Test_Del WHERE DEcVal > 200

--SELECT * FROM Edw_Test_Del;
--SELECT * FROM Edw_Test_Del_DelAudit;
--select * from view_EDW_EDW_TEST_DEL_DelAudit ;

if exists (select name from sys.tables where name = 'Edw_Test_Del')
BEGIN
	print ('DROP TABLE Edw_Test_Del') ;
	DROP TABLE Edw_Test_Del;
END
GO
if exists (select name from sys.tables where name = 'Edw_Test_Del_DelAudit')
BEGIN
	print ('DROP TABLE Edw_Test_Del_DelAudit') ;
	DROP TABLE Edw_Test_Del_DelAudit;
END
GO


--***************************************************************
--***************************************************************



GO

if not exists(select name from sys.indexes where name = 'PI_View_CMS_Tree_Joined_Regular')
BEGIN
	CREATE NONCLUSTERED INDEX [PI_View_CMS_Tree_Joined_Regular]
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentID])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTR_ClassCulture
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_CMSTREE_ClassDocID')
BEGIN
	CREATE NONCLUSTERED INDEX PI_CMSTREE_ClassDocID
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentID])
END
go

if NOT exists(select name from sys.indexes where name = 'CI_CMSTree_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX CI_CMSTree_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeID],[NodeAliasPath],[NodeParentID],[NodeLevel],[NodeGUID],[NodeOrder],[NodeLinkedNodeID],[DocumentModifiedWhen],[DocumentForeignKeyValue],[DocumentPublishedVersionHistoryID],[DocumentGUID])
END


if NOT exists(select name from sys.indexes where name = 'CI_HFit_HealthAssesmentUserQuestion_NodeGUID')
BEGIN
	CREATE NONCLUSTERED INDEX [CI_HFit_HealthAssesmentUserQuestion_NodeGUID]
	ON [dbo].[HFit_HealthAssesmentUserQuestion] ([HAQuestionNodeGUID])
	INCLUDE ([ItemID],[HAQuestionScore],[ItemModifiedWhen],[HARiskAreaItemID],[CodeName],[PreWeightedScore],[IsProfessionallyCollected])
END
GO

if NOT exists(select name from sys.indexes where name = 'PI_GuidLang')
BEGIN
	CREATE NONCLUSTERED INDEX [PI_GuidLang]
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([NodeGUID],[DocumentCulture])
END
Go

if NOT exists(select name from sys.indexes where name = 'PI_ClassLang')
BEGIN
	CREATE NONCLUSTERED INDEX PI_ClassLang
	ON [dbo].[View_CMS_Tree_Joined_Regular] ([ClassName],[DocumentCulture])
	INCLUDE ([NodeGUID],[DocumentForeignKeyValue])
END
GO

if NOT exists(select name from sys.indexes where name = 'CI_EDW_HealthAssesment_HAModuleItemID')
BEGIN
	CREATE NONCLUSTERED INDEX CI_EDW_HealthAssesment_HAModuleItemID
	ON [dbo].[HFit_HealthAssesmentUserRiskCategory] ([HAModuleItemID])
	INCLUDE ([ItemID],[ItemModifiedWhen],[HARiskCategoryScore],[CodeName],[PreWeightedScore],[HARiskCategoryNodeGUID])
END

PRINT('Processing view_EDW_HealthAssesment');
GO


if exists(select name from sys.views where name = 'view_EDW_HealthAssesment')
BEGIN
	drop view view_EDW_HealthAssesment 
END
go
--select top 100 * from [view_EDW_HealthAssesment]
create VIEW [dbo].[view_EDW_HealthAssesment]
AS
--********************************************************************************************************
--7/15/2014 17:19 min. 46,750 Rows DEV
--7/15/2014 per Mark Turner
--HAModuleDocumentID is on its way out, so is - 
--Module - RiskCategory - RiskArea - Question - Answer 
--all the "DocumentID" fields are deprecated and replaced by corresponding NodeGUID fields
--8/7/2014 - Executed in DEV with GUID changes and returned 51K Rows in 00:43:10.
--8/8/2014 - Generated corrected view in DEV
-- Verified last mod date available to EDW 9.10.2014

--09.08.2014: John Croft and I working together, realized there is a deficit in the ability 
--of the EDW to recognize changes to database records based on the last modified date of a row. 
--The views that we are currently using in the database or deeply nested. This means that 
--several base tables are involved in building a single view of data.

--09.30.2014: Verified with John Croft that he does want this view to return multi-languages.
--
--The views were initially designed to recognize a date change based on a record change very 
--high in the data hierarchy, the CMS Tree level which is the top most level. However, John 
--and I recognize that data can change at any level in the hierarchy and those changes must be 
--recognized as well. Currently, that is not the case. With the new modification to the views, 
--changes in CMS documents and base tables will filter up through the hierarchy and the EDW load 
--process will be able to realize that a change in this row’s data may affect and intrude into 
--the warehouse.

-- 10.01.2014 - Reviewed by Mark and Dale for use of the GUIDS
-- 10.01.2014 - Reviewed by Mark and Dale for use of Joins and fixed two that were incorrect (Thanks to Mark)

-- 10.23.2014 - (WDM) added two columns for the EDW HAPaperFlg / HATelephonicFlg
--			HAPaperFlg is whether the question was reveived electronically or on paper
--			HATelephonicFlg is whether the question was reveived by telephone or not

-- FIVE Pieces needed per John C. 10.16.2014
--	Document GUID -> HealthAssesmentUserStartedNodeGUID
--	Module GUID -> Module -> HAUserModule.HAModuleNodeGUID
--	Category GUID -> Category
--	RiskArea Node Guid -> RiskArea 
--	Question Node Guid -> Question
--	Answer Node Guid -> Answer 

 --   10.30.2014 : Sowmiya 
 --   The following are the possible values allowed in the HAStartedMode and HACompletedMode columns of the Hfit_HealthAssesmentUserStarted table
 --      Unknown = 0, 
 --       Paper = 1,  // Paper HA
 --       Telephonic = 2, // Telephonic HA
 --       Online = 3, // Online HA
 --       Ipad = 4 // iPAD
 -- 11.05.2014 - Mark T. / Dale M. needed to get the Document for the user : ADDED inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
 -- 11.05.2014 - removed the Distinct - may find it necessary to put it back as duplicates may be there. But the server resources required to do this may not be avail on P5.
 -- 12.02.2014 - (wdm)Found that the view was being overwritten between Prod 1 and the copy of Prod 5 / Prod 1. Found a script inside a job on PRod 5 that reverted the view to a previous state. Removed the script and the view migrates correctly (d. miller and m. kimenski)
 -- 12.02.2014 - (wdm) Found DUPS in Prod 1 and Prod 2, none in Prod 3. 
 -- 12.17.2014 - Added two columns requested by the EDW team as noted by comments next to each column.
 -- 12.29.2014 - Stripped HTML out of Title #47619
 -- 12.31.2014 - Eliminated negative MPI's in response to CR47516 
 -- 01.02.2014 - Tested the removal of negative MPI's in response to CR47516 
 --********************************************************************************************************
	--427 61788DF7-955D-4A78-B77E-3DA340847AE7
	SELECT 
		HAUserStarted.ItemID AS UserStartedItemID				
		, VHAJ.NodeGUID as  HealthAssesmentUserStartedNodeGUID	--Per John C. 10.16.2014 requested that this be put back into the view.	
																--11.05.2014 - Changed from CMS_TREE Joined to View_HFit_HealthAssessment_Joined Mark T. / Dale M.
		, HAUserStarted.UserID
		, CMSUser.UserGUID
		, UserSettings.HFitUserMpiNumber
		, CMSSite.SiteGUID
		, ACCT.AccountID
		, ACCT.AccountCD
		, HAUserStarted.HAStartedDt
		, HAUserStarted.HACompletedDt
		, HAUserModule.ItemID AS UserModuleItemId
		, HAUserModule.CodeName AS UserModuleCodeName
		
		--, VCTJ.DocumentGUID as HAModuleNodeGUID	--WDM 8/7/2014 as HAModuleDocumentID
		--, VCTJ.NodeGUID as HAModuleNodeGUID		--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		--, VCTJ.NodeGUID as CMSNodeGuid			--WDM 8/7/2014 as HAModuleDocumentID	--Left this and the above to kepp existing column structure

		, HAUserModule.HAModuleNodeGUID				--WDM 9/30/2014 as HAModuleDocumentID	--Mark and Dale use NodeGUID instead of Doc GUID
		
		--, NULL as CMSNodeGuid						--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL
		, VHAJ.NodeGUID as CMSNodeGuid				--WDM 8/7/2014 as HAModuleDocumentID	--WDM 10.02.2014 place holder for EDW ETL per John C., Added back per John C. 10.16.2014

		, NULL as HAModuleVersionID		--WDM 10.02.2014 place holder for EDW ETL
		, HARiskCategory.ItemID AS UserRiskCategoryItemID
		, HARiskCategory.CodeName AS UserRiskCategoryCodeName
		, HARiskCategory.HARiskCategoryNodeGUID						--WDM 8/7/2014 as HARiskCategoryDocumentID
		, NULL as HARiskCategoryVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserRiskArea.ItemID AS UserRiskAreaItemID
		, HAUserRiskArea.CodeName AS UserRiskAreaCodeName
		, HAUserRiskArea.HARiskAreaNodeGUID							--WDM 8/7/2014 as HARiskAreaDocumentID
		, NULL as HARiskAreaVersionID			--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.ItemID AS UserQuestionItemID
		, dbo.udf_StripHTML(HAQuestionsView.Title) as Title			--WDM 47619 12.29.2014
		, HAUserQuestion.HAQuestionNodeGUID	as HAQuestionGuid		--WDM 9.2.2014	This is a repeat field but had to stay to match the previous view - this is the NODE GUID 
		--															and matches to the definition file to get the question. This tells you the question, language agnostic.
		, HAUserQuestion.CodeName AS UserQuestionCodeName
		, NULL as HAQuestionDocumentID	--WDM 10.1.2014 - this is GOING AWAY 		--WDM 10.02.2014 place holder for EDW ETL
		, NULL as HAQuestionVersionID			--WDM 10.1.2014 - this is GOING AWAY - no versions across environments 		--WDM 10.02.2014 place holder for EDW ETL
		, HAUserQuestion.HAQuestionNodeGUID		--WDM 10.01.2014	Left this in place to preserve column structure.		
		, HAUserAnswers.ItemID AS UserAnswerItemID
		, HAUserAnswers.HAAnswerNodeGUID								--WDM 8/7/2014 as HAAnswerDocumentID
		, NULL as HAAnswerVersionID		--WDM 10.1.2014 - this is GOING AWAY - no versions across environments		--WDM 10.02.2014 place holder for EDW ETL
		, HAUserAnswers.CodeName AS UserAnswerCodeName
		, HAUserAnswers.HAAnswerValue
		, HAUserModule.HAModuleScore
		, HARiskCategory.HARiskCategoryScore
		, HAUserRiskArea.HARiskAreaScore
		, HAUserQuestion.HAQuestionScore
		, HAUserAnswers.HAAnswerPoints
		, HAUserQuestionGroupResults.PointResults
		, HAUserAnswers.UOMCode
		, HAUserStarted.HAScore
		, HAUserModule.PreWeightedScore AS ModulePreWeightedScore
		, HARiskCategory.PreWeightedScore AS RiskCategoryPreWeightedScore
		, HAUserRiskArea.PreWeightedScore AS RiskAreaPreWeightedScore
		, HAUserQuestion.PreWeightedScore AS QuestionPreWeightedScore
		, HAUserQuestionGroupResults.CodeName AS QuestionGroupCodeName       
       ,CASE WHEN HAUserAnswers.ItemCreatedWhen = HAUserAnswers.ItemModifiedWhen THEN 'I'
             ELSE 'U'
        END AS ChangeType
		,HAUserAnswers.ItemCreatedWhen
		,HAUserAnswers.ItemModifiedWhen
		,HAUserQuestion.IsProfessionallyCollected

	   ,HARiskCategory.ItemModifiedWhen as HARiskCategory_ItemModifiedWhen
	   ,HAUserRiskArea.ItemModifiedWhen as HAUserRiskArea_ItemModifiedWhen
	   ,HAUserQuestion.ItemModifiedWhen as HAUserQuestion_ItemModifiedWhen
	   ,HAUserAnswers.ItemModifiedWhen as HAUserAnswers_ItemModifiedWhen
	   ,HAUserStarted.HAPaperFlg
	   ,HAUserStarted.HATelephonicFlg
	   ,HAUserStarted.HAStartedMode		--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 
	   ,HAUserStarted.HACompletedMode	--12.11.2014 WDM Sowmiya and dale talked and decided to implement this column 12.17.2014 - Added 

	    ,VHCJ.DocumentCulture as DocumentCulture_VHCJ
		,HAQuestionsView.DocumentCulture as DocumentCulture_HAQuestionsView
	FROM
	dbo.HFit_HealthAssesmentUserStarted AS HAUserStarted
	INNER JOIN dbo.CMS_User AS CMSUser ON HAUserStarted.UserID = CMSUser.UserID
	INNER JOIN dbo.CMS_UserSettings AS UserSettings ON UserSettings.UserSettingsUserID = CMSUser.UserID
		AND HFitUserMpiNumber >= 0 AND HFitUserMpiNumber is not NULL		-- (WDM) CR47516 
	INNER JOIN dbo.CMS_UserSite AS UserSite ON CMSUser.UserID = UserSite.UserID
	INNER JOIN dbo.CMS_Site AS CMSSite ON UserSite.SiteID = CMSSite.SiteID
	INNER JOIN dbo.HFit_Account AS ACCT ON ACCT.SiteID = CMSSite.SiteID	
	INNER JOIN dbo.HFit_HealthAssesmentUserModule AS HAUserModule ON HAUserStarted.ItemID = HAUserModule.HAStartedItemID
		
	inner join View_HFit_HACampaign_Joined VHCJ on VHCJ.NodeGUID = HAUserStarted.HACampaignNodeGUID 
		AND VHCJ.NodeSiteID = UserSite.SiteID AND VHCJ.DocumentCulture = 'en-US'	--11.05.2014 - Mark T. / Dale M. - 
	
	--11.05.2014 - Mark T. / Dale M. needed to get the Document for the user
	inner join View_HFit_HealthAssessment_Joined as VHAJ on VHAJ.DocumentID = VHCJ.HealthAssessmentID
		
	--11.05.2014 - Mark T. / Dale M. removed the link to View_CMS_Tree_Joined and replaced with View_HFit_HealthAssessment_Joined
	--inner join View_CMS_Tree_Joined as VCTJ on VCTJ.NodeGUID = HAUserModule.HAModuleNodeGUID
	--	and VCTJ.DocumentCulture = 'en-US'	--10.01.2014 put here to match John C. req. for language agnostic.

	INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS HARiskCategory ON HAUserModule.ItemID = HARiskCategory.HAModuleItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea ON HARiskCategory.ItemID = HAUserRiskArea.HARiskCategoryItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserQuestion AS HAUserQuestion ON HAUserRiskArea.ItemID = HAUserQuestion.HARiskAreaItemID
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS HAQuestionsView ON HAUserQuestion.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
		AND HAQuestionsView.DocumentCulture = 'en-US'
	LEFT OUTER JOIN dbo.HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults ON HAUserRiskArea.ItemID = HAUserQuestionGroupResults.HARiskAreaItemID
	INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS HAUserAnswers ON HAUserQuestion.ItemID = HAUserAnswers.HAQuestionItemID

	where UserSettings.HFitUserMpiNumber NOT IN (Select RejectMPICode from HFit_LKP_EDW_RejectMPI)	
	--CMSUser.UserGUID not in  (Select RejectUserGUID from HFit_LKP_EDW_RejectMPI)	--61788DF7-955D-4A78-B77E-3DA340847AE7

GO

PRINT('Processed view_EDW_HealthAssesment');
GO
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesment.sql'); 
GO 


--***************************************************************
--***************************************************************


GO
print('***** FROM: view_EDW_CoachingDetail.sql'); 
go

print ('Processing: view_EDW_CoachingDetail ') ;
go

if exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN
	drop index [View_CMS_Tree_Joined_Regular].CI2_View_CMS_Tree_Joined_Regular;
END

if not exists(select NAME from sys.indexes where NAME = 'CI2_View_CMS_Tree_Joined_Regular')
BEGIN

	SET ARITHABORT ON
	SET CONCAT_NULL_YIELDS_NULL ON
	SET QUOTED_IDENTIFIER ON
	SET ANSI_NULLS ON
	SET ANSI_PADDING ON
	SET ANSI_WARNINGS ON
	SET NUMERIC_ROUNDABORT OFF

	CREATE NONCLUSTERED INDEX [CI2_View_CMS_Tree_Joined_Regular] ON [dbo].[View_CMS_Tree_Joined_Regular]
(
	[ClassName] ASC,
	[DocumentForeignKeyValue],
	[DocumentCulture] ASC
)
INCLUDE ( 	[NodeID], [NodeGUID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END
GO


if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_CoachingDetail')
BEGIN
	drop view view_EDW_CoachingDetail ;
END
GO

--GRANT SELECT
--	ON [dbo].[[view_EDW_CoachingDetail]]
--	TO [EDWReader_PRD]
--GO

/* TEST Queries
select * from [view_EDW_CoachingDetail]
select * from [view_EDW_CoachingDetail] where CloseReasonLKPID != 0
select count(*) from [view_EDW_CoachingDetail]
*/

create VIEW [dbo].[view_EDW_CoachingDetail]
AS
--********************************************************************************************
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
-- Verified last mod date available to EDW 9.10.2014
-- 01.02.2014 (WDM) added column HFUG.CloseReasonLKPID in order to satisfy Story #47923
-- 01.06.2014 (WDM) Tested with team B and found that the data was being returned. Stipulating that 
--					we converted the inner join to left outer join dbo.HFit_GoalOutcome. This 
--					allows data to be returned with the meaning that if NULL HFGO.EvaluationDate
--					is returned, the GOAL may exist without any input/update from the coach or
--					PPT
-- 01.07.2014 (WDM) This also takes care of 47976
--********************************************************************************************
	SELECT	
		HFUG.ItemID
		, HFUG.ItemGUID
		, GJ.GoalID
		, HFUG.UserID
		, cu.UserGUID
		, cus.HFitUserMpiNumber
		, cs.SiteGUID
		, hfa.AccountID
		, hfa.AccountCD
		, hfa.AccountName
		, HFUG.IsCreatedByCoach
		, HFUG.BaselineAmount
		, HFUG.GoalAmount
		, Null As DocumentID
		, HFUG.GoalStatusLKPID
		, HFLGS.GoalStatusLKPName
		, HFUG.EvaluationStartDate
		, HFUG.EvaluationEndDate
		, HFUG.GoalStartDate
		, HFUG.CoachDescription
		, HFGO.EvaluationDate
		, HFGO.Passed
		, HFGO.WeekendDate
		, CASE	WHEN CAST(HFUG.ItemCreatedWhen AS DATE) = CAST(HFUG.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HFUG.ItemCreatedWhen
		, HFUG.ItemModifiedWhen
		, GJ.NodeGUID
		, HFUG.CloseReasonLKPID
		, GRC.CloseReason

	FROM
		dbo.HFit_UserGoal AS HFUG WITH ( NOLOCK )
	INNER JOIN (
					SELECT
						VHFGJ.GoalID
						, VHFGJ.NodeID
						, VHFGJ.NodeGUID
						, VHFGJ.DocumentCulture
						, VHFGJ.DocumentGuid
						, VHFGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Goal_Joined AS VHFGJ WITH ( NOLOCK )
					UNION ALL
					SELECT
						VHFTGJ.GoalID
						, VHFTGJ.NodeID
						, VHFTGJ.NodeGUID
						, VHFTGJ.DocumentCulture
						, VHFTGJ.DocumentGuid
						, VHFTGJ.DocumentModifiedWhen	--WDM added 9.10.2014
					FROM
						dbo.View_HFit_Tobacco_Goal_Joined AS VHFTGJ WITH ( NOLOCK )
				) AS GJ ON hfug.NodeID = gj.NodeID and GJ.DocumentCulture = 'en-us'		
	left outer join dbo.HFit_GoalOutcome AS HFGO WITH ( NOLOCK ) ON HFUG.ItemID = HFGO.UserGoalItemID	
	INNER JOIN dbo.HFit_LKP_GoalStatus AS HFLGS WITH ( NOLOCK ) ON HFUG.GoalStatusLKPID = HFLGS.GoalStatusLKPID	
	INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON HFUG.UserID = cu.UserID
	INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON CU.UserGUID = CUS.UserSettingsUserGUID
	INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cu.UserID = CUS2.UserID	
	INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
	INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = hfa.SiteID
	left outer join HFit_LKP_GoalCloseReason as GRC on GRC.CloseReasonID = HFUG.CloseReasonLKPID
GO

  --  
  --  
GO 
print('***** Created: view_EDW_CoachingDetail'); 
GO 

--Testing History
--1.1.2015: WDM Tested table creation, data entry, and view join
--Testing Criteria
--select * from HFit_LKP_GoalCloseReason
--select * from view_EDW_CoachingDetail
--select * from view_EDW_CoachingDetail where userid in (13470, 107, 13299) and CloseReasonLKPID != 0 
--select * from view_EDW_CoachingDetail where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'
--select * from view_EDW_CoachingDetail where EvaluationDate is null 
--select * from view_EDW_CoachingDetail  where HFitUserMpiNumber in (6238677) and CloseReasonLKPID != 0 
--select * from HFit_UserGoal where UserGUID = '9C7F1657-8568-4D5D-A797-C6AEEA86834F'


--***************************************************************
--***************************************************************


print ('Processing: view_EDW_HealthAssesmentDeffinition ' + cast(getdate() as nvarchar(50))) ;
go

--select count(*) from view_EDW_HealthAssesmentDeffinition

if exists(select TABLE_NAME from INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'view_EDW_HealthAssesmentDeffinition')
BEGIN
	drop view view_EDW_HealthAssesmentDeffinition ;
END
GO

create VIEW [dbo].[view_EDW_HealthAssesmentDeffinition] 
AS
SELECT distinct 
--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--*****************************************************************************************************************************************************
--Test Queries:
--select * from view_EDW_HealthAssesmentDeffinition where AnsDocumentGuid is not NULL
--Changes:
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
--8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
--8/8/2014 - Generated corrected view in DEV
--8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
--				them out. With them in the QRY, returned 43104 rows, with them nulled
--				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
--				time doubled approximately.
--				Has to add a DISTINCT to all the queries - .
--				Original Query 0:25 @ 43104
--				Original Query 0:46 @ 28736 (distinct)
--				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
--				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
--				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
--8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
--				such that when running the view in QA: 
--8/12/2014 - select * from [view_EDW_HealthAssesmentDeffinition] where DocumentModifiedWhen between '2000-11-14' and 
--				'2014-11-15' now runs exceptionally fast
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
--				well as Site and Account data
--11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
--12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
--12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
--01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
--************************************************************************************************************************************************************
		NULL as SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
		, NULL as AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
		, HA.NodeID AS HANodeID										--WDM 08.07.2014
		, HA.NodeName AS HANodeName									--WDM 08.07.2014
		--, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
		, NULL AS HADocumentID										--WDM 08.07.2014
																	--09.29.2014: Mark and Dale discussed that NODEGUID should be used 
																	--such that the multi-language/culture is not a problem.
		, HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
		, HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title) AS ModTitle              --WDM 47619
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText              --WDM 47619
		, VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAMJ.Weight AS ModWeight
		, VHFHAMJ.IsEnabled AS ModIsEnabled
		, VHFHAMJ.CodeName AS ModCodeName
		, VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
		, dbo.udf_StripHTML(VHFHARCJ.Title) AS RCTitle              --WDM 47619
		, VHFHARCJ.Weight AS RCWeight
		, VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARCJ.IsEnabled AS RCIsEnabled
		, VHFHARCJ.CodeName AS RCCodeName
		, VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
		, dbo.udf_StripHTML(VHFHARAJ.Title) AS RATytle              --WDM 47619
		, VHFHARAJ.Weight AS RAWeight
		, VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHARAJ.IsEnabled AS RAIsEnabled
		, VHFHARAJ.CodeName AS RACodeName
		, VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
		, VHFHAQ.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ.Title,4000)) AS QuesTitle              --WDM 47619
		, VHFHAQ.Weight AS QuesWeight
		, VHFHAQ.IsRequired AS QuesIsRequired

		--, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
		, VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014
		
		, VHFHAQ.IsEnabled AS QuesIsEnabled
		, left(VHFHAQ.IsVisible,4000) AS QuesIsVisible
		, VHFHAQ.IsStaging AS QuesIsSTaging
		, VHFHAQ.CodeName AS QuestionCodeName
		, VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
		, VHFHAA.Value AS AnsValue
		, VHFHAA.Points AS AnsPoints
		, VHFHAA.NodeGuid AS AnsDocumentGuid		--ref: #47517
		, VHFHAA.IsEnabled AS AnsIsEnabled
		, VHFHAA.CodeName AS AnsCodeName
		, VHFHAA.UOM AS AnsUOM
		, VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
			THEN 'I'
			ELSE 'U'
		END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
		, HA.NodeGUID as HANodeGUID

		--, NULL as SiteLastModified
		, NULL as SiteLastModified
		--, NULL as Account_ItemModifiedWhen
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID01' as LocID
	 FROM
		--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
		View_HFit_HealthAssessment_Joined as HA WITH (NOLOCK) 
		INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID		
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
		INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
			
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
		AND VHFHAA.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
--WDM Retrieve Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)              --WDM 47619
		, dbo.udf_StripHTML(left(left(VHFHAMJ.IntroText,4000),4000)) AS IntroText              --WDM 47619
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)              --WDM 47619
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)              --WDM 47619
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ2.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ2.Title,4000)) AS QuesTitle              --WDM 47619
		, VHFHAQ2.Weight
		, VHFHAQ2.IsRequired
		, VHFHAQ2.NodeGuid
		, VHFHAQ2.IsEnabled
		, left(VHFHAQ2.IsVisible,4000)
		, VHFHAQ2.IsStaging
		, VHFHAQ2.CodeName AS QuestionCodeName
       --,VHFHAQ2.NodeAliasPath
		, VHFHAQ2.DocumentPublishedVersionHistoryID
		, VHFHAA2.Value
		, VHFHAA2.Points
		, VHFHAA2.NodeGuid		--ref: #47517
		, VHFHAA2.IsEnabled
		, VHFHAA2.CodeName
		, VHFHAA2.UOM
       --,VHFHAA2.NodeAliasPath
		, VHFHAA2.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID02' as LocID
	FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID	
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID
--matrix level 1 questiongroup
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID		
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA2.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ3.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ3.Title,4000)) AS QuesTitle
		, VHFHAQ3.Weight
		, VHFHAQ3.IsRequired
		, VHFHAQ3.NodeGuid
		, VHFHAQ3.IsEnabled
		, left(VHFHAQ3.IsVisible,4000)
		, VHFHAQ3.IsStaging
		, VHFHAQ3.CodeName AS QuestionCodeName
       --,VHFHAQ3.NodeAliasPath
		, VHFHAQ3.DocumentPublishedVersionHistoryID
		, VHFHAA3.Value
		, VHFHAA3.Points
		, VHFHAA3.NodeGuid		--ref: #47517
		, VHFHAA3.IsEnabled
		, VHFHAA3.CodeName
		, VHFHAA3.UOM
       --,VHFHAA3.NodeAliasPath
		, VHFHAA3.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID03' as LocID
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
	LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA3.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
--WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ7.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ7.Title,4000)) AS QuesTitle
		, VHFHAQ7.Weight
		, VHFHAQ7.IsRequired
		, VHFHAQ7.NodeGuid
		, VHFHAQ7.IsEnabled
		, left(VHFHAQ7.IsVisible,4000)
		, VHFHAQ7.IsStaging
		, VHFHAQ7.CodeName AS QuestionCodeName
       --,VHFHAQ7.NodeAliasPath
		, VHFHAQ7.DocumentPublishedVersionHistoryID
		, VHFHAA7.Value
		, VHFHAA7.Points
		, VHFHAA7.NodeGuid		--ref: #47517
		, VHFHAA7.IsEnabled
		, VHFHAA7.CodeName
		, VHFHAA7.UOM
       --,VHFHAA7.NodeAliasPath
		, VHFHAA7.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID04' as LocID
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

--matrix level 1 questiongroup
--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

--Branching Level 1 Question 
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

--Matrix Level 2 Question Group
	INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
	INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
	left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA7.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 1 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:40 minute
	-- Added two perf indexes to the first query: 25 Sec
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ8.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ8.Title,4000)) AS QuesTitle
		, VHFHAQ8.Weight
		, VHFHAQ8.IsRequired
		, VHFHAQ8.NodeGuid
		, VHFHAQ8.IsEnabled
		, left(VHFHAQ8.IsVisible,4000)
		, VHFHAQ8.IsStaging
		, VHFHAQ8.CodeName AS QuestionCodeName
       --,VHFHAQ8.NodeAliasPath
		, VHFHAQ8.DocumentPublishedVersionHistoryID
		, VHFHAA8.Value
		, VHFHAA8.Points
		, VHFHAA8.NodeGuid		--ref: #47517
		, VHFHAA8.IsEnabled
		, VHFHAA8.CodeName
		, VHFHAA8.UOM
       --,VHFHAA8.NodeAliasPath
		, VHFHAA8.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
	
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID05' as LocID
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			--LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA8.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
	--****************************************************
	--WDM 6/25/2014 Retrieve the Branching level 2 Question Group
	--THE PROBLEM LIES HERE in this part of query : 1:48  minutes
	--With the new indexes: 29 Secs
	--****************************************************
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ4.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ4.Title,4000)) AS QuesTitle
		, VHFHAQ4.Weight
		, VHFHAQ4.IsRequired
		, VHFHAQ4.NodeGuid
		, VHFHAQ4.IsEnabled
		, left(VHFHAQ4.IsVisible,4000)
		, VHFHAQ4.IsStaging
		, VHFHAQ4.CodeName AS QuestionCodeName
       --,VHFHAQ4.NodeAliasPath
		, VHFHAQ4.DocumentPublishedVersionHistoryID
		, VHFHAA4.Value
		, VHFHAA4.Points
		, VHFHAA4.NodeGuid		--ref: #47517
		, VHFHAA4.IsEnabled
		, VHFHAA4.CodeName
		, VHFHAA4.UOM
       --,VHFHAA4.NodeAliasPath
		, VHFHAA4.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID06' as LocID
FROM
 --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

			--matrix level 1 questiongroup
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

			--Branching Level 1 Question 
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
			LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

			--Matrix Level 2 Question Group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

			--Matrix branching level 1 question group
			--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
			--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

			--Branching level 2 Question Group
			INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
			INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
			left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA4.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 3 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ5.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ5.Title,4000)) AS QuesTitle
		, VHFHAQ5.Weight
		, VHFHAQ5.IsRequired
		, VHFHAQ5.NodeGuid
		, VHFHAQ5.IsEnabled
		, left(VHFHAQ5.IsVisible,4000)
		, VHFHAQ5.IsStaging
		, VHFHAQ5.CodeName AS QuestionCodeName
       --,VHFHAQ5.NodeAliasPath
		, VHFHAQ5.DocumentPublishedVersionHistoryID
		, VHFHAA5.Value
		, VHFHAA5.Points
		, VHFHAA5.NodeGuid		--ref: #47517
		, VHFHAA5.IsEnabled
		, VHFHAA5.CodeName
		, VHFHAA5.UOM
       --,VHFHAA5.NodeAliasPath
		, VHFHAA5.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID07' as LocID
FROM
--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK)  
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA5.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
--WDM 6/25/2014 Retrieve the Branching level 4 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ6.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ6.Title,4000)) AS QuesTitle
		, VHFHAQ6.Weight
		, VHFHAQ6.IsRequired
		, VHFHAQ6.NodeGuid
		, VHFHAQ6.IsEnabled
		, left(VHFHAQ6.IsVisible,4000)
		, VHFHAQ6.IsStaging
		, VHFHAQ6.CodeName AS QuestionCodeName
       --,VHFHAQ6.NodeAliasPath
		, VHFHAQ6.DocumentPublishedVersionHistoryID
		, VHFHAA6.Value
		, VHFHAA6.Points
		, VHFHAA6.NodeGuid		--ref: #47517
		, VHFHAA6.IsEnabled
		, VHFHAA6.CodeName
		, VHFHAA6.UOM
       --,VHFHAA6.NodeAliasPath
		, VHFHAA6.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID08' as LocID
FROM
  --dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA6.NodeGuid is not null		--ref: #47517

UNION ALL   --UNION
	--WDM 6/25/2014 Retrieve the Branching level 5 Question Group
	SELECT distinct
		NULL as SiteGUID --cs.SiteGUID		--WDM 08.12.2014
		, NULL as AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
		, HA.NodeID		--WDM 08.07.2014
		, HA.NodeName		--WDM 08.07.2014
		, NULL AS HADocumentID		--WDM 08.07.2014
		, HA.NodeSiteID		--WDM 08.07.2014
       --,VCTJ.NodeAliasPath
		, HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
		, dbo.udf_StripHTML(VHFHAMJ.Title)
		, dbo.udf_StripHTML(left(VHFHAMJ.IntroText,4000)) AS IntroText
		, VHFHAMJ.NodeGuid
		, VHFHAMJ.Weight
		, VHFHAMJ.IsEnabled
		, VHFHAMJ.CodeName
       --,VHFHAMJ.NodeAliasPath
		, VHFHAMJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARCJ.Title)
		, VHFHARCJ.Weight
		, VHFHARCJ.NodeGuid
		, VHFHARCJ.IsEnabled
		, VHFHARCJ.CodeName
       --,VHFHARCJ.NodeAliasPath
		, VHFHARCJ.DocumentPublishedVersionHistoryID
		, dbo.udf_StripHTML(VHFHARAJ.Title)
		, VHFHARAJ.Weight
		, VHFHARAJ.NodeGuid
		, VHFHARAJ.IsEnabled
		, VHFHARAJ.CodeName
       --,VHFHARAJ.NodeAliasPath
		, VHFHARAJ.ScoringStrategyID
		, VHFHARAJ.DocumentPublishedVersionHistoryID
		, VHFHAQ9.QuestionType
		, dbo.udf_StripHTML(left(VHFHAQ9.Title,4000)) AS QuesTitle
		, VHFHAQ9.Weight
		, VHFHAQ9.IsRequired
		, VHFHAQ9.NodeGuid
		, VHFHAQ9.IsEnabled
		, left(VHFHAQ9.IsVisible,4000)
		, VHFHAQ9.IsStaging
		, VHFHAQ9.CodeName AS QuestionCodeName
       --,VHFHAQ9.NodeAliasPath
		, VHFHAQ9.DocumentPublishedVersionHistoryID
		, VHFHAA9.Value
		, VHFHAA9.Points
		, VHFHAA9.NodeGuid		--ref: #47517
		, VHFHAA9.IsEnabled
		, VHFHAA9.CodeName
		, VHFHAA9.UOM
       --,VHFHAA9.NodeAliasPath
		, VHFHAA9.DocumentPublishedVersionHistoryID
		, CASE	WHEN CAST(HA.DocumentCreatedWhen AS DATE) = CAST(HA.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, HA.DocumentCreatedWhen
		, HA.DocumentModifiedWhen
		, HA.NodeGuid as CmsTreeNodeGuid	--WDM 08.07.2014
		, HA.NodeGUID as HANodeGUID
 
		, NULL as SiteLastModified
		, NULL as Account_ItemModifiedWhen
		--, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
		, NULL as Campaign_DocumentModifiedWhen
		, HA.DocumentModifiedWhen as Assessment_DocumentModifiedWhen
		, VHFHAMJ.DocumentModifiedWhen as Module_DocumentModifiedWhen
		, VHFHARCJ.DocumentModifiedWhen as RiskCategory_DocumentModifiedWhen
		, VHFHARAJ.DocumentModifiedWhen as RiskArea_DocumentModifiedWhen
		, VHFHAQ.DocumentModifiedWhen as Question_DocumentModifiedWhen
		, VHFHAA.DocumentModifiedWhen as Answer_DocumentModifiedWhen
		, HAMCQ.AllowMultiSelect
		, 'SID09' as LocID
FROM

--dbo.View_CMS_Tree_Joined AS VCTJ
		--INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
		--INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID
 
		--Campaign links Client which links to Assessment
		--INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 
 
View_HFit_HealthAssessment_Joined HA WITH (NOLOCK) 
 INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ ON HA.NodeID = VHFHAMJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
 INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
 INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
 LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA ON VHFHAQ.NodeID = VHFHAA.NodeParentID

		--matrix level 1 questiongroup
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

		--Branching Level 1 Question 
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3 ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
		LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

		--Matrix Level 2 Question Group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

		--Matrix branching level 1 question group
		--INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
		--INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

		--Branching level 2 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4 ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4 ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID

		--Branching level 3 Question Group
		--select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5 ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5 ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID

		--Branching level 4 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6 ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6 ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID

		--Branching level 5 Question Group
		INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9 ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
		INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9 ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
		left outer join [View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined] as HAMCQ 
			on VHFHAQ.Nodeguid = HAMCQ.Nodeguid
			AND HAMCQ.DocumentCulture = 'en-US'
	where  VHFHAQ.DocumentCulture = 'en-us'	
		and (VHFHAA.DocumentCulture = 'en-us' OR VHFHAA.DocumentCulture is null)	--WDM 08.12.2014		
		and VHFHARCJ.DocumentCulture = 'en-us'	
		and VHFHARAJ.DocumentCulture = 'en-us'	
		and VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
		and HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
		AND VHFHAA9.NodeGuid is not null		--ref: #47517

GO

print ('Processed: view_EDW_HealthAssesmentDeffinition ') ;
go
  --  
  --  
GO 
print('***** FROM: view_EDW_HealthAssesmentDeffinition.sql'); 
GO 


--***************************************************************
--***************************************************************


go
print ('Processing: view_EDW_RewardUserDetail ') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardUserDetail')
BEGIN
	drop view view_EDW_RewardUserDetail ;
END
GO
/* TESTS
select top 100 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
*/
create VIEW [dbo].[view_EDW_RewardUserDetail]
AS

	--**************************************************************************************************************************************************
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2000-11-14' and '2014-11-15'
	--select * from [view_EDW_RewardUserDetail] where ItemModifiedWhen between '2014-05-12' and '2014-05-13' 
	--8/7/2014 - added and commented out DocumentGuid and NodeGuid in case needed later
	--8/08/2014 - Generated corrected view in DEV (WDM)
	--8/12/2014 - Performance Issue - 00:06:49 @ 258502
	--8/12/2014 - Performance Issue - Add PI01_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:46 @ 258502
	--8/12/2014 - Performance Issue - Add PI02_view_EDW_RewardUserDetail
	--8/12/2014 - Performance Issue - 00:03:45 @ 258502
	--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
	--09.11.2014 : (wdm) Verified last mod date available to EDW - RewardsUserActivity_ItemModifiedWhen
	--				RewardExceptionModifiedDate, RewardTrigger_DocumentModifiedWhen. Warned Laura this might create many dups.
	--11.14.2014 : (wdm) The dups have surfaced. The combination of  HFRUAD.ActivityCompletedDt, 
	--				HFRUAD.ItemModifiedWhen, HFRE.ItemModifiedWhen, HFRUAD.ItemModifiedWhen, VHFRTJ.DocumentModifiedWhen has exposed
	--				tens of thousands of semi-redundant rows. Today, I commented these dates out and added a distinct and went from \
	--				returning more than 100,000 rows for a given MPI and Client to 4 rows. I left in place the original dates of 
	--				HFRULD.ItemCreatedWhen and HFRULD.ItemModifiedWhen. This gives us whether it is an insert or update. If multiple 
	--				dates are used to determine changes, then it will be necessary to use a DATE filter to bring back only the 
	--				rows indicating a change.
	--11.18.2014 : (wdm) Found a USERID qualifier missing on the join of HFit_RewardsUserActivityDetail. Added this qualifier to USERID
	--				and the view now appears to be functioning correctly returning about 160K rows in 2.5 minutes. The DISTINCT clause
	--				made no difference in the number of returned rows, so it was removed and the execution time of the query was cut in half.
	--01.01.2015 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view - reference CR-47520
	--01.01.2015 (WDM) Tested modifications - reference CR-47520
	--**************************************************************************************************************************************************

	SELECT
		cu.UserGUID
		, CS2.SiteGUID
		, cus2.HFitUserMpiNumber
		, VHFRAJ.RewardActivityID
		, VHFRPJ.RewardProgramName
		, VHFRPJ.RewardProgramID
		, VHFRPJ.RewardProgramPeriodStart
		, VHFRPJ.RewardProgramPeriodEnd
		, VHFRPJ.DocumentModifiedWhen AS RewardModifiedDate
		, VHFRGJ.GroupName
		, VHFRGJ.RewardGroupID
		, VHFRGJ.RewardGroupPeriodStart
		, VHFRGJ.RewardGroupPeriodEnd
		, VHFRGJ.DocumentModifiedWhen AS RewardGroupModifieDate
		, VHFRLJ.Level
		, HFLRLT.RewardLevelTypeLKPName
		, VHFRLJ.DocumentModifiedWhen AS RewardLevelModifiedDate
		, HFRULD.LevelCompletedDt
		, HFRULD.LevelVersionHistoryID
		, VHFRLJ.RewardLevelPeriodStart
		, VHFRLJ.RewardLevelPeriodEnd
		, VHFRAJ.ActivityName
		, HFRUAD.ActivityPointsEarned	
		, HFRUAD.ActivityCompletedDt	
		, HFRUAD.ItemModifiedWhen AS RewardActivityModifiedDate		
		, HFRUAD.ActivityVersionID
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.ActivityPoints
		, HFRE.UserAccepted
		, HFRE.UserExceptionAppliedTo		
		, VHFRTJ.TriggerName
		, VHFRTJ.RewardTriggerID
		, HFLRT2.RewardTriggerLKPDisplayName
		, HFLRT2.RewardTriggerDynamicValue
		, HFLRT2.ItemModifiedWhen AS RewardTriggerModifiedDate
		, HFLRT.RewardTypeLKPName
		, HFA.AccountID
		, HFA.AccountCD
		, CASE	WHEN CAST(HFRULD.ItemCreatedWhen AS DATE) = CAST(HFRULD.ItemModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		
		--WDM added 8/7/2014 in case needed
		, VHFRPJ.DocumentGuid		
		
		--WDM added 8/7/2014 in case needed
		, VHFRPJ.NodeGuid			

		, HFRULD.ItemCreatedWhen
		, HFRULD.ItemModifiedWhen

		--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.
		--wdm	11.18.2014 deemed necesary by Laura B. 
		, HFRE.ItemModifiedWhen AS RewardExceptionModifiedDate		

		--09.11.2014 (wdm) added for EDW			
		, HFRUAD.ItemModifiedWhen as RewardsUserActivity_ItemModifiedWhen	
		
		--wdm - 11.17.2014 commented out as it was causing many thousands of duplicate records.
		, VHFRTJ.DocumentModifiedWhen as  RewardTrigger_DocumentModifiedWhen		
		
		--01.01.2015 (WDM) added for CR-47520
		, LKPRA.RewardActivityLKPName	
	FROM	
		dbo.View_HFit_RewardProgram_Joined AS VHFRPJ WITH ( NOLOCK )
		LEFT OUTER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ WITH ( NOLOCK ) ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		LEFT OUTER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ WITH ( NOLOCK ) ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardType AS HFLRT WITH ( NOLOCK ) ON VHFRLJ.AwardType = HFLRT.RewardTypeLKPID
		LEFT OUTER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT WITH ( NOLOCK ) ON vhfrlj.LevelType = HFLRLT.RewardLevelTypeLKPID
		INNER JOIN dbo.HFit_RewardsUserLevelDetail AS HFRULD WITH ( NOLOCK ) ON VHFRLJ.NodeID = HFRULD.LevelNodeID
		INNER JOIN dbo.CMS_User AS CU WITH ( NOLOCK ) ON hfruld.UserID = cu.UserID
		INNER JOIN dbo.CMS_UserSite AS CUS WITH ( NOLOCK ) ON CU.UserID = CUS.UserID
		INNER JOIN dbo.CMS_Site AS CS2 WITH ( NOLOCK ) ON CUS.SiteID = CS2.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs2.SiteID = HFA.SiteID
		INNER JOIN dbo.CMS_UserSettings AS CUS2 WITH ( NOLOCK ) ON cu.UserID = cus2.UserSettingsUserID
		LEFT OUTER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ WITH ( NOLOCK ) ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		left outer join HFit_LKP_RewardActivity as LKPRA ON  LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID			
		--11.18.2014 (wdm) added this filter so that only USER Detail was returned.
		INNER JOIN dbo.HFit_RewardsUserActivityDetail AS HFRUAD WITH ( NOLOCK ) ON VHFRAJ.NodeID = HFRUAD.ActivityNodeID
			AND cu.UserID = HFRUAD.userid				
		LEFT OUTER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ WITH ( NOLOCK ) ON VHFRAJ.NodeID = VHFRTJ.NodeParentID			
		LEFT OUTER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT2 WITH ( NOLOCK ) ON VHFRTJ.RewardTriggerLKPID = HFLRT2.RewardTriggerLKPID
		LEFT OUTER JOIN dbo.HFit_RewardException AS HFRE WITH ( NOLOCK ) ON HFRE.RewardActivityID = VHFRAJ.RewardActivityID
				AND HFRE.UserID = cu.UserID

		Where VHFRPJ.DocumentCulture = 'en-us'
			AND VHFRGJ.DocumentCulture = 'en-us'
			AND VHFRLJ.DocumentCulture = 'en-us'
			AND VHFRAJ.DocumentCulture = 'en-us'
			AND VHFRTJ.DocumentCulture = 'en-us'
go

print ('Completed : view_EDW_RewardUserDetail ') ;
go

print('***** FROM: view_EDW_RewardUserDetail.sql'); 
GO 


--***************************************************************
--***************************************************************

print ('Processing: view_EDW_RewardsDefinition:') ;
go

if exists(select NAME from sys.VIEWS where NAME = 'view_EDW_RewardsDefinition')
BEGIN
	drop view view_EDW_RewardsDefinition ;
END
GO

--select RewardActivityID,* from View_HFit_RewardActivity_Joined

--GRANT SELECT
--	ON [dbo].[view_EDW_RewardsDefinition]
--	TO [EDWReader_PRD]
--GO

create VIEW [dbo].[view_EDW_RewardsDefinition]
AS
--****************************************************************************************************************************************************
--WDM Reviewed 8/6/2014 for needed updates, may be needed
--	My question - Is NodeGUID going to be passed onto the children
--8/7/2014 - added and commented out DocumentGuid in case needed later
--8/8/2014 - Generated corrected view in DEV (WDM)
--8/19/2014 - (WDM) Added where clause to make the query return english data only.	
--09.11.2014 : Added to facilitate EDW Last Mod Date determination and added language filters
--11.14.2014 : Found that this view was in PRod Staging and not in Prod.
--11.17.2014 : John C. found that Spanish was coming across. This was due to the view
--				View_HFit_RewardProgram_Joined not having the capability to FITER at the 
--				Document Culture level. Created a view, View_EDW_RewardProgram_Joined, that
--				used View_HFit_RewardProgram_Joined and added the capability to fiter languages.
--12.31.2014 (WDM) added left outer join HFit_LKP_RewardActivity AND VHFRAJ.RewardActivityLKPName to the view reference CR-47520
--01.01.2014 (WDM) tested changes for CR-47520
--****************************************************************************************************************************************************

	SELECT DISTINCT
		cs.SiteGUID
		, HFA.AccountID
		, hfa.AccountCD
		, RewardProgramID
		, RewardProgramName
		, RewardProgramPeriodStart
		, RewardProgramPeriodEnd
		, ProgramDescription
		, RewardGroupID
		, GroupName
		, RewardContactGroups
		, RewardGroupPeriodStart
		, RewardGroupPeriodEnd
		, RewardLevelID
		, [Level]
		, RewardLevelTypeLKPName
		, RewardLevelPeriodStart
		, RewardLevelPeriodEnd
		, FrequencyMenu
		, AwardDisplayName
		, AwardType
		, AwardThreshold1
		, AwardThreshold2
		, AwardThreshold3
		, AwardThreshold4
		, AwardValue1
		, AwardValue2
		, AwardValue3
		, AwardValue4
		, CompletionText
		, ExternalFulfillmentRequired
		, RewardHistoryDetailDescription
		, VHFRAJ.RewardActivityID
		, VHFRAJ.ActivityName
		, VHFRAJ.ActivityFreqOrCrit
		, VHFRAJ.RewardActivityPeriodStart
		, VHFRAJ.RewardActivityPeriodEnd
		, VHFRAJ.RewardActivityLKPID
		, LKPRA.RewardActivityLKPName
		, VHFRAJ.ActivityPoints
		, VHFRAJ.IsBundle
		, VHFRAJ.IsRequired
		, VHFRAJ.MaxThreshold
		, VHFRAJ.AwardPointsIncrementally
		, VHFRAJ.AllowMedicalExceptions
		, VHFRAJ.BundleText
		, RewardTriggerID
		, HFLRT.RewardTriggerDynamicValue
		, TriggerName
		, RequirementDescription
		, VHFRTPJ.RewardTriggerParameterOperator
		, VHFRTPJ.Value
		, vhfrtpj.ParameterDisplayName
		, CASE	WHEN CAST(VHFRPJ.DocumentCreatedWhen AS DATE) = CAST(VHFRPJ.DocumentModifiedWhen AS DATE)
				THEN 'I'
				ELSE 'U'
			END AS ChangeType
		, VHFRPJ.DocumentGuid	--WDM Added 8/7/2014 in case needed
		
		, VHFRPJ.DocumentCreatedWhen
		, VHFRPJ.DocumentModifiedWhen
		
		, VHFRAJ.DocumentModifiedWhen as RewardActivity_DocumentModifiedWhen	--09.11.2014 : Added to facilitate EDW Last Mod Date determination
		, VHFRAJ.DocumentCulture as DocumentCulture_VHFRAJ		
		,VHFRPJ.DocumentCulture as DocumentCulture_VHFRPJ
		,VHFRGJ.DocumentCulture as DocumentCulture_VHFRGJ
		,VHFRLJ.DocumentCulture as DocumentCulture_VHFRLJ
		,VHFRTPJ.DocumentCulture as DocumentCulture_VHFRTPJ
	FROM 
	dbo.[View_EDW_RewardProgram_Joined] AS VHFRPJ
	INNER JOIN dbo.View_HFit_RewardGroup_Joined AS VHFRGJ ON VHFRPJ.NodeID = VHFRGJ.NodeParentID
		and VHFRPJ.DocumentCulture = 'en-US'
		and VHFRGJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.View_HFit_RewardLevel_Joined AS VHFRLJ ON VHFRGJ.NodeID = VHFRLJ.NodeParentID
		and VHFRLJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.HFit_LKP_RewardLevelType AS HFLRLT ON VHFRLJ.LevelType = HFLRLT.RewardLevelTypeLKPID
	INNER JOIN dbo.View_HFit_RewardActivity_Joined AS VHFRAJ ON VHFRLJ.NodeID = VHFRAJ.NodeParentID
		and VHFRAJ.DocumentCulture = 'en-US'
    left outer join HFit_LKP_RewardActivity as LKPRA ON  LKPRA.RewardActivityLKPID = VHFRAJ.RewardActivityLKPID		--Added 1.2.2015 for SR-47520
	INNER JOIN dbo.View_HFit_RewardTrigger_Joined AS VHFRTJ ON VHFRAJ.NodeID = VHFRTJ.NodeParentID
		and VHFRTJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.View_HFit_RewardTriggerParameter_Joined AS VHFRTPJ ON vhfrtj.nodeid = vhfrtpj.nodeparentid
		and VHFRTPJ.DocumentCulture = 'en-US'
	INNER JOIN dbo.HFit_LKP_RewardTrigger AS HFLRT ON VHFRTJ.RewardTriggerLKPID = HFLRT.RewardTriggerLKPID
	INNER JOIN dbo.CMS_Site AS CS ON VHFRPJ.NodeSiteID = cs.SiteID
	INNER JOIN dbo.HFit_Account AS HFA ON cs.SiteID = HFA.SiteID
GO
print ('Processed: view_EDW_RewardsDefinition ') ;
go
--exec sp_helptext view_EDW_RewardsDefinition
  --  
  --  
GO 
print('***** FROM: view_EDW_RewardsDefinition.sql'); 
GO 


--***************************************************************
--***************************************************************


go
print ('Processing view_EDW_BioMetrics: ' +  cast(getdate() as nvarchar(50)) + '  *** view_EDW_BioMetrics.sql' );
GO


if NOT exists (Select name from sys.tables where name = 'EDW_BiometricViewRejectCriteria')
BEGIN
	print('EDW_BiometricViewRejectCriteria NOT found, creating');
	--This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored.
	CREATE TABLE dbo.EDW_BiometricViewRejectCriteria
	(
		--Use AccountCD and ItemCreatedWhen together OR SiteID and ItemCreatedWhen together. They work and reject in pairs.
		AccountCD nvarchar(8) NOT NULL,
		ItemCreatedWhen datetime2 (7) NOT NULL,
		SiteID int NOT NULL,
		RejectGUID uniqueidentifier NULL
	) ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria ADD CONSTRAINT
		DF_EDW_BiometricViewRejectCriteria_RejectGUID DEFAULT newid() FOR RejectGUID ;

	ALTER TABLE dbo.EDW_BiometricViewRejectCriteria SET (LOCK_ESCALATION = TABLE) ;
	
	EXEC sp_addextendedproperty 
    @name = N'PURPOSE', @value = 'This table contains the REJECT specifications for Biometric data. An entry causes all records before a date for a Client or SITE to be ignored. The data is entered as SiteID and Rejection Date OR AccountCD and Rejection Date. All dates prior to the rejection date wil be ignored.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria' ;
    --@level2type = N'Column', @level2name = NULL

	EXEC sp_addextendedproperty 
    @name = N'MS_Description', @value = 'Use AccountCD and ItemCreatedWhen together, entering a non-existant value for SiteID. They work and reject in pairs and this type of entry will only take AccountCD and ItemCreatedWhen date into consideration.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'AccountCD' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use SiteID and ItemCreatedWhen together, entering a non-existant value for AccountCD. They work and reject in pairs.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'SiteID' ;

	EXEC sp_addextendedproperty 
    @name = N'USAGE', @value = 'Use AccountCD or SiteID and ItemCreatedWhen together. They work and reject in pairs. Any date before this date will NOT be retrieved.',
    @level0type = N'Schema', @level0name = 'dbo',
    @level1type = N'Table', @level1name = 'EDW_BiometricViewRejectCriteria',
    @level2type = N'Column', @level2name = 'ItemCreatedWhen' ;
END
GO


if exists (Select name from sys.views where name = 'view_EDW_BiometricViewRejectCriteria')
BEGIN
	print('view_EDW_BiometricViewRejectCriteria found, updating');
	drop view view_EDW_BiometricViewRejectCriteria ;
END
GO

create view view_EDW_BiometricViewRejectCriteria
as
SELECT [AccountCD]
      ,[ItemCreatedWhen]
      ,[SiteID]
      ,[RejectGUID]
  FROM [dbo].[EDW_BiometricViewRejectCriteria]
GO
print('view_EDW_BiometricViewRejectCriteria, updated');
GO

if not exists (select name from sys.indexes where name = 'PKI_EDW_BiometricViewRejectCriteria')
BEGIN
	print('PKI_EDW_BiometricViewRejectCriteria NOT found, creating');
	CREATE UNIQUE CLUSTERED INDEX [PKI_EDW_BiometricViewRejectCriteria] ON [dbo].[EDW_BiometricViewRejectCriteria]
	(
		[AccountCD] ASC,
		[ItemCreatedWhen] ASC,
		[SiteID] ASC
	) ;
END
ELSE
	print('PKI_EDW_BiometricViewRejectCriteria created');

GO

if exists (select name from sys.procedures where name = 'proc_Insert_EDW_BiometricViewRejectCriteria')
BEGIN
	print('proc_Insert_EDW_BiometricViewRejectCriteria found, updating.');
	drop procedure proc_Insert_EDW_BiometricViewRejectCriteria ;
END
ELSE
	print('Creating proc_Insert_EDW_BiometricViewRejectCriteria');
GO

create proc proc_Insert_EDW_BiometricViewRejectCriteria (@AccountCD as nvarchar(50), @ItemCreatedWhen as DateTime , @SiteID as int)
as 
BEGIN	
	INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]
           ([AccountCD]
           ,[ItemCreatedWhen]
           ,[SiteID]
           )
     VALUES
           (@AccountCD
           ,@ItemCreatedWhen
           ,@SiteID
		   );
END

GO

if exists (select name from sys.procedures where name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Acct')
BEGIN
	print('proc_Delete_EDW_BiometricViewRejectCriteria_Acct  found, updating.');
	drop procedure proc_Delete_EDW_BiometricViewRejectCriteria_Acct ;
END
ELSE
	print('Creating proc_Delete_EDW_BiometricViewRejectCriteria_Acct');

GO


create proc proc_Delete_EDW_BiometricViewRejectCriteria_Acct (@AccountCD as nvarchar(50), @ItemCreatedWhen as DateTime)
as 
BEGIN
	delete from [dbo].[EDW_BiometricViewRejectCriteria]
           where [AccountCD] = @AccountCD
           AND [ItemCreatedWhen] = @ItemCreatedWhen;
END

GO 
if exists (select name from sys.procedures where name = 'proc_Delete_EDW_BiometricViewRejectCriteria_Site')
BEGIN
	print('proc_Delete_EDW_BiometricViewRejectCriteria_Site  found, updating.');
	drop procedure proc_Delete_EDW_BiometricViewRejectCriteria_Site ;
END
ELSE
	print('Creating proc_Delete_EDW_BiometricViewRejectCriteria_Site');

GO


create proc proc_Delete_EDW_BiometricViewRejectCriteria_Site (@SiteID as int, @ItemCreatedWhen as DateTime )
as 
BEGIN
	delete from [dbo].[EDW_BiometricViewRejectCriteria]
		where SiteID = @SiteID
           AND [ItemCreatedWhen] = @ItemCreatedWhen;
		   
END
GO

if exists (Select name from sys.views where name = 'view_EDW_BioMetrics')
BEGIN
	print('Removing current view_EDW_BioMetrics.');
	drop view view_EDW_BioMetrics ;
END
GO
print('Creating view_EDW_BioMetrics.');
go

CREATE VIEW [dbo].view_EDW_BioMetrics
AS
	--*****************************************************************************************************************************************
	--************** TEST Criteria and Results for view_EDW_BioMetrics ************************************************************************
	--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria] ([AccountCD],[ItemCreatedWhen],[SiteID]) VALUES('XX','2013-12-01',17  )  
	--NOTE:		XX is used so that the AccountCD is NOT taken into account and only SiteID and ItemCreatedWhen is used.
	--GO	--Tested by wdm on 11.21.2014

	-- select count(*) from view_EDW_BioMetrics		--(wdm) & (jc) : testing on {ProdStaging = 136348} / With reject on 136339 = 9
	
	--select * from view_EDW_BioMetrics	 where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
	--select * from view_Hfit_BioMetrics where AccountCD = 'peabody' AND COALESCE (EventDate,ItemCreatedWhen) is not NULL and COALESCE (EventDate,ItemCreatedWhen) < '2013-12-01'	: 9 
	
	--select * from view_EDW_BioMetrics	where AccountCD = 'peabody' and ItemCreatedWhen < '2013-12-01 00:00:00.000'		: 7 
	--select * from view_EDW_BioMetrics	where AccountCD = 'peaboOK dy' and EventDate < '2013-12-01 00:00:00.000'		: 9 

	--select count(*) from view_EDW_BioMetrics		--NO REJECT FILTER : 136348
	--select count(*) from view_EDW_BioMetrics		--REJECT FILTER ON : 136339 == 9 GOOD TEST

	--select count(*) from view_Hfit_BioMetrics	:136393
	--select count(*) from view_Hfit_BioMetrics where COALESCE (EventDate,ItemCreatedWhen) is not NULL 	:136348
	
	--NOTE: All tests passed 11.21.2014, 11.23.2014, 12.2.2014, 12,4,2014

	--truncate table EDW_BiometricViewRejectCriteria

	--INSERT INTO [dbo].[EDW_BiometricViewRejectCriteria]([AccountCD],[ItemCreatedWhen],[SiteID])VALUES('peabody','2013-12-01',-1)         
	--NOTE:		-1 is used so that the SiteID is NOT taken into account and only AccountCD and ItemCreatedWhen is used.
	--GO	--Tested by wdm on 11.21.2014

	--select * from view_EDW_BioMetrics where ItemCreatedWhen < '2013-12-01' and AccountCD = 'peabody' returns 1034
	--		so the number should be 43814 - 1034 = 42780 with AccountCD = 'peabody' and ItemCreatedWhen = '2014-03-19'
	--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	--GO	--Tested by wdm on 11.21.2014

	--select * from view_EDW_BioMetrics where SiteID = 17 and ItemCreatedWhen < '2014-03-19' returns 22,974
	--		so the number should be 43814 - 22974 = 20840 with SIteID = 17 and ItemCreatedWhen = '2014-03-19'
	--		in table EDW_BiometricViewRejectCriteria. And it worked (wdm) 11.21.2014
	--GO	--Tested by wdm on 11.21.2014

	--	11.24.2014 (wdm) -	requested a review of this code and validation with EDW.

	-- select * from EDW_BiometricViewRejectCriteria
	-- truncate table EDW_BiometricViewRejectCriteria
	--select count(*) from view_EDW_BioMetrics

	-- 12.22.2014 - Received an SR from John C. via Richard to add two fields to the view, Table name and Item ID.
	-- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table

	--*****************************************************************************************************************************************
      SELECT DISTINCT
			--HFit_UserTracker
			HFUT.UserID
			,cus.UserSettingsUserGUID AS UserGUID
			,cus.HFitUserMpiNumber
			,cus2.SiteID
			,cs.SiteGUID
			,NULL AS CreatedDate
			,NULL AS ModifiedDate
			,NULL AS Notes
			,NULL AS IsProfessionallyCollected
			,NULL AS EventDate
			,'Not Build Yet' AS EventName
       
			--HFit_TrackerWeight
			,NULL AS PPTWeight
       
			--HFit_TrackerHbA1C
			,NULL AS PPTHbA1C
       
			--HFit_TrackerCholesterol
			,NULL AS Fasting
			,NULL AS HDL
			,NULL AS LDL
			,NULL AS Ratio
			,NULL AS Total
			,NULL AS Triglycerides
       
			--HFit_TrackerBloodSugarandGlucose
			,NULL AS Glucose
			,NULL AS FastingState
       
			--HFit_TrackerBloodPressure
			,NULL AS Systolic
			,NULL AS Diastolic
       
			--HFit_TrackerBodyFat
			,NULL AS PPTBodyFatPCT
       
			--HFit_TrackerBMI
			,NULL AS BMI
       
			--HFit_TrackerBodyMeasurements
			,NULL AS WaistInches
			,NULL AS HipInches
			,NULL AS ThighInches
			,NULL AS ArmInches
			,NULL AS ChestInches
			,NULL AS CalfInches
			,NULL AS NeckInches
       
			--HFit_TrackerHeight
			,NULL AS Height
       
			--HFit_TrackerRestingHeartRate
			,NULL AS HeartRate
			,
			--HFit_TrackerShots
			NULL AS FluShot
			,NULL AS PneumoniaShot
       
			--HFit_TrackerTests
			,NULL AS PSATest
			,NULL AS OtherExam
			,NULL AS TScore
			,NULL AS DRA
			,NULL AS CotinineTest
			,NULL AS ColoCareKit
			,NULL AS CustomTest
			,NULL AS CustomDesc
			,NULL AS CollectionSource
			,HFA.AccountID
			,HFA.AccountCD
			,CASE WHEN HFUT.ItemCreatedWhen = COALESCE(HFUT.ItemModifiedWhen, hfut.ItemCreatedWhen) THEN 'I'
				ELSE 'U'
			END AS ChangeType
			,HFUT.ItemCreatedWhen
			,HFUT.ItemModifiedWhen
			,0   As TrackerCollectionSourceID 
			,HFUT.itemid
			,'HFit_UserTracker' as TBL
			,NULL as VendorID		--VENDOR.ItemID as VendorID
			,NULL as VendorName		--VENDOR.VendorName
      FROM
      dbo.HFit_UserTracker AS HFUT WITH ( NOLOCK )
		  INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON hfut.UserID = cus.UserSettingsUserID
		  INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		  INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		  INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
		  --left outer join HFit_LKP_TrackerVendor as VENDOR on HFUT.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where HFUT.ItemCreatedWhen < ItemCreatedWhen)	  
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND HFUT.ItemCreatedWhen < ItemCreatedWhen)
			--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified within table EDW_BiometricViewRejectCriteria
			AND HFUT.ItemCreatedWhen is not NULL		--Add per Robert and Laura 12.4.2014

	  UNION ALL
      SELECT
        hftw.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
       ,HFTW.Notes
       ,HFTW.IsProfessionallyCollected
       ,HFTW.EventDate
       ,'Not Build Yet' AS EventName
       ,hftw.Value AS PPTWeight
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTW.ItemCreatedWhen = COALESCE(HFTW.ItemModifiedWhen, HFTW.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTW.ItemCreatedWhen
       ,HFTW.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTW.itemid
		,'HFit_TrackerWeight' as TBL
		,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerWeight AS HFTW WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTW.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTW.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTW.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria	  
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTW.EventDate,HFTW.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTW.EventDate,HFTW.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTW.ItemCreatedWhen is not NULL or HFTW.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014			

      UNION ALL
      SELECT
        HFTHA.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
       ,HFTHA.Notes
       ,HFTHA.IsProfessionallyCollected
       ,HFTHA.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,HFTHA.Value AS PPTHbA1C
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTHA.ItemCreatedWhen = COALESCE(HFTHA.ItemModifiedWhen, HFTHA.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTHA.ItemCreatedWhen
       ,HFTHA.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTHA.itemid
		,'HFit_TrackerHbA1c' as TBL
		,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerHbA1c AS HFTHA WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTHA.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTHA.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTHA.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTHA.EventDate,HFTHA.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTHA.EventDate,HFTHA.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTHA.ItemCreatedWhen is not NULL or HFTHA.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTC.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
       ,HFTC.Notes
       ,HFTC.IsProfessionallyCollected
       ,HFTC.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,HFTC.Fasting
       ,HFTC.HDL
       ,HFTC.LDL
       ,HFTC.Ratio
       ,HFTC.Total
       ,HFTC.Tri
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTC.ItemCreatedWhen = COALESCE(HFTC.ItemModifiedWhen, HFTC.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTC.ItemCreatedWhen
       ,HFTC.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTC.itemid
	,'HFit_TrackerCholesterol' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerCholesterol AS HFTC WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTC.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTC.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTC.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTC.EventDate,HFTC.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTC.EventDate,HFTC.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTC.ItemCreatedWhen is not NULL or HFTC.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBSAG.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
       ,HFTBSAG.Notes
       ,HFTBSAG.IsProfessionallyCollected
       ,HFTBSAG.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBSAG.Units
       ,HFTBSAG.FastingState
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBSAG.ItemCreatedWhen = COALESCE(HFTBSAG.ItemModifiedWhen, HFTBSAG.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBSAG.ItemCreatedWhen
       ,HFTBSAG.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTBSAG.itemid
	,'HFit_TrackerBloodSugarAndGlucose' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerBloodSugarAndGlucose AS HFTBSAG WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBSAG.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBSAG.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTBSAG.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBSAG.EventDate,HFTBSAG.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBSAG.EventDate,HFTBSAG.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBSAG.ItemCreatedWhen is not NULL or HFTBSAG.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBP.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
       ,HFTBP.Notes
       ,HFTBP.IsProfessionallyCollected
       ,HFTBP.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBP.Systolic
       ,HFTBP.Diastolic
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBP.ItemCreatedWhen = COALESCE(HFTBP.ItemModifiedWhen, HFTBP.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBP.ItemCreatedWhen
       ,HFTBP.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTBP.itemid
	,'HFit_TrackerBloodPressure' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerBloodPressure AS HFTBP WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBP.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBP.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTBP.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBP.EventDate,HFTBP.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBP.EventDate,HFTBP.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBP.ItemCreatedWhen is not NULL or HFTBP.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBF.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
       ,HFTBF.Notes
       ,HFTBF.IsProfessionallyCollected
       ,HFTBF.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBF.Value AS PPTBodyFatPCT
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBF.ItemCreatedWhen = COALESCE(HFTBF.ItemModifiedWhen, HFTBF.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBF.ItemCreatedWhen
       ,HFTBF.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTBF.itemid
	,'HFit_TrackerBodyFat' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerBodyFat AS HFTBF WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBF.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBF.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTBF.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBF.EventDate,HFTBF.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND  COALESCE(HFTBF.EventDate,HFTBF.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTBF.ItemCreatedWhen is not NULL or HFTBF.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTB.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
       ,HFTB.Notes
       ,HFTB.IsProfessionallyCollected
       ,HFTB.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTB.BMI
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTB.ItemCreatedWhen = COALESCE(HFTB.ItemModifiedWhen, HFTB.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTB.ItemCreatedWhen
       ,HFTB.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTB.itemid
	,'HFit_TrackerBMI' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerBMI AS HFTB WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTB.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTB.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTB.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTB.EventDate,HFTB.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTB.EventDate,HFTB.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTB.ItemCreatedWhen is not NULL or HFTB.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTBM.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
       ,HFTBM.Notes
       ,HFTBM.IsProfessionallyCollected
       ,HFTBM.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTBM.WaistInches
       ,HFTBM.HipInches
       ,HFTBM.ThighInches
       ,HFTBM.ArmInches
       ,HFTBM.ChestInches
       ,HFTBM.CalfInches
       ,HFTBM.NeckInches
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTBM.ItemCreatedWhen = COALESCE(HFTBM.ItemModifiedWhen, HFTBM.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTBM.ItemCreatedWhen
       ,HFTBM.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTBM.itemid
	,'HFit_TrackerBodyMeasurements' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerBodyMeasurements AS HFTBM WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTBM.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTBM.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTBM.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTBM.EventDate,HFTBM.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTBM.EventDate,HFTBM.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTBM.ItemCreatedWhen is not NULL or HFTBM.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTH.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen
       ,HFTH.Notes
       ,HFTH.IsProfessionallyCollected
       ,HFTH.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTH.Height
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTH.ItemCreatedWhen = COALESCE(HFTH.ItemModifiedWhen, HFTH.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTH.ItemCreatedWhen
       ,HFTH.ItemModifiedWhen 
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTH.itemid
	,'HFit_TrackerHeight' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
		dbo.HFit_TrackerHeight AS HFTH WITH ( NOLOCK )
		INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTH.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
		INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTH.UserID = cus.UserSettingsUserID
		INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
		INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
		INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
		left outer join HFit_LKP_TrackerVendor as VENDOR on HFTH.VendorID = VENDOR.ItemID
		--11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria		
		Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTH.EventDate,HFTH.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTH.EventDate,HFTH.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTH.ItemCreatedWhen is not NULL or HFTH.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
      UNION ALL
      SELECT
        HFTRHR.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
       ,HFTRHR.Notes
       ,HFTRHR.IsProfessionallyCollected
       ,HFTRHR.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTRHR.HeartRate
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTRHR.ItemCreatedWhen = COALESCE(HFTRHR.ItemModifiedWhen, HFTRHR.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTRHR.ItemCreatedWhen
       ,HFTRHR.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTRHR.itemid
	,'HFit_TrackerRestingHeartRate' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerRestingHeartRate AS HFTRHR WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTRHR.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTRHR.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTRHR.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTRHR.EventDate,HFTRHR.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND  COALESCE(HFTRHR.EventDate,HFTRHR.ItemCreatedWhen)  < ItemCreatedWhen)
			AND (HFTRHR.ItemCreatedWhen is not NULL or HFTRHR.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTS.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
       ,HFTS.Notes
       ,HFTS.IsProfessionallyCollected
       ,HFTS.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTS.FluShot
       ,HFTS.PneumoniaShot
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTS.ItemCreatedWhen = COALESCE(HFTS.ItemModifiedWhen, HFTS.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTS.ItemCreatedWhen
       ,HFTS.ItemModifiedWhen
		,HFTCS.TrackerCollectionSourceID
		,HFTS.itemid
	,'HFit_TrackerShots' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerShots AS HFTS WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTS.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTS.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTS.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTS.EventDate,HFTS.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTS.EventDate,HFTS.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTS.ItemCreatedWhen is not NULL or HFTS.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
      UNION ALL
      SELECT
        HFTT.UserID
       ,cus.UserSettingsUserGUID
       ,cus.HFitUserMpiNumber
       ,cus2.SiteID
       ,cs.SiteGUID
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
       ,HFTT.Notes
       ,HFTT.IsProfessionallyCollected
       ,HFTT.EventDate
       ,'Not Build Yet' AS EventName
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,NULL
       ,HFTT.PSATest
       ,HFTT.OtherExam
       ,HFTT.TScore
       ,HFTT.DRA
       ,HFTT.CotinineTest
       ,HFTT.ColoCareKit
       ,HFTT.CustomTest
       ,HFTT.CustomDesc
       ,HFTCS.CollectionSourceName_External
       ,HFA.AccountID
       ,HFA.AccountCD
       ,CASE WHEN HFTT.ItemCreatedWhen = COALESCE(HFTT.ItemModifiedWhen, HFTT.ItemCreatedWhen) THEN 'I'
             ELSE 'U'
        END AS ChangeType
       ,HFTT.ItemCreatedWhen
       ,HFTT.ItemModifiedWhen
	   ,HFTCS.TrackerCollectionSourceID
	   ,HFTT.itemid
	,'HFit_TrackerTests' as TBL
	,VENDOR.ItemID as VendorID
		,VENDOR.VendorName
      FROM
        dbo.HFit_TrackerTests AS HFTT WITH ( NOLOCK )
      INNER JOIN dbo.HFit_TrackerCollectionSource AS HFTCS WITH ( NOLOCK ) ON HFTT.TrackerCollectionSourceID = HFTCS.TrackerCollectionSourceID
      INNER JOIN dbo.CMS_UserSettings AS CUS WITH ( NOLOCK ) ON HFTT.UserID = cus.UserSettingsUserID
      INNER JOIN dbo.CMS_UserSite AS CUS2 WITH ( NOLOCK ) ON cus.UserSettingsUserID = cus2.UserID
      INNER JOIN dbo.CMS_Site AS CS WITH ( NOLOCK ) ON CUS2.SiteID = CS.SiteID
      INNER JOIN dbo.HFit_Account AS HFA WITH ( NOLOCK ) ON cs.SiteID = HFA.SiteID
	  left outer join HFit_LKP_TrackerVendor as VENDOR on HFTT.VendorID = VENDOR.ItemID
	  --11.21.2014 (wdm) add so that Account or Site data rows could be rejected if prior to a date specified wihtin table EDW_BiometricViewRejectCriteria
	  Where CS.SITEID NOT IN (Select SiteID from EDW_BiometricViewRejectCriteria where COALESCE(HFTT.EventDate,HFTT.ItemCreatedWhen) < ItemCreatedWhen)
			AND HFA.AccountCD NOT IN (Select AccountCD from EDW_BiometricViewRejectCriteria where HFA.AccountCD = AccountCD AND COALESCE(HFTT.EventDate,HFTT.ItemCreatedWhen) < ItemCreatedWhen)
			AND (HFTT.ItemCreatedWhen is not NULL or HFTT.EventDate is not NULL)		--Add per RObert and Laura 12.4.2014
			
	--HFit_TrackerBMI
	--HFit_TrackerBodyMeasurements
	--HFit_TrackerHeight
	--HFit_TrackerRestingHeartRate
	--HFit_TrackerShots
	--HFit_TrackerTests

GO

print ('Created view_EDW_BioMetrics: ' +  cast(getdate() as nvarchar(50)));
GO
  --  
  --  
GO 
print('***** FROM: view_EDW_BioMetrics.sql'); 
GO 

----***************************************************************************************************************************
----** REMOVE THE INSERTS AFTER INTITAL LOAD
----***************************************************************************************************************************
--truncate table EDW_BiometricViewRejectCriteria ;
--go 
--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'trstmark','11/4/2013',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'entergy','1/6/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'mcwp','1/27/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'stateneb','4/1/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'jnj','5/28/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'coopers','7/1/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'cnh','8/4/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'amat','8/4/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'dupont','8/18/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'ejones','9/3/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'avera','9/15/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'sprvalu','9/18/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'firstgrp','10/6/2014',-1) ;
--GO

--insert into EDW_BiometricViewRejectCriteria (AccountCD, ItemCreatedWhen, SiteID)
--Values (
--'rexnord','12/2/2014',-1) ;
--GO

print('***** COMPLETED : view_EDW_BioMetrics.sql'); 
GO 


--***************************************************************
--***************************************************************

PRINT 'Processing: view_EDW_TrackerCompositeDetails ';
GO

IF EXISTS (SELECT TABLE_NAME
			 FROM INFORMATION_SCHEMA.VIEWS
			 WHERE TABLE_NAME = 'view_EDW_TrackerCompositeDetails') 
	BEGIN
		DROP VIEW view_EDW_TrackerCompositeDetails;
	END;
GO

CREATE VIEW dbo.view_EDW_TrackerCompositeDetails
AS
	--************************************************************************************************************************************
	-- NOTES:
	--************************************************************************************************************************************
	 --WDM 6/26/2014
	 --This view is needed by EDW in order to process the Tracker tables' data.
	 --As of now, the Tracker tables are representative of objects and that would cause 
	 --	large volumes of ETL to be devloped and maintained. 
	 --This view represents a columnar representation of all tracker tables in a Key/Value pair representation.
	 --Each tracker table to be processed into the EDW must be represented in this view.
	 --ALL new tracker tables need only be entered once using the structure contained within this view
	 --	and the same EDW ETL should be able to process it.
	 --If there is a change to the strucuture of any one query in this view, then all have to be modified 
	 --	to be support the change.
	 --Column TrackerNameAggregratetable (AggregateTableName) will be NULL if the Tracker is not a member 
	 --		of the DISPLAYED Trackers. This allows us to capture all trackers, displayed or not.

	 --7/29/2014
	 --ISSUE: HFit_TrackerBMI,  HFit_TrackerCholesterol, and HFit_TrackerHeight are not in the HFIT_Tracker
	 --		table. This causes T.IsAvailable, T.IsCustom, T.UniqueName to be NULL. 
	 --		This raises the need for the Tracker Definition Table.

	 --NOTE: It is a goal to keep this view using BASE tables in order to gain max performance. Nested views will 
	 --		be avoided here if possible.

	 --**************** SPECIFIC TRACKER DATA **********************
	 --**************** on 7/29/2014          **********************
	 --Tracker GUID or Unique ID across all DB Instances (ItemGuid)
	 --Tracker NodeID (we use it for the External ID for Audit and error Triage)  (John: can use ItemID in this case)
	 --Tracker Table Name or Value Group Name (e.g. Body Measurements) - Categorization (TrackerNameAggregateTable)
	 --Tracker Column Unique Name ( In English)  Must be consistent across all DB Instances  ([UniqueName] will be 
	 --		the TABLE NAME if tracker name not found in the HFIT_Tracker table)
	 --Tracker Column Description (In English) (???)
	 --Tracker Column Data Type (e.g. Character, Numeric, Date, Bit or Yes/No) – so that we can set up the answer type
	 --	NULLS accepted for No Answer?	(KEY1, KEY2, VAL1, VAL2, etc)
	 --Tracker Active flag (IsAvailable will be null if tracker name not found in the HFIT_Tracker table)
	 --Tracker Unit of Measure (character) (Currently, the UOM is supplied in the view based on the table and type of Tracker)
	 --Tracker Insert Date ([ItemCreatedWhen])
	 --Tracker Last Update Date ([ItemModifiedWhen])
	 --NOTE: Convert all numerics to floats 7/30/2104 John/Dale
	 --****************************************************************************************************************************
	 -- 12.23.2014 - Added the Vendor ID and Vendor name to the view via the HFit_LKP_TrackerVendor table
	 -- 12.25.2014 - Tested the view to see that it returned the correct VendorID description
	 --************************************************************************************************************************************

	 --USE:
	 --select * from view_EDW_TrackerCompositeDetails where EventDate between '2013-11-01 15:02:00.000' and '2013-12-01 15:02:00.000'

	 --Set statistics IO ON
	 --GO

	 SELECT 'HFit_TrackerBloodPressure' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mm/Hg' AS UOM ,
			'Systolic' AS KEY1 ,
			CAST (Systolic AS float) AS VAL1 ,
			'Diastolic' AS KEY2 ,
			CAST (Diastolic AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'bp') AS UniqueName ,
			ISNULL (T.UniqueName , 'bp') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodPressure AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodPressure'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBloodSugarAndGlucose' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mmol/L' AS UOM ,
			'Units' AS KEY1 ,
			CAST (Units AS float) AS VAL1 ,
			'FastingState' AS KEY2 ,
			CAST (FastingState AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'glucose') AS UniqueName ,
			ISNULL (T.UniqueName , 'glucose') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBloodSugarAndGlucose AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBloodSugarAndGlucose'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBMI' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'kg/m2' AS UOM ,
			'BMI' AS KEY1 ,
			CAST (BMI AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			0 AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerBMI') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerBMI') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBMI AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBMI'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerBodyFat' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'PCT' AS UOM ,
			'Value' AS KEY1 ,
			CAST ([Value] AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			0 AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerBodyFat') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyFat AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyFat'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 --******************************************************************************
	 SELECT 'HFit_TrackerBodyMeasurements' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Inch' AS UOM ,
			'WaistInches' AS KEY1 ,
			CAST (WaistInches AS float) AS VAL1 ,
			'HipInches' AS KEY2 ,
			CAST (HipInches AS float) AS VAL2 ,
			'ThighInches' AS KEY3 ,
			CAST (ThighInches AS float) AS VAL3 ,
			'ArmInches' AS KEY4 ,
			CAST (ArmInches AS float) AS VAL4 ,
			'ChestInches' AS KEY5 ,
			CAST (ChestInches AS float) AS VAL5 ,
			'CalfInches' AS KEY6 ,
			CAST (CalfInches AS float) AS VAL6 ,
			'NeckInches' AS KEY7 ,
			CAST (NeckInches AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerBodyMeasurements AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerBodyMeasurements'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 --******************************************************************************
	 UNION
	 SELECT 'HFit_TrackerCardio' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'Minutes' AS KEY1 ,
			CAST (Minutes AS float) AS VAL1 ,
			'Distance' AS KEY2 ,
			CAST (Distance AS float) AS VAL2 ,
			'DistanceUnit' AS KEY3 ,
			CAST (DistanceUnit AS float) AS VAL3 ,
			'Intensity' AS KEY4 ,
			CAST (Intensity AS float) AS VAL4 ,
			'ActivityID' AS KEY5 ,
			CAST (ActivityID AS float) AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemModifiedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerCardio AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCardio'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerCholesterol' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mg/dL' AS UOM ,
			'HDL' AS KEY1 ,
			CAST (HDL AS float) AS VAL1 ,
			'LDL' AS KEY2 ,
			CAST (LDL AS float) AS VAL2 ,
			'Total' AS KEY3 ,
			CAST (Total AS float) AS VAL3 ,
			'Tri' AS KEY4 ,
			CAST (Tri AS float) AS VAL4 ,
			'Ratio' AS KEY5 ,
			CAST (Ratio AS float) AS VAL5 ,
			'Fasting' AS KEY6 ,
			CAST (Fasting AS float) AS VAL6 ,
			'VLDL' AS VLDL ,
			CAST (VLDL AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerCholesterol') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerCholesterol') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerCholesterol AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerCholesterol'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerDailySteps' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Step' AS UOM ,
			'Steps' AS KEY1 ,
			CAST (Steps AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerDailySteps') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerDailySteps') AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerDailySteps AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerDailySteps'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerFlexibility' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'HasStretched' AS KEY1 ,
			CAST (HasStretched AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerFlexibility AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFlexibility'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerFruits' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'CUP(8oz)' AS UOM ,
			'Cups' AS KEY1 ,
			CAST (Cups AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerFruits AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerFruits'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHbA1c' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'mmol/mol' AS UOM ,
			'Value' AS KEY1 ,
			CAST ([Value] AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerHbA1c AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHbA1c'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHeight' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'inch' AS UOM ,
			'Height' AS KEY1 ,
			Height AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			ISNULL (T.UniqueName , 'HFit_TrackerHeight') AS UniqueName ,
			ISNULL (T.UniqueName , 'HFit_TrackerHeight') AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerHeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHighFatFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerHighFatFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighFatFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerHighSodiumFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerHighSodiumFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerHighSodiumFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerInstance_Tracker' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'TrackerDefID' AS KEY1 ,
			CAST (TrackerDefID AS float) AS VAL1 ,
			'YesNoValue' AS KEY2 ,
			CAST (YesNoValue AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerInstance_Tracker AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerInstance_Tracker'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerMealPortions' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-portion' AS UOM ,
			'Portions' AS KEY1 ,
			CAST (Portions AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerMealPortions AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMealPortions'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerMedicalCarePlan' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'FollowedPlan' AS KEY1 ,
			CAST (FollowedPlan AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerMedicalCarePlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerMedicalCarePlan'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerRegularMeals' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Units' AS KEY1 ,
			CAST (Units AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerRegularMeals AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRegularMeals'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerRestingHeartRate' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'BPM' AS UOM ,
			'HeartRate' AS KEY1 ,
			CAST (HeartRate AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerRestingHeartRate AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerRestingHeartRate'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerShots' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'FluShot' AS KEY1 ,
			CAST (FluShot AS float) AS VAL1 ,
			'PneumoniaShot' AS KEY2 ,
			CAST (PneumoniaShot AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSitLess' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Occurs' AS UOM ,
			'Times' AS KEY1 ,
			CAST (Times AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSitLess AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSitLess'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSleepPlan' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'HR' AS UOM ,
			'DidFollow' AS KEY1 ,
			CAST (DidFollow AS float) AS VAL1 ,
			'HoursSlept' AS KEY2 ,
			HoursSlept AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Techniques' AS TXTKEY1 ,
			Techniques AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSleepPlan AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSleepPlan'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStrength' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'HasTrained' AS KEY1 ,
			CAST (HasTrained AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStrength AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStrength'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStress' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'gradient' AS UOM ,
			'Intensity' AS KEY1 ,
			CAST (Intensity AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Awareness' AS TXTKEY1 ,
			Awareness AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStress AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStress'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerStressManagement' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'gradient' AS UOM ,
			'HasPracticed' AS KEY1 ,
			CAST (HasPracticed AS float) AS VAL1 ,
			'Effectiveness' AS KEY2 ,
			CAST (Effectiveness AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'Activity' AS TXTKEY1 ,
			Activity AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerStressManagement AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerStressManagement'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSugaryDrinks' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'OZ' AS UOM ,
			'Ounces' AS KEY1 ,
			CAST (Ounces AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSugaryDrinks AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryDrinks'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerSugaryFoods' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-portion' AS UOM ,
			'Portions' AS KEY1 ,
			CAST (Portions AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerSugaryFoods AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerSugaryFoods'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTests' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PSATest' AS KEY1 ,
			CAST (PSATest AS float) AS VAL1 ,
			'OtherExam' AS KEY1 ,
			CAST (OtherExam AS float) AS VAL2 ,
			'TScore' AS KEY3 ,
			CAST (TScore AS float) AS VAL3 ,
			'DRA' AS KEY4 ,
			CAST (DRA AS float) AS VAL4 ,
			'CotinineTest' AS KEY5 ,
			CAST (CotinineTest AS float) AS VAL5 ,
			'ColoCareKit' AS KEY6 ,
			CAST (ColoCareKit AS float) AS VAL6 ,
			'CustomTest' AS KEY7 ,
			CAST (CustomTest AS float) AS VAL7 ,
			'TSH' AS KEY8 ,
			CAST (TSH AS float) AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'CustomDesc' AS TXTKEY1 ,
			CustomDesc AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			TT.ItemOrder ,
			TT.ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTobaccoFree' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'Y/N' AS UOM ,
			'WasTobaccoFree' AS KEY1 ,
			CAST (WasTobaccoFree AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'QuitAids' AS TXTKEY1 ,
			QuitAids AS TXTVAL1 ,
			'QuitMeds' AS TXTKEY2 ,
			QuitMeds AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerTobaccoFree AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTobaccoFree'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerVegetables' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'CUP(8oz)' AS UOM ,
			'Cups' AS KEY1 ,
			CAST (Cups AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerVegetables AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerVegetables'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWater' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'OZ' AS UOM ,
			'Ounces' AS KEY1 ,
			CAST (Ounces AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerWater AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWater'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWeight' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'LBS' AS UOM ,
			'Value' AS KEY1 ,
			[Value] AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerWeight AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWeight'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerWholeGrains' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			CollectionSourceName_Internal ,
			CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA-serving' AS UOM ,
			'Servings' AS KEY1 ,
			CAST (Servings AS float) AS VAL1 ,
			'NA' AS KEY2 ,
			NULL AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			NULL AS VendorID	--VENDOR.ItemID as VendorID
			,
			NULL AS VendorName --VENDOR.VendorName
	   FROM dbo.HFit_TrackerWholeGrains AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerWholeGrains'
	 --left outer join HFit_LKP_TrackerVendor as VENDOR on TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerShots' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'FluShot' AS KEY1 ,
			CAST (FluShot AS float) AS VAL1 ,
			'PneumoniaShot' AS KEY2 ,
			CAST (PneumoniaShot AS float) AS VAL2 ,
			'NA' AS KEY3 ,
			NULL AS VAL3 ,
			'NA' AS KEY4 ,
			NULL AS VAL4 ,
			'NA' AS KEY5 ,
			NULL AS VAL5 ,
			'NA' AS KEY6 ,
			NULL AS VAL6 ,
			'NA' AS KEY7 ,
			NULL AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'NA' AS TXTKEY1 ,
			NULL AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerShots AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerShots'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID
	 UNION
	 SELECT 'HFit_TrackerTests' AS TrackerNameAggregateTable ,
			TT.ItemID ,
			EventDate ,
			TT.IsProfessionallyCollected ,
			TT.TrackerCollectionSourceID ,
			Notes ,
			TT.UserID ,
			NULL AS CollectionSourceName_Internal ,
			NULL AS CollectionSourceName_External ,
			'MISSING' AS EventName ,
			'NA' AS UOM ,
			'PSATest' AS KEY1 ,
			CAST (PSATest AS float) AS VAL1 ,
			'OtherExam' AS KEY2 ,
			CAST (OtherExam AS float) AS VAL2 ,
			'TScore' AS KEY3 ,
			CAST (TScore AS float) AS VAL3 ,
			'DRA' AS KEY4 ,
			CAST (DRA AS float) AS VAL4 ,
			'CotinineTest' AS KEY5 ,
			CAST (CotinineTest AS float) AS VAL5 ,
			'ColoCareKit' AS KEY6 ,
			CAST (ColoCareKit AS float) AS VAL6 ,
			'CustomTest' AS KEY7 ,
			CAST (CustomTest AS float) AS VAL7 ,
			'NA' AS KEY8 ,
			NULL AS VAL8 ,
			'NA' AS KEY9 ,
			NULL AS VAL9 ,
			'NA' AS KEY10 ,
			NULL AS VAL10 ,
			TT.ItemCreatedBy ,
			TT.ItemCreatedWhen ,
			TT.ItemModifiedBy ,
			TT.ItemModifiedWhen ,
			NULL AS IsProcessedForHa ,
			'CustomDesc' AS TXTKEY1 ,
			CustomDesc AS TXTVAL1 ,
			'NA' AS TXTKEY2 ,
			NULL AS TXTVAL2 ,
			'NA' AS TXTKEY3 ,
			NULL AS TXTVAL3 ,
			NULL AS ItemOrder ,
			NULL AS ItemGuid ,
			C.UserGuid ,
			PP.MPI ,
			PP.ClientCode ,
			S.SiteGUID ,
			ACCT.AccountID ,
			ACCT.AccountCD ,
			T.IsAvailable ,
			T.IsCustom ,
			T.UniqueName ,
			T.UniqueName AS ColDesc ,
			VENDOR.ItemID AS VendorID ,
			VENDOR.VendorName
	   FROM dbo.HFit_TrackerTests AS TT
				INNER JOIN dbo.CMS_User AS C
					ON C.UserID = TT.UserID
				INNER JOIN dbo.hfit_ppteligibility AS PP
					ON TT.UserID = PP.userID
				INNER JOIN dbo.HFit_Account AS ACCT
					ON PP.ClientCode = ACCT.AccountCD
				INNER JOIN dbo.CMS_Site AS S
					ON ACCT.SiteID = S.SiteID
				INNER JOIN dbo.HFit_TrackerCollectionSource AS TC
					ON TC.TrackerCollectionSourceID = TT.TrackerCollectionSourceID
				LEFT OUTER JOIN dbo.HFIT_Tracker AS T
					ON T.AggregateTableName = 'HFit_TrackerTests'
				LEFT OUTER JOIN HFit_LKP_TrackerVendor AS VENDOR
					ON TT.VendorID = VENDOR.ItemID;
GO

--  
--  
GO
PRINT '***** FROM: view_EDW_TrackerCompositeDetails.sql';
GO 


--***************************************************************
--***************************************************************

GO

--****************************************************************************************

PRINT 'Analyzing DUP Indexes.';

--****************************************************************************************

GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodPressure_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBloodPressure_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerBloodPressure_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodPressure_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBloodPressure_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodPressure_LastUpdate ON HFit_TrackerBloodPressure;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBloodPressure_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate';
		DROP INDEX PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate ON HFit_TrackerBloodSugarAndGlucose;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBloodSugarAndGlucose_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBMI_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBMI_LastUpdate';
		DROP INDEX PI_HFit_TrackerBMI_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerBMI_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBMI_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBMI_LastUpdate';
		DROP INDEX PI_HFit_TrackerBMI_LastUpdate ON HFit_TrackerBMI;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBMI_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyFat_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBodyFat_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyFat_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerBodyFat_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyFat_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBodyFat_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyFat_LastUpdate ON HFit_TrackerBodyFat;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBodyFat_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBodyMeasurements_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerBodyMeasurements_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBodyMeasurements_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON HFit_TrackerBodyMeasurements;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBodyMeasurements_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCardio_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCardio_LastUpdate';
		DROP INDEX PI_HFit_TrackerCardio_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerCardio_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCardio_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCardio_LastUpdate';
		DROP INDEX PI_HFit_TrackerCardio_LastUpdate ON HFit_TrackerCardio;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerCardio_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCategory_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCategory_LastUpdate';
		DROP INDEX PI_HFit_TrackerCategory_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerCategory_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCategory_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCategory_LastUpdate';
		DROP INDEX PI_HFit_TrackerCategory_LastUpdate ON HFit_TrackerCategory;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerCategory_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCholesterol_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCholesterol_LastUpdate';
		DROP INDEX PI_HFit_TrackerCholesterol_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerCholesterol_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCholesterol_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCholesterol_LastUpdate';
		DROP INDEX PI_HFit_TrackerCholesterol_LastUpdate ON HFit_TrackerCholesterol;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerCholesterol_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCollectionSource_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCollectionSource_LastUpdate';
		DROP INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerCollectionSource_LastUpdate.';
GO

--wdm

IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerCollectionSource_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerCollectionSource_LastUpdate';
		DROP INDEX PI_HFit_TrackerCollectionSource_LastUpdate ON HFit_TrackerCollectionSource;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerCollectionSource_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDailySteps_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDailySteps_LastUpdate';
		DROP INDEX PI_HFit_TrackerDailySteps_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerDailySteps_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDailySteps_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDailySteps_LastUpdate';
		DROP INDEX PI_HFit_TrackerDailySteps_LastUpdate ON HFit_TrackerDailySteps;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerDailySteps_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Item_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDef_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Item_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerDef_Item_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Item_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDef_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Item_LastUpdate ON HFit_TrackerDef;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerDef_Item_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Tracker_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDef_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerDef_Tracker_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDef_Tracker_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDef_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerDef_Tracker_LastUpdate ON HFit_TrackerDef;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerDef_Tracker_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDocument_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDocument_LastUpdate';
		DROP INDEX PI_HFit_TrackerDocument_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerDocument_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerDocument_LastUpdate';
		DROP INDEX PI_HFit_TrackerDocument_LastUpdate ON HFit_TrackerDocument;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerDocument_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFlexibility_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerFlexibility_LastUpdate';
		DROP INDEX PI_HFit_TrackerFlexibility_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerFlexibility_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFlexibility_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerFlexibility_LastUpdate';
		DROP INDEX PI_HFit_TrackerFlexibility_LastUpdate ON HFit_TrackerFlexibility;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerFlexibility_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFruits_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerFruits_LastUpdate';
		DROP INDEX PI_HFit_TrackerFruits_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerFruits_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerFruits_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerFruits_LastUpdate';
		DROP INDEX PI_HFit_TrackerFruits_LastUpdate ON HFit_TrackerFruits;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerFruits_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHbA1c_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHbA1c_LastUpdate';
		DROP INDEX PI_HFit_TrackerHbA1c_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerHbA1c_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHbA1c_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHbA1c_LastUpdate';
		DROP INDEX PI_HFit_TrackerHbA1c_LastUpdate ON HFit_TrackerHbA1c;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerHbA1c_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHeight_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerHeight_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerHeight_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHeight_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerHeight_LastUpdate ON HFit_TrackerHeight;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerHeight_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighFatFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHighFatFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerHighFatFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighFatFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHighFatFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighFatFoods_LastUpdate ON HFit_TrackerHighFatFoods;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerHighFatFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHighSodiumFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerHighSodiumFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerHighSodiumFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerHighSodiumFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerHighSodiumFoods_LastUpdate ON HFit_TrackerHighSodiumFoods;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerHighSodiumFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Item_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerInstance_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerInstance_Item_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Item_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerInstance_Item_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Item_LastUpdate ON HFit_TrackerInstance_Tracker;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerInstance_Item_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerInstance_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerInstance_Tracker_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerInstance_Tracker_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerInstance_Tracker_LastUpdate';
		DROP INDEX PI_HFit_TrackerInstance_Tracker_LastUpdate ON HFit_TrackerInstance_Tracker;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerInstance_Tracker_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMealPortions_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerMealPortions_LastUpdate';
		DROP INDEX PI_HFit_TrackerMealPortions_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerMealPortions_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMealPortions_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerMealPortions_LastUpdate';
		DROP INDEX PI_HFit_TrackerMealPortions_LastUpdate ON HFit_TrackerMealPortions;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerMealPortions_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerMedicalCarePlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerMedicalCarePlan_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerMedicalCarePlan_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerMedicalCarePlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerMedicalCarePlan_LastUpdate ON HFit_TrackerMedicalCarePlan;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerMedicalCarePlan_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRegularMeals_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerRegularMeals_LastUpdate';
		DROP INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerRegularMeals_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRegularMeals_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerRegularMeals_LastUpdate';
		DROP INDEX PI_HFit_TrackerRegularMeals_LastUpdate ON HFit_TrackerRegularMeals;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerRegularMeals_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerRestingHeartRate_LastUpdate';
		DROP INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerRestingHeartRate_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerRestingHeartRate_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerRestingHeartRate_LastUpdate';
		DROP INDEX PI_HFit_TrackerRestingHeartRate_LastUpdate ON HFit_TrackerRestingHeartRate;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerRestingHeartRate_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerShots_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerShots_LastUpdate';
		DROP INDEX PI_HFit_TrackerShots_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerShots_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerShots_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerShots_LastUpdate';
		DROP INDEX PI_HFit_TrackerShots_LastUpdate ON HFit_TrackerShots;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerShots_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSitLess_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSitLess_LastUpdate';
		DROP INDEX PI_HFit_TrackerSitLess_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerSitLess_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSitLess_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSitLess_LastUpdate';
		DROP INDEX PI_HFit_TrackerSitLess_LastUpdate ON HFit_TrackerSitLess;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerSitLess_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSleepPlan_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSleepPlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerSleepPlan_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSleepPlan_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSleepPlan_LastUpdate';
		DROP INDEX PI_HFit_TrackerSleepPlan_LastUpdate ON HFit_TrackerSleepPlan;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerSleepPlan_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStrength_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStrength_LastUpdate';
		DROP INDEX PI_HFit_TrackerStrength_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerStrength_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStrength_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStrength_LastUpdate';
		DROP INDEX PI_HFit_TrackerStrength_LastUpdate ON HFit_TrackerStrength;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerStrength_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStress_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStress_LastUpdate';
		DROP INDEX PI_HFit_TrackerStress_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerStress_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStress_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStress_LastUpdate';
		DROP INDEX PI_HFit_TrackerStress_LastUpdate ON HFit_TrackerStress;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerStress_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStressManagement_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStressManagement_LastUpdate';
		DROP INDEX PI_HFit_TrackerStressManagement_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerStressManagement_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerStressManagement_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerStressManagement_LastUpdate';
		DROP INDEX PI_HFit_TrackerStressManagement_LastUpdate ON HFit_TrackerStressManagement;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerStressManagement_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSugaryDrinks_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerSugaryDrinks_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryDrinks_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSugaryDrinks_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryDrinks_LastUpdate ON HFit_TrackerSugaryDrinks;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerSugaryDrinks_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSugaryFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerSugaryFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSugaryFoods_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSugaryFoods_LastUpdate';
		DROP INDEX PI_HFit_TrackerSugaryFoods_LastUpdate ON HFit_TrackerSugaryFoods;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerSugaryFoods_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSummary_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSummary_LastUpdate';
		DROP INDEX PI_HFit_TrackerSummary_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerSummary_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerSummary_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerSummary_LastUpdate';
		DROP INDEX PI_HFit_TrackerSummary_LastUpdate ON HFit_TrackerSummary;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerSummary_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTests_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerTests_LastUpdate';
		DROP INDEX PI_HFit_TrackerTests_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerTests_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTests_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerTests_LastUpdate';
		DROP INDEX PI_HFit_TrackerTests_LastUpdate ON HFit_TrackerTests;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerTests_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTobaccoFree_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerTobaccoFree_LastUpdate';
		DROP INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerTobaccoFree_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerTobaccoFree_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerTobaccoFree_LastUpdate';
		DROP INDEX PI_HFit_TrackerTobaccoFree_LastUpdate ON HFit_TrackerTobaccoFree;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerTobaccoFree_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerVegetables_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerVegetables_LastUpdate';
		DROP INDEX PI_HFit_TrackerVegetables_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerVegetables_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerVegetables_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerVegetables_LastUpdate';
		DROP INDEX PI_HFit_TrackerVegetables_LastUpdate ON HFit_TrackerVegetables;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerVegetables_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWater_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWater_LastUpdate';
		DROP INDEX PI_HFit_TrackerWater_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerWater_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWater_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWater_LastUpdate';
		DROP INDEX PI_HFit_TrackerWater_LastUpdate ON HFit_TrackerWater;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerWater_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWeight_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerWeight_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerWeight_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWeight_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWeight_LastUpdate';
		DROP INDEX PI_HFit_TrackerWeight_LastUpdate ON HFit_TrackerWeight;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerWeight_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWholeGrains_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWholeGrains_LastUpdate';
		DROP INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON HFit_TrackerFlexibility;
	END;
PRINT 'Processing PI_HFit_TrackerWholeGrains_LastUpdate.';
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerWholeGrains_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerWholeGrains_LastUpdate';
		DROP INDEX PI_HFit_TrackerWholeGrains_LastUpdate ON HFit_TrackerWholeGrains;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerWholeGrains_LastUpdate.';
GO

--Remove These Indexes if exists

IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFit_TrackerBodyMeasurements_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFit_TrackerBodyMeasurements_LastUpdate';
		DROP INDEX PI_HFit_TrackerBodyMeasurements_LastUpdate ON HFit_TrackerBodyMeasurements;

	-- (ItemCreatedWhen, ItemModifiedWhen)

	END;
PRINT 'Processing PI_HFit_TrackerBodyMeasurements_LastUpdate.';
GO

--WDM
--if exists (select name from sys.indexes where name = 'PK_Analytics_ConversionCampaign')
--BEGIN
--print ('REMOVING PK_Analytics_ConversionCampaign');
--drop index PK_Analytics_ConversionCampaign on Analytics_ConversionCampaign;
--END
--GO

IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_Class_ClassName_ClassDisplayName_ClassID') 
	BEGIN
		PRINT 'Processing IX_CMS_Class_ClassName_ClassDisplayName_ClassID .';
		PRINT 'REMOVING IX_CMS_Class_ClassName_ClassDisplayName_ClassID';
		DROP INDEX IX_CMS_Class_ClassName_ClassDisplayName_ClassID ON CMS_Class;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_Role_SiteID_RoleID') 
	BEGIN
		PRINT 'Processing IX_CMS_Role_SiteID_RoleID .';
		PRINT 'REMOVING IX_CMS_Role_SiteID_RoleID';
		DROP INDEX IX_CMS_Role_SiteID_RoleID ON CMS_Role;
	END;
GO

--if exists (select name from sys.indexes where name = 'PK_CMS_TranslationSubmission')
--BEGIN
--Print ('Processing PK_CMS_TranslationSubmission .');print ('REMOVING PK_CMS_TranslationSubmission')
--;
--drop index PK_CMS_TranslationSubmission on CMS_TranslationSubmission;
--END
--GO
--if exists (select name from sys.indexes where name = 'PK_CMS_Tree')
--BEGIN
--Print ('Processing PK_CMS_Tree .');print ('REMOVING PK_CMS_Tree')
--;
--drop index PK_CMS_Tree on CMS_Tree;
--END
--GO

--IF EXISTS (SELECT name
--			 FROM sys.indexes
--			 WHERE name = 'PI02_view_EDW_RewardUserDetail') 
--	BEGIN
--		PRINT 'Processing PI02_view_EDW_RewardUserDetail .';
--		PRINT 'REMOVING PI02_view_EDW_RewardUserDetail';
--		DROP INDEX PI02_view_EDW_RewardUserDetail ON CMS_UserSettings;
--	END;
--GO

IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_CMS_WebFarmServerTask_ServerID_TaskID') 
	BEGIN
		PRINT 'Processing IX_CMS_WebFarmServerTask_ServerID_TaskID .';
		PRINT 'REMOVING IX_CMS_WebFarmServerTask_ServerID_TaskID';
		DROP INDEX IX_CMS_WebFarmServerTask_ServerID_TaskID ON CMS_WebFarmServerTask;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_COM_SKU_SKUName_SKUEnabled') 
	BEGIN
		PRINT 'Processing IX_COM_SKU_SKUName_SKUEnabled .';
		PRINT 'REMOVING IX_COM_SKU_SKUName_SKUEnabled';
		DROP INDEX IX_COM_SKU_SKUName_SKUEnabled ON COM_SKU;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'Ref6') 
	BEGIN
		PRINT 'Processing Ref6.';
		PRINT 'REMOVING Ref6';
		DROP INDEX Ref65 ON HFit_HealthAssesmentThresholds;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'HFit_RewardsUserActivityDetail_PiDate') 
	BEGIN
		PRINT 'Processing HFit_RewardsUserActivityDetail_PiDate .';
		PRINT 'REMOVING HFit_RewardsUserActivityDetail_PiDate';
		DROP INDEX HFit_RewardsUserActivityDetail_PiDate ON HFit_RewardsUserActivityDetail;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'HFit_RewardsUserLevelDetail_PiDate') 
	BEGIN
		PRINT 'Processing HFit_RewardsUserLevelDetail_PiDate .';
		PRINT 'REMOVING HFit_RewardsUserLevelDetail_PiDate';
		DROP INDEX HFit_RewardsUserLevelDetail_PiDate ON HFit_RewardsUserLevelDetail;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'IX_Hfit_TrackerBloodPressure_') 
	BEGIN
		PRINT 'REMOVING IX_Hfit_TrackerBloodPressure_';
		DROP INDEX IX_Hfit_TrackerBloodPressure_1 ON HFit_TrackerBloodPressure;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate') 
	BEGIN
		PRINT 'REMOVING idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate';
		DROP INDEX idx_HFit_TrackerBloodSugarAndGlucose_UserIDEventDate ON HFit_TrackerBloodSugarAndGlucose;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'PI_HFIT_Tracker_LastUpdate') 
	BEGIN
		PRINT 'REMOVING PI_HFIT_Tracker_LastUpdate';
		DROP INDEX PI_HFIT_Tracker_LastUpdate ON HFit_TrackerFlexibility;
	END;
GO
IF EXISTS (SELECT name
			 FROM sys.indexes
			 WHERE name = 'nonContactID') 
	BEGIN
		PRINT 'Processing nonContactID .';
		PRINT 'REMOVING nonContactID';
		DROP INDEX nonContactID ON OM_Contact;
	END;
GO

--IF EXISTS (SELECT name
--			 FROM sys.indexes
--			 WHERE name = 'HFit_Account_AccountID_CI') 
--	BEGIN
--		DROP INDEX HFit_Account_AccountID_CI ON HFit_Account;
--		PRINT 'Removing duplicate HFit_Account';
--	END;
--GO

--IF EXISTS (SELECT name
--			 FROM sys.indexes
--			 WHERE name = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID') 
--	BEGIN
--		DROP INDEX ci_HFit_HealthAssesmentUserQuestion_NodeGUID ON HFit_HealthAssesmentUserQuestion;
--		PRINT 'Removing duplicate HFit_HealthAssesmentUserQuestion';
--	END;
--GO

--if exists(select name from sys.indexes where name = 'ci_commit_ts')
--BEGIN
--drop index ci_commit_ts on syscommittab;
--print('Removing duplicate syscommittab');
--END
--GO

--IF EXISTS (SELECT name
--			 FROM sys.indexes
--			 WHERE name = 'CI_CMSTree_ClassLang') 
--	BEGIN
--		DROP INDEX CI_CMSTree_ClassLang ON View_CMS_Tree_Joined_Regular;
--		PRINT 'Removing duplicate CI_CMSTree_ClassLang';
--	END;
--GO

--IF EXISTS (SELECT name
--			 FROM sys.indexes
--			 WHERE name = 'CI2_View_CMS_Tree_Joined_Regular') 
--	BEGIN
--		DROP INDEX CI2_View_CMS_Tree_Joined_Regular ON View_CMS_Tree_Joined_Regular;
--		PRINT 'Removing duplicate CI2_View_CMS_Tree_Joined_Regular';
--	END;
--GO

--**************************** KEEP THESE INDEXES *****************************

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_CMS_Class_ClassID_ClassName_ClassDisplayName') 
	BEGIN
		PRINT 'Generating IX_CMS_Class_ClassID_ClassName_ClassDisplayName';
		CREATE CLUSTERED INDEX IX_CMS_CLASS_CLASSID_CLASSNAME_CLASSDISPLAYNAME ON CMS_CLASS (CLASSID, CLASSDISPLAYNAME, CLASSNAME) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserActivityDetail_Date') 
	BEGIN
		PRINT 'Generating PI_HFit_RewardsUserActivityDetail_Date';
		CREATE INDEX PI_HFIT_REWARDSUSERACTIVITYDETAIL_DATE ON HFIT_REWARDSUSERACTIVITYDETAIL (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_Analytics_ConversionCampaign') 
	BEGIN
		PRINT 'Generating IX_Analytics_ConversionCampaign';
		CREATE UNIQUE CLUSTERED INDEX IX_ANALYTICS_CONVERSIONCAMPAIGN ON ANALYTICS_CONVERSIONCAMPAIGN (CAMPAIGNID, CONVERSIONID) WITH FILLFACTOR = 90;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'idx_HFit_TrackerBloodPressure_UserIDEventDate') 
	BEGIN
		PRINT 'Generating idx_HFit_TrackerBloodPressure_UserIDEventDate';
		CREATE INDEX IDX_HFIT_TRACKERBLOODPRESSURE_USERIDEVENTDATE ON HFIT_TRACKERBLOODPRESSURE (EVENTDATE, USERID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PK_OM_Contact') 
	BEGIN
		PRINT 'Generating PK_OM_Contact';
		CREATE UNIQUE CLUSTERED INDEX PK_OM_CONTACT ON OM_CONTACT (CONTACTID) WITH FILLFACTOR = 80;
	END;
GO

--if NOT exists (select name from sys.indexes where name = 'idxpagetemplatetemp')
--BEGIN
--print ('Generating idxpagetemplatetemp');
--print ('Generating idxpagetemplatetemp');
--CREATE  UNIQUE  CLUSTERED  INDEX [IDXPAGETEMPLATETEMP]
--         ON [TEMP_CMS_PAGETEMPLATE]
--  (PAGETEMPLATEID) WITH FILLFACTOR = 80 ;
--END
--GO

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'idx_ThresholdTypeID') 
	BEGIN
		PRINT 'Generating idx_ThresholdTypeID';
		CREATE INDEX IDX_THRESHOLDTYPEID ON HFIT_HEALTHASSESMENTTHRESHOLDS (THRESHOLDTYPEID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'pi_CMS_UserSettings_IDMPI') 
	BEGIN
		PRINT 'Generating pi_CMS_UserSettings_IDMPI';
		CREATE INDEX PI_CMS_USERSETTINGS_IDMPI ON CMS_USERSETTINGS (USERSETTINGSID, HFITUSERMPINUMBER) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'idx_HFit_TrackerFlexibility_CreateDate') 
	BEGIN
		PRINT 'Generating idx_HFit_TrackerFlexibility_CreateDate';
		CREATE INDEX IDX_HFIT_TRACKERFLEXIBILITY_CREATEDATE ON HFIT_TRACKERFLEXIBILITY (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_CMS_TranslationSubmission') 
	BEGIN
		PRINT 'Generating IX_CMS_TranslationSubmission';
		CREATE INDEX IX_CMS_TRANSLATIONSUBMISSION ON CMS_TRANSLATIONSUBMISSION (SUBMISSIONID) WITH FILLFACTOR = 90;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_CMS_Tree_NodeID') 
	BEGIN
		PRINT 'Generating IX_CMS_Tree_NodeID';
		CREATE UNIQUE CLUSTERED INDEX IX_CMS_TREE_NODEID ON CMS_TREE (NODEID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_CMS_Role_SiteID_RoleName_RoleDisplayName') 
	BEGIN
		PRINT 'Generating IX_CMS_Role_SiteID_RoleName_RoleDisplayName';
		CREATE CLUSTERED INDEX IX_CMS_ROLE_SITEID_ROLENAME_ROLEDISPLAYNAME ON CMS_ROLE (SITEID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_TrackerBloodSugar_UserID') 
	BEGIN
		PRINT 'Generating IX_TrackerBloodSugar_UserID';
		CREATE INDEX IX_TRACKERBLOODSUGAR_USERID ON HFIT_TRACKERBLOODSUGARANDGLUCOSE (EVENTDATE, USERID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'IX_COM_SKU_SKUDepartmentID') 
	BEGIN
		PRINT 'Generating IX_COM_SKU_SKUDepartmentID';
		CREATE INDEX IX_COM_SKU_SKUDEPARTMENTID ON COM_SKU (SKUDEPARTMENTID) WITH FILLFACTOR = 90;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PK_CMS_WebFarmServerTask') 
	BEGIN
		PRINT 'Generating PK_CMS_WebFarmServerTask';
		CREATE UNIQUE CLUSTERED INDEX PK_CMS_WEBFARMSERVERTASK ON CMS_WEBFARMSERVERTASK (SERVERID, TASKID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserLevelDetail_Date') 
	BEGIN
		PRINT 'Generating PI_HFit_RewardsUserLevelDetail_Date';
		CREATE INDEX PI_HFIT_REWARDSUSERLEVELDETAIL_DATE ON HFIT_REWARDSUSERLEVELDETAIL (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO

--************* KEEP THESE *****************

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserActivityDetail_ActivityNodeID') 
	BEGIN
		PRINT 'BUilding PI_HFit_RewardsUserActivityDetail_ActivityNodeID';
		CREATE INDEX PI_HFIT_REWARDSUSERACTIVITYDETAIL_ACTIVITYNODEID ON HFIT_REWARDSUSERACTIVITYDETAIL (ACTIVITYNODEID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserActivityDetail_Date') 
	BEGIN
		PRINT 'BUilding PI_HFit_RewardsUserActivityDetail_Date';
		CREATE INDEX PI_HFIT_REWARDSUSERACTIVITYDETAIL_DATE ON HFIT_REWARDSUSERACTIVITYDETAIL (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI') 
	BEGIN
		PRINT 'BUilding HFit_HealthAssesmentUserQuestion_HARiskAreaItemID_PI';
		CREATE INDEX HFIT_HEALTHASSESMENTUSERQUESTION_HARISKAREAITEMID_PI ON HFIT_HEALTHASSESMENTUSERQUESTION (HARISKAREAITEMID) WITH FILLFACTOR = 80;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI02_view_EDW_RewardUserDetail') 
	BEGIN
		PRINT 'BUilding PI02_view_EDW_RewardUserDetail';
		CREATE INDEX PI02_VIEW_EDW_REWARDUSERDETAIL ON CMS_USERSETTINGS (USERSETTINGSID, HFITUSERMPINUMBER) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'pi_CMS_UserSettings_IDMPI') 
	BEGIN
		PRINT 'BUilding pi_CMS_UserSettings_IDMPI';
		CREATE INDEX PI_CMS_USERSETTINGS_IDMPI ON CMS_USERSETTINGS (USERSETTINGSID, HFITUSERMPINUMBER) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_SchemaChangeMonitor') 
	BEGIN
		PRINT 'BUilding PI_SchemaChangeMonitor';
		CREATE INDEX PI_SCHEMACHANGEMONITOR ON SCHEMACHANGEMONITOR (OBJ) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'HFit_Account_ClientCode_PI') 
	BEGIN
		PRINT 'BUilding HFit_Account_ClientCode_PI';
		CREATE INDEX HFIT_ACCOUNT_CLIENTCODE_PI ON HFIT_ACCOUNT (ACCOUNTCD) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'HFit_Account_SiteID_PI') 
	BEGIN
		PRINT 'BUilding HFit_Account_SiteID_PI';
		CREATE INDEX HFIT_ACCOUNT_SITEID_PI ON HFIT_ACCOUNT (SITEID) ;
	END;
GO
--IF NOT EXISTS (SELECT name
--				 FROM sys.indexes
--				 WHERE name = 'PI_HFIT_Tracker_LastUpdate') 
--	BEGIN
--		PRINT 'BUilding PI_HFIT_Tracker_LastUpdate';
--		CREATE INDEX PI_HFIT_TRACKER_LASTUPDATE ON HFIT_TRACKERFLEXIBILITY (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
--	END;
--GO
--IF NOT EXISTS (SELECT name
--				 FROM sys.indexes
--				 WHERE name = 'PK_HFit_SSISLoad_ScreeningInvalidMPI') 
--	BEGIN
--		PRINT 'BUilding PK_HFit_SSISLoad_ScreeningInvalidMPI';
--		CREATE UNIQUE CLUSTERED INDEX PK_HFIT_SSISLOAD_SCREENINGINVALIDMPI ON HFIT_SSISLOAD_SCREENINGINVALIDMPI (ITEMID) ;
--	END;
--GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_View_CMS_Tree_Joined_Regular_DocumentCulture') 
	BEGIN
		PRINT 'BUilding PI_View_CMS_Tree_Joined_Regular_DocumentCulture';
		CREATE INDEX PI_VIEW_CMS_TREE_JOINED_REGULAR_DOCUMENTCULTURE ON VIEW_CMS_TREE_JOINED_REGULAR (NODEID, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_VIEW_CMS_TREE_JOINED_REGULAR_NODESITEID_DOCUMENTCULTURE_NODEID') 
	BEGIN
		PRINT 'BUilding PI_VIEW_CMS_TREE_JOINED_REGULAR_NODESITEID_DOCUMENTCULTURE_NODEID';
		CREATE INDEX PI_VIEW_CMS_TREE_JOINED_REGULAR_NODESITEID_DOCUMENTCULTURE_NODEID ON VIEW_CMS_TREE_JOINED_REGULAR (NODEID, NODEPARENTID, NODESITEID, NODEGUID, DOCUMENTID, DOCUMENTMODIFIEDWHEN, DOCUMENTCREATEDWHEN, DOCUMENTPUBLISHEDVERSIONHISTORYID, DOCUMENTCULTURE, DOCUMENTGUID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_ClassLang') 
	BEGIN
		PRINT 'BUilding PI_ClassLang';
		CREATE INDEX PI_CLASSLANG ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, NODEGUID, DOCUMENTFOREIGNKEYVALUE, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_GuidLang') 
	BEGIN
		PRINT 'BUilding PI_GuidLang';
		CREATE INDEX PI_GUIDLANG ON VIEW_CMS_TREE_JOINED_REGULAR (NODEGUID, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_View_CMS_Tree_Joined_Regular_NodeGUID') 
	BEGIN
		PRINT 'BUilding PI_View_CMS_Tree_Joined_Regular_NodeGUID';
		CREATE INDEX PI_VIEW_CMS_TREE_JOINED_REGULAR_NODEGUID ON VIEW_CMS_TREE_JOINED_REGULAR (NODEGUID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_CMS_Tree_Joined_Regular_NODE_FK') 
	BEGIN
		PRINT 'BUilding PI_CMS_Tree_Joined_Regular_NODE_FK';
		CREATE INDEX PI_CMS_TREE_JOINED_REGULAR_NODE_FK ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, NODEGUID, DOCUMENTFOREIGNKEYVALUE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'pi_CMS_Tree_Joined_Regular_NodeGUID') 
	BEGIN
		PRINT 'BUilding pi_CMS_Tree_Joined_Regular_NodeGUID';
		CREATE INDEX PI_CMS_TREE_JOINED_REGULAR_NODEGUID ON VIEW_CMS_TREE_JOINED_REGULAR (NODEGUID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_CMSTR_ClassCulture') 
	BEGIN
		PRINT 'BUilding PI_CMSTR_ClassCulture';
		CREATE INDEX PI_CMSTR_CLASSCULTURE ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, NODEGUID, DOCUMENTFOREIGNKEYVALUE, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_CMSTREE_ClassDocID') 
	BEGIN
		PRINT 'BUilding PI_CMSTREE_ClassDocID';
		CREATE INDEX PI_CMSTREE_CLASSDOCID ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, DOCUMENTID) ;
	END;
GO

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_View_CMS_Tree_Joined_Regular') 
	BEGIN
		PRINT 'BUilding PI_View_CMS_Tree_Joined_Regular';
		CREATE INDEX PI_VIEW_CMS_TREE_JOINED_REGULAR ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, DOCUMENTID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_VIEW_CMS_TREE_JOINED_LINKED_NODESITEID_DOCUMENTCULTURE_NODEID') 
	BEGIN
		PRINT 'BUilding [PI_VIEW_CMS_TREE_JOINED_LINKED_NODESITEID_DOCUMENTCULTURE_NODEID]';
		CREATE INDEX PI_VIEW_CMS_TREE_JOINED_LINKED_NODESITEID_DOCUMENTCULTURE_NODEID ON VIEW_CMS_TREE_JOINED_LINKED (NODEID, NODESITEID, NODEGUID, DOCUMENTMODIFIEDWHEN, DOCUMENTCREATEDWHEN, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_Linked_ClassLang') 
	BEGIN
		PRINT 'BUilding PI_Linked_ClassLang';
		CREATE INDEX PI_LINKED_CLASSLANG ON VIEW_CMS_TREE_JOINED_LINKED (CLASSNAME, NODEGUID, DOCUMENTFOREIGNKEYVALUE, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'idxHfitRewardsAwardUserDetail_CreateDate_PI') 
	BEGIN
		PRINT 'BUilding idxHfitRewardsAwardUserDetail_CreateDate_PI';
		CREATE INDEX IDXHFITREWARDSAWARDUSERDETAIL_CREATEDATE_PI ON HFIT_REWARDSAWARDUSERDETAIL (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_CMS_UserSite_SiteID') 
	BEGIN
		PRINT 'BUilding PI_CMS_UserSite_SiteID';
		CREATE INDEX PI_CMS_USERSITE_SITEID ON CMS_USERSITE (USERID, SITEID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'ix_CmsUserSite_Userid_PI') 
	BEGIN
		PRINT 'BUilding ix_CmsUserSite_Userid_PI';
		CREATE INDEX IX_CMSUSERSITE_USERID_PI ON CMS_USERSITE (USERSITEID, USERID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI') 
	BEGIN
		PRINT 'BUilding HFit_HealthAssesmentUserRiskArea_HARiskCategoryItemID_PI';
		CREATE INDEX HFIT_HEALTHASSESMENTUSERRISKAREA_HARISKCATEGORYITEMID_PI ON HFIT_HEALTHASSESMENTUSERRISKAREA (HARISKCATEGORYITEMID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserLevelDetail_LevelNodeID') 
	BEGIN
		PRINT 'BUilding PI_HFit_RewardsUserLevelDetail_LevelNodeID';
		CREATE INDEX PI_HFIT_REWARDSUSERLEVELDETAIL_LEVELNODEID ON HFIT_REWARDSUSERLEVELDETAIL (LEVELNODEID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'PI_HFit_RewardsUserLevelDetail_Date') 
	BEGIN
		PRINT 'BUilding PI_HFit_RewardsUserLevelDetail_Date';
		CREATE INDEX PI_HFIT_REWARDSUSERLEVELDETAIL_DATE ON HFIT_REWARDSUSERLEVELDETAIL (ITEMCREATEDWHEN, ITEMMODIFIEDWHEN) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'ci_HFit_HealthAssesmentUserQuestion_NodeGUID') 
	BEGIN
		PRINT 'BUilding ci_HFit_HealthAssesmentUserQuestion_NodeGUID';
		CREATE INDEX CI_HFIT_HEALTHASSESMENTUSERQUESTION_NODEGUID ON HFIT_HEALTHASSESMENTUSERQUESTION (ITEMID, HAQUESTIONSCORE, ITEMMODIFIEDWHEN, HARISKAREAITEMID, CODENAME, PREWEIGHTEDSCORE, ISPROFESSIONALLYCOLLECTED, HAQUESTIONNODEGUID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'HFit_Account_AccountID_CI') 
	BEGIN
		PRINT 'BUilding HFit_Account_AccountID_CI';
		CREATE INDEX HFIT_ACCOUNT_ACCOUNTID_CI ON HFIT_ACCOUNT (ACCOUNTID, ACCOUNTCD) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI_CMSTree_ClassLang') 
	BEGIN
		PRINT 'BUilding CI_CMSTree_ClassLang';
		CREATE INDEX CI_CMSTREE_CLASSLANG ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, NODEID, NODEPARENTID, NODELEVEL, NODEGUID, NODEORDER, NODELINKEDNODEID, DOCUMENTMODIFIEDWHEN, DOCUMENTFOREIGNKEYVALUE, DOCUMENTPUBLISHEDVERSIONHISTORYID, DOCUMENTCULTURE, DOCUMENTGUID) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'CI2_View_CMS_Tree_Joined_Regular') 
	BEGIN
		PRINT 'BUilding CI2_View_CMS_Tree_Joined_Regular';
		CREATE INDEX CI2_VIEW_CMS_TREE_JOINED_REGULAR ON VIEW_CMS_TREE_JOINED_REGULAR (CLASSNAME, NODEGUID, DOCUMENTFOREIGNKEYVALUE, DOCUMENTCULTURE) ;
	END;
GO
IF NOT EXISTS (SELECT name
				 FROM sys.indexes
				 WHERE name = 'ci_commit_ts') 
	BEGIN
		PRINT 'BUilding ci_commit_ts';
		CREATE UNIQUE CLUSTERED INDEX CI_COMMIT_TS ON SYSCOMMITTAB (COMMIT_TS, XDES_ID) ;
	END;
GO



GO

DECLARE @DBNAME nvarchar(100);
declare @ServerName nvarchar(80);
set @ServerName = (SELECT @@SERVERNAME ) ;
set @DBNAME = (SELECT DB_NAME() AS [Current Database]);

print ('--');
print ('*************************************************************************************************************');
print ('Processing complete - please check for errors: on database ' + @DBNAME + ' : ON SERVER : '+ @ServerName + ' ON ' + cast(getdate() as nvarchar(50)));
print ('*************************************************************************************************************');
  --  
GO 
print('***** FROM: TheEnd.sql'); 
GO 
