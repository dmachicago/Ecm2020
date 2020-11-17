
IF EXISTS ( SELECT
                   name
                   FROM sys.procedures
                   WHERE name = 'proc_GenK7K8TestDdl') 
    BEGIN
        DROP PROCEDURE
             proc_GenK7K8TestDdl;
    END;
GO

/*********************************************************************************************
How to execute:
exec proc_GenK7K8TestDdl 'KenticoCMS_Prod1', 'KenticoCMS_Prod3', 'view_EDW_SmallStepResponses'
exec proc_GenK7K8TestDdl 'KenticoCMS_Prod1', 'KenticoCMS_Prod3', 'view_EDW_CoachingDefinition'

select 'EXEC proc_GenK7K8TestDdl ''KenticoCMS_Prod1'', ''KenticoCMS_Prod2'', ''' +  TABLE_NAME + '''' + char(10) + 'GO' + char(10)
from information_schema.tables 
where 
table_name like '%EDW%'
AND table_name not like '%_CT_%'
AND table_name not like '%_CT'
AND table_name not like '%_EDW_EDW_'
and TABLE_TYPE = 'VIEW'

*********************************************************************************************/

CREATE PROCEDURE proc_GenK7K8TestDdl (
       @DBSource AS nvarchar (100) 
     , @DBTarget AS nvarchar (100)
     , @ViewName AS nvarchar (100)
) 
AS
BEGIN

/*
    Author : W. Dale Miller
    Created: 04.01.2015
    Purpose: Generate DDL to create two test tables from a specific view using only the columns that are common to both views.
			 If a column IS NOT found to exist in both views, it will be ignored. This allows for updated views with new
			 columns to be evaluated as well.
*/

    SET NOCOUNT ON;

    --@DBSource AS nvarchar (100) = 'KenticoCMS_Prod1'
    --,@DBTarget AS nvarchar (100) = 'KenticoCMS_Prod3'
    --     ,@ViewName AS nvarchar (100) = 'view_EDW_SmallStepResponses'

    DECLARE
           @TgtCol AS nvarchar ( 100) 
         , @FoundFlg AS bit = 0
         , @MySql AS nvarchar ( max) 
         , @TABLE_CATALOG AS nvarchar ( 100) 
         , @TABLE_NAME AS nvarchar ( 100) 
         , @COLUMN_NAME AS nvarchar ( 100) 
         , @DATA_TYPE AS nvarchar ( 100) 
         , @TT_Name1  AS nvarchar ( 100) 
         , @TT_Name2  AS nvarchar ( 100) 
         , @crlf AS nvarchar ( 10) = CHAR ( 10) ;

    --,@crlf as nvarchar(10) = char(10) + char(13);

    if not exists (select name from sys.tables where name = 'HFit_EDW_K7K8_TestDDL')
begin
    --drop table [HFit_EDW_K7K8_TestDDL]
    CREATE TABLE [dbo].[HFit_EDW_K7K8_TestDDL](
	   [VIEW_NAME] [nvarchar](100) NOT NULL,
	   [VIEW_DDL] [nvarchar](max) not NULL,
	   [RowNbr] int identity (1,1),
	   [PASSED] BIT NULL,
    CONSTRAINT [PK_HFit_EDW_K7K8_TestDDL] PRIMARY KEY CLUSTERED 
    (
	   [VIEW_NAME] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
    
end;


    PRINT '-------- VIEW BEING PROCESSED -------- ';
    PRINT '-------- ' + @ViewName;
    PRINT '----------------------------------------';

    --select top 10 * from KenticoCMS_PRD_prod3K7.information_schema.columns ;

    IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE id = OBJECT_ID ( N'tempdb..#Temp_DB1')) 
        BEGIN
            PRINT 'Dropping #Temp_DB1';
            DROP TABLE
                 #Temp_DB1;
        END;
    IF EXISTS ( SELECT
                       name
                       FROM tempdb.dbo.sysobjects
                       WHERE id = OBJECT_ID ( N'tempdb..#Temp_DB2')) 
        BEGIN
            PRINT 'Dropping #Temp_DB2';
            DROP TABLE
                 #Temp_DB2;
        END;
    SELECT
           TABLE_CATALOG
         , TABLE_NAME
         , COLUMN_NAME
         , DATA_TYPE
    INTO
         #Temp_DB1
           FROM KenticoCMS_PRD_prod3K8.information_schema.columns
           WHERE TABLE_NAME = @ViewName
           ORDER BY
                    column_name;
    SELECT
           TABLE_CATALOG
         , TABLE_NAME
         , COLUMN_NAME
         , DATA_TYPE
    INTO
         #Temp_DB2
           FROM KenticoCMS_PRD_prod3K7.information_schema.columns
           WHERE TABLE_NAME = @ViewName
           ORDER BY
                    column_name;

    if exists (select VIEW_NAME from HFit_EDW_K7K8_TestDDL where VIEW_NAME = @ViewName)
begin 
    delete from HFit_EDW_K7K8_TestDDL where VIEW_NAME = @ViewName ;
end ;

    DECLARE CSR CURSOR
        FOR
            SELECT
                   TABLE_CATALOG
                 , TABLE_NAME
                 , COLUMN_NAME
                 , DATA_TYPE
                   FROM #Temp_DB1;
    OPEN CSR;
    FETCH NEXT FROM CSR
    INTO @TABLE_CATALOG , @TABLE_NAME , @COLUMN_NAME , @DATA_TYPE;
    SET @TT_Name1 = 'TEST_K7K8_' + @ViewName;
    SET @MySql = 'Select DISTINCT top 150 ' + @crlf;
    DECLARE
           @iCnt AS int = 0;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS ( SELECT
                               COLUMN_NAME
                               FROM #Temp_DB2
                               WHERE COLUMN_NAME = @COLUMN_NAME) 
                BEGIN
                    IF @iCnt = 0
                        BEGIN
                            SET @MySql = @MySql + '     ' + @COLUMN_NAME + @crlf;
                        END;
                    ELSE
                        BEGIN
                            SET @MySql = @MySql + '    ,' + @COLUMN_NAME + @crlf;
                        END;
                END;
            ELSE
                BEGIN
                    SET @MySql = @MySql + '--    ,' + @COLUMN_NAME + '                  --MISSING from one view' + @crlf;
                    PRINT 'COLUMN NAME: ' + @COLUMN_NAME + 'NOT FOUND IN BOTH VIEWS.';
                END;
            FETCH NEXT FROM CSR
            INTO @TABLE_CATALOG , @TABLE_NAME , @COLUMN_NAME , @DATA_TYPE;
            SET @iCnt = @iCnt + 1;
        END;
    CLOSE CSR;
    DEALLOCATE CSR;
    DECLARE
           @MS1 AS nvarchar ( max) = '';
    DECLARE
           @MS2 AS nvarchar ( max) = '';
    DECLARE
           @MySql1 AS nvarchar ( max) = '';
    DECLARE
           @MySql2 AS nvarchar ( max) = '';
    SET @MS1 = 'use ' + @DBSource + @crlf;
    SET @MS1 = @MS1 + 'GO ' + @crlf;
    SET @MS1 = @MS1 + 'if exists (select name from sys.tables where name = ''' + @TT_Name1 + ''' )' + @crlf;
    SET @MS1 = @MS1 + 'BEGIN' + @crlf;
    SET @MS1 = @MS1 + '    DROP Table ' + @TT_Name1 + @crlf;
    SET @MS1 = @MS1 + 'END' + @crlf;
    SET @MS1 = @MS1 + 'GO' + @crlf + @crlf;
    SET @MS2 = 'use ' + @DBTarget + @crlf;
    SET @MS2 = @MS2 + 'GO ' + @crlf;
    SET @MS2 = @MS2 + 'if exists (select name from sys.tables where name = ''' + @TT_Name1 + ''' )' + @crlf;
    SET @MS2 = @MS2 + 'BEGIN' + @crlf;
    SET @MS2 = @MS2 + '    DROP Table ' + @TT_Name1 + @crlf;
    SET @MS2 = @MS2 + 'END' + @crlf;
    SET @MS2 = @MS2 + 'GO' + @crlf + @crlf;
    SET @MySql1 = @MySql + 'INTO ' + @DBSource + '.dbo.' + @TT_Name1 + @crlf;
    SET @MySql1 = @MySql1 + 'FROM' + @crlf;
    SET @MySql1 = @MySql1 + @DBSource + '.dbo.' + @ViewName + ';';
    SET @MySql2 = @MySql + 'INTO ' + @DBTarget + '.dbo.' + @TT_Name1 + @crlf;
    SET @MySql2 = @MySql2 + 'FROM' + @crlf;
    SET @MySql2 = @MySql2 + @DBTarget + '.dbo.' + @ViewName + ';';

    --PRINT '--********************************************************************';
    --PRINT @MS1;
    --PRINT @MySql1;
    --PRINT '--********************************************************************';
    --PRINT '--********************************************************************';
    --PRINT @MS2;
    --PRINT @MySql2;
    --PRINT '--********************************************************************';

    declare @TSQL as nvarchar(max)  = 
	   @MS1 + char(10) + '--****************************************************' + char(10) +
	   @MySql1 + char(10) + '--****************************************************' + char(10) +
	   @MS2 + char(10) + '--****************************************************' + char(10) +
	   @MySql2 + char(10) + '--****************************************************' + char(10) + 'GO' + char(10) ;
	   
SET @TSQL = @TSQL + CHAR(10) +  'select top 100 * from ' + + @DBSource + '.dbo.' + @TT_Name1 + ';' + char(10) ;
SET @TSQL = @TSQL + CHAR(10) +  'select top 100 * from ' + + @DBTarget + '.dbo.' + @TT_Name1 + ';' + char(10) ;

SET @TSQL = @TSQL + CHAR(10) +  '--update HFit_EDW_K7K8_TestDDL set Passed = 1 where VIEW_NAME = ''' +@ViewName + '''; '

PRINT @TSQL ;
    insert into HFit_EDW_K7K8_TestDDL ([VIEW_NAME],VIEW_DDL) values 
    (
	   @ViewName
	   ,@TSQL
    );
print 'select * from HFit_EDW_K7K8_TestDDL order by [RowNbr] desc ; '
END;