--exec sp_who2
DROP TABLE
     ##temp_sp_who2;
GO
CREATE TABLE ##temp_sp_who2
(
             SPID int
           ,Status varchar (1000) NULL
           ,Login sysname NULL
           ,HostName sysname NULL
           ,BlkBy sysname NULL
           ,DBName sysname NULL
           ,Command varchar (1000) NULL
           ,CPUTime int NULL
           ,DiskIO int NULL
           ,LastBatch varchar (1000) NULL
           ,ProgramName varchar (1000) NULL
           ,SPID2 int
           ,REQUESTID int NULL --comment out for SQL 2000 databases

);

INSERT  INTO ##temp_sp_who2
EXEC sp_who2;
--kill 78 

--with (SPID, BlkBy)
--as
--(
--    SELECT SPID, BlkBy FROM ##temp_sp_who2  where CHARINDEX('.',BlkBy) <= 0 
--)

SELECT
       *
       FROM ##temp_sp_who2
       WHERE CHARINDEX ('.', BlkBy) <= 0
       ORDER BY
                BlkBy DESC;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

