--drop index PI_EDW_HealthAssessment_IDs ON dbo.DIM_EDW_HealthAssessment
CREATE NONCLUSTERED INDEX PI_HA_IDS
  ON DIM_EDW_HealthAssessment 
	   (
			 UserStartedItemID
			 , HealthAssesmentUserStartedNodeGUID 
			 , UserGUID
			 , SiteGUID			 
			 , AccountCD			 
			 , HAModuleNodeGUID
			 , CMSNodeGuid			 
			 , HARiskCategoryNodeGUID
			 , UserRiskAreaItemID
			 , HARiskAreaNodeGUID
			 , UserQuestionItemID
			 , HAQuestionGuid
			 , HAQuestionNodeGUID
			 , UserAnswerItemID
			 , HAAnswerNodeGUID  
			 , CampaignNodeGUID
	   )
  INCLUDE (AccountID, UserModuleItemId, UserRiskCategoryItemID)

IF NOT EXISTS
(SELECT
        name
        FROM sys.indexes
        WHERE name = 'PI_EDW_HealthAssessment_NATKEY') 
    BEGIN
        CREATE INDEX PI_EDW_HealthAssessment_NATKEY ON dbo.DIM_EDW_HealthAssessment (
		  UserStartedItemID
		  , UserGUID
		  , PKHashCode
        ) 
    END;


IF NOT EXISTS
(SELECT
        name
        FROM sys.indexes
        WHERE name = 'temp_PI_EDW_HealthAssessment_NATKEY') 
    BEGIN
        CREATE INDEX temp_PI_EDW_HealthAssessment_NATKEY ON dbo.TEMP_EDW_HealthAssessment_DATA (
		  UserStartedItemID
		  , UserGUID
		  , PKHashCode
        ) 
    END;

--go
select top 100 * from [DIM_EDW_HealthAssessment]
where UserGUID = 'F805DB47-4F13-4BB1-B44C-E3C0B6691027'
--go

--alter table [DIM_EDW_HealthAssessment] add PKHashCode varchar(100) null ;
--alter table TEMP_EDW_HealthAssessment_DATA add PKHashCode varchar(100) null ;

UPDATE TEMP_EDW_HealthAssessment_DATA
       SET
           PKHashCode = HASHBYTES ( 'sha1' ,
			 ISNULL ( CAST ( UserStartedItemID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HealthAssesmentUserStartedNodeGUID  AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( SiteGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( AccountID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( AccountCD AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserModuleItemId AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HAModuleNodeGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( CMSNodeGuid AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserRiskCategoryItemID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HARiskCategoryNodeGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserRiskAreaItemID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HARiskAreaNodeGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserQuestionItemID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HAQuestionGuid AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HAQuestionNodeGUID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( UserAnswerItemID AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( HAAnswerNodeGUID   AS varchar (50)) , '-') 
			 + ISNULL ( CAST ( CampaignNodeGUID AS varchar (50)) , '-') 
			 )
 where PKHashCode is null
--where UserStartedItemId in (Select distinct top 20000 UserStartedItemId from dbo.DIM_EDW_HealthAssessment where PKHashCode is null)
GO
SELECT count(*) 
    FROM dbo.DIM_EDW_HealthAssessment
	   WHERE PKHashCode IS NULL;

GO
SELECT
	   COUNT ( *) as CNT
	   , UserStartedItemID
	   , UserGUID
	   , PKHashCode
	   FROM dbo.DIM_EDW_HealthAssessment
	   where PKHashCode is not null
	   GROUP BY
                UserStartedItemID
              , UserGUID
              , PKHashCode
        HAVING COUNT ( *) > 1 ;
GO

SELECT
       COUNT ( *) 
     ,UserStartedItemID
     , HealthAssesmentUserStartedNodeGUID
     , UserGUID
     , SiteGUID
     , AccountID
     , AccountCD
     , UserModuleItemId
     , HAModuleNodeGUID
     , CMSNodeGuid
     , HAModuleVersionID
     , UserRiskCategoryItemID
     , HARiskCategoryNodeGUID
     , HARiskCategoryVersionID
     , UserRiskAreaItemID
     , HARiskAreaNodeGUID
     , HARiskAreaVersionID
     , UserQuestionItemID
     , HAQuestionGuid
     , HAQuestionDocumentID
     , HAQuestionVersionID
     , HAQuestionNodeGUID
     , UserAnswerItemID
     , HAAnswerNodeGUID
     , CampaignNodeGUID
       FROM dbo.DIM_EDW_HealthAssessment
       --where [UserStartedItemID] = 92537
       GROUP BY
                UserStartedItemID
              , HealthAssesmentUserStartedNodeGUID
                --,[UserID]
              ,
                UserGUID
                --,[HFitUserMpiNumber]
              ,
                SiteGUID
              , AccountID
              , AccountCD
                --,[AccountName]
                --,[HAStartedDt]
                --,[HACompletedDt]
              ,
                UserModuleItemId
                --,[UserModuleCodeName]
              ,
                HAModuleNodeGUID
              , CMSNodeGuid
              , HAModuleVersionID
              , UserRiskCategoryItemID
                --,[UserRiskCategoryCodeName]
              ,
                HARiskCategoryNodeGUID
              , HARiskCategoryVersionID
              , UserRiskAreaItemID
                --,[UserRiskAreaCodeName]
              ,
                HARiskAreaNodeGUID
              , HARiskAreaVersionID
              , UserQuestionItemID
                --,[Title]
              ,
                HAQuestionGuid
                --,[UserQuestionCodeName]
              ,
                HAQuestionDocumentID
              , HAQuestionVersionID
              , HAQuestionNodeGUID
              , UserAnswerItemID
              , HAAnswerNodeGUID
              , CampaignNodeGUID
       --,[HACampaignID]   
       HAVING COUNT ( *) > 1;

select count(*)
    ,HAModuleNodeGUID
    ,HAQuestionGuid
    ,HAQuestionNodeGUID
    ,HARiskAreaNodeGUID
    ,HARiskCategoryNodeGUID
    ,HealthAssesmentUserStartedNodeGUID 
    ,SiteGUID
    ,UserAnswerItemID
    ,UserGUID
    ,UserModuleItemId
    ,UserQuestionItemID
    ,UserRiskAreaItemID
    ,UserRiskCategoryItemID
    ,UserStartedItemID
FROM dbo.DIM_EDW_HealthAssessment
group by
    HAModuleNodeGUID
    ,HAQuestionGuid
    ,HAQuestionNodeGUID
    ,HARiskAreaNodeGUID
    ,HARiskCategoryNodeGUID
    ,HealthAssesmentUserStartedNodeGUID 
    ,SiteGUID
    ,UserAnswerItemID
    ,UserGUID
    ,UserModuleItemId
    ,UserQuestionItemID
    ,UserRiskAreaItemID
    ,UserRiskCategoryItemID
    ,UserStartedItemID
having count(*) > 1
