
/************************************************************************************
 Create a partition scheme that maps each partition to a different filegroup
************************************************************************************/

CREATE PARTITION FUNCTION myRangePF1
(INT
) AS RANGE LEFT FOR VALUES
(1, 100, 1000
);  
GO  
CREATE PARTITION SCHEME myRangePS1 AS PARTITION myRangePF1 TO(test1fg, test2fg, test3fg, test4fg);

/************************************************************************************
 Create a partition scheme that maps multiple partitions to the same filegroup
************************************************************************************/

CREATE PARTITION FUNCTION myRangePF2
(INT
) AS RANGE LEFT FOR VALUES
(1, 100, 1000
);  
GO  
CREATE PARTITION SCHEME myRangePS2 AS PARTITION myRangePF2 TO(test1fg, test1fg, test1fg, test2fg);

/************************************************************************************
 Creating a partition scheme that maps all partitions to the same filegroup
************************************************************************************/

CREATE PARTITION FUNCTION myRangePF3
(INT
) AS RANGE LEFT FOR VALUES
(1, 100, 1000
);  
GO  
CREATE PARTITION SCHEME myRangePS3 AS PARTITION myRangePF3 ALL TO(test1fg);

/************************************************************************************
 Creating a partition scheme that specifies a 'NEXT USED' filegroup
************************************************************************************/

CREATE PARTITION FUNCTION myRangePF4
(INT
) AS RANGE LEFT FOR VALUES
(1, 100, 1000
);  
GO  
CREATE PARTITION SCHEME myRangePS4 AS PARTITION myRangePF4 TO(test1fg, test2fg, test3fg, test4fg, test5fg);

/************************************************************************************************
 Creating a partition schema only on PRIMARY - only PRIMARY is supported for SQL Database
************************************************************************************************/

CREATE PARTITION FUNCTION myRangePF1
(INT
) AS RANGE LEFT FOR VALUES
(1, 100, 1000
);  
GO  
CREATE PARTITION SCHEME myRangePS1 AS PARTITION myRangePF1 ALL TO([PRIMARY]);