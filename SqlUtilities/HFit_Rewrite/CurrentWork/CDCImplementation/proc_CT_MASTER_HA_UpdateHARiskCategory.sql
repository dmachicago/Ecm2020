
GO
PRINT 'Executing proc_CT_MASTER_HA_UpdateHARiskCategory.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_UpdateHARiskCategory') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_UpdateHARiskCategory;
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_UpdateHARiskCategory (@ModDate datetime)
AS
BEGIN

    DECLARE
           @LastFullUpdateDate datetime
         , @iCnt bigint = 9;

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
      SET BASEHA.UserRiskCategoryItemID = HARiskCategory.ItemID
        , BASEHA.UserRiskCategoryCodeName = HARiskCategory.CodeName
        , BASEHA.HARiskCategoryNodeGUID = HARiskCategory.HARiskCategoryNodeGUID
        , BASEHA.HARiskCategoryScore = HARiskCategory.HARiskCategoryScore
        , BASEHA.RiskCategoryPreWeightedScore = HARiskCategory.PreWeightedScore
        , BASEHA.HARiskCategory_ItemModifiedWhen = HARiskCategory.ItemModifiedWhen
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_HFit_HealthAssesmentUserRiskCategory AS HARiskCategory
           ON BASEHA.UserModuleItemId = HARiskCategory.HAModuleItemID
          --AND BASEHA.SVR = HARiskCategory.SVR
          AND BASEHA.DBNAME = HARiskCategory.DBNAME
		and HARiskCategory.LastModifiedDate > @LastFullUpdateDate
		and (HARiskCategory.CT_CodeName = 1 
			   OR HARiskCategory.CT_HARiskCategoryNodeGUID = 1 
			   OR HARiskCategory.CT_HARiskCategoryScore = 1 
			   OR HARiskCategory.CT_PreWeightedScore = 1 
		) ;

    SET @iCnt = @@ROWCOUNT;
    RETURN @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_UpdateHARiskCategory.sql';
GO
