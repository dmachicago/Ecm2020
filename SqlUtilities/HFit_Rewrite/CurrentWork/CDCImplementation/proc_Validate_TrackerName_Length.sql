
-- USE KenticoCMS_Datamart_2
go
print 'Executing proc_Validate_TrackerName_Length.sql'
go
if exists (select name from sys.procedures where name = 'proc_Validate_TrackerName_Length')
    drop procedure proc_Validate_TrackerName_Length;
go
-- EXEC proc_Validate_TrackerName_Length ;
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
print 'Executed proc_Validate_TrackerName_Length.sql'
go