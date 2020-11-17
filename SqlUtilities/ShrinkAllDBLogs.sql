--If the database is in the SIMPLE recovery model you can use the following statement to shrink the log file:

        DBCC SHRINKFILE (PowerDatabase_log, 1)
use [ECM.Library.FS]        
--Replace AdventureWorks2012_log with the logical name of the log file you need shrunk and
-- change 1 to the number of MB you want the log file shrunk to.

--If the database is in FULL recovery model you could set it to SIMPLE, run DBCC SHRINKFILE, 
-- and set back to FULL if you don’t care about losing the data in the log.

        ALTER DATABASE AdventureWorks2012
        SET RECOVERY SIMPLE
        GO
        DBCC SHRINKFILE (AdventureWorks2012_log, 1)
        GO
        ALTER DATABASE AdventureWorks2012
        SET RECOVERY FULL
        
--**You can find the logical name of the log file by using the following query:
--select D.name as DBNAME, L.name as LogName from sys.databases D
--DBCC SHRINKFILE (PowerDatabase_log, 1)
        SELECT 'USE [' +  D.Name + '];' + char(10) + 'GO' + char(10) + 'DBCC SHRINKFILE ([' + L.name + '], 1) ;' + char(10) as CMD FROM 
		sys.master_files L
		join sys.databases D
		on L.database_id = D.database_id
		WHERE L.type_desc = 'LOG'