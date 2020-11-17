
--USE KenticoCMS_Datamart_2
GO
PRINT 'Execute isPrimaryKeyExists.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'isPrimaryKeyExists') 
    BEGIN
        DROP PROCEDURE
             isPrimaryKeyExists;
    END;
GO
-- 
/*
    USE KenticoCMS_Datamart_2
    
    declare @tsql as nvarchar(max) = '' ;
    declare @InstanceName as nvarchar(500) = 'KenticoCMS_1' ;
    declare @TblName as nvarchar(500) = 'HFit_PPTStatusEnum' ;
    declare @tcnt as int = 0 ;
    exec @tcnt = isPrimaryKeyExists @InstanceName , @TblName   ;

    if @tcnt = 0 
    begin
		  declare @xcolname as nvarchar(500) = @TblName+'_GuidID' ;
		  declare @pkname as nvarchar(500) = 'PK_CT_' + @TblName ;
		  set @tsql = 'ALTER TABLE '+ @InstanceName + '.' + @TblName + ' ADD ' + @xcolname + ' uniqueidentifier default newid() '  ;
		  print (@tsql) ;
		  set @tsql = 'ALTER TABLE '+@InstanceName + '.' + @TblName+' ADD CONSTRAINT '+@pkname+' PRIMARY KEY ('+@xcolname+') ' ;
		  print  (@tsql) ;
    end 
*/
CREATE PROCEDURE isPrimaryKeyExists (
       @InstanceName AS NVARCHAR (500) 
     , @TblName AS NVARCHAR (500)) 
AS
BEGIN
    --Check to see if the table has a primary key
    --declare @InstanceName as nvarchar(500) = 'KenticoCMS_1' ;
    --declare @TblName as nvarchar(500) = 'CMS_USer' ;
    DECLARE
         @i AS INT = 0;
    DECLARE
         @CountSQL AS NVARCHAR (MAX) = '';
    DECLARE
         @out TABLE (
                    out INT) ;
    SET @CountSQL = 'SELECT count(*) FROM ' + @InstanceName + '.INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
		  WHERE CONSTRAINT_TYPE = ''PRIMARY KEY'' 
		  AND TABLE_NAME = ''' + @TblName + ''' 
		  AND TABLE_SCHEMA =''dbo'' ';
    --PRINT @CountSQL;
    INSERT INTO @out
    EXEC (@CountSQL) ;
    SET @i = (SELECT
                     *
              FROM @out) ;
    RETURN @i;
END;

GO
PRINT 'Executed isPrimaryKeyExists.sql';
GO

--ALTER TABLE KenticoCMS_1.dbo.HFit_PPTStatusEnum ADD HFit_PPTStatusEnum_GuidID uniqueidentifier not null default newid() 
--ALTER TABLE KenticoCMS_1.dbo.HFit_PPTStatusEnum ADD CONSTRAINT PK_CT_HFit_PPTStatusEnum PRIMARY KEY (HFit_PPTStatusEnum_GuidID) 