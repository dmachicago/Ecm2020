
-- use KenticoCMS_DataMart_2

/*----------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
drop table FACT_EDW_TrackerCompositeDetails
set rowcount 500

-- truncate table FACT_EDW_TrackerCompositeDetails
-- delete from FACT_EDW_TrackerCompositeDetails where TrackerNameAggregateTable = 'HFit_TrackerCardio'

select count(*) from FACT_EDW_TrackerCompositeDetails
select top 100 * from FACT_EDW_TrackerCompositeDetails
*/

GO
PRINT 'Executing Create_FACT_EDW_TrackerCompositeDetails.sql';
GO

/*
IF EXISTS (SELECT
                  name
           FROM sys.tables
           WHERE
                  name = 'FACT_EDW_TrackerCompositeDetails') 
    BEGIN
        DROP TABLE
             dbo.FACT_EDW_TrackerCompositeDetails;
    END;
GO
*/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.tables
               WHERE
                      name = 'FACT_EDW_TrackerCompositeDetails') 
    BEGIN
        CREATE TABLE dbo.FACT_EDW_TrackerCompositeDetails (
                     TrackerNameAggregateTable NVARCHAR (100) NOT NULL
                   , ItemID INT NOT NULL
                   , EventDate DATETIME NULL
                   , IsProfessionallyCollected BIT NULL
                   , TrackerCollectionSourceID INT NULL
                   , Notes NVARCHAR (1000) NULL
                   , UserID INT NULL
                   , CollectionSourceName_Internal NVARCHAR (100) NULL
                   , CollectionSourceName_External NVARCHAR (100) NULL
                   , EventName NVARCHAR (100) NULL
                   , UOM NVARCHAR (100) NULL
                   , KEY1 NVARCHAR (100) NULL
                   , VAL1 FLOAT NULL
                   , KEY2 NVARCHAR (8) NULL
                   , VAL2 FLOAT NULL
                   , KEY3 NVARCHAR (100) NULL
                   , VAL3 FLOAT NULL
                   , KEY4 NVARCHAR (100) NULL
                   , VAL4 FLOAT NULL
                   , KEY5 NVARCHAR (100) NULL
                   , VAL5 FLOAT NULL
                   , KEY6 NVARCHAR (100) NULL
                   , VAL6 INT NULL
                   , KEY7 NVARCHAR (100) NULL
                   , VAL7 INT NULL
                   , KEY8 NVARCHAR (100) NULL
                   , VAL8 INT NULL
                   , KEY9 NVARCHAR (100) NULL
                   , VAL9 INT NULL
                   , KEY10 NVARCHAR (100) NULL
                   , VAL10 INT NULL
                   , ItemCreatedBy INT NULL
                   , ItemCreatedWhen DATETIME NULL
                   , ItemModifiedBy INT NULL
                   , ItemModifiedWhen DATETIME NULL
                   , IsProcessedForHa INT NULL
                   , TXTKEY1 NVARCHAR (100) NULL
                   , TXTVAL1 INT NULL
                   , TXTKEY2 NVARCHAR (100) NULL
                   , TXTVAL2 INT NULL
                   , TXTKEY3 NVARCHAR (100) NULL
                   , TXTVAL3 INT NULL
                   , ItemOrder INT NULL
                   , ItemGuid INT NULL
                   , UserGuid UNIQUEIDENTIFIER NULL
                   , MPI NVARCHAR (100) NULL
                   , ClientCode NVARCHAR (100) NULL
                   , SiteGUID UNIQUEIDENTIFIER NULL
                   , AccountID INT NULL
                   , AccountCD NVARCHAR (100) NULL
                   , IsAvailable BIT NULL
                   , IsCustom BIT NULL
                   , UniqueName NVARCHAR (100) NULL
                   , ColDesc NVARCHAR (100) NULL
                   , VendorID INT NULL
                   , VendorName INT NULL
                   , LastModifiedDate DATETIME NULL
                   , SVR NVARCHAR (100) NOT NULL
                   , DBNAME NVARCHAR (100) NOT NULL
                   , RowNumber INT IDENTITY (1 , 1) 
                                   NOT NULL
                   , SurrogateKey INT NULL
        ) 
        ON [PRIMARY]
    END;
GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PKEY_FACT_TrackerData') 
    BEGIN
        CREATE UNIQUE INDEX PKEY_FACT_TrackerData ON dbo.FACT_EDW_TrackerCompositeDetails
        (
        ItemID ASC ,
        SVR ,
        DBNAME
        )INCLUDE (AccountCD , TrackerNameAggregateTable) ;
    END;
GO
IF NOT EXISTS (SELECT
                      name
               FROM sys.indexes
               WHERE
                      name = 'PKEY_FACT_TrackerData_Recno') 
    BEGIN
        CREATE INDEX PKEY_FACT_TrackerData_Recno ON dbo.FACT_EDW_TrackerCompositeDetails
        (
        RowNumber
        ) INCLUDE (TrackerNameAggregateTable) ;
    END;
GO
-- ADD THE Surrogate KEYS
DECLARE
       @CMD AS NVARCHAR (4000) 
     , @TblName  AS NVARCHAR (250) 
     , @ColName  AS NVARCHAR (250) ;
DECLARE C CURSOR
    FOR
        SELECT
               table_name AS TableName
             , column_name AS ColumnNme
             , 'alter table FACT_EDW_TrackerCompositeDetails add ' + column_name + ' bigint null ;' AS CMD
        FROM information_schema.columns
        WHERE
        table_name LIKE 'BASE_Hfit_track%' AND
        column_name LIKE 'SurrogateKey_%';

OPEN C;

FETCH NEXT FROM C INTO @TblName , @ColName , @CMD;

WHILE
       @@FETCH_STATUS = 0
    BEGIN

        BEGIN TRY
            IF NOT EXISTS (SELECT
                                  column_name
                           FROM information_schema.columns
                           WHERE
                                  column_name = @ColName AND
                                  Table_name = 'FACT_EDW_TrackerCompositeDetails') 
                BEGIN
                    EXEC (@CMD) ;
                    PRINT 'SUCCESS: ' + @CMD;
                END;
            ELSE
                BEGIN
                    PRINT 'ALREADY EXISTS - Skipping: ' + @CMD;
                END;
        END TRY
        BEGIN CATCH
            PRINT 'FAILED: ' + @CMD;
        END CATCH;

        --declare @FKeyName as nvarchar(500) ;
        --set @FKeyName = 'FKEY_TrackerCompositeDetails_TO_'+@TblName ;
        --print @FKeyName ;

        --ALTER TABLE FACT_EDW_TrackerCompositeDetails
        --ADD CONSTRAINT @FKeyName FOREIGN KEY(@TblName)REFERENCES @TblName(ProductID)

        FETCH NEXT FROM C INTO @TblName , @ColName , @CMD;
    END;
CLOSE C;
DEALLOCATE C;

GO
PRINT 'Executed Create_FACT_EDW_TrackerCompositeDetails.sql';
GO
