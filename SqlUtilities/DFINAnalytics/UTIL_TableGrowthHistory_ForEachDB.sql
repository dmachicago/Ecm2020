--* USEDFINAnalytics;
go

DECLARE @RunID BIGINT;
EXEC @RunID = dbo.UTIL_GetSeq;
PRINT 'RUN ID: ' + cast(@RunID as nvarchar(10));
DECLARE @command NVARCHAR(1000);
SELECT @command = '--* USE?; exec sp_UTIL_TableGrowthHistory ' + CAST(@RunID AS NVARCHAR(10)) ;
EXEC sp_MSforeachdb @command;

