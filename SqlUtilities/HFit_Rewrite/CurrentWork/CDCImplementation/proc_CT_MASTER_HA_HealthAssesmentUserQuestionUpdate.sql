
GO
PRINT 'Executing proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate (@ModDate datetime)
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
      SET BASEHA.UserQuestionItemID = HAUserQuestion.ItemID
        , BASEHA.HAQuestionGuid = HAUserQuestion.HAQuestionNodeGUID
        , BASEHA.UserQuestionCodeName = HAUserQuestion.CodeName
        , BASEHA.HAQuestionNodeGUID = HAUserQuestion.HAQuestionNodeGUID
        , BASEHA.HAQuestionScore = HAUserQuestion.HAQuestionScore
        , BASEHA.QuestionPreWeightedScore = HAUserQuestion.PreWeightedScore
        , BASEHA.IsProfessionallyCollected = HAUserQuestion.IsProfessionallyCollected
        , BASEHA.HAUserQuestion_ItemModifiedWhen = CAST (HAUserQuestion.ItemModifiedWhen AS datetime)
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_HFit_HealthAssesmentUserQuestion AS HAUserQuestion
           ON BASEHA.UserRiskAreaItemID = HAUserQuestion.HARiskAreaItemID
          --AND BASEHA.SVR = HAUserQuestion.SVR
          AND BASEHA.DBNAME = HAUserQuestion.DBNAME
		AND  (
			 HAUserQuestion.CT_HAQuestionNodeGUID = 1
			 OR HAUserQuestion.CT_CodeName = 1
			 OR HAUserQuestion.CT_HAQuestionNodeGUID = 1
			 OR HAUserQuestion.CT_HAQuestionScore = 1
			 OR HAUserQuestion.CT_PreWeightedScore = 1
			 OR HAUserQuestion.CT_IsProfessionallyCollected = 1
		  )
		and HAUserQuestion.LastModifiedDate > @ModDate ;
	--*************************************************************
	SET @iCnt = @@ROWCOUNT;
	return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_HealthAssesmentUserQuestionUpdate.sql';
GO
