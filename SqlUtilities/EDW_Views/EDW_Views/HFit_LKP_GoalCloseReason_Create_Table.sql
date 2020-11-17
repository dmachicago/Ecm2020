

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