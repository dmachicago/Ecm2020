
-- Use KenticoCMS_Datamart_2 
GO
PRINT 'Excecuting proc_ConnectTables_BySurrogateKey.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_ConnectTables_BySurrogateKey') 
    BEGIN
        DROP PROCEDURE
             proc_ConnectTables_BySurrogateKey;
    END;
GO

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------
UPDATE
    ChildTable
SET
    SurrogateKey_cms_user = ParentTable.SurrogateKey_cms_user
FROM
    FACT_TrackerData ChildTable
    JOIN
    BASE_CMS_User ParentTable ON 
		ChildTable.DBNAME=ParentTable.DBNAME
		and ChildTable.UserID=ParentTable.UserID 

select 
exec proc_ConnectTables_BySurrogateKey @SurrogateKey = "SurrogateKey_cms_user", @ParentTable = "BASE_CMS_User", @ChildTable  = "BASE_HFit_LKP_TrackerCardioActivity", @PreviewOnly = 0

update BASE_HFit_LKP_TrackerCardioActivity set SurrogateKey_cms_user = (select SurrogateKey_cms_user from BASE_CMS_User B 
    where BASE_HFit_LKP_TrackerCardioActivity.Userid = B.UserID and BASE_HFit_LKP_TrackerCardioActivity.DBNAME = B.DBNAME)

exec proc_ConnectTables_BySurrogateKey 
       @SurrogateKey = 'SurrogateKey_hfit_PPTEligibility'
     , @ParentTable = 'BASE_hfit_PPTEligibility'
     , @ChildTable  = 'BASE_HFit_Coaches'
     , @PreviewOnly = 0

-- *********************************************
exec proc_ConnectTables_BySurrogateKey 
       @SurrogateKey = 'SurrogateKey_CMS_User'
     , @ParentTable = 'BASE_CMS_User'
     , @ChildTable  = 'BASE_cms_usersettings'
     , @PreviewOnly = 0

update BASE_cms_usersettings set SurrogateKey_CMS_User = (select SurrogateKey_CMS_User from BASE_CMS_User B 
    where BASE_cms_usersettings.UserSettingsUserID = B.UserID and BASE_cms_usersettings.DBNAME = B.DBNAME)

select * from MART_SYNC_Table_FKRels 
-- *********************************************

exec proc_ConnectTables_BySurrogateKey 
       @SurrogateKey = 'SurrogateKey_cms_user'
     , @ParentTable = 'BASE_CMS_User'
     , @ChildTable  = 'FACT_TrackerData'
     , @PreviewOnly = 0
update FACT_TrackerData set SurrogateKey_cms_user = (select top 1 SurrogateKey_cms_user from BASE_CMS_User B 
    where FACT_TrackerData.Userid = B.UserID and FACT_TrackerData.DBNAME = B.DBNAME)

exec proc_ConnectTables_BySurrogateKey 
       @SurrogateKey = 'SurrogateKey_hfit_PPTEligibility'
     , @ParentTable = 'BASE_hfit_PPTEligibility'
     , @ChildTable  = 'FACT_TrackerData'
     , @PreviewOnly = 0
update BASE_HFit_Coaches set SurrogateKey_hfit_PPTEligibility = (select SurrogateKey_hfit_PPTEligibility from BASE_hfit_PPTEligibility B 
    where BASE_HFit_Coaches.Userid = B.UserID and BASE_HFit_Coaches.DBNAME = B.DBNAME)
*/
CREATE PROCEDURE proc_ConnectTables_BySurrogateKey (
       @SurrogateKey AS NVARCHAR (250) 
     , @ParentTable  AS NVARCHAR (250) 
     , @ChildTable  AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
AS
BEGIN

/*--------------------------------------------------------------------------------------------------------
-----------------------------
Developer	  W. Dale Miller
Contact	  wdalemiller@gmail.com
Date		  02.15.2016
Purpose	  The Data Mart requires numeric surrogate keys in order to build cubes correctly and efficiently.
		  This routine allows a foreign key relationship to be created between two tables by simply supplying 
		  the required parameters.
*/
    DECLARE
           @i AS INT = 0
         , @MySql AS NVARCHAR (MAX) 
         , @FKNAME AS NVARCHAR (250) 
         , @DBNAME AS NVARCHAR (250) = DB_NAME () ;

    IF
           (SELECT
                   count (*) 
            FROM
            INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
            INNER JOIN
            INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
            ON
                   TC.CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                   TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME AND
                   ku.table_name = @ParentTable AND
                   column_name = @SurrogateKey) = 0
        BEGIN
            PRINT @ParentTable + ' does not contain ' + @SurrogateKey + ', ABORTING...';
            RETURN;
        END;
    ELSE
        BEGIN
            PRINT @ParentTable + ' CONTAINS ' + @SurrogateKey + ', continuing...';
        END;

    --Check to see if FK rel already exists    
    SET @i = (SELECT
                     count (*) 
              FROM ufnTbl_GetAllForeignKeyRelationships (@ParentTable) 
              WHERE
                     PK_Table = @ParentTable AND
                     FK_Table = @ChildTable AND
                     FK_Column = @SurrogateKey) ;

    -- IF So- return with message
    IF @i > 0
        BEGIN
            PRINT 'Foreign Key ' + @SurrogateKey + ' already exists between ' + @ParentTable + ' and ' + @ChildTable + '.';
            RETURN;
        END;
    ELSE
        BEGIN
            PRINT 'Foreign Key ' + @SurrogateKey + ' DOES NOT exist between ' + @ParentTable + ' and ' + @ChildTable + '.';
        END;

    SET @i = (SELECT
                     count (*) 
              FROM information_schema.columns
              WHERE
                     table_name = @ChildTable AND
                     column_name = @SurrogateKey) ;

    IF @i = 0
        BEGIN
            SET @MySql = 'ALTER table ' + @ChildTable + ' add ' + @SurrogateKey + ' bigint null ';
            PRINT @MySql;
            IF @PreviewOnly = 0
                BEGIN EXEC (@MySql) ;
                END;
        END;

    --**********************************************************
    BEGIN TRY
        SET @FKNAME = 'FK_' + @ParentTable + @ChildTable;
        SET @MySql = 'ALTER TABLE ' + @ChildTable + char (10) ;
        SET @MySql = @MySql + ' ADD CONSTRAINT ' + @FKNAME + ' FOREIGN KEY(' + @SurrogateKey + ')REFERENCES ' + @ParentTable + '(' + @SurrogateKey + ') ';

        IF NOT EXISTS (SELECT
                              name
                       FROM sys.foreign_keys
                       WHERE name = @FKNAME) 
            BEGIN
                PRINT @MySql;
                IF
                       @PreviewOnly != 1
                    BEGIN
                        EXEC (@MySql) ;
                    END;
            END ;
        ELSE
            BEGIN
                PRINT 'NOTICE: FKEY ' + @FKNAME + ' already exists, will not attempt to create it again.';
            END;
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE: FKEY ' + @FKNAME + ' Failed to create.';
        PRINT @MySql;
    END CATCH;
--**********************************************************

END;

GO
PRINT 'Excecuting proc_ConnectTables_BySurrogateKey.sql';
GO
