
declare @MySql as nvarchar(max) ;
declare @DBNAME as nvarchar(250) = 'KenticoCMS_2' ;
declare @T as nvarchar(250) = '' ;
declare C cursor for
    select table_name from information_schema.tables 
    where table_name like '%join%' 
    and table_type = 'VIEW' and table_schema = 'dbo'

    OPEN C;

    FETCH NEXT FROM C INTO @T ;

 WHILE
           @@FETCH_STATUS = 0
       begin
set @MySql = 'exec proc_GenBaseTableFromView '''+@DBNAME+''', '''+@T+''', ''NO'', @GenJobToExecute = 1, @SkipIfExists = 0 '
print @MySql + char(10);

            FETCH NEXT FROM C INTO @T ;
        END

close C;
deallocate C; 


--***************************************************************************************************

-- USE KenticoCMS_Datamart_2
go
print 'Executing CREATE PROCEDURE proc_Validate_TrackerName_Length.sql'
go
if exists (select name from sys.procedures where name = 'proc_Validate_TrackerName_Length')
    drop procedure proc_Validate_TrackerName_Length;
go
CREATE PROCEDURE proc_Validate_TrackerName_Length
AS
BEGIN

    DECLARE @MySql AS NVARCHAR (MAX) ;
    DECLARE @DBNAME AS NVARCHAR (250) = 'KenticoCMS_2';
    DECLARE @CMD AS NVARCHAR (250) = '';
    DECLARE C CURSOR
        FOR
            SELECT
                   'alter table ' + table_name + '  alter column TrackerName nvarchar(100) NULL'
            FROM INFORMATION_SCHEMA.columns
            WHERE
                   COLUMN_NAME = 'TrackerName' AND
                   CHARACTER_MAXIMUM_LENGTH < 100
            ORDER BY
                     TABLE_NAME, 1;

    OPEN C;

    FETCH NEXT FROM C INTO @CMD;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            exec (@CMD) ;
            FETCH NEXT FROM C INTO @CMD;
        END;

    CLOSE C;
    DEALLOCATE C;

END; 

go
print 'Executed CREATE PROCEDURE proc_Validate_TrackerName_Length.sql'
go
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
