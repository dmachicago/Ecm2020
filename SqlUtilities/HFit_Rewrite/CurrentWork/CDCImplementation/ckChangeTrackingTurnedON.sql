
go
print 'FROM ckChangeTrackingTurnedON.sql';
print 'Installing Change Tracking';
go


DECLARE @DB AS NVarChar (200) = DB_NAME () ;
DECLARE @DBID AS Int = 0;
DECLARE @s AS NVarChar (2000) = '';

IF NOT EXISTS (SELECT
				  [database_id]
			   FROM [sys].[change_tracking_databases]
			   WHERE [database_id] = DB_ID (@DB)) 
    BEGIN
	   SET @s =
			'ALTER DATABASE ' + @DB + ' SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 5 DAYS, AUTO_CLEANUP = ON) ';
	   EXEC (@s) ;
	   PRINT 'Turned Change Tracking On';
    END;

GO
print 'FROM ckChangeTrackingTurnedON.sql';
print 'Installed Change Tracking';
go
