
--drop table [TBL_DIFF1] ;
--drop table [TBL_DIFF2] ;
--drop table [TBL_DIFF3] ;
--drop table [TBL_DIFF4] ;

GO
PRINT 'Creating proc_Compare_Views';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_Compare_Views') 
    BEGIN
        DROP PROCEDURE proc_Compare_Views;
    END;
GO

/*
exec proc_Compare_Views @LinkedSVR = 'hfitazuprdsql05.cloudapp.net'
                                   , @LinkedDB = 'KenticoCMS_1'
                                   , @LinkedVIEW = 'view_EDW_HealthAssesment'
                                   , @CurrDB = 'DataMartPlatform'
                                   , @CurrVIEW = 'BASE_view_EDW_HealthAssesment'
                                   , @NewRun = 1 ;
select * from view_SchemaDiff ;
*/

CREATE PROCEDURE proc_Compare_Views (@LinkedSVR AS nvarchar (254) 
                                   , @LinkedDB AS nvarchar (254) 
                                   , @LinkedVIEW AS nvarchar (254) 
                                   , @CurrDB AS nvarchar (254) 
                                   , @CurrVIEW AS nvarchar (254) 
                                   , @NewRun AS int) 
AS
BEGIN
		  
/*
@Copyright D. Miller & Associates, Ltd., Highland Park, IL, 1.1.1960 allrights reserved.
License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.
Author:	  W. Dale Miller
Date:	  1-1-2010
*/

    DECLARE
           @ParmDefinition AS nvarchar (max) ;
    DECLARE
           @retval int = 0;
    DECLARE
           @S AS nvarchar (250) = '';
    DECLARE
           @SVR AS varchar (254) = @LinkedSVR;
    DECLARE
           @iCnt AS int;
    DECLARE
           @iRetval AS int = 0;
    DECLARE
           @Note AS nvarchar (max) = '';
    SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
    SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
    EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
    SET @iCnt = (SELECT @iRetval) ;
    IF @iCnt = 1
        BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins';
        END;
    EXEC sp_addlinkedserver @LinkedSVR, 'SQL Server';
    SET @S = 'select @retval = count(*) from [' + @LinkedSVR + '].[' + @LinkedDB + '].sys.views where NAME = @TgtVIEW ';
    SET @ParmDefinition = N'@TgtVIEW nvarchar(254), @retval int OUTPUT';
    EXEC sp_executesql @S, @ParmDefinition, @TgtVIEW = @LinkedVIEW, @retval = @iRetval OUTPUT;
    SET @iCnt = (SELECT @iRetval) ;

    --print ('Step01');

    IF @iCnt = 0
        BEGIN
            PRINT @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
            DECLARE
                   @SSQL AS nvarchar (max) = '';
            DECLARE
                   @msg AS nvarchar (max) = '';
            SET @msg = @LinkedVIEW + ' : VIEW does not exist on server ' + @LinkedSVR + ' in database ' + @LinkedDB + '.';
            SET @SSQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
            SET @SSQL = @SSQL + 'VALUES ( ';
            SET @SSQL = @SSQL + '''' + @CurrVIEW + ''', null, null , null, null ,null,null, null, ''' + @msg + ''' ';
            SET @SSQL = @SSQL + ')';
            EXEC (@SSQL) ;
            RETURN;
        END;
    IF NOT EXISTS (SELECT name

                   --FROM tempdb.dbo.sysobjects

                     FROM sysobjects
                     WHERE ID = OBJECT_ID (N'TBL_DIFF1')) 
        BEGIN
            CREATE TABLE dbo.TBL_DIFF1 (table_name sysname NOT NULL
                                      , COLUMN_NAME sysname NULL
                                      , DATA_TYPE nvarchar (254) NULL
                                      , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
                                      , table_name2 sysname NULL
                                      , DATA_TYPE2 nvarchar (254) NULL
                                      , COLUMN_NAME2 sysname NULL
                                      , CHARACTER_MAXIMUM_LENGTH2 int NULL
                                      , NOTE varchar (max) 
                                      , CreateDate datetime2 (7) NULL
                                                                 DEFAULT GETDATE () 
                                      , RowNbr int IDENTITY) ;
        END;
    IF NOT EXISTS (SELECT name

                   --FROM tempdb.dbo.sysobjects

                     FROM sysobjects
                     WHERE ID = OBJECT_ID (N'TBL_DIFF2')) 
        BEGIN
            CREATE TABLE dbo.TBL_DIFF2 (table_name sysname NOT NULL
                                      , COLUMN_NAME sysname NULL
                                      , DATA_TYPE nvarchar (254) NULL
                                      , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
                                      , table_name2 sysname NULL
                                      , DATA_TYPE2 nvarchar (254) NULL
                                      , COLUMN_NAME2 sysname NULL
                                      , CHARACTER_MAXIMUM_LENGTH2 int NULL
                                      , NOTE varchar (max) 
                                      , RowNbr int IDENTITY) ;
        END;
    IF NOT EXISTS (SELECT name

                   --FROM tempdb.dbo.sysobjects

                     FROM sysobjects
                     WHERE ID = OBJECT_ID (N'TBL_DIFF3')) 
        BEGIN
            CREATE TABLE dbo.TBL_DIFF3 (table_name sysname NOT NULL
                                      , COLUMN_NAME sysname NULL
                                      , DATA_TYPE nvarchar (254) NULL
                                      , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
                                      , table_name2 sysname NULL
                                      , DATA_TYPE2 nvarchar (254) NULL
                                      , COLUMN_NAME2 sysname NULL
                                      , CHARACTER_MAXIMUM_LENGTH2 int NULL
                                      , NOTE varchar (max) 
                                      , CreateDate datetime2 (7) NULL
                                                                 DEFAULT GETDATE () 
                                      , RowNbr int IDENTITY) ;
        END;
    IF NOT EXISTS (SELECT name

                   --FROM tempdb.dbo.sysobjects

                     FROM sysobjects
                     WHERE ID = OBJECT_ID (N'TBL_DIFF4')) 
        BEGIN
            CREATE TABLE dbo.TBL_DIFF4 (table_name sysname NOT NULL
                                      , COLUMN_NAME sysname NULL
                                      , DATA_TYPE nvarchar (254) NULL
                                      , CHARACTER_MAXIMUM_LENGTH nvarchar (254) NULL
                                      , table_name2 sysname NULL
                                      , DATA_TYPE2 nvarchar (254) NULL
                                      , COLUMN_NAME2 sysname NULL
                                      , CHARACTER_MAXIMUM_LENGTH2 int NULL
                                      , NOTE varchar (max) 
                                      , CreateDate datetime2 (7) NULL
                                                                 DEFAULT GETDATE () 
                                      , RowNbr int IDENTITY) ;
        END;
    IF @NewRun = 1
        BEGIN
            truncate TABLE TBL_DIFF1;
            truncate TABLE TBL_DIFF2;
            truncate TABLE TBL_DIFF3;
        END;
    DECLARE
           @MySQL AS nvarchar (max) ;
    SET @MySQL = 'INSERT INTO TBL_DIFF1 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
    SET @MySQL = @MySql + 'select c1.table_name, c1.COLUMN_NAME, c1.DATA_TYPE , cast (c1.CHARACTER_MAXIMUM_LENGTH as nvarchar(254)) as CHARACTER_MAXIMUM_LENGTH, c2.table_name as table_name2 ,c2.DATA_TYPE as DATA_TYPE2 ,c2.COLUMN_NAME as COLUMN_NAME2, c2.CHARACTER_MAXIMUM_LENGTH as CHARACTER_MAXIMUM_LENGTH2, ''Data Types or Data Length Differ'' ';
    SET @MySQL = @MySQL + 'from [' + @LinkedSVR + '].[' + @LinkedDB + '].[INFORMATION_SCHEMA].[COLUMNS] c1 ';
    SET @MySQL = @MySQL + 'left join ' + @CurrDB + '.[INFORMATION_SCHEMA].[COLUMNS] c2 on c1.TABLE_NAME = c2.TABLE_NAME ';
    SET @MySQL = @MySQL + 'where c1.TABLE_NAME= ''' + @LinkedVIEW + ''' and c2.TABLE_NAME = ''' + @CurrVIEW + ''' ';
    SET @MySQL = @MySQL + 'and C1.column_name = c2.column_name ';
    SET @MySQL = @MySQL + 'and ((c1.data_type <> c2.DATA_TYPE) ';
    SET @MySQL = @MySQL + '		OR (c1.data_type = c2.DATA_TYPE AND c1.CHARACTER_MAXIMUM_LENGTH <> c2.CHARACTER_MAXIMUM_LENGTH))';
    EXEC (@MySql) ;

    --print ('Step05');

    SET @MySQL = '';
    SET @MySQL = 'INSERT INTO TBL_DIFF2 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
    SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @CurrDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2 , ''NA'' as C3, 0 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @CurrDB + '/' + @CurrVIEW + ' ''  ';
    SET @MySQL = @MySQL + ' FROM  [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.COLUMNS AS c1 ';
    SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
    SET @MySQL = @MySQL + ' 	AND c1.column_name not in ';
    SET @MySQL = @MySQL + ' 	(select column_name from ' + @CurrDB + '.INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
    PRINT @MySql;
    EXEC (@MySql) ;

    --print ('Step06');

    SET @MySQL = 'INSERT INTO TBL_DIFF3 (table_name, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, table_name2, DATA_TYPE2, COLUMN_NAME2, CHARACTER_MAXIMUM_LENGTH2, Note) ';
    SET @MySQL = @MySQL + 'SELECT c1.TABLE_NAME, c1.COLUMN_NAME, c1.DATA_TYPE, ''' + @LinkedDB + ''' as DBNAME, ''MISSING'' as C1, ''NA'' as C2, ''NA'' as C3, -1 as I1, ''Column ''+c1.COLUMN_NAME+'' Missing in: ' + @LinkedDB + '/' + @LinkedVIEW + ' ''  ';
    SET @MySQL = @MySQL + ' FROM [' + @CurrDB + '].INFORMATION_SCHEMA.COLUMNS as C1 ';
    SET @MySQL = @MySQL + ' WHERE  C1.table_name = ''' + @CurrVIEW + ''' ';
    SET @MySQL = @MySQL + ' AND c1.column_name not in ';
    SET @MySQL = @MySQL + ' (select column_name from [' + @LinkedSVR + '].[' + @LinkedDB + '].INFORMATION_SCHEMA.columns C2 where C2.table_name = ''' + @LinkedVIEW + ''') ';
    EXEC (@MySql) ;

    --print ('Step07');

    SET @S = 'SELECT @retval = count(*) FROM sys.servers WHERE name = @TgtSVR ';
    SET @ParmDefinition = N'@TgtSVR nvarchar(254), @retval bit OUTPUT';
    EXEC sp_executesql @S, @ParmDefinition, @TgtSVR = @LinkedSVR, @retval = @iRetval OUTPUT;
    SET @iCnt = (SELECT @iRetval) ;
    IF @iCnt = 1
        BEGIN EXEC master.sys.sp_dropserver @LinkedSVR, 'droplogins';
        END;

    --print ('Step08');

    IF NOT EXISTS (SELECT name
                     FROM sys.views
                     WHERE name = 'view_SchemaDiff') 
        BEGIN
            DECLARE
                   @sTxt AS nvarchar (max) = '';
            SET @sTxt = @sTxt + 'Create view view_SchemaDiff AS ';
            SET @sTxt = @sTxt + 'Select * from TBL_DIFF1 ';
            SET @sTxt = @sTxt + 'union ';
            SET @sTxt = @sTxt + 'Select * from TBL_DIFF2  ';
            SET @sTxt = @sTxt + 'union ';
            SET @sTxt = @sTxt + 'Select * from TBL_DIFF3  ';
            EXEC (@sTxt) ;
            PRINT 'Created view view_SchemaDiff.';
        END;

    --Select * from TBL_DIFF1 
    --union
    --Select * from TBL_DIFF2 
    --union
    --Select * from TBL_DIFF3 

    PRINT 'To see "deltas" - select * from view_SchemaDiff';
    PRINT '_________________________________________________';

--print ('Step09');

END;
GO
PRINT 'Created proc_Compare_Views';
GO
