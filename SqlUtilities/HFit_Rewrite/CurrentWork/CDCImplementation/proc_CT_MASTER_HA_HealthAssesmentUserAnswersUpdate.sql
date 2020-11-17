
GO
PRINT 'Executing proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate (@ModDate datetime)
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
      SET BASEHA.UserAnswerItemID = HAUserAnswers.ItemID
        , BASEHA.HAAnswerNodeGUID = HAUserAnswers.HAAnswerNodeGUID
        , BASEHA.HAAnswerVersionID = NULL
        , BASEHA.UserAnswerCodeName = HAUserAnswers.CodeName
        , BASEHA.HAAnswerValue = HAUserAnswers.HAAnswerValue
        , BASEHA.HAAnswerPoints = HAUserAnswers.HAAnswerPoints
        , BASEHA.UOMCode = HAUserAnswers.UOMCode
        --, BASEHA.ChangeType = TD.SYS_CHANGE_OPERATION
        , BASEHA.ItemCreatedWhen = CAST (HAUserAnswers.ItemCreatedWhen AS datetime) 
        , BASEHA.HAUserAnswers_ItemModifiedWhen = CAST (HAUserAnswers.ItemModifiedWhen AS datetime)
	   , BASEHA.ItemModifiedWhen = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           INNER JOIN
           dbo.BASE_HFit_HealthAssesmentUserAnswers AS HAUserAnswers
           ON BASEHA.UserQuestionItemID = HAUserAnswers.HAQuestionItemID
          --AND BASEHA.SVR = HAUserAnswers.SVR
          AND BASEHA.DBNAME = HAUserAnswers.DBNAME
		AND HAUserAnswers.LastModifiedDate >  @LastFullUpdateDate
		and (
			 HAUserAnswers.CT_HAAnswerNodeGUID = 1 
			 OR HAUserAnswers.CT_CodeName = 1 
			 OR HAUserAnswers.CT_HAAnswerValue = 1 
			 OR HAUserAnswers.CT_HAAnswerPoints = 1 
			 OR HAUserAnswers.CT_UOMCode = 1 
		)
    --*************************************************************
	SET @iCnt = @@ROWCOUNT;
	return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_HealthAssesmentUserAnswersUpdate.sql';
GO
