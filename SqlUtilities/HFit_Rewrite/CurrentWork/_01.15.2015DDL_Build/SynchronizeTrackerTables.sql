

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

