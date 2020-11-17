

-- drop table FACT_CMS_Class

GO
PRINT 'Executing proc_CreateFactTable.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_CreateFactTable') 
    BEGIN
        DROP PROCEDURE
             proc_CreateFactTable;
    END;

GO
--KenticoCMS_1.dbo.COM_SKU
-- EXEC proc_CreateFactTable 'KenticoCMS_1', 'CMS_Class', 0
-- select top 100 * from FACT_CMS_USER
CREATE PROCEDURE proc_CreateFactTable (
       @InstanceName AS NVARCHAR (200) 
     , @TblName AS NVARCHAR (200) 
     , @SkipIfExists AS BIT = 1) 
AS
BEGIN

    -- Each table tracked for changes requires:
    --	   5 stored procedures to track and apply changes
    --	   3 FACT Tables
    --	   1 Delte Trigger 

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    PRINT 'Inside proc_CreateFactTable: ' + @InstanceName + ' / ' + @TblName;

    DECLARE
    @S AS NVARCHAR (2000) = '';
    DECLARE
    @FactTable AS NVARCHAR (100) = 'FACT_' + @TblName;
    DECLARE
    @DelTable AS NVARCHAR (100) = 'FACT_' + @TblName + '_DEL';

    IF
    @SkipIfExists = 1
        BEGIN
            IF EXISTS (SELECT
                              TABLE_NAME
                              FROM INFORMATION_SCHEMA.TABLES
                              WHERE
                              TABLE_NAME = @FactTable) 
                BEGIN
                    PRINT 'Skipping Table Exists: ' + @FactTable;
                    GOTO VERIFYCOLS;
                END;
        END;

    IF EXISTS (SELECT
                      TABLE_NAME
                      FROM INFORMATION_SCHEMA.TABLES
                      WHERE
                      TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'REPLACING table: ' + @FactTable;
            SET  @S = ' drop table ' + @FactTable;
            PRINT @s;
            EXEC (@S) ;
        END;

    PRINT 'Creating table: ' + @FactTable;
    SET  @S = ' SELECT top 10 * INTO ' + @FactTable + ' FROM ' + @InstanceName + '.DBO.' + @TblName;
    EXEC (@S) ;

    IF EXISTS (    SELECT
                          name
                          FROM sys.key_constraints
                          WHERE
                          type = 'PK'
                      AND OBJECT_NAME (parent_object_id) = @FactTable) 
        BEGIN
            DECLARE
            @CNAME AS NVARCHAR (250) = (SELECT
                                               name
                                               FROM sys.key_constraints
                                               WHERE
                                               type = 'PK'
                                           AND OBJECT_NAME (parent_object_id) = @FactTable);
            PRINT 'EXISTING PRIMARY KEY FOUND: ' + @CNAME;
            -- Delete the primary key constraint.
            DECLARE
            @MySql AS NVARCHAR (MAX) = '';
            SET @MySql = 'ALTER TABLE dbo.' + @FactTable + ' DROP CONSTRAINT ' + @CNAME;
            EXEC (@MySql) ;
        END;
    ELSE
        BEGIN
            PRINT 'NO EXISTING PRIMARY KEY FOUND';
        END;

    SET  @S = ' Truncate table ' + @FactTable;
    EXEC (@S) ;
    EXEC proc_RemoveIdentityCols @FactTable , 1;

    VERIFYCOLS:

    IF EXISTS (SELECT
                      TABLE_NAME
                      FROM INFORMATION_SCHEMA.TABLES
                      WHERE
                      TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'REPLACING table: ' + @DelTable;
            SET  @S = ' drop table ' + @DelTable;
            PRINT @s;
            EXEC (@S) ;
        END;

    PRINT 'Creating table: ' + @DelTable;
    SET  @S = ' SELECT top 1 * INTO ' + @DelTable + ' FROM ' + @InstanceName + '.DBO.' + @TblName;
    EXEC (@S) ;

    SET  @S = ' Truncate table ' + @DelTable;
    EXEC (@S) ;

    BEGIN TRY
        SET  @S = ' Alter table ' + @DelTable + ' add Action char(1) null ';
        EXEC (@S) ;
        PRINT 'Added Action to ' + @DelTable;
    END TRY
    BEGIN CATCH
        PRINT 'Action exists in ' + @DelTable;
    END CATCH;

    BEGIN TRY
        SET  @S = ' Alter table ' + @FactTable + ' add Action char(1) null ';
        EXEC (@S) ;
        PRINT 'Added Action to ' + @FactTable;
    END TRY
    BEGIN CATCH
        PRINT 'Action exists in ' + @FactTable;
    END CATCH;

    BEGIN TRY
        SET  @S = ' Alter table ' + @DelTable + ' add ActionDate datetime default getdate() ';
        EXEC (@S) ;
        PRINT 'Added ActionDate to ' + @DelTable;
    END TRY
    BEGIN CATCH
        PRINT 'ActionDate exists in ' + @DelTable;
    END CATCH;

    EXEC proc_RemoveIdentityCols @DelTable;

    --**************************************************************************************************
    DECLARE
    @SQL AS NVARCHAR (100) = '';
    DECLARE
    @ChgTable AS NVARCHAR (100) = @FactTable + '_CTVerHIST';
    IF EXISTS (SELECT
                      TABLE_NAME
                      FROM INFORMATION_SCHEMA.TABLES
                      WHERE
                      TABLE_NAME = @ChgTable) 
        BEGIN
            SET @SQL = 'drop table ' + @ChgTable;
            EXEC (@SQL) ;
        END;
    IF NOT EXISTS (SELECT
                          TABLE_NAME
                          FROM INFORMATION_SCHEMA.TABLES
                          WHERE
                          TABLE_NAME = @ChgTable) 
        BEGIN
            PRINT 'CREATING table: ' + @ChgTable;
            SET  @S = ' CREATE TABLE [dbo].[' + @ChgTable + ']( ' + CHAR (10) ;
            SET  @S = @S + '[SYS_CHANGE_VERSION] [bigint] NOT NULL, ' + CHAR (10) ;
            SET  @S = @S + '[DBMS] nvarchar(250) NOT NULL, ' + CHAR (10) ;
            SET  @S = @S + 'CONSTRAINT [PK_' + @ChgTable + '] PRIMARY KEY CLUSTERED  ' + CHAR (10) ;
            SET  @S = @S + '( ' + CHAR (10) ;
            SET  @S = @S + '	[DBMS] ASC ' + CHAR (10) ;
            SET  @S = @S + '	,[SYS_CHANGE_VERSION] ASC ' + CHAR (10) ;
            SET  @S = @S + ')WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] ' + CHAR (10) ;
            SET  @S = @S + ') ON [PRIMARY] ' + CHAR (10) ;
            PRINT 'CREATED table: ' + @ChgTable;
            EXEC (@S) ;
        END;

    --IF NOT EXISTS (SELECT
    --                      COLUMN_NAME
    --                      FROM INFORMATION_SCHEMA.COLUMNS
    --                      WHERE COLUMN_NAME = 'RowSeq'
    --                        AND TABLE_NAME = @FactTable) 
    --    BEGIN
    --        PRINT 'Adding Column RowSeq';
    --        SET @S = 'ALTER TABLE ' + @FactTable + ' ADD RowSeq int identity (1,1) not NULL ';
    --        PRINT @s;
    --        EXEC (@S) ;
    --    END;
    --IF NOT EXISTS (SELECT
    --                      COLUMN_NAME
    --                      FROM INFORMATION_SCHEMA.COLUMNS
    --                      WHERE COLUMN_NAME = 'RowSeq'
    --                        AND TABLE_NAME = @DelTable) 
    --    BEGIN
    --        PRINT 'Adding Column RowSeq';
    --        SET @S = 'ALTER TABLE ' + @DelTable + ' ADD RowSeq int NULL ';
    --        PRINT @s;
    --        EXEC (@S) ;
    --    END;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'SYS_CHANGE_VERSION'
                      AND TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'Adding Column SYS_CHANGE_VERSION';
            SET @S = 'ALTER TABLE ' + @FactTable + ' ADD SYS_CHANGE_VERSION bigint not NULL default 0  ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'SYS_CHANGE_VERSION'
                      AND TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'Adding Column SYS_CHANGE_VERSION';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD SYS_CHANGE_VERSION bigint NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'LastModifiedDate'
                      AND TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'Adding Column LastModifiedDate';
            SET @S = 'ALTER TABLE ' + @FactTable + ' ADD LASTMODIFIEDDATE datetime NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'LastModifiedDate'
                      AND TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'Adding Column LastModifiedDate';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD LASTMODIFIEDDATE datetime NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'HashCode'
                      AND TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'Adding Column HashCode';
            SET @S = 'ALTER TABLE ' + @FactTable + ' ADD HashCode nvarchar(75) NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'HashCode'
                      AND TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'Adding Column HashCode';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD HashCode nvarchar(75) NULL ';
            PRINT @s;
            EXEC (@S) ;
        END;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'SVR'
                      AND TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'Adding Column SVR';
            SET @S = 'ALTER TABLE ' + @FactTable + ' ADD SVR nvarchar (100) NOT NULL default @@SERVERNAME ';
            PRINT @s;
            EXEC (@S) ;
        END;
    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'SVR'
                      AND TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'Adding Column SVR';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD SVR nvarchar (100) NOT NULL default @@SERVERNAME ';
            PRINT @s;
            EXEC (@S) ;
        END;
    else 
	   print @DelTable + ' contains column DBNAME.' ;


print '*** LOC00: ' ;
    SET @S = 'UPDATE ' + @FactTable + ' SET SVR = @@SERVERNAME where SVR is null ';
    PRINT @s;
    EXEC (@S) ;
    SET @S = 'UPDATE ' + @DelTable + ' SET SVR = @@SERVERNAME where SVR is null ';
    PRINT @s;
    EXEC (@S) ;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'DBNAME'
                      AND TABLE_NAME = @FactTable) 
        BEGIN
            PRINT 'DOES not contain Column DBNAME';
            SET @S = 'ALTER TABLE ' + @FactTable + ' ADD DBNAME nvarchar (100) not NULL default ''-'' ';
            PRINT @s;
            EXEC (@S) ;
        END;
    else 
	   print @FactTable + ' contain column DBNAME.' ;

    IF NOT EXISTS (SELECT
                          COLUMN_NAME
                          FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE
                          COLUMN_NAME = 'DBNAME'
                      AND TABLE_NAME = @DelTable) 
        BEGIN
            PRINT 'Adding Column DBNAME';
            SET @S = 'ALTER TABLE ' + @DelTable + ' ADD DBNAME nvarchar (100) not NULL default ''-'' ';
            PRINT @s;
            EXEC (@S) ;
        END;

    SET @S = 'UPDATE ' + @FactTable + ' SET DBNAME = ''' + @InstanceName + '''' + ' where DBNAME = ''-'' ';
    PRINT '001: ' +  @s;
    EXEC (@S) ;
    SET @S = 'UPDATE ' + @DelTable + ' SET DBNAME = ''' + @InstanceName + '''' + ' where DBNAME = ''-'' ';
    PRINT '002: ' + @s;
    EXEC (@S) ;

    DECLARE
    @TblKeys AS NVARCHAR (2000) = '';
    DECLARE
    @PK AS NVARCHAR (2000) = NULL;
    EXEC @TblKeys = procGetTablePK @InstanceName , @TblName , @PK OUT;
    SET @TblKeys = @PK;
    PRINT @TblKeys;

    DECLARE
    @NewPkCols AS NVARCHAR (2000) = 'SVR, DBNAME, SYS_CHANGE_VERSION, ' + @TblKeys;

    SET @mysql = '';
    DECLARE
    @IdxName AS NVARCHAR (2000) = 'UKI_' + @FactTable + ' ';

    --IF NOT EXISTS (SELECT
    --                      name
    --                      FROM sys.indexes
    --                      WHERE name = @IdxName) 
    --    BEGIN
    --        PRINT '00 Creating: ' + @IdxName;
    --        SET @mysql += 'CREATE UNIQUE CLUSTERED INDEX [UKI_' + @FactTable + '] ON [dbo].[' + @FactTable + '] ' + CHAR (10) ;
    --        SET @mysql += '( ' + CHAR (10) ;
    --        SET @mysql += @NewPkCols + CHAR (10) ;
    --        SET @mysql += ' )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] ' + CHAR (10) ;
    --        EXEC (@mysql) ;
    --PRINT '01 Created: ' + @IdxName;
    --    END;

    SET @IdxName = 'CI_' + @FactTable + ' ';

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.indexes
                          WHERE name = @IdxName) 
        BEGIN
            DECLARE
            @CICols AS NVARCHAR (2000) = 'SVR, DBNAME, SYS_CHANGE_VERSION ';
        END;
    BEGIN
        PRINT 'Creating: ' + @IdxName;
        SET @mysql = 'CREATE NONCLUSTERED INDEX [' + @IdxName + '] ON [dbo].[' + @FactTable + '] ' + CHAR (10) ;
        SET @mysql += '( ' + CHAR (10) ;
        SET @mysql += @CICols + CHAR (10) ;
        SET @mysql += ' )' + CHAR (10) ;
        SET @mysql += ' INCLUDE (HashCode) ' + CHAR (10) ;
        EXEC (@mysql) ;
        PRINT 'Created: ' + @IdxName;
    END;

    --ALTER TABLE ConstraintTable ADD CONSTRAINT Ct_ID PRIMARY KEY (ID)
    PRINT 'ADDING PK to: ' + @FactTable + '  - KEY: ' + @NewPkCols;
    DECLARE
    @ConstName AS NVARCHAR (200) = 'PKEY_' + @FactTable;
    IF NOT EXISTS (SELECT
                          *
                          FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
                          WHERE
                          CONSTRAINT_NAME = @ConstName) 
        BEGIN
            PRINT 'PK Constraint: ' + @IdxName;
            BEGIN TRY
                SET @MySql = 'ALTER TABLE ' + @FactTable + ' ADD CONSTRAINT ' + @ConstName + ' PRIMARY KEY CLUSTERED (' + @NewPkCols + ') ';
                EXEC (@MySql) ;
                PRINT 'Added Primary Key: ' + @ConstName + ' ON ' + @NewPkCols;
            END TRY
            BEGIN CATCH
                PRINT '!!! WARNING ON : Primary Key: ' + @ConstName + ' ON ' + @NewPkCols;
            --EXECUTE usp_GetErrorInfo;
            END CATCH;

        END;

    --PRINT 'Adding CT to ' + @FactTable;
    --DECLARE @DBMSNAME AS nvarchar (100) = DB_NAME () ;
    --EXEC proc_ChangeTracking  @DBMSNAME , @FactTable, 1;
    --PRINT 'Added CT: ' + @FactTable;

    BEGIN TRY
        SET  @S = ' Alter table ' + @DelTable + ' add Action char(1) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column Action already in ' + @DelTable;
    END CATCH;

    BEGIN TRY
        SET  @S = ' Alter table ' + @FactTable + ' add Action char(1) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column Action already in ' + @FactTable;
    END CATCH;
    BEGIN TRY
        SET  @S = ' Alter table ' + @FactTable + ' add DBNAME nvarchar(100) null ';
        EXEC (@S) ;
    END TRY
    BEGIN CATCH
        PRINT 'Column DBNAME already in ' + @FactTable;
    END CATCH;

    DECLARE
    @TrigName AS NVARCHAR (500) = 'TRIG_DEL_' + @FactTable;

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.triggers
                          WHERE name = @TrigName) 
        BEGIN
            PRINT 'CREATING TRIGGER: ' + @TrigName;
            DECLARE
            @OUT AS NVARCHAR (MAX) = '';
            DECLARE
            @DDL AS NVARCHAR (MAX) = '';
            EXEC proc_genFactDelTrigger @FactTable , @DDL OUTPUT;
            SET @OUT = (SELECT
                               @DDL);
            EXEC (@OUT) ;
            PRINT 'CREATED DELETE TRIGGER: ' + @TrigName;
            EXEC proc_genFactUpdtTrigger @FactTable , @DDL OUTPUT;
            SET @OUT = (SELECT
                               @DDL);
            EXEC (@OUT) ;
            PRINT 'CREATED UPDATE TRIGGER: ' + @TrigName;
        END;

    DECLARE
    @HISTPROC AS NVARCHAR (100) = 'proc_FACT_' + @TBLNAME + '_' + @InstanceName + '_CTHist';

    IF NOT EXISTS (SELECT
                          name
                          FROM sys.procedures
                          WHERE name = @HISTPROC) 
        BEGIN
            PRINT '00 - CREATING PROC: ' + @HISTPROC;
            SET @OUT = '';
            SET @DDL = '';
            EXEC proc_GenCT_HistProcedure @InstanceName , @TBLNAME , @ChgTable , @DDL OUTPUT;
            SET @OUT = (SELECT
                               @DDL);
            EXEC (@OUT) ;
            PRINT 'CREATED HISTORY TRACKING PROC: ' + @HISTPROC;
        END;

    PRINT 'Adding CT to ' + @FactTable;
    DECLARE
    @DBMSNAME AS NVARCHAR (100) = DB_NAME () ;
    EXEC proc_ChangeTracking  @DBMSNAME , @FactTable , 1;
    PRINT 'Added CT: ' + @FactTable;

    SET  @DDL = '';
    EXEC proc_genPullChangesProc @InstanceName , @TblName;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    PRINT '************************ COMPLETED ' + @InstanceName + ' / ' + @TblName + ' ********************************************';
END;
GO
PRINT 'Executed proc_CreateFactTable.sql';
GO
