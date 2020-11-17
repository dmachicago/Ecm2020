
IF NOT EXISTS (SELECT
                      OBJECT_ID ('tempdb..##ProcFlow')) 
    BEGIN
        CREATE TABLE ##ProcFlow (
                     Name NVARCHAR (250) 
                   , type NVARCHAR (250) 
                   , updated NVARCHAR (50) 
                   , selected NVARCHAR (50) 
                   , [column] NVARCHAR (250) 
                   , ParentObj NVARCHAR (250) 
                   , ChildObj NVARCHAR (250) 
                   , ParentLevel INT
                   , ChildLevel INT) 
    END;

DECLARE
     @TempFlow AS TABLE (
                        Name NVARCHAR (250) 
                      , type NVARCHAR (250) 
                      , updated NVARCHAR (50) 
                      , selected NVARCHAR (50) 
                      , [column] NVARCHAR (250)) ;
DECLARE
     @TblName AS NVARCHAR (250) = 'proc_CreateBaseTable';

INSERT INTO @TempFlow
EXEC sp_depends proc_CreateBaseTable;

SELECT
       *
FROM @TempFlow;