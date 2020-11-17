
GO
PRINT 'Executing proc_GetColumnID.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GetColumnID') 
    BEGIN
        DROP PROCEDURE
             proc_GetColumnID
    END;

GO
-- exec proc_GetColumnID 'KenticoCMS_1', 'HFit_HealthAssesmentUserStarted', 'HAPaperFlg'
create PROCEDURE proc_GetColumnID (
      @InstanceName AS NVARCHAR (250) 
    , @TblName AS NVARCHAR (250) 
    , @ColName AS NVARCHAR (250)) 
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE
           @MySQl AS NVARCHAR (MAX) = ''
         , @ID AS INT = 0;
    DECLARE
           @rowcount TABLE (
                           Value INT) ;

    SET @MySQl = 'select column_id from ' + @InstanceName + '.sys.columns 
				where object_id = OBJECT_ID (''' + @InstanceName + '.dbo.' + @TblName + ''')
				and name = ''' + @ColName + '''';

    INSERT INTO @rowcount EXEC (@MySql) ;
    SELECT @ID = Value FROM @rowcount;

    SET NOCOUNT ON;
    RETURN @ID;

END;
GO
GO
PRINT 'Executed proc_GetColumnID.sql';
GO
