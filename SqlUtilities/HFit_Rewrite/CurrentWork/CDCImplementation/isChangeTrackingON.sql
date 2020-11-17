
--USE KenticoCMS_Datamart_2
GO

GO
PRINT 'Execute isChangeTrackingON.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'isChangeTrackingON') 
    BEGIN
        DROP PROCEDURE
             isChangeTrackingON;
    END;
GO
-- 
-- HFit_PPTStatusEnum
CREATE PROCEDURE isChangeTrackingON (
       @InstanceName AS NVARCHAR (500) 
     , @TblName AS NVARCHAR (500)) 
AS
BEGIN
    --Check to see if change tracking is turned on for  table
    --declare @InstanceName as nvarchar(500) = 'KenticoCMS_1' ;
    --declare @TblName as nvarchar(500) = 'CMS_USer' ;
    DECLARE
         @i AS INT = 0
       , @CountSQL AS NVARCHAR (MAX) = '';
    DECLARE
         @out TABLE (
                    out INT) ;
    SET @CountSQL = 'SELECT count(*) FROM ' + @InstanceName + '.sys.change_tracking_tables tr
		  INNER JOIN sys.tables t on t.object_id = tr.object_id
		  INNER JOIN sys.schemas s on s.schema_id = t.schema_id
		  where t.name = ''' + @TblName + '''';
    --PRINT @CountSQL;
    INSERT INTO @out
    EXEC (@CountSQL) ;
    SET @i = (SELECT
                     *
              FROM @out) ;
    RETURN @i;
END;

GO
PRINT 'Executed isChangeTrackingON.sql';
GO