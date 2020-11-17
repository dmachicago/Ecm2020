
IF OBJECT_ID('tempdb..##usp_myTempWorker') IS NOT NULL
BEGIN
    DROP PROC ##usp_myTempWorker
END
go
CREATE PROC ##usp_myTempWorker AS
	declare @cnt as int = 0 ;
  set @cnt = (SELECT count(*) FROM sys.databases);
  print '@cnt: ' + cast(@cnt as nvarchar(10));
  print 'DB: ' + db_name();
go
exec ##usp_myTempWorker;
go
declare @stmt nvarchar(1000);
set @stmt = '--* USE?; exec ##usp_myTempWorker';
exec sp_msForEachDB @stmt;