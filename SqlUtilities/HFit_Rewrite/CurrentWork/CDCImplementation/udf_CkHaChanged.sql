
GO
PRINT 'Creating function udf_CkUserTrackerHasChanged.';
PRINT 'FROM udf_CkUserTrackerHasChanged.sql';
GO
IF EXISTS (SELECT
              *
                  FROM   sys.objects
                  WHERE
                  object_id = OBJECT_ID (N'[dbo].[udf_CkUserTrackerHasChanged]') 
              AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT')) 
    BEGIN
        DROP FUNCTION
           dbo.udf_CkUserTrackerHasChanged
    END;
GO
/*
declare @iChg as int = (select dbo.udf_CkUserTrackerHasChanged ()) ;
print @iChg;
*/
CREATE FUNCTION udf_CkUserTrackerHasChanged ()
                --@TF bit) 
RETURNS int
AS
BEGIN

/*
    If a 0 is returned, NO updates were found.
    If a 1 is returned, updates were found.
    If a 2 is returned, deletes were found.
*/

    DECLARE
           @UpdatesFound AS TABLE
           (
   chgFlg nvarchar (10) NULL) ;

    DECLARE
           @b AS int = 0;

    INSERT INTO @UpdatesFound (
       chgFlg)    
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Class, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Document, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Site, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES COM_SKU, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_Account, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HACampaign, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserAnswers, NULL) AS CT
	   UNION ALL
	   
Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestionGroupResults, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskArea, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory, NULL) AS CT

	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT
	   UNION ALL
	   Select distinct SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_LKP_EDW_RejectMPI, NULL) AS CT ;

    DECLARE
           @iDel AS int = 0;
    DECLARE
           @iUpdt AS int = 0;

    SET @iUpdt = (SELECT
                     COUNT (*) 
                         FROM @UpdatesFound);
    SET @iDel = (SELECT
                    COUNT (*) 
                        FROM @UpdatesFound
                        WHERE chgFlg = 'D');

    IF @iUpdt > 0
        BEGIN
            SET @b = 1;
        END
    ELSE
        BEGIN
            SET @b = 0;
        END;

    IF @iDel > 0
        BEGIN
            SET @b = 2
        END;

    RETURN @b;

END;
GO
PRINT 'Created function udf_CkUserTrackerHasChanged.';
PRINT 'FROM udf_CkUserTrackerHasChanged.sql';
GO
