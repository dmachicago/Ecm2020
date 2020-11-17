
--select * from BASE_HFit_HealthAssesmentUserStarted_CTVerHIST
GO
PRINT 'Executing proc_GenCTVerHIST_Trigger.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenCTVerHIST_Trigger') 
    BEGIN
        DROP PROCEDURE
             proc_GenCTVerHIST_Trigger;
    END;
GO
-- exec proc_GenCTVerHIST_Trigger 'BASE_HFit_HealthAssesmentUserStarted'
CREATE PROCEDURE proc_GenCTVerHIST_Trigger (
       @TblName AS NVARCHAR (250)) 
AS
BEGIN
    DECLARE @MySql AS NVARCHAR (MAX) = ''
          , @TrigName AS NVARCHAR (500) = '';

    SET @TrigName = 'TRIG_UPDT_' + @TblName + '_CTVerHIST';
    IF EXISTS (SELECT
                      name
               FROM sys.triggers
               WHERE name = @TrigName) 
        BEGIN
            SET @MySQl = 'drop trigger ' + @TrigName;
            EXEC (@MySql) ;
        END;

    SET @MySql = 'CREATE TRIGGER [dbo].[' + @TrigName + '] ' + CHAR (10) ;
    SET @MySql = @MySql + '    ON [dbo].' + @TblName + CHAR (10) ;
    SET @MySql = @MySql + '        AFTER UPDATE  ' + CHAR (10) ;
    SET @MySql = @MySql + '    AS  ' + CHAR (10) ;
    SET @MySql = @MySql + '    BEGIN  ' + CHAR (10) ;
    SET @MySql = @MySql + '        update inserted set SYS_CHANGE_VERSION = SYS_CHANGE_VERSION -1  ' + CHAR (10) ;
    SET @MySql = @MySql + '    	   where SYS_CHANGE_VERSION is not null  ' + CHAR (10) ;
    SET @MySql = @MySql + '    		  and SYS_CHANGE_VERSION > 0  ' + CHAR (10) ;
    print @MySql ;
    EXEC (@MySQl) ;

END;

GO
PRINT 'Executed proc_GenCTVerHIST_Trigger.sql';
GO


CREATE TRIGGER [dbo].[TRIG_UPDT_BASE_HFit_HealthAssesmentUserStarted_CTVerHIST] 
    ON [dbo].BASE_HFit_HealthAssesmentUserStarted
        AFTER UPDATE  
    AS  
    BEGIN  
        update BASE_HFit_HealthAssesmentUserStartedset set SYS_CHANGE_VERSION = SYS_CHANGE_VERSION -1  
    	   where SYS_CHANGE_VERSION in (select max( SYS_CHANGE_VERSION) from inserted )
end    		