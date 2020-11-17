SET NOCOUNT ON;

DECLARE @DBNAME AS nvarchar (100) = DB_NAME () ;
DECLARE @SVR AS nvarchar (100) = @@SERVERNAME;

DROP INDEX NONHARISKCATEGORYITEMID ON dbo.HFit_HealthAssesmentUserRiskArea;
GO

CREATE NONCLUSTERED INDEX NONHARISKCATEGORYITEMID ON dbo.HFit_HealthAssesmentUserRiskArea
(
ItemID ASC,
HARiskCategoryItemID ASC,
UserID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY];
GO

IF NOT EXISTS (SELECT
                      name
                      FROM sys.indexes
                      WHERE name = 'CI_EDW_HEALTHASSESMENT_TEMID_TEMP') 
    BEGIN

        CREATE NONCLUSTERED INDEX CI_EDW_HEALTHASSESMENT_TEMID_TEMP ON dbo.HFit_HealthAssesmentUserRiskCategory
        (
        ItemID ASC
        , UserID ASC
        , HAModuleItemID ASC
        , HARiskCategoryScore
        , CodeName) ;
    END;

IF OBJECT_ID ('tempdb.dbo.#tMultipleRC') IS NOT NULL
    BEGIN
        DROP TABLE
             #tMultipleRC;
    END;
--select * from View_HFit_ProfessionallyCollectedBiometrics where UserID = 91639
-- drop table #tMultipleRC
SELECT TOP 100000
       us.UserID
     , u.UserName
     , us.ItemID AS UserStartedItemId
     , us.HACampaignNodeGUID AS HACampaignNodeGuid
     , rc.CodeName
     , rc.HAModuleItemID
--, COUNT (DISTINCT rc.HARiskCategoryScore) AS CountDistinctCategoryScore
INTO
     #tMultipleRC
       FROM
           dbo.HFit_HealthAssesmentUserStarted AS us
               INNER JOIN dbo.HFit_HealthAssesmentUserModule AS um WITH (nolock) 
                   ON um.HAStartedItemID = us.ItemID
                  AND um.UserID = us.UserID
                  AND um.CodeName = 'Biometrics' --and um.CodeName = 'Biometrics'
               INNER JOIN dbo.HFit_HealthAssesmentUserRiskCategory AS rc WITH (nolock) 
                   ON rc.HAModuleItemID = um.ItemID
                  AND rc.UserID = um.UserID
               INNER JOIN dbo.HFit_HealthAssesmentUserRiskArea AS ra WITH (nolock) 
                   ON ra.HARiskCategoryItemID = rc.ItemID
                  AND ra.UserID = rc.UserID
               INNER JOIN hfit_healthassesmentUserQuestion AS uq WITH (nolock) 
                   ON uq.HARiskAreaItemID = ra.ItemID
                  AND uq.UserID = ra.UserID
               INNER JOIN dbo.HFit_HealthAssesmentUserAnswers AS ua WITH (nolock) 
                   ON ua.HAQuestionItemID = uq.ItemID
                  AND ua.UserID = uq.UserID
               INNER JOIN CMS_User AS u WITH (nolock) 
                   ON u.UserID = us.UserID ;

WITH CTE (
     UserID
   , UserName
   , ItemID
   , HACampaignNodeGUID
   , CodeName
   , HAModuleItemID, DuplicateCount) 
    AS (
    SELECT
           UserID
         , UserName
         , UserStartedItemId
         , HACampaignNodeGuid
         , CodeName
         , HAModuleItemID
         , ROW_NUMBER () OVER ( PARTITION BY UserName
                                           , UserStartedItemId
           ORDER BY UserName, UserStartedItemId) AS DuplicateCount
           FROM #tMultipleRC
    ) 
    DELETE
    FROM CTE
    WHERE
          DuplicateCount < 2;

declare @iDel as int = (select count(*) from #tMultipleRC) ;
print 'Duplicate Count: ' + cast(@iDel  as nvarchar(50)) ;

IF EXISTS (SELECT
                  name
                  FROM sys.indexes
                  WHERE name = 'CI_EDW_HEALTHASSESMENT_TEMID_TEMP') 
    BEGIN
        DROP INDEX CI_EDW_HEALTHASSESMENT_TEMID_TEMP ON dbo.HFit_HealthAssesmentUserRiskCategory;
    END;

DECLARE @iCnt AS int = @@ROWCOUNT;
PRINT 'TOTAL ROWS: ' + CAST (@iCnt AS nvarchar (50)) ;