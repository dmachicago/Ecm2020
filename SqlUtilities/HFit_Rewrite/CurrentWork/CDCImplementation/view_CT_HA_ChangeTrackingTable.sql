
GO
PRINT 'Creating view_CT_HA_ChangeTrackingTable.sql';

GO
IF EXISTS ( SELECT
                   name
              FROM sys.views
              WHERE name = 'view_CT_HA_ChangeTrackingTable' )
    BEGIN
        DROP view 
             view_CT_HA_ChangeTrackingTable
    END;
GO

--select * from view_CT_HA_ChangeTrackingTable
--select * from view_CT_HA_ChangeTrackingTable where SYS_CHANGE_VERSION between 18 and 22
CREATE view view_CT_HA_ChangeTrackingTable 
AS
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserAnswers' AS TBL ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserAnswers , null )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_Class' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_Class , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_Document' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_Document , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_Site' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_Site , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_Tree' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_Tree , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_User' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_User , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_UserSettings' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_UserSettings , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'CMS_UserSite' ,
           *
      FROM CHANGETABLE( CHANGES dbo.CMS_UserSite , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'COM_SKU' ,
           *
      FROM CHANGETABLE( CHANGES dbo.COM_SKU , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_Account' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_Account , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HACampaign' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HACampaign , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentMatrixQuestion' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentMatrixQuestion , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentMultipleChoiceQuestion' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentMultipleChoiceQuestion , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserAnswers' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserAnswers , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserModule' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserModule , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserQuestion' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserQuestion , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserQuestionGroupResults' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserQuestionGroupResults , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserRiskArea' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserRiskArea , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserRiskCategory' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserRiskCategory , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssesmentUserStarted' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssesmentUserStarted , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssessment' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssessment , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_HealthAssessmentFreeForm' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_HealthAssessmentFreeForm , NULL )AS CT
    UNION
    SELECT
           @@SERVERNAME AS SVR ,
           'HFit_LKP_EDW_RejectMPI' ,
           *
      FROM CHANGETABLE( CHANGES dbo.HFit_LKP_EDW_RejectMPI , NULL )AS CT;


GO
PRINT 'Created view_CT_HA_ChangeTrackingTable';
GO

