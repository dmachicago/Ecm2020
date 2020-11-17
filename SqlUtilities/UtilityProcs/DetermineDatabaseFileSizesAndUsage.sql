SET QUOTED_IDENTIFIER OFF
GO
DROP PROCEDURE spGetAllDBStats2
GO
CREATE PROCEDURE spGetAllDBStats2
AS
BEGIN
   ----------------------------------------------------------------
   -- Purpose:
   --    This SP Returns Data and Log File Sizes For all Databases,
   --    Along With Percent Capacity Used.
   --    Uses a Bunch of Dynamic SQL and DBCC Calls.
   -- 
   --  LIMITATIONS: For Databases With Multiple FILEGROUPS,
   --               it will only list information on one (the last)
   --               FILEGROUP!
   --
   -- Database:  (All)
   --
   -- History:
   --  
   --   Who       When      What
   --   ---       --------  ----------------------------------
   --   WDM       6.8.04    Created SP  
   ----------------------------------------------------------------

   DECLARE @buf     VARCHAR(512)
   DECLARE @db_name VARCHAR(80)

   SET NOCOUNT ON

   -- Create Two Temporary Tables
   CREATE TABLE #T
   (
      _DBName           VARCHAR(80) NOT NULL,

      _LogSizeMB        FLOAT           NULL,
      _LogSpaceUsedPct  FLOAT           NULL,          
      _LogFileName      VARCHAR(255)    NULL,
      _LogTotalExtents  INT             NULL,
      _LogUsedExtents   INT             NULL,

      _DataSizeMB       FLOAT           NULL,
      _DataFileName     VARCHAR(255)    NULL,
      _DataTotalExtents INT             NULL,
      _DataUsedExtents  INT             NULL,
      _DataSpaceUsedPct FLOAT           NULL, 

      _Status           INT             NULL
   )

   CREATE TABLE #T2
   (_Fileid INT, _FileGroup INT, _TotalExtents INT, _UsedExtents INT, _Name VARCHAR(255), _FileName VARCHAR(255))

   -- PHASE I -- Run DBCC SQLPERF(Logspace)
   INSERT INTO #T(_DBName, _LogSizeMB, _LogSpaceUsedPct, _Status)
      EXEC('DBCC SQLPERF(LOGSPACE)')

   -- PHASE II -- 
   -- Create cursor for cycling through databases
   DECLARE MyCursor CURSOR FOR
      SELECT _DBName FROM #T

   -- Execute the cursor
   OPEN MyCursor
   FETCH NEXT FROM MyCursor INTO @db_name 

   -- Do Until All Databases Exhausted...
   WHILE (@@fetch_status <> -1)
   BEGIN
      -- Query To Get Log File and Size Info
      SELECT @buf = "UPDATE #T"
                  + " SET _LogFileName = X.[filename], _LogTotalExtents = X.[size]"            
                  + " FROM #T,"
                  + " (SELECT '" + @db_name + "' AS 'DBName'," 
                  + " fileid, [filename], [size] FROM "
                  + @db_name + ".dbo.sysfiles WHERE (status & 0x40 <> 0)) X"
                  + " WHERE X.DBName = #T._DBName"
      --PRINT @buf
      EXEC(@buf)

      -- "DBCC showfilestats" Query To Get Data File and Size Info
      DELETE FROM #T2
      SELECT @buf = 'INSERT INTO #T2'
                  + '(_Fileid, _FileGroup, _TotalExtents, _UsedExtents, _Name, _FileName)'
                  + " EXEC ('USE " + @db_name + "; DBCC showfilestats')"
      -- PRINT @buf
      EXEC(@buf)

      -- Update the Data Info., and Calculate the Remaining Entities
      UPDATE #T 
      SET _DataFileName     = #T2._FileName, 
          _DataTotalExtents = #T2._TotalExtents, 
          _DataUsedExtents  = #T2._UsedExtents,
          _LogUsedExtents   = CONVERT(INT, (_LogSpaceUsedPct * _LogTotalExtents / 100.0)),
          _DataSpaceUsedPct = 100.0 * CONVERT(FLOAT, #T2._UsedExtents) / CONVERT(FLOAT, #T2._TotalExtents),
          _DataSizeMB       = CONVERT(FLOAT, #T2._TotalExtents) / 16.0
      FROM #T, #T2
      WHERE _DBName = @db_name
             
      -- Go to Next Cursor Row
      FETCH NEXT FROM MyCursor INTO @db_name 
   END

   -- Close Cursor
   CLOSE      MyCursor
   DEALLOCATE MyCursor

   -- Return Results to User
   SELECT 
      _DBName                                                             ,

      _LogFileName                                                        , 
      _LogSizeMB                                                          ,
      _LogTotalExtents                                                    ,
      _LogUsedExtents                                                     ,
      CONVERT(DECIMAL(6, 2), _LogSpaceUsedPct)  AS '_PercentLogSpaceUsed' ,            

      _DataFileName                                                       ,
      _DataSizeMB                                                         ,
      _DataTotalExtents                                                   ,
      _DataUsedExtents                                                    ,
      CONVERT(DECIMAL(6, 2), _DataSpaceUsedPct) AS '_PercentDataSpaceUsed'  
       
   FROM #T 
   ORDER BY _DBName

   -- Clean Up
   DROP TABLE #T
   DROP TABLE #T2
END 
GO

