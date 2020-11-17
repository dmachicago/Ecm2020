--HFit_HealthAssesmentUserRiskCategory
--CREATE INDEX [CI_HFit_HealthAssesmentUserRiskCategory] ON [dbo].[HFit_HealthAssesmentUserRiskCategory]
--(
--	ItemID include(ItemModifiedWhen, HARiskCategoryScore, PreWeightedScore,HARiskCategoryNodeGUID)
--)

GO

PRINT 'Creating proc_Stage_EDW_Views.sql';
GO

IF EXISTS ( SELECT
                   name
              FROM sys.procedures
              WHERE name = 'proc_Stage_EDW_Views' )
    BEGIN
        DROP PROCEDURE
             proc_Stage_EDW_Views
    END;
GO
CREATE PROCEDURE proc_Stage_EDW_Views
AS
BEGIN

    IF EXISTS ( SELECT
                       name
                  FROM sys.tables
                  WHERE name = 'STAGED_View_HFit_HealthAssessment_Joined' )
        BEGIN
            DROP TABLE
                 STAGED_View_HFit_HealthAssessment_Joined
        END;

    SELECT
           * INTO
                  STAGED_View_HFit_HealthAssessment_Joined
      FROM View_HFit_HealthAssessment_Joined;
    CREATE CLUSTERED INDEX PI_STAGED_View_HFit_HealthAssessment_Joined ON dbo.STAGED_View_HFit_HealthAssessment_Joined
    (
    DocumentID
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY];

    IF EXISTS ( SELECT
                       name
                  FROM sys.tables
                  WHERE name = 'STAGED_View_HFit_HACampaign_Joined' )
        BEGIN
            DROP TABLE
                 STAGED_View_HFit_HACampaign_Joined
        END;

    SELECT
           * INTO
                  STAGED_View_HFit_HACampaign_Joined
      FROM View_HFit_HACampaign_Joined
      WHERE DocumentCulture = 'en-US';
    CREATE CLUSTERED INDEX PI_STAGED_View_HFit_HACampaign_Joined ON dbo.STAGED_View_HFit_HACampaign_Joined
    (
    NodeGUID , NodeSiteID , DocumentCulture
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY];

    IF EXISTS ( SELECT
                       name
                  FROM sys.tables
                  WHERE name = 'STAGED_View_EDW_HealthAssesmentQuestions' )
        BEGIN
            DROP TABLE
                 STAGED_View_EDW_HealthAssesmentQuestions
        END;

    SELECT
           * INTO
                  STAGED_View_EDW_HealthAssesmentQuestions
      FROM View_EDW_HealthAssesmentQuestions
      WHERE documentculture = 'en-US';
    CREATE CLUSTERED INDEX PI_STAGED_View_EDW_HealthAssesmentQuestions ON dbo.STAGED_View_EDW_HealthAssesmentQuestions
    (
    NodeGUID , DocumentCulture
    )WITH ( PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY];
END;

GO
PRINT 'Created proc_Stage_EDW_Views.sql';
GO
