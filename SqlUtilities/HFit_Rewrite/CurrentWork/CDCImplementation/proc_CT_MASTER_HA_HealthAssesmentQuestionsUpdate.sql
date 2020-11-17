
GO
PRINT 'Executing proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate (@ModDate datetime)
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
		  SET BASEHA.Title = HAQuestionsView.Title
		  , BASEHA.DocumentCulture_HAQuestionsView = HAQuestionsView.DocumentCulture
		  , BASEHA.LastModifiedDate = @ModDate
	   FROM BASE_MART_EDW_HealthAssesment AS BASEHA
		  --INNER JOIN
		  --TEMP_HA_Changes AS TD
		  --ON BASEHA.SVR = TD.SVR
		  --AND BASEHA.DBNAME = TD.DBNAME
		  --AND BASEHA.UserStartedItemID = TD.ItemID
		  INNER JOIN
		  dbo.BASE_View_EDW_HealthAssesmentQuestions AS HAQuestionsView
		  ON BASEHA.HAQuestionNodeGUID = HAQuestionsView.NodeGUID
		  --AND BASEHA.SVR = HAQuestionsView.SVR
		  AND BASEHA.DBNAME = HAQuestionsView.DBNAME
		  AND HAQuestionsView.DocumentCulture = 'en-US'
		  AND HAQuestionsView.DocumentModifiedWhen > @LastFullUpdateDate
		  AND (BASEHA.Title != HAQuestionsView.Title
				OR BASEHA.DocumentCulture_HAQuestionsView != HAQuestionsView.DocumentCulture 
		  )
	   --*************************************************************


		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_HealthAssesmentQuestionsUpdate.sql';
GO
