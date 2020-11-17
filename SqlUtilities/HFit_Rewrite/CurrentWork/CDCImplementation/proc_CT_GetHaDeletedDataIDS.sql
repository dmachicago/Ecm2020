
GO
PRINT 'Creating proc_CT_GetHaDeletedDataIDS';
PRINT 'FROM proc_CT_GetHaDeletedDataIDS.sql';

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_CT_GetHaDeletedDataIDS' )
    BEGIN
        DROP PROCEDURE
             proc_CT_GetHaDeletedDataIDS;
    END;
GO
-- exec proc_CT_GetHaDeletedDataIDS
-- drop table #HA_DELETES
CREATE PROC proc_CT_GetHaDeletedDataIDS
AS
BEGIN

    CREATE TABLE #HA_DELETES (
                 TABLE_NAME varchar( 100 ) NULL ,
                 SYS_CHANGE_VERSION bigint NULL ,
                 SYS_CHANGE_CREATION_VERSION bigint NULL ,
                 SYS_CHANGE_OPERATION nchar( 1 ) NULL ,
                 SYS_CHANGE_COLUMNS varbinary( 4100 ) NULL ,
                 SYS_CHANGE_CONTEXT varbinary( 128 ) NULL ,
                 ClassID int NOT NULL );

    DECLARE
       @b AS bit = 0;

    INSERT INTO #HA_DELETES
    SELECT
           'CMS_Class' ,
           *
      FROM CHANGETABLE( CHANGES CMS_Class , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'CMS_Document' ,
           *
      FROM CHANGETABLE( CHANGES CMS_Document , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'CMS_Site' ,
           *
      FROM CHANGETABLE( CHANGES CMS_Site , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'CMS_Tree' ,
           *
      FROM CHANGETABLE( CHANGES CMS_Tree , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from view_EDW_HealthAssesment_CT
    --select top 100 * from CMS_User
    --delete from CMS_User where 
    SELECT
           'CMS_User' ,
           *
      FROM CHANGETABLE( CHANGES CMS_User , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'CMS_UserSettings' ,
           *
      FROM CHANGETABLE( CHANGES CMS_UserSettings , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'CMS_UserSite' ,
           *
      FROM CHANGETABLE( CHANGES CMS_UserSite , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'COM_SKU' ,
           *
      FROM CHANGETABLE( CHANGES COM_SKU , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
--update HFit_Account set  AccountName = 'TrustMark' where AccountName = 'TrustMarl'
    SELECT
           'HFit_Account' ,
           *
      FROM CHANGETABLE( CHANGES HFit_Account , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HACampaign
    --update HFit_HACampaign set SocialProofID = -1 where SocialProofID is null
    SELECT
           'HFit_HACampaign' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HACampaign , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssesmentMatrixQuestion' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentMatrixQuestion , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssesmentMultipleChoiceQuestion' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentMultipleChoiceQuestion , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HealthAssesmentUserAnswers
    --update HFit_HealthAssesmentUserAnswers set HAAnswerValue = null where UserID = 662 and HAAnswerValue is null
    SELECT
           'HFit_HealthAssesmentUserAnswers' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserAnswers , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HealthAssesmentUserModule
    --delete from HFit_HealthAssesmentUserModule where ItemID = 1529
    SELECT
           'HFit_HealthAssesmentUserModule' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserModule , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HealthAssesmentUserQuestion
    --delete from HFit_HealthAssesmentUserModule where ItemID = 15054
    SELECT
           'HFit_HealthAssesmentUserQuestion' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestion , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssesmentUserQuestionGroupResults' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserQuestionGroupResults , NULL )AS CT
    --where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssesmentUserRiskArea' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskArea , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssesmentUserRiskCategory' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserRiskCategory , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HealthAssesmentUserStarted
    --delete from HFit_HealthAssesmentUserStarted where itemid = 823
    SELECT
           'HFit_HealthAssesmentUserStarted' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssesmentUserStarted , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    --select top 100 * from HFit_HealthAssessment
    SELECT
           'HFit_HealthAssessment' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssessment , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_HealthAssessmentFreeForm' ,
           *
      FROM CHANGETABLE( CHANGES HFit_HealthAssessmentFreeForm , NULL )AS CT       ----where SYS_CHANGE_OPERATION = 'D'
    UNION ALL
    SELECT
           'HFit_LKP_EDW_RejectMPI' ,
           *
      FROM CHANGETABLE( CHANGES HFit_LKP_EDW_RejectMPI , NULL )AS CT;       ----where SYS_CHANGE_OPERATION = 'D';

    DECLARE
                                                                               @NbrUpdates AS int = @@ROWCOUNT;
    DECLARE
       @iInsert AS int = 0;
    DECLARE
       @iUpdate AS int = 0;
    DECLARE
       @iDel AS int = 0;

    IF @NbrUpdates = 0
        BEGIN
            PRINT 'No changes found';
            SET @b = 0;
        END;
    ELSE
        BEGIN
            SET @iInsert = ( SELECT
                                    COUNT ( * )
                               FROM #HA_DELETES
                               WHERE SYS_CHANGE_OPERATION = 'I' );
            SET @iUpdate = ( SELECT
                                    COUNT ( * )
                               FROM #HA_DELETES
                               WHERE SYS_CHANGE_OPERATION = 'U' );
            SET @iDel = ( SELECT
                                 COUNT ( * )
                            FROM #HA_DELETES
                            WHERE SYS_CHANGE_OPERATION = 'D' );
            PRINT CAST ( @NbrUpdates AS nvarchar ( 50 )) + ' Changes found';
            PRINT CAST ( @iInsert AS nvarchar ( 50 )) + ' Inserts found';
            PRINT CAST ( @iUpdate AS nvarchar ( 50 )) + ' Updates found';
            PRINT CAST ( @iDel AS nvarchar ( 50 )) + ' Deletes found';
            SET @b = 1;
            IF @iDel > 0
                BEGIN
                    SET @b = 2;
                END;
        END;
    SELECT
           *
      FROM #HA_DELETES;
END;
GO
PRINT 'Created proc_CT_GetHaDeletedDataIDS';
GO