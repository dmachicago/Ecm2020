
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_UpdateQryPlansAndText'
)
    BEGIN
        DROP PROCEDURE UTIL_UpdateQryPlansAndText;
END;
GO

/*
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry2000' ;
exec UTIL_UpdateQryPlansAndText 'DFS_IO_BoundQry' ;
exec UTIL_UpdateQryPlansAndText 'DFS_CPU_BoundQry' ;

select top 100 * from DFS_QryPlanBridge

*/

CREATE PROCEDURE UTIL_UpdateQryPlansAndText
(@TgtTbl NVARCHAR(150), 
 @debug  INT           = 0
)
AS
    BEGIN
        DECLARE @stmt AS NVARCHAR(MAX)= '';
        DELETE FROM DFS_QryPlanBridge
        WHERE [query_hash] IS NULL
              AND [query_plan_hash] IS NULL;

        /* Delete Duplicate records */
        WITH CTE([query_hash], 
                 [query_plan_hash], 
                 DuplicateCount)
             AS (SELECT [query_hash], 
                        [query_plan_hash], 
                        ROW_NUMBER() OVER(PARTITION BY [query_hash], 
                                                       [query_plan_hash]
                        ORDER BY [query_hash], 
                                 [query_plan_hash]) AS DuplicateCount
                 FROM DFS_QryPlanBridge)
             DELETE FROM CTE
             WHERE DuplicateCount > 1;
        SET @stmt = 'UPDATE DFS_QryPlanBridge SET NbrHits = NbrHits + 1
						where exists (select Q.[query_hash], Q.[query_plan_hash] from DFS_QryPlanBridge Q 
										join ' + @TgtTbl + ' B 
										on B.[query_hash] = Q.[query_hash]
										and B.[query_plan_hash] = Q.[query_plan_hash] )';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        SET @stmt = 'insert into [dbo].[DFS_QryPlanBridge] ([query_hash],[query_plan_hash],[PerfType],[TblType],[CreateDate],LastUpdate,NbrHits)  
						select distinct Q.[query_hash],Q.[query_plan_hash],''C'' as PerfType, ''2000'' as [TblType],getdate() as [CreateDate], getdate() as LastUpdate,1 as NbrHits
						from ' + @TgtTbl + ' Q 
						WHERE NOT EXISTS 
						   (SELECT distinct [query_hash],[query_plan_hash]
							from [DFS_QryPlanBridge] B
							WHERE B.[query_hash] = Q.[query_hash] AND B.[query_plan_hash] = Q.[query_plan_hash]);
						';
        IF
           (@debug = 1
           )
            PRINT @stmt;
        EXECUTE sp_executesql 
                @stmt;
        SET @stmt = 'insert into [dbo].[DFS_QrysPlans] ([query_hash],[query_plan_hash],[UID],PerfType, [text], query_plan, CreateDate)  
						select Q.[query_hash],Q.[query_plan_hash],newid() as PerfType, ''C'' as PerfType, [text] ,query_plan, getdate() as [CreateDate]
						from ' + @TgtTbl + ' Q 
						WHERE NOT EXISTS 
						   (SELECT distinct [query_hash],[query_plan_hash]
							from [DFS_QrysPlans] B
							WHERE B.[query_hash] = Q.[query_hash] AND B.[query_plan_hash] = Q.[query_plan_hash]);
						';
        IF
           (@debug = 1
           )
            PRINT @stmt;
        EXECUTE sp_executesql 
                @stmt;

        /* truncate table [DFS_QryPlanBridge]*/

        SET @stmt = 'WITH CTE_parent 
						AS
						(
							SELECT  [query_hash], [query_plan_hash]
							FROM    [DFS_QryPlanBridge]
						)    
						UPDATE DFS_CPU_BoundQry2000 
						SET [text] = null, [query_plan] = null
						FROM CTE_parent C
						INNER JOIN ' + @TgtTbl + ' Q 
						ON C.[query_hash] = Q.[query_hash]
						and C.[query_plan_hash] = Q.[query_plan_hash] 
						where Q.Processed = 0; ';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        SET @stmt = 'UPDATE ' + @TgtTbl + ' SET processed = 1
						where exists (select Q.[query_hash], Q.[query_plan_hash] from DFS_QryPlanBridge Q 
										join ' + @TgtTbl + ' B 
										on B.[query_hash] = Q.[query_hash]
										and B.[query_plan_hash] = Q.[query_plan_hash]
										and B.Processed = 0)';
        EXECUTE sp_executesql 
                @stmt;
        IF
           (@debug = 1
           )
            PRINT @stmt;
        DELETE FROM DFS_QryPlanBridge
        WHERE [query_hash] IS NULL
              AND [query_plan_hash] IS NULL;

        /* Delete Duplicate records */
        WITH CTE([query_hash], 
                 [query_plan_hash], 
                 DuplicateCount)
             AS (SELECT [query_hash], 
                        [query_plan_hash], 
                        ROW_NUMBER() OVER(PARTITION BY [query_hash], 
                                                       [query_plan_hash]
                        ORDER BY [query_hash], 
                                 [query_plan_hash]) AS DuplicateCount
                 FROM DFS_QryPlanBridge)
             DELETE FROM CTE
             WHERE DuplicateCount > 1;
    END;