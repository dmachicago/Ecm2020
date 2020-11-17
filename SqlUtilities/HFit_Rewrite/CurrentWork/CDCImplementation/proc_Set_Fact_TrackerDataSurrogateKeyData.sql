
GO
PRINT 'Executing proc_Set_Fact_TrackerDataSurrogateKeyData.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_Set_Fact_TrackerDataSurrogateKeyData') 
    BEGIN
        DROP PROCEDURE
             proc_Set_Fact_TrackerDataSurrogateKeyData
    END;
GO
-- use KenticoCMS_Datamart_2
-- exec proc_Set_Fact_TrackerDataSurrogateKeyData
CREATE PROCEDURE proc_Set_Fact_TrackerDataSurrogateKeyData
AS
BEGIN
    set NOCOUNT on ;
    declare @iCnt as bigint = 0 ; 

    print 'Checking Fact_TrackerData for Orphan records.' ;

    IF NOT EXISTS (SELECT
                          column_name
                   FROM INFORMATION_SCHEMA.COLUMNS
                   WHERE
                          COLUMN_NAME = 'SurrogateKey_CMS_User' AND
                          table_name = 'FACT_TrackerData') 
        BEGIN
            ALTER TABLE FACT_TrackerData
            ADD
                        SurrogateKey_CMS_User BIGINT NULL;
        END;

    UPDATE T1
        SET
            T1.SurrogateKey_CMS_User = T2.SurrogateKey_CMS_User
    FROM FACT_TrackerData T1
         INNER JOIN BASE_CMS_User T2
         ON
            T1.SVR = T2.SVR AND
           T1.DBNAME = T2.DBNAME AND
           T1.UserID = T2.UserID
    WHERE
		  T1.SurrogateKey_CMS_User IS NULL;

    set @iCnt = @@ROWCOUNT ;

    INSERT INTO MART_Orphan_Rec_Log (
                   ParentTableName
                 , TableName
                 , LogText
                 , OrphanCnt) 
            VALUES ('BASE_CMS_User' , 'FACT_TrackerData' , 'Orphan Records' , @iCnt) ;
            PRINT 'Orphan Count: ' + cast(@iCnt as nvarchar(50)) ;

    EXEC ScriptAllForeignKeyConstraints ;

    DECLARE
           @i AS INT = (
                       SELECT
                              count (*) 
                       FROM ##FK_Constraints
                       WHERE
                              ForeignKeyNAME = 'FK_FACT_TrackerData_BASE_CMS_User'
                       );

    IF @i = 0
        BEGIN
            ALTER TABLE dbo.FACT_TrackerData
            ADD
                        CONSTRAINT FK_FACT_TrackerData_BASE_CMS_User FOREIGN KEY (SurrogateKey_CMS_User) 
                        REFERENCES dbo.BASE_CMS_User (
                                   SurrogateKey_CMS_User) 
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
        END;
    set NOCOUNT off ;
END;
GO
PRINT 'Executed proc_Set_Fact_TrackerDataSurrogateKeyData.sql';
GO
