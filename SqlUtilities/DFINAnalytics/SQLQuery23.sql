/*Declare a table variable with some unusual options.*/
DECLARE @T TABLE
(
[dba.se] INT IDENTITY PRIMARY KEY NONCLUSTERED,
A INT CHECK (A > 0),
B INT DEFAULT 1,
InRowFiller char(1000) DEFAULT REPLICATE('A',1000),
OffRowFiller varchar(8000) DEFAULT REPLICATE('B',8000),
LOBFiller varchar(max) DEFAULT REPLICATE(cast('C' as varchar(max)),10000),
UNIQUE CLUSTERED (A,B) 
    WITH (FILLFACTOR = 80, 
         IGNORE_DUP_KEY = ON, 
         DATA_COMPRESSION = PAGE, 
         ALLOW_ROW_LOCKS=ON, 
         ALLOW_PAGE_LOCKS=ON)
)

INSERT INTO @T (A)
VALUES (1),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13)

SELECT t.object_id,
       t.name,
       p.rows,
       a.type_desc,
       a.total_pages,
       a.used_pages,
       a.data_pages,
       p.data_compression_desc
FROM   tempdb.sys.partitions AS p
       INNER JOIN tempdb.sys.system_internals_allocation_units AS a
         ON p.hobt_id = a.container_id
       INNER JOIN tempdb.sys.tables AS t
         ON t.object_id = p.object_id
       INNER JOIN tempdb.sys.columns AS c
         ON c.object_id = p.object_id
WHERE  c.name = 'dba.se'