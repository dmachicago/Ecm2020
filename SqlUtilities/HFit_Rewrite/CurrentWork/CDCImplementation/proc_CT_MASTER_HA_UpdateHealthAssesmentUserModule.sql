
GO
PRINT 'Executing proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule (@ModDate datetime)
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
   
       UPDATE BASEHA
      SET BASEHA.UserModuleItemId = HAUserModule.ItemID
        , BASEHA.UserModuleCodeName = HAUserModule.CodeName
        , BASEHA.HAModuleNodeGUID = HAUserModule.HAModuleNodeGUID
        , BASEHA.HAModuleScore = HAUserModule.HAModuleScore
        , BASEHA.ModulePreWeightedScore = HAUserModule.PreWeightedScore
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_HFit_HealthAssesmentUserModule AS HAUserModule
           ON BASEHA.UserStartedItemID = HAUserModule.HAStartedItemID
          --AND BASEHA.SVR = HAUserModule.SVR
          AND BASEHA.DBNAME = HAUserModule.DBNAME
		where HAUserModule.LastModifiedDate > @LastFullUpdateDate
		and (
		  --HAUserModule.CT_ItemID = 1 
		  HAUserModule.CT_CodeName = 1 
		  OR HAUserModule.CT_HAModuleNodeGUID = 1 
		  OR HAUserModule.CT_HAModuleScore = 1 
		  OR HAUserModule.CT_PreWeightedScore = 1 
		)

		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_UpdateHealthAssesmentUserModule.sql';
GO
