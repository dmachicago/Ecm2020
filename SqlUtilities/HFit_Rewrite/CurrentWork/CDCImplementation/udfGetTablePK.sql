
--SELECT COLUMN_NAME
--FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
--WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1
--AND TABLE_NAME = 'CMS_WidgetRole' AND TABLE_SCHEMA = 'dbo'

go
print 'Executing udfGetTablePK.sql' ;
go
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].udfGetTablePK')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
begin
    print 'Replacing function udfGetTablePK';
    drop function udfGetTablePK ;
end 

go

CREATE FUNCTION dbo.udfGetTablePK (@InstanceName nvarchar(100), @TblName nvarchar (100)) 
RETURNS varchar (2000) 
AS
BEGIN
    DECLARE @PK AS nvarchar (2000) = '';
    DECLARE @COL AS nvarchar (2000) = '';
    DECLARE @MySql AS nvarchar (max) = '';
    DECLARE @S AS nvarchar (max) = '';
    --declare @TblName as nvarchar(50) = 'CMS_WidgetRole' ;
    --declare @InstanceName as nvarchar(50) = 'KenticoCMS_1' ;

    set @S = 'DECLARE PCursor CURSOR ' + char(10) ;
        set @S = @S + ' FOR ' + char(10) ; 
        set @S = @S +  '     SELECT '  + char(10); 
        set @S = @S +  '            COLUMN_NAME ' + char(10) ; 
        set @S = @S +  '            FROM '+@InstanceName+'.INFORMATION_SCHEMA.KEY_COLUMN_USAGE '  + char(10); 
        set @S = @S +  '              WHERE OBJECTPROPERTY (OBJECT_ID (CONSTRAINT_SCHEMA + ' + '''.''' + ' + CONSTRAINT_NAME) , ''IsPrimaryKey'') = 1 ' + char(10) ;
        set @S = @S +  '               AND TABLE_NAME = '''+@TblName+''''  + char(10) ;
        set @S = @S +  '               AND TABLE_SCHEMA = ''dbo''' + char(10);

    OPEN PCursor;
    FETCH NEXT FROM PCursor INTO @COL;
    IF @@FETCH_STATUS <> 0
        BEGIN
            RETURN '';
        END;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SELECT
                   @PK = ',' + @COL;
            FETCH NEXT FROM PCursor INTO @COL;
        END;

    CLOSE product_cursor;
    DEALLOCATE product_cursor;

    RETURN @PK;
END; 
go
print 'Executed udfGetTablePK.sql' ;
go

