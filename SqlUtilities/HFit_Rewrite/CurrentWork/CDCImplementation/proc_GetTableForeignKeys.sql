
-- use KenticoCMSCloudtst4
-- use KenticoCMS_DataMart_2
-- use KenticoCMS_1
GO
PRINT 'Executing proc_GetTableForeignKeys.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GetTableForeignKeys') 
    BEGIN
        DROP PROCEDURE
             proc_GetTableForeignKeys;
    END;
GO

/*-------------------------------------------------------
exec proc_GetTableForeignKeys 'BASE_HFit_TrackerCotinine'
select * from TEMP_TableFKeys
*/
CREATE PROCEDURE proc_GetTableForeignKeys (
       @TblName AS NVARCHAR (200)) 
AS
BEGIN

/*-----------------------------------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  WDaleMiller@gmail.com
DATE:	  12/19/2015
USE:		  The passed in table willbe search for foreign keys and any that are found will be placed 
		  into the table TEMP_TableFKey such that the list is available to other processes.
*/

    SET NOCOUNT ON;

    DECLARE
           @iCnt AS INT = 0;
    IF OBJECT_ID ('TEMP_TableFKeys') IS NOT NULL
        BEGIN
            DROP TABLE
                 TEMP_TableFKeys;
        END;

    CREATE TABLE TEMP_TableFKeys
    (
                 PKTable_Qualifier NVARCHAR (200) NULL
               , PKTable_Owner NVARCHAR (200) NULL
               , PKTable_Name NVARCHAR (200) NULL
               , PKColumn_Name NVARCHAR (200) NULL
               , FKTable_Qualifier NVARCHAR (200) NULL
               , FKTable_Owner NVARCHAR (200) NULL
               , FKTable_Name NVARCHAR (200) NULL
               , FKColumn_Name NVARCHAR (200) NULL
               , KEY_SEQ INT NULL
               , UPDATE_RULE INT NULL
               , DELETE_RULE INT NULL
               , FK_Name NVARCHAR (200) NULL
               , pK_Name NVARCHAR (200) NULL
               , DEFERRABILITY INT NULL
    );
    --drop table MASTER_FKEYS
    if not exists (select name from sys.tables where name = 'MASTER_FKEYS')
    CREATE TABLE MASTER_FKEYS
    (
                 PKTable_Qualifier NVARCHAR (200) NULL
               , PKTable_Owner NVARCHAR (200) NULL
               , PKTable_Name NVARCHAR (200) NULL
               , PKColumn_Name NVARCHAR (200) NULL
               , FKTable_Qualifier NVARCHAR (200) NULL
               , FKTable_Owner NVARCHAR (200) NULL
               , FKTable_Name NVARCHAR (200) NULL
               , FKColumn_Name NVARCHAR (200) NULL
               , KEY_SEQ INT NULL
               , UPDATE_RULE INT NULL
               , DELETE_RULE INT NULL
               , FK_Name NVARCHAR (200) NULL
               , pK_Name NVARCHAR (200) NULL
               , DEFERRABILITY INT NULL
			, RowNbr int identity (1,1)
    );

    CREATE CLUSTERED INDEX PI_TableFKeys ON TEMP_TableFKeys (PKTable_Name , FKTable_Name) ;

    INSERT INTO TEMP_TableFKeys EXEC sp_fkeys @TblName;
    INSERT INTO MASTER_FKEYS EXEC sp_fkeys @TblName;

    INSERT INTO MASTER_FKEYS EXEC sp_fkeys @TblName;
    
    DELETE FROM TEMP_TableFKeys
    WHERE
           PKTable_Owner != 'dbo';

    SET @iCnt = (SELECT
                        count (*) 
                 FROM TEMP_TableFKeys) ;
    SET NOCOUNT OFF;
    RETURN @iCnt;

END;
GO
PRINT 'Executed proc_GetTableForeignKeys.sql';
GO
