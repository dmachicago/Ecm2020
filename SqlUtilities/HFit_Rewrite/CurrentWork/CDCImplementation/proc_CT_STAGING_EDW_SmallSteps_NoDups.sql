
GO

PRINT 'Execute proc_CT_EDW_SmallSteps_NoDups.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_EDW_SmallSteps_NoDups' )
    BEGIN
        DROP PROCEDURE
             proc_CT_EDW_SmallSteps_NoDups;
    END;
GO

/*
exec proc_CT_EDW_SmallSteps_NoDups
delete from DIM_EDW_SmallSteps where userID < 0 or userID is null
select count(*), HFitUserMPINumber, HashCode from DIM_EDW_SmallSteps group by HFitUserMPINumber, HashCode having count(*) > 1
select * from DIM_EDW_SmallSteps where HFitUserMPINumber = 9336928 and  HashCode = 0x2136D91AC7B41EC83EE3AB2F79E87A65FD815C6D
*/

CREATE PROCEDURE proc_CT_EDW_SmallSteps_NoDups
AS
BEGIN

    /* Delete Duplicate records */
    WITH CTE (
         HFitUserMPINumber ,
         HashCode ,
         DuplicateCount )
        AS ( SELECT HFitUserMPINumber ,HashCode
                    ,ROW_NUMBER( ) OVER( PARTITION BY  HFitUserMPINumber ,
                                                       HashCode
                    ORDER BY   HFitUserMPINumber , HashCode
                    ) AS DuplicateCount
               FROM DIM_EDW_SmallSteps
               WHERE DeletedFlg IS NULL
        )
        DELETE
        FROM CTE
          WHERE
                DuplicateCount > 1;
	   declare @i as int = @@ROWCOUNT ;
	   print 'Duplicates found and removed: ' + cast(@i as nvarchar(50)) ;
END;
GO
PRINT 'Executed proc_CT_EDW_SmallSteps_NoDups.sql';
GO

GO

PRINT 'Execute proc_CT_EDW_SmallSteps_Temp_NoDups.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_EDW_SmallSteps_Temp_NoDups' )
    BEGIN
        DROP PROCEDURE
             proc_CT_EDW_SmallSteps_Temp_NoDups;
    END;
GO

/*
exec proc_CT_EDW_SmallSteps_Temp_NoDups
delete from DIM_EDW_SmallSteps where userID < 0 or userID is null
select count(*), HFitUserMPINumber, HashCode from DIM_EDW_SmallSteps group by HFitUserMPINumber, HashCode having count(*) > 1
select * from DIM_EDW_SmallSteps where HFitUserMPINumber = 9336928 and  HashCode = 0x2136D91AC7B41EC83EE3AB2F79E87A65FD815C6D
*/

CREATE PROCEDURE proc_CT_EDW_SmallSteps_Temp_NoDups
AS
BEGIN

    /* Delete Duplicate records */
    IF OBJECT_ID('tempdb..##Temp_SmallSteps') IS NOT NULL 
            BEGIN
                return ;
            END;

    WITH CTE (
         HFitUserMPINumber ,
         HashCode ,
         DuplicateCount )
        AS ( SELECT
                    HFitUserMPINumber ,
                    HashCode
                    ,ROW_NUMBER( ) OVER( PARTITION BY  HFitUserMPINumber ,
                                                       HashCode
                    ORDER BY   HFitUserMPINumber , HashCode
                    ) AS DuplicateCount
               FROM ##Temp_SmallSteps
        )
        DELETE
        FROM CTE
          WHERE
                DuplicateCount > 1;
END;
GO
PRINT 'Executed proc_CT_EDW_SmallSteps_Temp_NoDups.sql';
GO
