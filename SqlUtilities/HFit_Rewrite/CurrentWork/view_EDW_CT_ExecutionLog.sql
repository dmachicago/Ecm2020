
GO 
PRINT 'Creating view_EDW_CT_ExecutionLog';
PRINT 'FROM view_EDW_CT_ExecutionLog.sql';
GO
--exec sp_depends 'EDW_CT_ExecutionLog'
IF EXISTS( SELECT
                  name
             FROM sys.views
             WHERE name = 'view_EDW_CT_ExecutionLog' )
    BEGIN
        DROP VIEW
             view_EDW_CT_ExecutionLog
    END;
GO
CREATE VIEW view_EDW_CT_ExecutionLog
AS SELECT
          *
     FROM EDW_CT_ExecutionLog;
GO
PRINT 'CREATED view_EDW_CT_ExecutionLog';
GO
