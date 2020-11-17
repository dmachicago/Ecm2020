
GO
PRINT 'Executing proc_CT_MASTER_HA_AccountUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_AccountUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_AccountUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_AccountUpdate (@ModDate datetime)
AS
BEGIN
    
    --BEGIN TRY
    --    DROP TABLE ##TEMP_HA_SiteData;
    --END TRY
    --BEGIN CATCH
    --    EXEC printImmediate 'Loading Temp Site Data';
    --END CATCH;
    

    DECLARE
           @LastFullUpdateDate datetime,
		 @iCnt bigint = 9 ;

    SET @LastFullUpdateDate = (SELECT MAX (LastUpdate)
                                 FROM CT_MASTER_HA_UpdateHistory) ;

    IF @LastFullUpdateDate IS NULL
        BEGIN
            SET @LastFullUpdateDate = CAST ('01-01-1800' AS datetime) ;
            INSERT INTO CT_MASTER_HA_UpdateHistory (LastUpdate) 
            VALUES
                   (@LastFullUpdateDate) ;
        END;

    UPDATE BASEHA
      SET BASEHA.AccountID = ACCT.AccountID
        , BASEHA.AccountCD = ACCT.AccountCD
        , BASEHA.AccountName = ACCT.AccountName
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
           INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
          -- INNER JOIN
           ##TEMP_HA_SiteData AS S
		 --BASE_CMS_Site AS S
           ON BASEHA.UserID = S.UserID
          AND BASEHA.SiteID = S.SiteID
          --AND BASEHA.SVR = S.SVR
          AND BASEHA.DBNAME = S.DBNAME
           INNER JOIN
           dbo.BASE_HFit_Account AS ACCT
           ON S.SiteID = ACCT.SiteID
          --AND BASEHA.SVR = ACCT.SVR
          AND BASEHA.DBNAME = ACCT.DBNAME
    where ACCT.LastModifiedDate > @LastFullUpdateDate
    and (ACCT.CT_AccountID = 1 or ACCT.CT_AccountCD = 1 or ACCT.CT_AccountName = 1)

		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_AccountUpdate.sql';
GO
