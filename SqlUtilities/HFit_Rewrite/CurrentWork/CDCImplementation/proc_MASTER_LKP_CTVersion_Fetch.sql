
GO
PRINT 'EXecuting proc_MASTER_LKP_CTVersion_Fetch.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE
                  name = 'proc_MASTER_LKP_CTVersion_Fetch') 
    BEGIN
        DROP PROCEDURE
             proc_MASTER_LKP_CTVersion_Fetch;
    END;

GO
-- select * from MASTER_LKP_CTVersion
-- truncate table MASTER_LKP_CTVersion
CREATE PROCEDURE proc_MASTER_LKP_CTVersion_Fetch (
       @TableName AS NVARCHAR (100) 
     , @ProcID AS NVARCHAR (100)) 
AS
BEGIN

    DECLARE
           @iCnt AS BIGINT = 0;
    SET @iCnt = (SELECT
                        MAX (SYS_CHANGE_VERSION) 
                        FROM MASTER_LKP_CTVersion
                        WHERE
                        ProcedureID = @ProcID) ;

    IF @iCnt IS NULL
        BEGIN
            SET @iCnt = 0
        END;

    RETURN @iCnt;

END;
GO
PRINT 'Executed proc_MASTER_LKP_CTVersion_Fetch.sql';
GO