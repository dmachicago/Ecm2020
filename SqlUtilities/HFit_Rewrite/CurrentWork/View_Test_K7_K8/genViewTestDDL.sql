


if exists (select name from sys.procedures where name = 'proc_GenK7K8TestDdl')
    drop procedure proc_GenK7K8TestDdl;
go

create procedure proc_GenK7K8TestDdl ( 
@DBSource AS nvarchar (100) = 'KenticoCMS_Prod1'
,@DBTarget AS nvarchar (100) = 'KenticoCMS_Prod3'
     ,@ViewName AS nvarchar (100) = 'view_EDW_SmallStepResponses'
)
as 
begin
SET NOCOUNT ON;

DECLARE
    --@DBSource AS nvarchar (100) = 'KenticoCMS_Prod1'
    --,@DBTarget AS nvarchar (100) = 'KenticoCMS_Prod3'
    --     ,@ViewName AS nvarchar (100) = 'view_EDW_SmallStepResponses'
     @TgtCol AS nvarchar (100) 
     ,@FoundFlg AS bit = 0
     ,@MySql AS nvarchar (max) 
     ,@TABLE_CATALOG AS nvarchar (100) 
     ,@TABLE_NAME AS nvarchar (100) 
     ,@COLUMN_NAME AS nvarchar (100) 
     ,@DATA_TYPE AS nvarchar (100) 
     ,@TT_Name1  AS nvarchar (100) 
     ,@TT_Name2  AS nvarchar (100) 
     ,@crlf as nvarchar(10) = char(10);
     --,@crlf as nvarchar(10) = char(10) + char(13);

PRINT '-------- VIEW BEING PROCESSED:';
PRINT '-------- ' + @ViewName;
--select top 10 * from KenticoCMS_Prod1.information_schema.columns ;

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
       FROM KenticoCMS_Prod3.information_schema.columns
       WHERE TABLE_NAME = @ViewName;

SELECT
       TABLE_CATALOG
     , TABLE_NAME
     , COLUMN_NAME
     , DATA_TYPE
INTO
     #Temp_DB2
       FROM KenticoCMS_Prod1.information_schema.columns
       WHERE TABLE_NAME = @ViewName;

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
INTO @TABLE_CATALOG, @TABLE_NAME, @COLUMN_NAME, @DATA_TYPE;
set @TT_Name1 = 'TEST_K7K8_'+@ViewName ;
set @MySql = 'Select ' + @crlf;
declare @iCnt as int = 0 ; 
WHILE @@FETCH_STATUS = 0
    BEGIN

        IF EXISTS (SELECT
                          COLUMN_NAME
                          FROM #Temp_DB2
                          WHERE COLUMN_NAME = @COLUMN_NAME) 
            BEGIN
                PRINT 'FOUND COLUMN NAME: ' + @COLUMN_NAME + 'IN BOTH VIEWS.';
			 if @iCnt = 0 
			 set @MySql = @MySql + @COLUMN_NAME + @crlf ;
			 else 
			 set @MySql = @MySql + ',' + @COLUMN_NAME + @crlf ;
            END;
        ELSE
            BEGIN
                PRINT 'COLUMN NAME: ' + @COLUMN_NAME + 'NOT FOUND IN BOTH VIEWS.';
            END;
        FETCH NEXT FROM CSR
        INTO @TABLE_CATALOG, @TABLE_NAME, @COLUMN_NAME, @DATA_TYPE;
	   set @iCnt = @iCnt +1 ;
    END;
CLOSE CSR;
DEALLOCATE CSR;
declare @MS1 as nvarchar(max) = '' ;
declare @MS2 as nvarchar(max) = '' ;
declare @MySql1 as nvarchar(max) = '' ;
declare @MySql2 as nvarchar(max) = '' ;

set @MS1 = 'use ' + @DBSource + @crlf ;
set @MS1 = @MS1 + 'GO '  + @crlf ;
set @MS1 = @MS1 + 'if exists (select name from sys.tables where name = ''' + @TT_Name1 + ''' )' + @crlf ;
set @MS1 = @MS1 + 'BEGIN' + @crlf ;
set @MS1 = @MS1 + '    DROP Table ' + @TT_Name1 + @crlf ;
set @MS1 = @MS1 + 'END' + @crlf  ;
set @MS1 = @MS1 + 'GO' + @crlf + @crlf + @crlf ;

set @MS2 = 'use ' + @DBTarget + @crlf ;
set @MS2 = @MS2 + 'GO '  + @crlf ;
set @MS2 = @MS2 + 'if exists (select name from sys.tables where name = ''' + @TT_Name1 + ''' )' + @crlf ;
set @MS2 = @MS2 + 'BEGIN' + @crlf ;
set @MS2 = @MS2 + '    DROP Table ' + @TT_Name1 + @crlf ;
set @MS2 = @MS2 + 'END' + @crlf  ;
set @MS2 = @MS2 + 'GO' + @crlf + @crlf + @crlf ;


set @MySql1 = @MySql + 'INTO ' + @DBSource +'.dbo.' + @TT_Name1 + @crlf;
set @MySql1 = @MySql1 + 'FROM' + @crlf;
set @MySql1 =  @MySql1 + @ViewName + ';' ;

set @MySql2 = @MySql + 'INTO ' + @DBTarget +'.dbo.' + @TT_Name1 + @crlf;
set @MySql2 = @MySql2 + 'FROM' + @crlf;
set @MySql2 =  @MySql2 + @ViewName + ';' ;

print ('--********************************************************************');
print @MS1 ;
print @MySql1 ;
print ('--********************************************************************');
print ('--********************************************************************');
print @MS2 ;
print @MySql2 ;
print ('--********************************************************************');

END;