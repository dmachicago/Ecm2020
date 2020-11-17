
GO
PRINT 'Executing proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate.sql';
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate') 
    BEGIN
        DROP PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate
    END;
GO

CREATE PROCEDURE proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate (@ModDate datetime)
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
      SET BASEHA.PointResults = HAUserQuestionGroupResults.PointResults
        , BASEHA.QuestionGroupCodeName = HAUserQuestionGroupResults.CodeName
	   , BASEHA.LastModifiedDate = @ModDate
      FROM BASE_MART_EDW_HealthAssesment AS BASEHA
          -- INNER JOIN
          -- TEMP_HA_Changes AS TD
          -- ON BASEHA.SVR = TD.SVR
          --AND BASEHA.DBNAME = TD.DBNAME
          --AND BASEHA.UserStartedItemID = TD.ItemID
           LEFT OUTER JOIN
           dbo.BASE_HFit_HealthAssesmentUserQuestionGroupResults AS HAUserQuestionGroupResults
           ON BASEHA.UserRiskAreaItemID = HAUserQuestionGroupResults.HARiskAreaItemID
          --AND BASEHA.SVR = HAUserQuestionGroupResults.SVR
          AND BASEHA.DBNAME = HAUserQuestionGroupResults.DBNAME
		AND HAUserQuestionGroupResults.LastModifiedDate > @LastFullUpdateDate
		--AND HAUserQuestionGroupResults.LastModifiedDate > '01-01-2016'
		and (
		    HAUserQuestionGroupResults.CT_PointResults = 1
		    OR HAUserQuestionGroupResults.CT_CodeName = 1 
		  )
--*************************************************************



		SET @iCnt = @@ROWCOUNT;
		return @iCnt;
END;

GO
PRINT 'Executed proc_CT_MASTER_HA_HealthAssesmentUserQuestionGroupResultsUpdate.sql';
GO
