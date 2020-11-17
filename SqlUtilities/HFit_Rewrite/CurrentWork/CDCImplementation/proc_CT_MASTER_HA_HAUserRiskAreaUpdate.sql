
GO
PRINT 'Executing proc_CT_MASTER_HA_HAUserRiskAreaUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_HAUserRiskAreaUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_HAUserRiskAreaUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_HAUserRiskAreaUpdate (@ModDate datetime)
AS
BEGIN
    
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

--*************************************************************
    UPDATE BASEHA
      SET BASEHA.UserRiskAreaItemID = HAUserRiskArea.ItemID
        , BASEHA.UserRiskAreaCodeName = HAUserRiskArea.CodeName
        , BASEHA.HARiskAreaNodeGUID = HAUserRiskArea.HARiskAreaNodeGUID
        , BASEHA.HARiskAreaScore = HAUserRiskArea.HARiskAreaScore
        , BASEHA.RiskAreaPreWeightedScore = HAUserRiskArea.PreWeightedScore
        , BASEHA.HAUserRiskArea_ItemModifiedWhen = CAST (HAUserRiskArea.ItemModifiedWhen AS datetime)
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- --ON BASEHA.SVR = TD.SVR
          --on BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_HFit_HealthAssesmentUserRiskArea AS HAUserRiskArea
           ON BASEHA.UserRiskCategoryItemID = HAUserRiskArea.HARiskCategoryItemID
		 and BASEHA.HARiskAreaNodeGUID = HAUserRiskArea.HARiskAreaNodeGUID
          --AND BASEHA.SVR = HAUserRiskArea.SVR
          AND BASEHA.DBNAME = HAUserRiskArea.DBNAME
		AND HAUserRiskArea.LastModifiedDate > @LastFullUpdateDate
		and (HAUserRiskArea.CT_CodeName = 1 
			OR HAUserRiskArea.CT_HARiskAreaScore = 1 
			OR HAUserRiskArea.CT_PreWeightedScore = 1 
		)
--*************************************************************


		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_HAUserRiskAreaUpdate.sql';
GO
