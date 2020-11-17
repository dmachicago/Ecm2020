

GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures AS CTCNT
             WHERE name = 'proc_EDW_CountDeletedHA') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_CountDeletedHA;
    END;
GO
CREATE PROC proc_EDW_CountDeletedHA
AS
BEGIN
    DECLARE
       @iCnt AS bigint = 0;

    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES CMS_UserSettings , NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES CMS_Site, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_Account, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HACampaign, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserAnswers, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestionGroupResults, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskArea, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    SET @iCnt = @iCnt + (SELECT
                                COUNT (*) 
                                FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted, NULL) AS CTCNT
                           WHERE SYS_CHANGE_OPERATION = 'D') ;
    print ('HA Deletes found: ' + cast(@iCnt as nvarchar(50)));
    RETURN @iCnt;
END;