DBCC TRACEON(2537)
SELECT
   [Current LSN] , Operation , dblog.[Transaction ID] , AllocUnitId , AllocUnitName , [Page ID] , [Slot ID] , [Num Elements] , dblog1.[Begin Time] , dblog1.[Transaction Name] , [RowLog Contents 0] , [Log Record]
FROM
   ::fn_dblog(NULL, NULL) dblog
   INNER JOIN
      (
         SELECT
            allocunits.allocation_unit_id , objects.name , objects.id
         FROM
            sys.allocation_units allocunits
            INNER JOIN
               sys.partitions partitions
               ON
                  (
                     allocunits.type IN (1, 3)
                     AND partitions.hobt_id = allocunits.container_id
                  )
                  OR
                  (
                     allocunits.type             = 2
                     and partitions.partition_id = allocunits.container_id
                  )
            INNER JOIN
               sysobjects objects
               ON
                  partitions.object_id = objects.id
                  AND objects.type IN ('U', 'u')
         WHERE
            partitions.index_id IN (0, 1)
      )
      allocunits
      ON
         dblog.AllocUnitID = allocunits.allocation_unit_id
   INNER JOIN
      (
         SELECT
            [Begin Time] , [Transaction Name] , [Transaction ID]
         FROM
            fn_dblog(NULL, NULL) x
         WHERE
            Operation = 'LOP_BEGIN_XACT'
      )
      dblog1
      ON
         dblog1.[Transaction ID] = dblog.[Transaction ID]
WHERE
   [Page ID]         IS NOT NULL
   AND [Slot ID]              >= 0
   AND dblog.[Transaction ID] != '0000:00000000'
   AND Context in ('LCX_HEAP' , 'LCX_CLUSTERED')
   DBCC TRACEOFF(2537)