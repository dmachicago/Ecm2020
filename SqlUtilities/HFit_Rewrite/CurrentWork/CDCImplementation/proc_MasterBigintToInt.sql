
-- use kenticoCMS_1

-- select * from information_schema.columns where table_name = 'HFit_HealthAssessmentPaperException'


/*
use KenticoCMSDebug
use KenticoCMSDev
use KenticoCMSTest
exec PROC_MasterBigIntToInt @PreviewOnly = 'NO'
*/

GO

GO
PRINT 'Executing PROC_MasterBigIntToInt.sql';
GO

IF NOT EXISTS (SELECT NAME
                 FROM SYS.PROCEDURES
                 WHERE NAME = 'usp_GetErrorInfo') 
    BEGIN
        DECLARE
              @S AS nvarchar (1000) = 'CREATE PROCEDURE usp_GetErrorInfo AS SELECT ERROR_NUMBER() AS ErrorNumber,ERROR_SEVERITY() AS ErrorSeverity,ERROR_STATE() AS ErrorState,ERROR_PROCEDURE() AS ErrorProcedure,ERROR_LINE() AS ErrorLine,ERROR_MESSAGE() AS ErrorMessage; ';
        EXEC (@S) ;
    END;
GO
IF EXISTS (SELECT NAME
             FROM SYS.PROCEDURES
             WHERE NAME = 'proc_BigintToInt') 
    BEGIN
        DROP PROCEDURE PROC_BIGINTTOINT;
    END;
GO
IF EXISTS (SELECT NAME
             FROM SYS.PROCEDURES
             WHERE NAME = 'PROC_MasterBigIntToInt') 
    BEGIN
        DROP PROCEDURE dbo.PROC_MasterBigIntToInt;
    END;
GO

/*------------------------------------------------
exec PROC_MasterBigIntToInt @PreviewOnly = 'YES'
exec PROC_MasterBigIntToInt @PreviewOnly = 'NO'

SELECT * FROM VIEW_DDL_BACKUP
*/

CREATE PROCEDURE PROC_MasterBigIntToInt (@PreviewOnly AS nvarchar (10) = 'YES') 
AS
BEGIN

/*---------------------------------------------------------------------------------------
Author:	  W. Dale Miller
Contact:	  WDaleMiller@gmail.com
Date:	  12/21/2015
Changes:	  
01/07/2016:
    Found and corrected issue with recreating indexes. 
    The check to see if an index already exists was
    not returning a response that was being used by 
    logic. (WDM)
01/07/2016:
    Found and corrected index lexer issue. (WDM)
02/10/2016:
    Added PROC to rebuild all VIEWs that might be affected (proc_BigIntViewRebuild). (WDM)
*/

    --declare @PreviewOnly AS NVARCHAR (10) = 'NO' ;

    print 'LAST IVP BUILD DATE: 03.30.2016 1256' ;

    EXEC ScriptAllForeignKeyConstraints;

    DECLARE
          @Idx AS nvarchar (100) = '' , 
          @Ct_Name AS nvarchar (100) = '' , 
          @Ct_Needed AS nvarchar (100) = 'N' , 
          @Mysql AS nvarchar (max) = '' , 
          @Icnt AS int = 0 , 
          @Tablename AS nvarchar (100) = '' , 
          @Indexname AS nvarchar (100) = '' , 
          @S AS nvarchar (max) = '' , 
          @I AS int = 0 , 
          @Currconstraint AS nvarchar (100) = '' , 
          @Prevconstraint AS nvarchar (100) = '~~' , 
          @Currtable AS nvarchar (100) = '' , 
          @Prevtable AS nvarchar (100) = '~~' , 
          @Curridx AS nvarchar (100) = '' , 
          @Previdx AS nvarchar (100) = '~~' , 
          @Idxsql AS nvarchar (max) = NULL , 
          @Indexcols AS nvarchar (max) = NULL , 
          @Includes AS nvarchar (max) = NULL , 
          @Ddl AS nvarchar (max) = NULL , 
          @Icolcnt AS int = 0 , 
          @Foreignkeyname nvarchar (4000) , 
          @Parenttablename nvarchar (4000) , 
          @Parenttableschema nvarchar (4000) , 
          @Tsqldropfk nvarchar (max) , 
          @Sqlcmd nvarchar (max) , 
          @Foreignkeyid int , 
          @Parentcolumn varchar (4000) , 
          @Referencedtable varchar (4000) , 
          @Referencedcolumn varchar (4000) , 
          @Strparentcolumn varchar (max) , 
          @Strreferencedcolumn varchar (max) , 
          @Msg varchar (max) , 
          @Referencedtableschema varchar (4000) , 
          @Tsqlcreationfk varchar (max) , 
          @cmd varchar (4000) ;

    IF NOT EXISTS (SELECT name
                     FROM sys.tables
                     WHERE name = 'BIGINT_Conversion_Errors') 
        BEGIN
            CREATE TABLE BIGINT_Conversion_Errors (err_txt nvarchar (max)) ;
        END;

    truncate TABLE BIGINT_Conversion_Errors;

    BEGIN TRANSACTION TX01;
    SET NOCOUNT ON;

    --ROLLBACK TRANSACTION TX01;

    BEGIN TRY

        --**********************************************************************
        -- CLEAN UP THE TEMP TABLES IF THEY EXIST.
        --**********************************************************************

        BEGIN TRY
            CLOSE CINDEXDDL;
            DEALLOCATE CINDEXDDL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CINDEXDDL';
        END CATCH;

        BEGIN TRY
            CLOSE CUR_Constraint_CREATE;
            DEALLOCATE CUR_Constraint_CREATE;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CUR_Constraint_CREATE';
        END CATCH;
        BEGIN TRY
            CLOSE CUR_Constraint_DROP;
            DEALLOCATE CUR_Constraint_DROP;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CUR_Constraint_DROP';
        END CATCH;
        BEGIN TRY
            CLOSE CCT;
            DEALLOCATE CCT;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CCT';
        END CATCH;
        BEGIN TRY
            CLOSE CPKEYDDL;
            DEALLOCATE CPKEYDDL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CPKEYDDL';
        END CATCH;
        BEGIN TRY
            CLOSE CCHGTRACK;
            DEALLOCATE CCHGTRACK;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CChgTrack';
        END CATCH;
        BEGIN TRY
            CLOSE CDROPIDX;
            DEALLOCATE CDROPIDX;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CDropIdx';
        END CATCH;
        BEGIN TRY
            CLOSE CBIGINT;
            DEALLOCATE CBIGINT;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Cleaned up CBigint';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_LISTOFINDEXES;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_LISTOFINDEXES ';
        END CATCH;
        BEGIN TRY
            DROP TABLE TMP_TEMP;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TMP_TEMP';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_LISTOFSUSPECTTABLES;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_LISTOFSUSPECTTABLES';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_INDEXSQLSTATEMENT;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_INDEXSQLSTATEMENT';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_INDEXDETAIL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_INDEXDETAIL';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_TblPriKeyDDL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_TblPriKeyDDL';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_PRIMARYKEYDETAIL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_PRIMARYKEYDETAIL';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_IndexDDL;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_IndexDDL';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_CT_Tables;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_CT_Tables;';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_FK;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_FK;';
        END CATCH;
        BEGIN TRY
            DROP TABLE TEMP_TblConstraints;
        END TRY
        BEGIN CATCH
            EXEC dbo.PrintImmediate 'Recreate TEMP_TblConstraints;';
        END CATCH;
        IF OBJECT_ID ('TEMP_DROPFK') IS NOT NULL
            BEGIN
                DROP TABLE TEMP_DROPFK;
            END;

        --**********************************************************************************************
        -- LOAD ALL FOREIGN KEY CONSTRAINTS AND REGEN THE RESPECTIVE DLL
        --**********************************************************************************************

        IF OBJECT_ID ('TEMP_FK_Constraints') IS NOT NULL
            BEGIN
                DROP TABLE TEMP_FK_Constraints;
            END;

        CREATE TABLE TEMP_FK_Constraints (FOREIGNKEYID int NULL , 
                                          FOREIGNKEYNAME nvarchar (150) NOT NULL , 
                                          PARENTTABLENAME nvarchar (150) NOT NULL , 
                                          PARENTCOLUMN nvarchar (150) NOT NULL , 
                                          REFERENCEDTABLE nvarchar (150) NOT NULL , 
                                          REFERENCEDCOLUMN nvarchar (150) NOT NULL , 
                                          GENSQL nvarchar (4000) NULL , 
                                          SchemaName nvarchar (100) NULL) ;

        DECLARE CURSORFK CURSOR
            FOR SELECT object_id

                --, name, object_name( parent_object_id) 

                  FROM SYS.FOREIGN_KEYS;
        OPEN CURSORFK;
        FETCH NEXT FROM CURSORFK INTO @Foreignkeyid;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @Strparentcolumn = '';
                SET @Strreferencedcolumn = '';
                DECLARE CURSORFKDETAILS CURSOR
                    FOR SELECT FK.NAME AS FOREIGNKEYNAME , 
                               SCHEMA_NAME (T1.SCHEMA_ID) AS PARENTTABLESCHEMA , 
                               OBJECT_NAME (FKC.PARENT_OBJECT_ID) AS PARENTTABLE , 
                               C1.NAME AS PARENTCOLUMN , 
                               SCHEMA_NAME (T2.SCHEMA_ID) AS REFERENCEDTABLESCHEMA , 
                               OBJECT_NAME (FKC.REFERENCED_OBJECT_ID) AS REFERENCEDTABLE , 
                               C2.NAME AS REFERENCEDCOLUMN
                          FROM
                               SYS.FOREIGN_KEYS AS FK
                               INNER JOIN SYS.FOREIGN_KEY_COLUMNS AS FKC
                               ON FK.OBJECT_ID = FKC.CONSTRAINT_OBJECT_ID
                               INNER JOIN SYS.COLUMNS AS C1
                               ON C1.OBJECT_ID = FKC.PARENT_OBJECT_ID
                              AND C1.COLUMN_ID = FKC.PARENT_COLUMN_ID
                               INNER JOIN SYS.COLUMNS AS C2
                               ON C2.OBJECT_ID = FKC.REFERENCED_OBJECT_ID
                              AND C2.COLUMN_ID = FKC.REFERENCED_COLUMN_ID
                               INNER JOIN SYS.TABLES AS T1
                               ON T1.OBJECT_ID = FKC.PARENT_OBJECT_ID
                               INNER JOIN SYS.TABLES AS T2
                               ON T2.OBJECT_ID = FKC.REFERENCED_OBJECT_ID
                          WHERE FK.OBJECT_ID = @Foreignkeyid;

                OPEN CURSORFKDETAILS;

                FETCH NEXT FROM CURSORFKDETAILS INTO @Foreignkeyname , @Parenttableschema , @Parenttablename , @Parentcolumn , @Referencedtableschema , @Referencedtable , @Referencedcolumn;
                WHILE @@Fetch_Status = 0
                    BEGIN
                        SET @Strparentcolumn = @Strparentcolumn + ', ' + QUOTENAME (@Parentcolumn) ;
                        SET @Strreferencedcolumn = @Strreferencedcolumn + ', ' + QUOTENAME (@Referencedcolumn) ;
                        FETCH NEXT FROM CURSORFKDETAILS INTO @Foreignkeyname , @Parenttableschema , @Parenttablename , @Parentcolumn , @Referencedtableschema , @Referencedtable , @Referencedcolumn;
                    END;
                CLOSE CURSORFKDETAILS;
                DEALLOCATE CURSORFKDETAILS;

                SET @Strparentcolumn = SUBSTRING (@Strparentcolumn , 2 , LEN (@Strparentcolumn) - 1) ;
                SET @Strreferencedcolumn = SUBSTRING (@Strreferencedcolumn , 2 , LEN (@Strreferencedcolumn) - 1) ;
                SET @Tsqlcreationfk = 'ALTER TABLE ' + QUOTENAME (@Parenttableschema) + '.' + QUOTENAME (@Parenttablename) + ' WITH CHECK ADD CONSTRAINT ' + QUOTENAME (@Foreignkeyname) + ' FOREIGN KEY(' + LTRIM (@Strparentcolumn) + ') ' + CHAR (13) + 'REFERENCES ' + QUOTENAME (@Referencedtableschema) + '.' + QUOTENAME (@Referencedtable) + ' (' + LTRIM (@Strreferencedcolumn) + ') ' + CHAR (13) + 'GO';
                SET @Sqlcmd = 'ALTER TABLE ' + QUOTENAME (@Parenttableschema) + '.' + QUOTENAME (@Parenttablename) + ' WITH CHECK ADD CONSTRAINT ' + QUOTENAME (@Foreignkeyname) + ' FOREIGN KEY(' + LTRIM (@Strparentcolumn) + ') ' + CHAR (13) + 'REFERENCES ' + QUOTENAME (@Referencedtableschema) + '.' + QUOTENAME (@Referencedtable) + ' (' + LTRIM (@Strreferencedcolumn) + ') ';
                EXEC dbo.PrintImmediate @Tsqlcreationfk;

                INSERT INTO TEMP_FK_Constraints (FOREIGNKEYID , 
                                                 FOREIGNKEYNAME , 
                                                 PARENTTABLENAME , 
                                                 PARENTCOLUMN , 
                                                 REFERENCEDTABLE , 
                                                 REFERENCEDCOLUMN , 
                                                 GENSQL , 
                                                 SchemaName) 
                VALUES (@Foreignkeyid , 
                        @Foreignkeyname , 
                        @Parenttablename , 
                        @Parentcolumn , 
                        @Referencedtable , 
                        @Referencedcolumn , 
                        @Sqlcmd , 
                        'DBO') ;

                FETCH NEXT FROM CURSORFK INTO @Foreignkeyid;
            END;
        CLOSE CURSORFK;
        DEALLOCATE CURSORFK;

        --**********************************************************************************************
        -- GENERATE AND LOAD DLL TO DROP ALL FOREIGN KEY CONSTRAINTS 
        --**********************************************************************************************        

        IF OBJECT_ID ('TEMP_DROPFK') IS NOT NULL
            BEGIN
                DROP TABLE TEMP_DROPFK;
            END;
        CREATE TABLE TEMP_DROPFK (PARENTTABLENAME nvarchar (150) NOT NULL , 
                                  ChildTableName nvarchar (150) NULL , 
                                  FOREIGNKEYNAME nvarchar (150) NOT NULL , 
                                  DROPSQL nvarchar (4000) NULL) ;
        DECLARE CURSORFK CURSOR
            FOR SELECT FK.NAME AS FOREIGNKEYNAME , 
                       SCHEMA_NAME (T.SCHEMA_ID) AS PARENTTABLESCHEMA , 
                       T.NAME AS PARENTTABLENAME
                  FROM
                       SYS.FOREIGN_KEYS AS FK
                       INNER JOIN SYS.TABLES AS T
                       ON FK.PARENT_OBJECT_ID = T.OBJECT_ID
                  --ADDED by Nixon and Dale 2.1.2016
                  WHERE T.NAME NOT LIKE 'Analytics%'
                    AND T.NAME NOT LIKE 'PM_%'
                    AND T.NAME NOT LIKE '%EDW_CT%'
                    AND T.NAME NOT LIKE 'STAGE%'
                    AND T.NAME NOT LIKE 'MEDIA_FILE'
                    AND T.NAME NOT LIKE 'STAGing%'
                    AND T.NAME NOT LIKE 'temp_%'
                    AND T.NAME NOT LIKE 'sharepoint_%'
                    AND T.NAME NOT LIKE 'sm_insight%'
                    AND T.NAME NOT LIKE 'ct_%'
                    AND T.NAME NOT LIKE 'Trace%'
                    AND T.NAME NOT LIKE 'RewardPointsRewarded'
                    AND T.NAME NOT LIKE 'EDW_HealthAssessment'
                    AND T.NAME NOT LIKE 'HFit_HealthAssessmentPaperException'
                    AND T.NAME NOT LIKE '%FileSize%'
                    AND T.NAME NOT LIKE '%HitValue%';

        OPEN CURSORFK;
        FETCH NEXT FROM CURSORFK INTO @Foreignkeyname , @Parenttableschema , @Parenttablename;
        WHILE @@Fetch_Status = 0
            BEGIN

                DECLARE
                      @ChildTableName AS nvarchar (250) , 
                      @TgtTable AS nvarchar (200) = QUOTENAME (@Parenttableschema) + '.' + QUOTENAME (@Parenttablename) ;

                SET @ChildTableName = (SELECT TOP 1 OBJECT_NAME (f.referenced_object_id) AS ChildTable
                                         FROM
                                              sys.foreign_keys AS f
                                              INNER JOIN sys.foreign_key_columns AS fc
                                              ON f.object_id = fc.constraint_object_id
                                             AND name = @Foreignkeyname) ;

                SET @Msg = 'Procesing FK: ' + @Foreignkeyname + ' / Parent table: ' + @Parenttablename + ' / Child Table: ' + @ChildTableName;
                EXEC PrintImmediate @Msg;

                SET @Tsqldropfk = 'ALTER TABLE ' + QUOTENAME (@Parenttableschema) + '.' + QUOTENAME (@Parenttablename) + ' DROP CONSTRAINT ' + QUOTENAME (@Foreignkeyname) + CHAR (13) + 'GO';
                SET @Sqlcmd = 'ALTER TABLE ' + QUOTENAME (@Parenttableschema) + '.' + QUOTENAME (@Parenttablename) + ' DROP CONSTRAINT ' + QUOTENAME (@Foreignkeyname) ;
                EXEC dbo.PrintImmediate @Tsqldropfk;
                INSERT INTO TEMP_DROPFK (PARENTTABLENAME , 
                                         ChildTableName , 
                                         FOREIGNKEYNAME , 
                                         DROPSQL) 
                VALUES (@Parenttablename , 
                        @ChildTableName , 
                        @Foreignkeyname , 
                        @Sqlcmd) ;
                FETCH NEXT FROM CURSORFK INTO @Foreignkeyname , @Parenttableschema , @Parenttablename;
            END;
        CLOSE CURSORFK;
        DEALLOCATE CURSORFK;

        --**********************************************************************************************
        -- LOAD ALL FOREIGN KEY CONSTRAINTS IN SHORTHAND FORMAT
        --**********************************************************************************************  
        -- select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        -- select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        -- select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE
        SELECT CONSTRAINEDTABLE = FK.TABLE_NAME , 
               FK_COLUMN = CU.COLUMN_NAME , 
               PARENTTABLE = PK.TABLE_NAME , 
               PK_COLUMN = PT.COLUMN_NAME , 
               CONSTRAINTNAME = C.CONSTRAINT_NAME INTO TEMP_FK
          FROM
               INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS C
               INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS FK
               ON C.CONSTRAINT_NAME = FK.CONSTRAINT_NAME
              AND FK.CONSTRAINT_SCHEMA = 'dbo'
               INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS PK
               ON C.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
              AND PK.CONSTRAINT_SCHEMA = 'dbo'
               INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS CU
               ON C.CONSTRAINT_NAME = CU.CONSTRAINT_NAME
              AND CU.CONSTRAINT_SCHEMA = 'dbo'
               INNER JOIN (
                           SELECT I1.TABLE_NAME , 
                                  I2.COLUMN_NAME
                             FROM
                                  INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS I1
                                  INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS I2
                                  ON I1.CONSTRAINT_NAME = I2.CONSTRAINT_NAME
                             WHERE I1.CONSTRAINT_TYPE = 'PRIMARY KEY') AS PT
               ON PT.TABLE_NAME = PK.TABLE_NAME;

        --**********************************************************************
        -- GET ALL INDEXS' DETAIL ATTRIBUTES IN CASE WE NEED THEM LATER.
        --**********************************************************************
        -- Select top 100 * from sys.tables
        SELECT OBJECT_SCHEMA_NAME (T.OBJECT_ID , DB_ID ()) AS [SCHEMA] , 
               T.NAME AS TABLE_NAME , 
               I.NAME AS INDEX_NAME , 
               AC.NAME AS COLUMN_NAME , 
               I.TYPE_DESC , 
               I.IS_UNIQUE , 
               I.DATA_SPACE_ID , 
               I.IGNORE_DUP_KEY , 
               I.IS_PRIMARY_KEY , 
               I.IS_UNIQUE_CONSTRAINT , 
               I.FILL_FACTOR , 
               I.IS_PADDED , 
               I.IS_DISABLED , 
               I.IS_HYPOTHETICAL , 
               I.ALLOW_ROW_LOCKS , 
               I.ALLOW_PAGE_LOCKS , 
               IC.IS_DESCENDING_KEY , 
               IC.IS_INCLUDED_COLUMN INTO TEMP_INDEXDETAIL
          FROM
               SYS.TABLES AS T
               INNER JOIN SYS.INDEXES AS I
               ON T.OBJECT_ID = I.OBJECT_ID
               INNER JOIN SYS.INDEX_COLUMNS AS IC
               ON I.OBJECT_ID = IC.OBJECT_ID
               INNER JOIN SYS.ALL_COLUMNS AS AC
               ON T.OBJECT_ID = AC.OBJECT_ID
              AND IC.COLUMN_ID = AC.COLUMN_ID
          WHERE T.IS_MS_SHIPPED = 0
            AND I.TYPE_DESC <> 'HEAP'
            AND SCHEMA_NAME (T.SCHEMA_ID) = 'dbo'
          ORDER BY T.NAME , I.INDEX_ID , IC.KEY_ORDINAL;

        --**********************************************************************
        -- GET THE LIST OF TABLES THAT MIGHT HAVE ISSUES
        --**********************************************************************
        -- select * from TEMP_LISTOFSUSPECTTABLES
        -- select * from INFORMATION_SCHEMA.tables
        -- select * from INFORMATION_SCHEMA.COLUMNS

        SELECT C.TABLE_NAME , 
               C.COLUMN_NAME , 
               C.IS_NULLABLE , 
               C.TABLE_SCHEMA INTO TEMP_LISTOFSUSPECTTABLES
          FROM
               INFORMATION_SCHEMA.COLUMNS AS C
               JOIN INFORMATION_SCHEMA.tables AS T
               ON T.table_name = C.table_name
              AND T.table_type = 'BASE TABLE'
              AND T.TABLE_NAME NOT LIKE 'Analytics%'
              AND T.TABLE_NAME NOT LIKE 'PM_%'
              AND T.TABLE_NAME NOT LIKE '%EDW_CT%'
              AND T.TABLE_NAME NOT LIKE 'STAGE%'
              AND T.TABLE_NAME NOT LIKE 'MEDIA_FILE'
              AND T.TABLE_NAME NOT LIKE 'STAGing%'
              AND T.TABLE_NAME NOT LIKE 'temp_%'
              AND T.TABLE_NAME NOT LIKE 'sharepoint_%'
              AND T.TABLE_NAME NOT LIKE 'sm_insight%'
              AND T.TABLE_NAME NOT LIKE 'ct_%'
              AND T.TABLE_NAME NOT LIKE 'Trace%'
              AND T.TABLE_NAME NOT LIKE 'RewardPointsRewarded'
              AND T.TABLE_NAME NOT LIKE 'EDW_HealthAssessment'
              AND T.TABLE_NAME NOT LIKE 'HFit_HealthAssessmentPaperException'
              AND T.TABLE_NAME NOT LIKE '%FileSize%'
              AND T.TABLE_NAME NOT LIKE '%HitValue%'
              AND C.TABLE_SCHEMA = 'dbo'
          WHERE C.DATA_TYPE = 'bigint'
            AND C.COLUMN_NAME != 'SYS_CHANGE_VERSION'
            AND C.COLUMN_NAME NOT LIKE '%_SCV'
            AND C.COLUMN_NAME NOT LIKE '%_SCV'
            AND C.COLUMN_NAME NOT LIKE 'HFit_HealthAssessmentPaperException'
            AND T.table_schema = 'DBO';

        --**********************************************************************
        -- GET ALL ASSOCIATED TABLE CONSTRAINTS
        --**********************************************************************   
        -- select * from sys.tables
        SELECT DISTINCT TableName = t.Name , 
                        ColumnName = c.Name , 
                        dc.Name , 
                        dc.definition , 
                        IST.table_schema INTO TEMP_TblConstraints
          FROM
               sys.tables AS t
               INNER JOIN TEMP_LISTOFSUSPECTTABLES AS SuspectTbl
               ON T.name = SuspectTbl.TABLE_NAME
               INNER JOIN information_schema.tables AS IST
               ON T.name = IST.TABLE_NAME
              AND IST.table_schema = 'dbo'
               INNER JOIN sys.default_constraints AS dc
               ON t.object_id = dc.parent_object_id
               INNER JOIN sys.columns AS c
               ON dc.parent_object_id = c.object_id
              AND c.column_id = dc.parent_column_id
          WHERE SCHEMA_NAME (T.schema_id) = 'dbo'
          --WHERE
          --t.name = 'HFit_HealthAssesmentStarted'

          ORDER BY t.Name;
        ALTER TABLE TEMP_TblConstraints
        ADD DropDDl nvarchar (max) NULL;
        ALTER TABLE TEMP_TblConstraints
        ADD CreateDDl nvarchar (max) NULL;
        UPDATE TEMP_TblConstraints
          SET TEMP_TblConstraints.CreateDDl = 'ALTER TABLE [dbo].[' + TEMP_TblConstraints.TableName + '] ADD  CONSTRAINT [' + TEMP_TblConstraints.name + ']  DEFAULT (' + TEMP_TblConstraints.definition + ') FOR [' + TEMP_TblConstraints.ColumnName + ']';
        UPDATE TEMP_TblConstraints
          SET TEMP_TblConstraints.DropDDl = 'ALTER TABLE [dbo].[' + TEMP_TblConstraints.TableName + '] DROP CONSTRAINT [' + TEMP_TblConstraints.Name + '] ';

        --select * from TEMP_TblConstraints
        --**********************************************************************
        -- GET THE PRIMARY KEY INDEXS / CONSTRAINTS
        --**********************************************************************
        -- drop table TEMP_PRIMARYKEYDETAIL
        -- select top 100 * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        -- select top 100 * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE

        SELECT DISTINCT KU.CONSTRAINT_NAME , 
                        KU.TABLE_NAME , 
                        KU.COLUMN_NAME , 
                        KU.ORDINAL_POSITION , 
                        KU.CONSTRAINT_SCHEMA INTO TEMP_PRIMARYKEYDETAIL
          FROM
               INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
               INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
               ON TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
              AND TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
              AND KU.CONSTRAINT_SCHEMA = 'dbo'
               INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
               ON KU.TABLE_NAME = S.TABLE_NAME
          WHERE TC.CONSTRAINT_SCHEMA = 'dbo'
          ORDER BY KU.TABLE_NAME , KU.ORDINAL_POSITION ASC;

        -- select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where TABLE_NAME = 'BASE_HFit_RewardException' 
        -- select * from INFORMATION_SCHEMA.KEY_COLUMN_USAGE where TABLE_NAME = 'BASE_HFit_RewardException' 
        -- select * from TEMP_LISTOFSUSPECTTABLES
        --SELECT * FROM TEMP_PRIMARYKEYDETAIL ORDER BY TABLE_NAME, ORDINAL_POSITION ASC;
        --**********************************************************************
        -- GENERATE THE NON-PRIMARY KEY INDEX DDL
        --**********************************************************************

        SELECT SYS.OBJECTS.NAME AS TABLE_NAME , 
               SYS.INDEXES.NAME AS INDEXNAME , 
               'CREATE ' + CASE
                               WHEN SYS.INDEXES.IS_UNIQUE = 1
                                AND SYS.INDEXES.IS_PRIMARY_KEY = 0
                                   THEN 'UNIQUE '
                           ELSE ''
                           END + CASE
                                     WHEN SYS.INDEXES.TYPE_DESC = 'CLUSTERED'
                                         THEN 'CLUSTERED '
                                 ELSE 'NONCLUSTERED '
                                 END + 'INDEX [' + SYS.INDEXES.NAME + '] ON dbo.[' + SYS.OBJECTS.NAME + '] ( ' + INDEX_COLUMNS.INDEX_COLUMNS_KEY + ' ) ' + ISNULL ('INCLUDE (' + INDEX_COLUMNS.INDEX_COLUMNS_INCLUDE + ')' , '') AS INDEXDDL , 
               SCHEMA_NAME (SYS.OBJECTS.SCHEMA_ID) AS SchemaName INTO TEMP_IndexDDL
          FROM
               SYS.OBJECTS
               JOIN SYS.SCHEMAS
               ON SYS.OBJECTS.SCHEMA_ID = SYS.SCHEMAS.SCHEMA_ID
              AND SCHEMA_NAME (SYS.OBJECTS.SCHEMA_ID) = 'dbo'
               JOIN SYS.INDEXES
               ON SYS.INDEXES.OBJECT_ID = SYS.OBJECTS.OBJECT_ID
               INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
               ON SYS.OBJECTS.NAME = S.TABLE_NAME
               CROSS APPLY (
                            SELECT LEFT (INDEX_COLUMNS.INDEX_COLUMNS_KEY , LEN (INDEX_COLUMNS.INDEX_COLUMNS_KEY) - 1) AS INDEX_COLUMNS_KEY , 
                                   LEFT (INDEX_COLUMNS.INDEX_COLUMNS_INCLUDE , LEN (INDEX_COLUMNS.INDEX_COLUMNS_INCLUDE) - 1) AS INDEX_COLUMNS_INCLUDE
                              FROM (
                            SELECT (
                            SELECT SYS.COLUMNS.NAME + ','
                              FROM
                                   SYS.INDEX_COLUMNS
                                   JOIN SYS.COLUMNS
                                   ON SYS.INDEX_COLUMNS.COLUMN_ID = SYS.COLUMNS.COLUMN_ID
                                  AND SYS.INDEX_COLUMNS.OBJECT_ID = SYS.COLUMNS.OBJECT_ID
                              WHERE SYS.INDEX_COLUMNS.IS_INCLUDED_COLUMN = 0
                                AND SYS.INDEXES.OBJECT_ID = SYS.INDEX_COLUMNS.OBJECT_ID
                                AND SYS.INDEXES.INDEX_ID = SYS.INDEX_COLUMNS.INDEX_ID
                              ORDER BY KEY_ORDINAL
                              FOR XML PATH ('')) AS INDEX_COLUMNS_KEY , 
                                   (
                            SELECT SYS.COLUMNS.NAME + ','
                              FROM
                                   SYS.INDEX_COLUMNS
                                   JOIN SYS.COLUMNS
                                   ON SYS.INDEX_COLUMNS.COLUMN_ID = SYS.COLUMNS.COLUMN_ID
                                  AND SYS.INDEX_COLUMNS.OBJECT_ID = SYS.COLUMNS.OBJECT_ID
                              WHERE SYS.INDEX_COLUMNS.IS_INCLUDED_COLUMN = 1
                                AND SYS.INDEXES.OBJECT_ID = SYS.INDEX_COLUMNS.OBJECT_ID
                                AND SYS.INDEXES.INDEX_ID = SYS.INDEX_COLUMNS.INDEX_ID
                              ORDER BY INDEX_COLUMN_ID
                              FOR XML PATH ('')) AS INDEX_COLUMNS_INCLUDE) AS INDEX_COLUMNS) AS INDEX_COLUMNS
          WHERE SYS.OBJECTS.TYPE = 'u'
            AND SYS.OBJECTS.IS_MS_SHIPPED = 0
            AND SYS.INDEXES.TYPE_DESC <> 'HEAP'
            AND SYS.INDEXES.IS_PRIMARY_KEY = 0
          ORDER BY SYS.OBJECTS.NAME , SYS.INDEXES.NAME;
        -- SELECT * FROM TEMP_IndexDDL;
        --**********************************************************************
        -- BUILD A TEMP TABLE TO HOLD THE PRIMARY KEY DDL FOR SUSPECT TABLES.
        -- LEAVE THE DDL STATEMENT BLANK SO IT CAN BE POPULATED LATER.
        --**********************************************************************

        SELECT DISTINCT P.TABLE_NAME , 
                        P.CONSTRAINT_NAME , 
                        REPLICATE (' ' , 4000) AS IDXSQL INTO TEMP_TblPriKeyDDL
          FROM
               TEMP_PRIMARYKEYDETAIL AS P
               INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
               ON P.TABLE_NAME = S.TABLE_NAME;

        -- select * from TEMP_TblPriKeyDDL
        -- select * from TEMP_PRIMARYKEYDETAIL
        -- drop table TEMP_INDEXSQLSTATEMENT

        SELECT DISTINCT I.TABLE_NAME AS TABLENAME , 
                        I.INDEX_NAME AS INDEXNAME , 
                        REPLICATE (' ' , 4000) AS IDXSQL INTO TEMP_INDEXSQLSTATEMENT
          FROM
               TEMP_INDEXDETAIL AS I
               INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
               ON I.TABLE_NAME = S.TABLE_NAME;

        --select * from TEMP_INDEXSQLSTATEMENT;
        --**********************************************************************
        -- BUILD A TEMP TABLE TO HOLD THE PRIMARY KEY DDL FOR SUSPECT TABLES.
        -- AND NOW, POPULATE THE DDL.
        --**********************************************************************
        -- select * from TEMP_PRIMARYKEYDETAIL

        DECLARE
              @Constraint_Name nvarchar (128) , 
              @Table_Name nvarchar (128) , 
              @Column_Name nvarchar (128) , 
              @Ordinal_Position int;

        --select * from TEMP_PRIMARYKEYDETAIL

        DECLARE C1 CURSOR
            FOR SELECT DISTINCT TEMP_PRIMARYKEYDETAIL.CONSTRAINT_NAME , 
                                TEMP_PRIMARYKEYDETAIL.TABLE_NAME , 
                                TEMP_PRIMARYKEYDETAIL.COLUMN_NAME , 
                                TEMP_PRIMARYKEYDETAIL.ORDINAL_POSITION
                  FROM TEMP_PRIMARYKEYDETAIL
                  ORDER BY TEMP_PRIMARYKEYDETAIL.TABLE_NAME , TEMP_PRIMARYKEYDETAIL.CONSTRAINT_NAME , TEMP_PRIMARYKEYDETAIL.ORDINAL_POSITION;
        OPEN C1;

        -- truncate TABLE TEMP_TblPriKeyDDL;
        -- DBCC FREEPROCCACHE

        FETCH NEXT FROM C1 INTO @Constraint_Name , @Table_Name , @Column_Name , @Ordinal_Position;
        WHILE @@Fetch_Status <> -1
            BEGIN
                SET @Currtable = @Table_Name;
                IF @I = 0
                OR @Prevconstraint <> @Constraint_Name
                    BEGIN
                        SET @I = @I + 1;
                        IF LEN (@Idxsql) > 0
                            BEGIN
                                SET @Ddl = @Idxsql + @Indexcols + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]';
                                UPDATE TEMP_TblPriKeyDDL
                                  SET TEMP_TblPriKeyDDL.IDXSQL = @Ddl
                                  WHERE TEMP_TblPriKeyDDL.CONSTRAINT_NAME = @Prevconstraint;

                            --INSERT INTO TEMP_TblPriKeyDDL (
                            --       TABLE_NAME
                            --     , CONSTRAINT_NAME
                            --     , IDXSQL) 
                            --VALUES (
                            --       @Table_Name , @Prevconstraint , @Ddl) ;

                            END;
                        SET @Prevconstraint = @Currconstraint;
                        SET @Idxsql = 'ALTER TABLE [dbo].' + @Currtable + ' ADD CONSTRAINT [' + @Constraint_Name + '] primary key clustered ';
                        SET @Icolcnt = 1;
                        SET @Indexcols = '(';
                    END;
                IF @Icolcnt = 1
                    BEGIN
                        SET @Indexcols = @Indexcols + @Column_Name;
                    END;
                ELSE
                    BEGIN
                        SET @Indexcols = @Indexcols + ', ' + @Column_Name;
                    END;
                SET @Prevconstraint = @Constraint_Name;
                FETCH NEXT FROM C1 INTO @Constraint_Name , @Table_Name , @Column_Name , @Ordinal_Position;
                SET @Prevtable = @Table_Name;
                SET @Icolcnt = @Icolcnt + 1;
            END;
        IF LEN (@Idxsql) > 0
            BEGIN
                SET @Ddl = @Idxsql + @Indexcols + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]';
                UPDATE TEMP_TblPriKeyDDL
                  SET TEMP_TblPriKeyDDL.IDXSQL = @Ddl
                  WHERE TEMP_TblPriKeyDDL.CONSTRAINT_NAME = @Prevconstraint;

            --INSERT INTO TEMP_TblPriKeyDDL (
            --       TABLE_NAME
            --     , CONSTRAINT_NAME
            --     , IDXSQL) 
            --VALUES (
            --       @Table_Name , @Prevconstraint , @Ddl) ;

            END;
        CLOSE C1;
        DEALLOCATE C1;

        --SELECT * FROM TEMP_TblPriKeyDDL;
        --**********************************************************************
        -- CHANGE TRACKING MUST BE DISABLED FOR ALL TABLES    
        --**********************************************************************
        --drop table TEMP_CT_Tables ;

        SELECT T.NAME INTO TEMP_CT_Tables
          FROM
               SYS.CHANGE_TRACKING_TABLES AS TR
               INNER JOIN SYS.TABLES AS T
               ON T.OBJECT_ID = TR.OBJECT_ID
               INNER JOIN SYS.SCHEMAS AS S
               ON S.SCHEMA_ID = T.SCHEMA_ID;
        DECLARE CCT CURSOR
            FOR SELECT DISTINCT I.NAME
                  FROM
                       TEMP_CT_Tables AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.NAME = S.TABLE_NAME;
        OPEN CCT;
        FETCH NEXT FROM CCT INTO @Tablename;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @Mysql = 'ALTER TABLE dbo.[' + @Tablename + '] DISABLE CHANGE_TRACKING; ';
                SET @MySql = 'EXEC (''' + @MySql + ''');';
                SET @Msg = 'Disable CT: ' + @Mysql;
                EXEC dbo.PrintImmediate @Msg;
                IF @PreviewOnly = 'NO'
                    BEGIN EXEC (@Mysql) ;
                    END;
                FETCH NEXT FROM CCT INTO @Tablename;
            END;
        CLOSE CCT;
        DEALLOCATE CCT;

        --**********************************************************************
        -- INDEXES MUST BE DROPPED SO THAT AN ALTER TABLE CAN BE ACCOMPLISHED.
        -- ONCE THIS IS DONE, CALL THE PROCEDURE TO CHANGE BIGINT TO INT.
        --**********************************************************************
        -- select * from TEMP_INDEXSQLSTATEMENT        
        -- select * from information_Schema.columns where table_name = 'BASE_HFit_HealthAssesmentUserStarted' 
        -- drop table TEMP_INDEXSQLSTATEMENT

        DECLARE
              @Ifkcnt AS int = 0;
        DECLARE CDROPIDX CURSOR
            FOR SELECT DISTINCT I.TABLENAME , 
                                I.INDEXNAME
                  FROM
                       TEMP_INDEXSQLSTATEMENT AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.TABLENAME = S.TABLE_NAME
                EXCEPT
                SELECT TEMP_TblPriKeyDDL.TABLE_NAME , 
                       TEMP_TblPriKeyDDL.CONSTRAINT_NAME
                  FROM TEMP_TblPriKeyDDL
                  ORDER BY I.TABLENAME , I.INDEXNAME;

        --SELECT * FROM TEMP_INDEXSQLSTATEMENT;

        OPEN CDROPIDX;

        FETCH NEXT FROM CDROPIDX INTO @Tablename , @Indexname;

        WHILE @@Fetch_Status = 0
            BEGIN
                SET @Idx = (SELECT CONSTRAINT_NAME
                              FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                              WHERE CONSTRAINT_TYPE = 'PRIMARY KEY'
                                AND TABLE_NAME = @Tablename
                                AND CONSTRAINT_NAME = @Indexname) ;

                --***************************************************************************

                EXEC @Ifkcnt = dbo.PROC_GETTABLEFOREIGNKEYS @Tablename;
                --*** REMOVE THE foreign keys 
                --NOW, remove all foreign keys and put them back at the end of the run
                IF @Ifkcnt > 0
                    BEGIN EXEC dbo.proc_TableFKeysDrop @Tablename;
                    END;

                --***************************************************************************

                IF @Idx IS NOT NULL
                    BEGIN
                        SET @S = 'ALTER TABLE dbo.[' + @Tablename + '] DROP CONSTRAINT ' + @Indexname;
                        SET @Msg = 'ALTER IDX: ' + @S;
                        EXEC dbo.PrintImmediate @Msg;
                    END;
                ELSE
                    BEGIN
                        IF EXISTS (SELECT name
                                     FROM sys.indexes
                                     WHERE name = @Indexname) 
                            BEGIN
                                SET @S = 'Drop index [' + RTRIM (LTRIM (@Indexname)) + '] ON dbo.' + @Tablename;
                            END;
                    END;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        SET @cmd = '''' + @S + '''';
                        SET @msg = 'CMD: ' + @cmd;
                        BEGIN TRY EXEC PrintImmediate @msg;
                            EXEC (@S) ;
                            EXEC PrintImmediate 'SUCCESSFUL';
                        END TRY
                        BEGIN CATCH
                            SET @Msg = 'WARNING (Review): ' + @cmd;
                            INSERT INTO BIGINT_Conversion_Errors (err_txt) 
                            VALUES (@msg) ;
                        END CATCH;

                    END;
                FETCH NEXT FROM CDROPIDX

                --INTO @TableName, @IndexName, @IdxSQL;

                INTO @Tablename , @Indexname;
            END;
        CLOSE CDROPIDX;
        DEALLOCATE CDROPIDX;

        --**********************************************************************
        -- DROP TABLE CONSTRAINTS SUCH AS DEFAULT OF GETDATE(), ETC.
        --**********************************************************************
        -- select * from TEMP_TblConstraints        

        DECLARE
              @CON_TableName AS nvarchar (250) , 
              @CON_ColumnName AS nvarchar (250) , 
              @CON_Name AS nvarchar (250) , 
              @CON_definition AS nvarchar (250) , 
              @CON_DropDDl AS nvarchar (4000) , 
              @CON_CreateDDl AS nvarchar (4000) ;
        DECLARE CUR_Constraint_DROP CURSOR
            FOR SELECT DISTINCT TEMP_TblConstraints.TableName , 
                                TEMP_TblConstraints.ColumnName , 
                                TEMP_TblConstraints.Name , 
                                TEMP_TblConstraints.definition , 
                                TEMP_TblConstraints.DropDDl , 
                                TEMP_TblConstraints.CreateDDl
                  FROM TEMP_TblConstraints;
        OPEN CUR_Constraint_DROP;
        FETCH NEXT FROM CUR_Constraint_DROP INTO @CON_TableName , @CON_ColumnName , @CON_Name , @CON_definition , @CON_DropDDl , @CON_CreateDDl;
        WHILE @@Fetch_Status = 0
            BEGIN
                IF @PreviewOnly = 'NO'
                    BEGIN
                        SET @cmd = @CON_DropDDl;
                        SET @msg = 'Drop Constraint: ' + @cmd;
                        EXEC PrintImmediate @msg;
                        EXEC (@cmd) ;
                    END;
                FETCH NEXT FROM CUR_Constraint_DROP INTO @CON_TableName , @CON_ColumnName , @CON_Name , @CON_definition , @CON_DropDDl , @CON_CreateDDl;
            END;
        CLOSE CUR_Constraint_DROP;
        DEALLOCATE CUR_Constraint_DROP;

        --**********************************************************************
        --**********************************************************************
        -- THE INDEXES HAVE BEEN DROPPED.
        -- CALL THE PROCEDURE TO CHANGE BIGINT TO INT ON EACH SUSPECT TABLE.
        --**********************************************************************

        DECLARE CBIGINT CURSOR
            FOR SELECT DISTINCT I.TABLENAME
                  FROM
                       TEMP_INDEXSQLSTATEMENT AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.TABLENAME = S.TABLE_NAME;
        OPEN CBIGINT;
        FETCH NEXT FROM CBIGINT INTO @Tablename;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @S = 'EXEC proc_ConvertBigintToInt ' + @Tablename;
                SET @Msg = 'CALL BigInt: ' + @S;
                EXEC dbo.PrintImmediate @Msg;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        SET @Msg = 'CALL proc_AllTblConstraintsDrop: ' + @Tablename;
                        EXEC dbo.PrintImmediate @Msg;
                        EXEC dbo.proc_AllTblConstraintsDrop @Tablename;
                        EXEC (@S) ;
                        SET @Msg = 'CALL proc_AllTblConstraintsReGen: ' + @Tablename;
                        EXEC dbo.PrintImmediate @Msg;
                        --*** ADD THE foreign keys BACK
                        EXEC dbo.proc_AllTblConstraintsReGen @Tablename;
                    END;
                FETCH NEXT FROM CBIGINT INTO @Tablename;
            END;
        CLOSE CBIGINT;
        DEALLOCATE CBIGINT;

        --**********************************************************************
        -- Recreate the indexes, both primary key and non-key indexes.
        -- LOOP THRU THE Standard INDEXES AND CREATE ON EACH TABLE.
        --**********************************************************************
        -- select * from TEMP_IndexDDL

        DECLARE CINDEXDDL CURSOR
            FOR SELECT DISTINCT I.TABLE_NAME , 
                                I.INDEXNAME , 
                                I.INDEXDDL
                  FROM
                       TEMP_IndexDDL AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.TABLE_NAME = S.TABLE_NAME;
        OPEN CINDEXDDL;
        FETCH NEXT FROM CINDEXDDL INTO @Tablename , @Indexname , @Idxsql;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @S = @Idxsql;
                SET @Msg = 'CREATE IDX: ' + @S;
                EXEC dbo.PrintImmediate @Msg;

                DECLARE
                      @sText AS nvarchar (max) = '' , 
                      @IdxDLL AS nvarchar (max) = '' , 
                      @iLoc AS int = 0 , 
                      @iLen AS int = 0;

                SET @IdxDLL = @S;
                SET @iLen = LEN (@IdxDLL) ;
                SET @iLoc = CHARINDEX ('index ' , @IdxDLL) ;
                SET @sText = SUBSTRING (@IdxDLL , @iLoc , @iLen) ;
                SET @iLoc = CHARINDEX (' ' , @sText) ;
                SET @sText = SUBSTRING (@sText , @iLoc , @iLen) ;
                SET @sText = REPLACE (@sText , '[' , ' ') ;
                SET @sText = REPLACE (@sText , ']' , ' ') ;
                SET @sText = LTRIM (@sText) ;
                SET @iLoc = CHARINDEX (' ' , @sText) ;
                SET @sText = SUBSTRING (@sText , 1 , @iLoc) ;
                SET @sText = RTRIM (LTRIM (@sText)) ;
                PRINT 'TGT Index: "' + @sText + '"';

                IF @PreviewOnly = 'NO'
                    BEGIN
                        IF NOT EXISTS (SELECT NAME
                                         FROM SYS.INDEXES
                                         WHERE NAME = @sText) 
                            BEGIN
                                SET @MSG = '@Creating Index: ' + @Indexname + ' / ' + @Idxsql;
                                EXEC dbo.PrintImmediate @Msg;
                                BEGIN TRY EXEC (@S) ;
                                    EXEC dbo.PrintImmediate '    ->SUCCESS.';
                                END TRY
                                BEGIN CATCH
                                    SET @MSG = '@WARNING (Review): ' + @S;
                                    EXEC dbo.PrintImmediate @Msg;
                                    INSERT INTO BIGINT_Conversion_Errors (err_txt) 
                                    VALUES (@msg) ;
                                END CATCH;
                            END;
                        ELSE
                            BEGIN
                                SET @Msg = 'INDEX ' + @Indexname + ' already exists, skipping.';
                                EXEC dbo.PrintImmediate @Msg;
                            END;
                    END;
                FETCH NEXT FROM CINDEXDDL INTO @Tablename , @Indexname , @Idxsql;
            END;
        CLOSE CINDEXDDL;
        DEALLOCATE CINDEXDDL;

        --**********************************************************************
        -- LOOP THRU THE PRIMARY KEY INDEXES AND REBUILD ON EACH TABLE.
        --**********************************************************************
        SET @msg = 'STARTING to reimplement change tracking.';
        EXEC PrintImmediate @msg;
        DECLARE CPKEYDDL CURSOR
            FOR SELECT DISTINCT I.TABLE_NAME , 
                                I.CONSTRAINT_NAME AS INDEXNAME , 
                                I.IDXSQL AS INDEXDDL
                  FROM
                       TEMP_TblPriKeyDDL AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.TABLE_NAME = S.TABLE_NAME;
        OPEN CPKEYDDL;
        FETCH NEXT FROM CPKEYDDL INTO @Tablename , @Indexname , @Idxsql;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @S = @Idxsql;
                SET @S = REPLACE (@S , 'SORT_IN_TEMPDB = OFF,' , '') ;
                SET @S = REPLACE (@S , 'ONLINE = OFF,' , '') ;
                SET @Msg = 'ADD PK: ' + @S;
                EXEC dbo.PrintImmediate @Msg;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        DECLARE
                              @PKExists AS int = 0;
                        IF EXISTS (SELECT TABLE_NAME
                                     FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                                     WHERE CONSTRAINT_TYPE = 'PRIMARY KEY'
                                       AND TABLE_NAME = @Tablename) 
                            BEGIN
                                SET @PKExists = 1;
                                SET @msg = 'PK Already exists on ' + @Tablename + ', skipping - ' + @Indexname + ' : ' + @Idxsql;
                                EXEC PrintImmediate @msg;
                            END;
                        IF @PKExists = 0
                            BEGIN
                                SET @msg = 'PK DOES NOT exist on ' + @Tablename + '.';
                                EXEC PrintImmediate @msg;
                                SET @msg = 'RE-ADDing PK to ' + @Tablename;
                                EXEC PrintImmediate @msg;
                                BEGIN TRY EXEC (@S) ;
                                    SET @msg = 'Success RE-ADDing PK to ' + @Tablename;
                                    EXEC PrintImmediate @msg;
                                END TRY
                                BEGIN CATCH
                                    SET @msg = 'WARNING (Review) RE-ADDing PK to ' + @Tablename;
                                    EXEC PrintImmediate @msg;
                                    INSERT INTO BIGINT_Conversion_Errors (err_txt) 
                                    VALUES (@msg) ;
                                    SET @msg = 'DDL: ' + @S;
                                    EXEC PrintImmediate @msg;
                                    INSERT INTO BIGINT_Conversion_Errors (err_txt) 
                                    VALUES (@msg) ;
                                END CATCH;
                            END;
                    END;
                FETCH NEXT FROM CPKEYDDL INTO @Tablename , @Indexname , @Idxsql;
            END;
        CLOSE CPKEYDDL;
        DEALLOCATE CPKEYDDL;

        --**********************************************************************
        -- LOOP THRU THE PRIMARY KEY INDEXES AND REBUILD ON EACH TABLE.
        --**********************************************************************
        IF OBJECT_ID ('TEMP_CT_Tables') IS NULL
        OR (SELECT COUNT (*)
              FROM TEMP_CT_Tables) = 0
            BEGIN EXEC PrintImmediate 'There appears to be no tables with Change Tracking enabled, proceeding.';
                GOTO NO_CT_RECS;
            END;

        DECLARE CCHGTRACK CURSOR
            FOR SELECT DISTINCT I.NAME
                  FROM
                       TEMP_CT_Tables AS I
                       INNER JOIN TEMP_LISTOFSUSPECTTABLES AS S
                       ON I.NAME = S.TABLE_NAME;
        OPEN CCHGTRACK;

        FETCH NEXT FROM CCHGTRACK INTO @Tablename;
        WHILE @@Fetch_Status = 0
            BEGIN
                SET @Mysql = 'ALTER TABLE ' + @Tablename + ' ENABLE CHANGE_TRACKING; ';
                SET @MySql = @MySql;
                SET @Msg = 'ENABLE CT : ' + @Mysql;
                EXEC dbo.PrintImmediate @Msg;
                IF @PreviewOnly = 'NO'
                    BEGIN
                        BEGIN TRY EXEC (@Mysql) ;
                            SET @msg = '@01 SUCCESS: ' + @Mysql;
                            EXEC PrintImmediate @msg;
                        END TRY
                        BEGIN CATCH
                            SET @msg = '@01 WARNING (Review): ' + @Mysql;
                            EXEC PrintImmediate @msg;
                            INSERT INTO BIGINT_Conversion_Errors (err_txt) 
                            VALUES (@msg) ;
                        END CATCH;
                    END;
                FETCH NEXT FROM CCHGTRACK INTO @Tablename;
            END;
        CLOSE CCHGTRACK;
        DEALLOCATE CCHGTRACK;

        --***************************************************************
        NO_CT_RECS:
        EXEC PrintImmediate 'Calling PROC_AddMissingTableFKEYS.';
        EXEC dbo.PROC_ADDMISSINGTABLEFKEYS @Tablename;
        EXEC PrintImmediate 'executed PROC_ADDMISSINGTABLEFKEYS.';

        --***************************************************************
        --**********************************************************************
        -- DROP TABLE CONSTRAINTS SUCH AS DEFAULT OF GETDATE(), ETC.
        --**********************************************************************
        -- select * from TEMP_INDEXSQLSTATEMENT        
        --declare  @CON_TableName as nvarchar(250)
        --                 , @CON_ColumnName as nvarchar(250)
        -- , @CON_Name as nvarchar(250)
        -- , @CON_definition as nvarchar(250), @CON_DropDDl  as nvarchar(4000), @CON_CreateDDl as nvarchar(4000);

        DECLARE
              @IConstraintCnt AS int = 0;
        SET @IConstraintCnt = (SELECT COUNT (*)
                                 FROM TEMP_TblConstraints) ;
        SET @msg = 'Processing ' + CAST (@IConstraintCnt AS nvarchar (50)) + ' TEMP_TblConstraints records.';
        EXEC PrintImmediate @msg;

        DECLARE CUR_Constraint_CREATE CURSOR
            FOR SELECT DISTINCT TEMP_TblConstraints.TableName , 
                                TEMP_TblConstraints.ColumnName , 
                                TEMP_TblConstraints.Name , 
                                TEMP_TblConstraints.definition , 
                                TEMP_TblConstraints.DropDDl , 
                                TEMP_TblConstraints.CreateDDl
                  FROM TEMP_TblConstraints;
        OPEN CUR_Constraint_CREATE;
        FETCH NEXT FROM CUR_Constraint_CREATE INTO @CON_TableName , @CON_ColumnName , @CON_Name , @CON_definition , @CON_DropDDl , @CON_CreateDDl;
        WHILE @@Fetch_Status = 0
            BEGIN
                IF @PreviewOnly = 'NO'
                    BEGIN
                        SET @cmd = @CON_CreateDDl;
                        SET @msg = 'Create Constraint: ' + @cmd;
                        EXEC PrintImmediate @msg;
                        EXEC (@cmd) ;
                    END;
                FETCH NEXT FROM CUR_Constraint_CREATE INTO @CON_TableName , @CON_ColumnName , @CON_Name , @CON_definition , @CON_DropDDl , @CON_CreateDDl;
            END;
        CLOSE CUR_Constraint_CREATE;
        DEALLOCATE CUR_Constraint_CREATE;

        --**********************************************************************
        --**********************************************************************

        SET NOCOUNT OFF;
        COMMIT TRANSACTION TX01;

        BEGIN TRY
            ALTER TABLE HFit_RewardsUserSummaryArchive ALTER COLUMN RewardPointsRewarded int NULL;
            ALTER TABLE HFit_RewardsUserSummaryArchive ALTER COLUMN UserID int NOT NULL;
            ALTER TABLE Hfit_HAHealthCheckLog ALTER COLUMN UserID int NULL;
        END TRY
        BEGIN CATCH
            PRINT 'REVIEW: alter table HFit_RewardsUserSummaryArchive alter column RewardPointsRewarded int NULL';
            PRINT 'REVIEW: alter table HFit_RewardsUserSummaryArchive alter column UserID int not NULL ';
            PRINT 'REVIEW: alter table Hfit_HAHealthCheckLog alter column UserID int NULL';
        END CATCH;
        EXEC dbo.PrintImmediate 'PROCESSING COMPLETE.';
    END TRY
    BEGIN CATCH
        EXEC dbo.PrintImmediate 'ERRORS DETECTED, ROLLING BACK - PLEASE STANDBY.';

        INSERT INTO BIGINT_Conversion_Errors (err_txt) 
        VALUES ('ERRORS DETECTED, ROLLING BACK - PLEASE STANDBY.') ;
        SET @msg = (SELECT ERROR_MESSAGE ()) ;
        INSERT INTO BIGINT_Conversion_Errors (err_txt) 
        VALUES (@msg) ;
        EXECUTE dbo.USP_GETERRORINFO;
        IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION TX01;
            END;
    END CATCH;

    DECLARE
          @iErr AS int = (SELECT COUNT (*)
                            FROM BIGINT_Conversion_Errors) ;
    IF @iErr > 0
        BEGIN
            SELECT *
              FROM BIGINT_Conversion_Errors;
        END;
    ELSE
        BEGIN EXEC proc_BigIntViewRebuild;
        END;


    SET @Msg = '************** ADDING ALL THE DEFAULT Values BACK! ************** ';
    EXEC dbo.PrintImmediate @Msg;
    EXEC proc_AllTblConstraintsReGen;

    SET @Msg = '************** ADDING ALL THE foreign keys BACK! ************** ';
    EXEC dbo.PrintImmediate @Msg;
    EXEC ScriptAllForeignKeyConstraints_ReGenerateMissing;

END;

--SELECT * FROM TEMP_IndexDDL;
--SELECT * FROM TEMP_TblPriKeyDDL;

GO
PRINT 'Executed PROC_MasterBigIntToInt.sql';
GO
