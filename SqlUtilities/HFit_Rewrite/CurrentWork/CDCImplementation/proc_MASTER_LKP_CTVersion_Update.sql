
GO
PRINT 'Executing proc_MASTER_LKP_CTVersion_Update.sql';
GO

IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_MASTER_LKP_CTVersion_Update') 
    BEGIN
	   PRINT 'Replacing proc_MASTER_LKP_CTVersion_Update.sql';
        DROP PROCEDURE
             proc_MASTER_LKP_CTVersion_Update
    END;

GO

/*
select * from MASTER_LKP_CTVersion
truncate table MASTER_LKP_CTVersion

*/

CREATE PROCEDURE proc_MASTER_LKP_CTVersion_Update (@TableName AS NVARCHAR (100) , @ProcID AS NVARCHAR (100) , @VerNO AS BIGINT) 
AS
BEGIN
    
    DECLARE @iCnt AS INT = 0;
    SET @iCnt = (SELECT
                        COUNT (*) 
                        FROM MASTER_LKP_CTVersion
                        WHERE ProcedureID = @ProcID
                          AND SYS_CHANGE_VERSION = @VerNO);

    --If the version (@Verno) already exist, a -1 is returned.
    IF @iCnt > 0
        BEGIN
            RETURN -1
        END;
    --If the version (@Verno) does not exist, it is added to the master lookup.
    INSERT INTO MASTER_LKP_CTVersion (
           TableName
         , ProcedureID
         , SYS_CHANGE_VERSION) 
    VALUES (
           @TableName, @ProcID, @VerNO) ;

END;
GO
PRINT 'Executed proc_MASTER_LKP_CTVersion_Update.sql';
GO