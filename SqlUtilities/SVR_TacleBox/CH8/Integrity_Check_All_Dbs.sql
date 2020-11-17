CREATE TABLE #CheckDBTemp (
     Error         INT
   , [Level]      INT
   , [State]      INT
   , MessageText   NVARCHAR(1000)
   , RepairLevel   NVARCHAR(1000)
   , [Status]      INT
   , [DBID]      INT
   , ObjectID      INT
   , IndexID      INT
   , PartitionID   BIGINT
   , AllocUnitID   BIGINT
   , [File]      INT
   , Page         INT
   , Slot         INT
   , RefFile      INT
   , RefPage      INT
   , RefSlot      INT
   , Allocation   INT
)
-- Needed variables
DECLARE @TSQL         NVARCHAR(1000)
DECLARE @dbName         NVARCHAR(100)
DECLARE @dbErrorList   NVARCHAR(1000)
DECLARE @dbID         INT
DECLARE @ErrorCount      INT
DECLARE @EmailSubject   NVARCHAR(255)
DECLARE @ProfileName   VARCHAR(100)
DECLARE @EmailRecipient   VARCHAR(255)

-- Init variables
SET @dbID = 0
SET @dbErrorList = ''
SET @EmailSubject = 'Integrity Check Failure on ' + CAST(COALESCE(@@SERVERNAME, 'Server Name Not Available') AS NVARCHAR)
SET @ProfileName = 'Notifications'
SET @EmailRecipient = 'rlandrum13@cox.net'
-- CYCLE THROUGH DATABASES
WHILE(@@ROWCOUNT > 0)
BEGIN
   IF( @dbID > 0 )
   BEGIN
      SET @TSQL = 'DBCC CHECKDB(''' +  @dbName  + ''') WITH TABLERESULTS, PHYSICAL_ONLY, NO_INFOMSGS'

      INSERT INTO #CheckDBTemp
      EXEC(@TSQL)

      SELECT @ErrorCount = COUNT(*) FROM #CheckDBTemp

      IF( @ErrorCount > 0 )
      BEGIN
         SET @dbErrorList = @dbErrorList + CHAR(10) + CHAR(13) + 'Issue found on database : ' + @dbName
         SET @dbErrorList = @dbErrorList + CHAR(10) + CHAR(13) + (Select Top 1 MessageText from  #CheckDBTemp)
      END

      TRUNCATE TABLE #CheckDBTemp
   END
   
   IF SUBSTRING(CONVERT(varchar(50), SERVERPROPERTY('ProductVersion')),1,1) = '8'
   BEGIN
      SELECT TOP 1 @dbName = name, @dbID = dbid
      FROM sysdatabases WHERE dbid > @dbID 
          AND name NOT IN ('tempdb')
          AND DATABASEPROPERTYEX(name, 'Status') = 'Online'
      ORDER by dbid      
   END
   ELSE
   BEGIN
      SELECT TOP 1 @dbName = name, @dbID = database_ID
      FROM sys.databases WHERE database_ID > @dbID 
          AND name NOT IN ('tempdb') 
          AND DATABASEPROPERTYEX(name, 'Status') = 'Online'
      ORDER by database_ID
   END
END
-- If errors were found
IF( @dbErrorList <> '' )
BEGIN
   IF SUBSTRING(CONVERT(varchar(50), SERVERPROPERTY('ProductVersion')),1,1) = '8'
   BEGIN
      EXEC master..xp_sendmail @recipients = @EmailRecipient, @subject = @EmailSubject, @message = @dbErrorList
   END
   ELSE
   BEGIN
      EXEC msdb..sp_send_dbmail @profile_name = @ProfileName, @recipients = @EmailRecipient, @subject = @EmailSubject, @body = @dbErrorList, @importance = 'High'
   END
END

DROP TABLE #CheckDBTemp
