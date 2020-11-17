
--Displaying fragmentation information for a table
declare @txt nvarchar(2000);
DBCC SHOWCONTIG('HumanResources.Employee') ;
--Displaying an abbreviated result set for a table
DBCC SHOWCONTIG('HumanResources.Employee', 1) WITH FAST; 
GO

--Displaying the full result set for every index on every table in a database

DBCC SHOWCONTIG WITH TABLERESULTS, ALL_INDEXES;  
GO


/*
There are three types of fragmentation to consider.

Logical fragmentation, when the pages are out of logical sequence.
Extent fragmentation, when the extents are not contiguous and SQL Server 
is unable to leverage read ahead, for example, reads up to 512k.*
External fragmentation, where everything is in logical order according to 
SQL Server, but where the data physically resides on the disk is not contiguous.
*An Extent is eight (8) contiguous 8k pages.
*/
/*
When data is contiguous, SQL Server can read the same amount of data in fewer, 
but larger I/O operations, which is usually faster. Because of this, SQL Server 
DBAs frequently perform one of three operations to address fragmentation.

Reorg—A reorg will swap pages of a table in small transactions until all pages 
are in logical order. The result will not yield physically contiguous pages, 
only logically ordered pages. This operation leaves the underlying table/index 
available for update but will take longer than a reindex if the index has a lot 
of logical fragmentation i.e. the pages are out of order. One of the most important 
benefits of this operation is that its atomic transactions are small so you can stop 
the operation without rolling back much work. Thus you can get as much done as you 
have time, stop then resume later. Sometimes this is the best answer for an incredibly 
large index that cannot be rebuilt within a maintenance window.

Offline Rebuild—This operation locks the underlying table/index leaving it unavailable 
for updates until the operation completes. As opposed to the reorg mentioned above, 
it does seek to make the pages physically contiguous and this is all or nothing. If 
you cancel it, everything rolls back.

Online Rebuild–This operation locks the underlying table/index significantly less, 
leaving it available for updates during most of the operation. As opposed to the reorg 
mentioned above, it does seek to make the pages physically contiguous and this is all 
or nothing. If you cancel it, everything rolls back.
*/

SELECT 'ALTER TABLE ' + T.TABLE_SCHEMA + '.' + T.TABLE_NAME + ';' + CHAR(10) + 'GO'
FROM INFORMATION_SCHEMA.tables AS T
WHERE T.TABLE_TYPE <> 'VIEW';

/*
DBCC SHOWCONTIG determines whether the table is heavily fragmented. Table fragmentation occurs through the process of data modifications (INSERT, UPDATE, and DELETE statements) made against the table. Because these modifications are not ordinarily distributed equally among the rows of the table, the fullness of each page can vary over time. For queries that scan part or all of a table, such table fragmentation can cause additional page reads. This hinders parallel scanning of data.
*/

--************************************************************
--Show specific table and specific index

USE AW2016;  
GO
DECLARE @id INT, @indid INT;
SET @id = OBJECT_ID('Production.Product');
SELECT @indid = index_id
FROM sys.indexes
WHERE object_id = @id
      AND name = 'AK_Product_Name';
DBCC SHOWCONTIG(@id, @indid);  
GO

--************************************************************
/*
Using DBCC SHOWCONTIG and DBCC INDEXDEFRAG to defragment the indexes in a database
Perform a 'USE <database name>' to select the database in which to run the script.
*/

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ReorgTableIndexes'
)
    DROP PROCEDURE UTIL_ReorgTableIndexes;
GO

-- exec UTIL_ReorgTableIndexes 20.0
CREATE PROCEDURE UTIL_ReorgTableIndexes(@maxfrag AS DECIMAL(8, 2)  = 30.0)
AS
    BEGIN
        -- Declare variables  
        SET NOCOUNT ON;
        DECLARE @tablename VARCHAR(255);
        DECLARE @execstr VARCHAR(400);
        DECLARE @objectid INT;
        DECLARE @indexid INT;
        DECLARE @frag DECIMAL;

        -- Declare a cursor.  
        DECLARE tables CURSOR
        FOR SELECT TABLE_SCHEMA + '.' + TABLE_NAME
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_TYPE = 'BASE TABLE';

        -- Create the table.  
        CREATE TABLE #fraglist
        (ObjectName     CHAR(255), 
         ObjectId       INT, 
         IndexName      CHAR(255), 
         IndexId        INT, 
         Lvl            INT, 
         CountPages     INT, 
         CountRows      INT, 
         MinRecSize     INT, 
         MaxRecSize     INT, 
         AvgRecSize     INT, 
         ForRecCount    INT, 
         Extents        INT, 
         ExtentSwitches INT, 
         AvgFreeBytes   INT, 
         AvgPageDensity INT, 
         ScanDensity    DECIMAL, 
         BestCount      INT, 
         ActualCount    INT, 
         LogicalFrag    DECIMAL, 
         ExtentFrag     DECIMAL
        );

        -- Open the cursor.  
        OPEN tables;

        -- Loop through all the tables in the database.  
        FETCH NEXT FROM tables INTO @tablename;
        WHILE @@FETCH_STATUS = 0
            BEGIN  
                -- Do the showcontig of all indexes of the table  
                INSERT INTO #fraglist
                EXEC ('DBCC SHOWCONTIG ('''+@tablename+''')   
      WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
                FETCH NEXT FROM tables INTO @tablename;
            END;

        -- Close and deallocate the cursor.  
        CLOSE tables;
        DEALLOCATE tables;

        -- Declare the cursor for the list of indexes to be defragged.  
        DECLARE indexes CURSOR
        FOR SELECT ObjectName, 
                   ObjectId, 
                   IndexId, 
                   LogicalFrag
            FROM #fraglist
            WHERE LogicalFrag >= @maxfrag
                  AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;

        -- Open the cursor.  
        OPEN indexes;

        -- Loop through the indexes.  
        FETCH NEXT FROM indexes INTO @tablename, @objectid, @indexid, @frag;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT 'Executing DBCC INDEXDEFRAG (0, ' + RTRIM(@tablename) + ',  
      ' + RTRIM(@indexid) + ') - fragmentation currently ' + RTRIM(CONVERT(VARCHAR(15), @frag)) + '%';
                SELECT @execstr = 'DBCC INDEXDEFRAG (0, ' + RTRIM(@objectid) + ',  
       ' + RTRIM(@indexid) + ')';
                EXEC (@execstr);
                FETCH NEXT FROM indexes INTO @tablename, @objectid, @indexid, @frag;
            END;

        -- Close and deallocate the cursor.  

        CLOSE indexes;
        DEALLOCATE indexes;

        -- Delete the temporary table.  
        --SELECT * FROM #fraglist;
        DROP TABLE #fraglist;
    END;
GO