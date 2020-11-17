

GO
PRINT 'Processing: view_EDW_HealthAssessmentDefinition_CT ' + CAST (GETDATE () AS nvarchar (50)) ;
GO

/*
select count(*), HashCode 
from view_EDW_HealthAssessmentDefinition_CT
group by HashCode 
having count(*) > 1

select * from view_EDW_HealthAssessmentDefinition_CT
select top 100 lastModifiedDate,* from view_EDW_HealthAssessmentDefinition_CT
select count(*) from view_EDW_HealthAssessmentDefinition_CT
select count(*) from view_EDW_HealthAssessmentDefinition_CT
--RCDocPubVerID
Select * from HFit_HealthAssesmentMultipleChoiceQuestion where HealthAssesmentMultipleChoiceQuestionID = 495
update HFit_HealthAssesmentMultipleChoiceQuestion set AllowMultiSelect = -1  where HealthAssesmentMultipleChoiceQuestionID = 495
update HFit_HealthAssesmentMultipleChoiceQuestion set AllowMultiSelect = 0  where HealthAssesmentMultipleChoiceQuestionID = 495

select * 
into STAGED_EDW_HealthAssessmentDefinition
from view_EDW_HealthAssessmentDefinition_CT
where
CHANGED_FLG IS NOT NULL

PK: SiteGUID,ModDocGuid,RCDocumentGUID,RADocumentGuid,QuesDocumentGuid,AnsDocumentGuid,CmsTreeNodeGuid,HANodeGUID

select count(*) SiteGUID,ModDocGuid,RCDocumentGUID,RADocumentGuid,QuesDocumentGuid,AnsDocumentGuid,CmsTreeNodeGuid,HANodeGUID 
from view_EDW_HealthAssessmentDefinition_CT
group by SiteGUID,ModDocGuid,RCDocumentGUID,RADocumentGuid,QuesDocumentGuid,AnsDocumentGuid,CmsTreeNodeGuid,HANodeGUID
having count(*)  >1

*/

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
             WHERE TABLE_NAME = 'view_EDW_HealthAssessmentDefinition_CT') 
    BEGIN
        DROP VIEW
             view_EDW_HealthAssessmentDefinition_CT;
    END;
GO

/*
select * 
into Staging_EDW_HealthAssesmentDeffinition
from view_EDW_HealthAssessmentDefinition_CT
select * from Staging_EDW_HealthAssesmentDeffinition
*/

--**************************************************************************************************************
--NOTE: The column DocumentModifiedWhen comes from the CMS_TREE join - it was left 
--		unchanged when other dates added for the Last Mod Date additions. 
--		Therefore, the 'ChangeType' was left dependent upon this date only. 09.12.2014 (wdm)
--*****************************************************************************************************************************************************
--Test Queries:
--select * from view_EDW_HealthAssessmentDefinition_CT where AnsDocumentGuid is not NULL
--Changes:
--WDM - 6/25/2014
--Query was returning a NULL dataset. Found that it is being caused by the AccountCD join.
--Worked with Shane to discover the CMS Tree had been modified.
--Modified the code so that reads it reads the CMS tree correctly - working.
--7/14/2014 1:29 time to run - 79024 rows - DEV
--7/14/2014 0:58 time to run - 57472 rows - PROD1
--7/15/2014 - Query was returning NodeName of 'Campaigns' only
--	Found the issue in view View_HFit_HACampaign_Joined. Documented the change in the view.
--7/16/2014 - Full Select: Using a DocumentModifiedWhen filter 00:17:28 - Record Cnt: 793,520
--8/7/2014 - Executed in DEV with GUID changes and returned 1.13M Rows in 23:14.
--8/8/2014 - Executed in DEV with GUID changes, new views, and returned 1.13M Rows in 20:16.
--8/8/2014 - Generated corrected view in DEV
--8/12/2014 - John C. explained that Account Code and Site Guid are not needed, NULLED
--				them out. With them in the QRY, returned 43104 rows, with them nulled
--				out, returned 43104 rows. Using a DISTINCT, 28736 rows returned and execution
--				time doubled approximately.
--				Has to add a DISTINCT to all the queries - .
--				Original Query 0:25 @ 43104
--				Original Query 0:46 @ 28736 (distinct)
--				Filter added - VHFHAQ.DocumentCulture 0:22 @ 14368
--				Filter added - and VHFHARCJ.DocumentCulture = 'en-us'	 0:06 @ 3568
--				Filter added - and VHFHARAJ.DocumentCulture = 'en-us'	 0:03 @ 1784
--8/12/2014 - Applied the language filters with John C. and performance improved, as expected,
--				such that when running the view in QA: 
--8/12/2014 - select * from [view_EDW_HealthAssessmentDefinition_CT] where DocumentModifiedWhen between '2000-11-14' and 
--				'2014-11-15' now runs exceptionally fast
--08/12/2014 - ProdStaging 00:21:52 @ 2442
--08/12/2014 - ProdStaging 00:21:09 @ 13272 (UNION ALL   --UNION)
--08/12/2014 - ProdStaging 00:21:37 @ 13272 (UNION ONLY)
--08/12/2014 - ProdStaging 00:06:26 @ 1582 (UNION ONLY & Select Filters Added for Culture)
--08/12/2014 - ProdStaging 00:10:07 @ 6636 (UNION ALL   --UNION) and all selected
--08/12/2014 - ProdStaging added PI PI_View_CMS_Tree_Joined_Regular_DocumentCulture: 00:2:34 @ 6636 
--08/12/2014 - DEV 00:00:58 @ 3792
--09.11.2014 - (wdm) added the needed date fields to help EDW in determining the last mod date of a row.
--10.01.2014 - Dale and Mark reworked this view to use NodeGUIDS and eliminated the CMS_TREE View from participating as 
--				well as Site and Account data
--11.25.2014 - (wdm) added multi-select column capability. The values can be 0,1, NULL
--12.29.2014 - (wdm) Added HTML stripping to two columns #47619, the others mentioned already had stripping applied
--12.31.2014 - (wdm) Started the review to apply CR-47517: Eliminate Matrix Questions with NULL Answer GUID's
--01.07.2014 - (wdm) 47619 The Health Assessment Definition interface view contains HTML tags - corrected with udf_StripHTML
--************************************************************************************************************************************************************
CREATE VIEW dbo.view_EDW_HealthAssessmentDefinition_CT
AS SELECT DISTINCT

          NULL AS SiteGUID --cs.SiteGUID								--WDM 08.12.2014 per John C.
        , NULL AS AccountCD	 --, HFA.AccountCD						--WDM 08.07.2014 per John C.
        , HA.NodeID AS HANodeID										--WDM 08.07.2014
        , HA.NodeName AS HANodeName									--WDM 08.07.2014
          --, HA.DocumentID AS HADocumentID								--WDM 08.07.2014 commented out and left in place for history
        , NULL AS HADocumentID										--WDM 08.07.2014; 09.29.2014: Mark and Dale discussed that NODEGUID should be used such that the multi-language/culture is not a problem.
        , HA.NodeSiteID AS HANodeSiteID								--WDM 08.07.2014
        , HA.DocumentPublishedVersionHistoryID AS HADocPubVerID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) AS ModTitle              --WDM 47619
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText              --WDM 47619
        , VHFHAMJ.NodeGuid AS ModDocGuid	--, VHFHAMJ.DocumentID AS ModDocID	--WDM 08.07.2014	M&D 10.01.2014
        , VHFHAMJ.Weight AS ModWeight
        , VHFHAMJ.IsEnabled AS ModIsEnabled
        , VHFHAMJ.CodeName AS ModCodeName
        , VHFHAMJ.DocumentPublishedVersionHistoryID AS ModDocPubVerID
        , dbo.udf_StripHTML (VHFHARCJ.Title) AS RCTitle              --WDM 47619
        , VHFHARCJ.Weight AS RCWeight
        , VHFHARCJ.NodeGuid AS RCDocumentGUID	--, VHFHARCJ.DocumentID AS RCDocumentID	--WDM 08.07.2014	M&D 10.01.2014
        , VHFHARCJ.IsEnabled AS RCIsEnabled
        , VHFHARCJ.CodeName AS RCCodeName
        , VHFHARCJ.DocumentPublishedVersionHistoryID AS RCDocPubVerID
        , dbo.udf_StripHTML (VHFHARAJ.Title) AS RATytle              --WDM 47619
        , VHFHARAJ.Weight AS RAWeight
        , VHFHARAJ.NodeGuid AS RADocumentGuid	--, VHFHARAJ.DocumentID AS RADocumentID	--WDM 08.07.2014	M&D 10.01.2014
        , VHFHARAJ.IsEnabled AS RAIsEnabled
        , VHFHARAJ.CodeName AS RACodeName
        , VHFHARAJ.ScoringStrategyID AS RAScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID AS RADocPubVerID
        , VHFHAQ.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ.Title, 4000)) AS QuesTitle              --WDM 47619
        , VHFHAQ.Weight AS QuesWeight
        , VHFHAQ.IsRequired AS QuesIsRequired

          --, VHFHAQ.DocumentGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014	M&D 10.01.2014
        , VHFHAQ.NodeGuid AS QuesDocumentGuid	--, VHFHAQ.DocumentID AS QuesDocumentID	--WDM 08.07.2014

        , VHFHAQ.IsEnabled AS QuesIsEnabled
        , LEFT (VHFHAQ.IsVisible, 4000) AS QuesIsVisible
        , VHFHAQ.IsStaging AS QuesIsSTaging
        , VHFHAQ.CodeName AS QuestionCodeName
        , VHFHAQ.DocumentPublishedVersionHistoryID AS QuesDocPubVerID
        , VHFHAA.Value AS AnsValue
        , VHFHAA.Points AS AnsPoints
        , VHFHAA.NodeGuid AS AnsDocumentGuid		--ref: #47517
        , VHFHAA.IsEnabled AS AnsIsEnabled
        , VHFHAA.CodeName AS AnsCodeName
        , VHFHAA.UOM AS AnsUOM
        , VHFHAA.DocumentPublishedVersionHistoryID AS AnsDocPUbVerID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014 ADDED TO the returned Columns
        , HA.NodeGUID AS HANodeGUID
          --, NULL as SiteLastModified
        , NULL AS SiteLastModified
          --, NULL as Account_ItemModifiedWhen
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID01' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ.CodeName, '-') + ISNULL (CAST (VHFHAQ.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA.CodeName , '-') + ISNULL (CAST (VHFHAA.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID01' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ.IsVisible, 1000) , '-') 
          ) AS HashCode

          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US'

/*
		  --** ADD THE CHANGE TRACKING Tables
		  */

                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHARAJ.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'		--WDM 08.12.2014	
       AND VHFHAA.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title)              --WDM 47619
        , dbo.udf_StripHTML (LEFT (LEFT (VHFHAMJ.IntroText, 4000) , 4000)) AS IntroText              --WDM 47619
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title)              --WDM 47619
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title)              --WDM 47619
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ2.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ2.Title, 4000)) AS QuesTitle              --WDM 47619
        , VHFHAQ2.Weight
        , VHFHAQ2.IsRequired
        , VHFHAQ2.NodeGuid
        , VHFHAQ2.IsEnabled
        , LEFT (VHFHAQ2.IsVisible, 4000) 
        , VHFHAQ2.IsStaging
        , VHFHAQ2.CodeName AS QuestionCodeName
          --,VHFHAQ2.NodeAliasPath
        , VHFHAQ2.DocumentPublishedVersionHistoryID
        , VHFHAA2.Value
        , VHFHAA2.Points
        , VHFHAA2.NodeGuid		--ref: #47517
        , VHFHAA2.IsEnabled
        , VHFHAA2.CodeName
        , VHFHAA2.UOM
          --,VHFHAA2.NodeAliasPath
        , VHFHAA2.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID02' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ2.CodeName, '-') + ISNULL (CAST (VHFHAQ2.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA2.CodeName , '-') + ISNULL (CAST (VHFHAA2.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ2.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA2.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID02' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ2.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ2.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2
                      ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2
                      ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA2.NodeGuid IS NOT NULL		--ref: #47517

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 1 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ3.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ3.Title, 4000)) AS QuesTitle
        , VHFHAQ3.Weight
        , VHFHAQ3.IsRequired
        , VHFHAQ3.NodeGuid
        , VHFHAQ3.IsEnabled
        , LEFT (VHFHAQ3.IsVisible, 4000) 
        , VHFHAQ3.IsStaging
        , VHFHAQ3.CodeName AS QuestionCodeName
          --,VHFHAQ3.NodeAliasPath
        , VHFHAQ3.DocumentPublishedVersionHistoryID
        , VHFHAA3.Value
        , VHFHAA3.Points
        , VHFHAA3.NodeGuid		--ref: #47517
        , VHFHAA3.IsEnabled
        , VHFHAA3.CodeName
        , VHFHAA3.UOM
          --,VHFHAA3.NodeAliasPath
        , VHFHAA3.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID03' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ3.CodeName, '-') + ISNULL (CAST (VHFHAQ3.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA3.CodeName , '-') + ISNULL (CAST (VHFHAA3.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ3.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA3.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID03' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ3.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ3.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                      ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA3.NodeGuid IS NOT NULL		--ref: #47517
   --AND (
   --    CT_CMS_Class.ClassID IS NOT NULL
   -- OR CT_CMS_Document.DocumentID IS NOT NULL
   -- OR CT_CMS_Site.SiteID IS NOT NULL
   -- OR CT_CMS_Tree.NodeID IS NOT NULL
   -- OR CT_CMS_User.UserID IS NOT NULL
   -- OR CT_COM_SKU.SKUID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- --OR CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID_CtID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID IS NOT NULL
   -- OR CT_HFit_HealthAssessment.HealthAssessmentID IS NOT NULL
   -- OR CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   --    ) 

   UNION ALL   --UNION
   --WDM Retrieve Branching Level 1 Question and Matrix Level 2 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ7.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ7.Title, 4000)) AS QuesTitle
        , VHFHAQ7.Weight
        , VHFHAQ7.IsRequired
        , VHFHAQ7.NodeGuid
        , VHFHAQ7.IsEnabled
        , LEFT (VHFHAQ7.IsVisible, 4000) 
        , VHFHAQ7.IsStaging
        , VHFHAQ7.CodeName AS QuestionCodeName
          --,VHFHAQ7.NodeAliasPath
        , VHFHAQ7.DocumentPublishedVersionHistoryID
        , VHFHAA7.Value
        , VHFHAA7.Points
        , VHFHAA7.NodeGuid		--ref: #47517
        , VHFHAA7.IsEnabled
        , VHFHAA7.CodeName
        , VHFHAA7.UOM
          --,VHFHAA7.NodeAliasPath
        , VHFHAA7.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID04' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ7.CodeName, '-') + ISNULL (CAST (VHFHAQ7.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA7.CodeName , '-') + ISNULL (CAST (VHFHAA7.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ7.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA7.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID04' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ7.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ7.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************		

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

              --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                      ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                      ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA7.NodeGuid IS NOT NULL		--ref: #47517
   --********************************************

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 1 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:40 minute
   -- Added two perf indexes to the first query: 25 Sec
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ8.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ8.Title, 4000)) AS QuesTitle
        , VHFHAQ8.Weight
        , VHFHAQ8.IsRequired
        , VHFHAQ8.NodeGuid
        , VHFHAQ8.IsEnabled
        , LEFT (VHFHAQ8.IsVisible, 4000) 
        , VHFHAQ8.IsStaging
        , VHFHAQ8.CodeName AS QuestionCodeName
          --,VHFHAQ8.NodeAliasPath
        , VHFHAQ8.DocumentPublishedVersionHistoryID
        , VHFHAA8.Value
        , VHFHAA8.Points
        , VHFHAA8.NodeGuid		--ref: #47517
        , VHFHAA8.IsEnabled
        , VHFHAA8.CodeName
        , VHFHAA8.UOM
          --,VHFHAA8.NodeAliasPath
        , VHFHAA8.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID05' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ8.CodeName, '-') + ISNULL (CAST (VHFHAQ8.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA8.CodeName , '-') + ISNULL (CAST (VHFHAA8.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ8.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA8.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID05' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ8.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ8.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************	

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID --LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3 ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID

              --Matrix Level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7
                      ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7
                      ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID --Matrix branching level 1 question group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8
                      ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8
                      ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA8.NodeGuid IS NOT NULL		--ref: #47517
   --********************************************

   UNION ALL   --UNION
   --****************************************************
   --WDM 6/25/2014 Retrieve the Branching level 2 Question Group
   --THE PROBLEM LIES HERE in this part of query : 1:48  minutes
   --With the new indexes: 29 Secs
   --****************************************************
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ4.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ4.Title, 4000)) AS QuesTitle
        , VHFHAQ4.Weight
        , VHFHAQ4.IsRequired
        , VHFHAQ4.NodeGuid
        , VHFHAQ4.IsEnabled
        , LEFT (VHFHAQ4.IsVisible, 4000) 
        , VHFHAQ4.IsStaging
        , VHFHAQ4.CodeName AS QuestionCodeName
          --,VHFHAQ4.NodeAliasPath
        , VHFHAQ4.DocumentPublishedVersionHistoryID
        , VHFHAA4.Value
        , VHFHAA4.Points
        , VHFHAA4.NodeGuid		--ref: #47517
        , VHFHAA4.IsEnabled
        , VHFHAA4.CodeName
        , VHFHAA4.UOM
          --,VHFHAA4.NodeAliasPath
        , VHFHAA4.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID06' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ4.CodeName, '-') + ISNULL (CAST (VHFHAQ4.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA4.CodeName , '-') + ISNULL (CAST (VHFHAA4.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ4.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA4.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID06' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ4.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ4.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************		

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                      ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

              --Matrix branching level 1 question group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

              --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                      ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                      ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA4.NodeGuid IS NOT NULL		--ref: #47517
   --********************************************
   --AND (
   --    CT_CMS_Class.ClassID IS NOT NULL
   -- OR CT_CMS_Document.DocumentID IS NOT NULL
   -- OR CT_CMS_Site.SiteID IS NOT NULL
   -- OR CT_CMS_Tree.NodeID IS NOT NULL
   -- OR CT_CMS_User.UserID IS NOT NULL
   -- OR CT_COM_SKU.SKUID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- --OR CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID_CtID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID IS NOT NULL
   -- OR CT_HFit_HealthAssessment.HealthAssessmentID IS NOT NULL
   -- OR CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   --    ) 

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 3 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ5.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ5.Title, 4000)) AS QuesTitle
        , VHFHAQ5.Weight
        , VHFHAQ5.IsRequired
        , VHFHAQ5.NodeGuid
        , VHFHAQ5.IsEnabled
        , LEFT (VHFHAQ5.IsVisible, 4000) 
        , VHFHAQ5.IsStaging
        , VHFHAQ5.CodeName AS QuestionCodeName
          --,VHFHAQ5.NodeAliasPath
        , VHFHAQ5.DocumentPublishedVersionHistoryID
        , VHFHAA5.Value
        , VHFHAA5.Points
        , VHFHAA5.NodeGuid		--ref: #47517
        , VHFHAA5.IsEnabled
        , VHFHAA5.CodeName
        , VHFHAA5.UOM
          --,VHFHAA5.NodeAliasPath
        , VHFHAA5.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID07' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ5.CodeName, '-') + ISNULL (CAST (VHFHAQ5.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA5.CodeName , '-') + ISNULL (CAST (VHFHAA5.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ5.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA5.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID07' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ5.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ5.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION
          --********************************************		

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                      ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

              --Matrix branching level 1 question group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

              --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                      ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                      ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                      ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                      ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE VHFHAQ.DocumentCulture = 'en-us'
       AND (VHFHAA.DocumentCulture = 'en-us'
         OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
       AND VHFHARCJ.DocumentCulture = 'en-us'
       AND VHFHARAJ.DocumentCulture = 'en-us'
       AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
       AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
       AND VHFHAA5.NodeGuid IS NOT NULL		--ref: #47517
   --********************************************
   --AND (
   --    CT_CMS_Class.ClassID IS NOT NULL
   -- OR CT_CMS_Document.DocumentID IS NOT NULL
   -- OR CT_CMS_Site.SiteID IS NOT NULL
   -- OR CT_CMS_Tree.NodeID IS NOT NULL
   -- OR CT_CMS_User.UserID IS NOT NULL
   -- OR CT_COM_SKU.SKUID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- --OR CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID_CtID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID IS NOT NULL
   -- OR CT_HFit_HealthAssessment.HealthAssessmentID IS NOT NULL
   -- OR CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   --    ) 

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 4 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ6.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ6.Title, 4000)) AS QuesTitle
        , VHFHAQ6.Weight
        , VHFHAQ6.IsRequired
        , VHFHAQ6.NodeGuid
        , VHFHAQ6.IsEnabled
        , LEFT (VHFHAQ6.IsVisible, 4000) 
        , VHFHAQ6.IsStaging
        , VHFHAQ6.CodeName AS QuestionCodeName
          --,VHFHAQ6.NodeAliasPath
        , VHFHAQ6.DocumentPublishedVersionHistoryID
        , VHFHAA6.Value
        , VHFHAA6.Points
        , VHFHAA6.NodeGuid		--ref: #47517
        , VHFHAA6.IsEnabled
        , VHFHAA6.CodeName
        , VHFHAA6.UOM
          --,VHFHAA6.NodeAliasPath
        , VHFHAA6.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID08' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ6.CodeName, '-') + ISNULL (CAST (VHFHAQ6.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA6.CodeName , '-') + ISNULL (CAST (VHFHAA6.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ6.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA6.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID08' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ6.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ6.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                      ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

              --Matrix branching level 1 question group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

              --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                      ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                      ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
              --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                      ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                      ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                      ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                      ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE  VHFHAQ.DocumentCulture = 'en-us'
        AND (VHFHAA.DocumentCulture = 'en-us'
          OR VHFHAA.DocumentCulture IS NULL)	--WDM 08.12.2014		
        AND VHFHARCJ.DocumentCulture = 'en-us'
        AND VHFHARAJ.DocumentCulture = 'en-us'
        AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
        AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
        AND VHFHAA6.NodeGuid IS NOT NULL		--ref: #47517
   --********************************************
   --AND (
   --    CT_CMS_Class.ClassID IS NOT NULL
   -- OR CT_CMS_Document.DocumentID IS NOT NULL
   -- OR CT_CMS_Site.SiteID IS NOT NULL
   -- OR CT_CMS_Tree.NodeID IS NOT NULL
   -- OR CT_CMS_User.UserID IS NOT NULL
   -- OR CT_COM_SKU.SKUID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   -- --OR CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID_CtID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID IS NOT NULL
   -- OR CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID IS NOT NULL
   -- OR CT_HFit_HealthAssessment.HealthAssessmentID IS NOT NULL
   -- OR CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
   --    ) 

   UNION ALL   --UNION
   --WDM 6/25/2014 Retrieve the Branching level 5 Question Group
   SELECT DISTINCT
          NULL AS SiteGUID --cs.SiteGUID		--WDM 08.12.2014
        , NULL AS AccountCD	 --, HFA.AccountCD												--WDM 08.07.2014
        , HA.NodeID		--WDM 08.07.2014
        , HA.NodeName		--WDM 08.07.2014
        , NULL AS HADocumentID		--WDM 08.07.2014
        , HA.NodeSiteID		--WDM 08.07.2014
          --,VCTJ.NodeAliasPath
        , HA.DocumentPublishedVersionHistoryID		--WDM 08.07.2014
        , dbo.udf_StripHTML (VHFHAMJ.Title) 
        , dbo.udf_StripHTML (LEFT (VHFHAMJ.IntroText, 4000)) AS IntroText
        , VHFHAMJ.NodeGuid
        , VHFHAMJ.Weight
        , VHFHAMJ.IsEnabled
        , VHFHAMJ.CodeName
          --,VHFHAMJ.NodeAliasPath
        , VHFHAMJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARCJ.Title) 
        , VHFHARCJ.Weight
        , VHFHARCJ.NodeGuid
        , VHFHARCJ.IsEnabled
        , VHFHARCJ.CodeName
          --,VHFHARCJ.NodeAliasPath
        , VHFHARCJ.DocumentPublishedVersionHistoryID
        , dbo.udf_StripHTML (VHFHARAJ.Title) 
        , VHFHARAJ.Weight
        , VHFHARAJ.NodeGuid
        , VHFHARAJ.IsEnabled
        , VHFHARAJ.CodeName
          --,VHFHARAJ.NodeAliasPath
        , VHFHARAJ.ScoringStrategyID
        , VHFHARAJ.DocumentPublishedVersionHistoryID
        , VHFHAQ9.QuestionType
        , dbo.udf_StripHTML (LEFT (VHFHAQ9.Title, 4000)) AS QuesTitle
        , VHFHAQ9.Weight
        , VHFHAQ9.IsRequired
        , VHFHAQ9.NodeGuid
        , VHFHAQ9.IsEnabled
        , LEFT (VHFHAQ9.IsVisible, 4000) 
        , VHFHAQ9.IsStaging
        , VHFHAQ9.CodeName AS QuestionCodeName
          --,VHFHAQ9.NodeAliasPath
        , VHFHAQ9.DocumentPublishedVersionHistoryID
        , VHFHAA9.Value
        , VHFHAA9.Points
        , VHFHAA9.NodeGuid		--ref: #47517
        , VHFHAA9.IsEnabled
        , VHFHAA9.CodeName
        , VHFHAA9.UOM
          --,VHFHAA9.NodeAliasPath
        , VHFHAA9.DocumentPublishedVersionHistoryID
        , CASE
              WHEN CAST (HA.DocumentCreatedWhen AS date) = CAST (HA.DocumentModifiedWhen AS date) 
                  THEN 'I'
              ELSE 'U'
          END AS ChangeType
        , HA.DocumentCreatedWhen
        , HA.DocumentModifiedWhen
        , HA.NodeGuid AS CmsTreeNodeGuid	--WDM 08.07.2014
        , HA.NodeGUID AS HANodeGUID

        , NULL AS SiteLastModified
        , NULL AS Account_ItemModifiedWhen
          --, c.DocumentModifiedWhen as Campaign_DocumentModifiedWhen
        , NULL AS Campaign_DocumentModifiedWhen
        , HA.DocumentModifiedWhen AS Assessment_DocumentModifiedWhen
        , VHFHAMJ.DocumentModifiedWhen AS Module_DocumentModifiedWhen
        , VHFHARCJ.DocumentModifiedWhen AS RiskCategory_DocumentModifiedWhen
        , VHFHARAJ.DocumentModifiedWhen AS RiskArea_DocumentModifiedWhen
        , VHFHAQ.DocumentModifiedWhen AS Question_DocumentModifiedWhen
        , VHFHAA.DocumentModifiedWhen AS Answer_DocumentModifiedWhen
        , HAMCQ.AllowMultiSelect
        , 'SID09' AS LocID
        , HASHBYTES ('sha1',
          + ISNULL (CAST (HA.NodeName  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeSiteID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHAMJ.CodeName, '-') + ISNULL (CAST (VHFHARCJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARCJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.Weight  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.IsEnabled  AS nvarchar (50)) , '-') + ISNULL (VHFHARAJ.CodeName, '-') + ISNULL (CAST (VHFHARAJ.ScoringStrategyID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.QuestionType  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.Weight AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsRequired AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.NodeGuid AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsEnabled AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.IsStaging AS nvarchar (50)) , '-') + ISNULL (VHFHAQ.CodeName, '-') + ISNULL (CAST (VHFHAQ.DocumentPublishedVersionHistoryID AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.Value  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.Points AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.IsEnabled AS nvarchar (50)) , '-') + ISNULL (VHFHAA.CodeName , '-') + ISNULL (CAST (VHFHAA.UOM  AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.DocumentPublishedVersionHistoryID  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentCreatedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HA.NodeGuid  AS nvarchar (50)) , '-') + ISNULL (CAST (HA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAMJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARCJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHARAJ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAQ.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (VHFHAA.DocumentModifiedWhen AS nvarchar (50)) , '-') + ISNULL (CAST (HAMCQ.AllowMultiSelect AS nvarchar (50)) , '-') + 'SID09' + ISNULL (LEFT (VHFHARAJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHARCJ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAMJ.IntroText, 1000) , '-') + ISNULL (LEFT (VHFHAQ.Title, 1000) , '-') + ISNULL (LEFT (VHFHAQ.IsVisible, 1000) , '-') 
          ) AS HashCode
          --********************************************
        , CT_CMS_Class.ClassID AS CMS_Class_CtID
        , CT_CMS_Class.SYS_CHANGE_VERSION AS CMS_Class_SCV
        , CT_CMS_Document.DocumentID AS CMS_Document_CtID
        , CT_CMS_Document.SYS_CHANGE_VERSION AS CMS_Document_SCV
        , CT_CMS_Site.SiteID AS CMS_Site_CtID
        , CT_CMS_Site.SYS_CHANGE_VERSION AS CMS_Site_SCV
        , CT_CMS_Tree.NodeID AS CMS_Tree_CtID
        , CT_CMS_Tree.SYS_CHANGE_VERSION AS CMS_Tree_SCV
        , CT_CMS_User.UserID AS CMS_User_CtID
        , CT_CMS_User.SYS_CHANGE_VERSION AS CMS_User_SCV
        , CT_COM_SKU.SKUID AS COM_SKU_CtID
        , CT_COM_SKU.SYS_CHANGE_VERSION AS COM_SKU_SCV
        , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMatrixQuestion_CtID
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMatrixQuestion_SCV
        , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID AS HFit_HealthAssesmentModule_CtID
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_VERSION AS HFit_HealthAssesmentModule_SCV
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssesmentMultipleChoiceQuestion_CtID
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_VERSION AS HFit_HealthAssesmentMultipleChoiceQuestion_SCV
          --, CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID AS HFit_HealthAssesmentPredefinedAnswer_CtID
          --, CT_HFit_HealthAssesmentPredefinedAnswer.SYS_CHANGE_VERSION AS HFit_HealthAssesmentPredefinedAnswer_SCV
        , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID AS HFit_HealthAssesmentRiskArea_CtID
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskArea_SCV
        , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID AS HFit_HealthAssesmentRiskCategory_CtID
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_VERSION AS HFit_HealthAssesmentRiskCategory_SCV
        , CT_HFit_HealthAssessment.HealthAssessmentID AS HFit_HealthAssessment_CtID
        , CT_HFit_HealthAssessment.SYS_CHANGE_VERSION AS HFit_HealthAssessment_SCV
        , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID AS HFit_HealthAssessmentFreeForm_CtID
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_VERSION AS HFit_HealthAssessmentFreeForm_SCV

        , CT_CMS_Class.SYS_CHANGE_OPERATION AS CMS_Class_CHANGE_OPERATION
        , CT_CMS_Document.SYS_CHANGE_OPERATION AS CMS_Document_CHANGE_OPERATION
        , CT_CMS_Site.SYS_CHANGE_OPERATION AS CMS_Site_CHANGE_OPERATION
        , CT_CMS_Tree.SYS_CHANGE_OPERATION AS CMS_Tree_CHANGE_OPERATION
        , CT_CMS_User.SYS_CHANGE_OPERATION AS CMS_User_CHANGE_OPERATION
        , CT_COM_SKU.SYS_CHANGE_OPERATION AS COM_SKU_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMatrixQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentModule_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentMultipleChoiceQuestion_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskArea_CHANGE_OPERATION
        , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION AS HFit_HealthAssesmentRiskCategory_CHANGE_OPERATION
        , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION AS HFit_HealthAssessment_CHANGE_OPERATION
        , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION AS HFit_HealthAssessmentFreeForm_CHANGE_OPERATION

        , COALESCE (  CT_CMS_Class.ClassID
          , CT_CMS_Document.DocumentID
          , CT_CMS_Site.SiteID
          , CT_CMS_Tree.NodeID
          , CT_CMS_User.UserID
          , CT_COM_SKU.SKUID
          , CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID
          , CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
          , CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
          , CT_HFit_HealthAssessment.HealthAssessmentID
          , CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
          )  AS CHANGED_FLG

        , COALESCE
          (CT_CMS_Class.SYS_CHANGE_OPERATION
          , CT_CMS_Document.SYS_CHANGE_OPERATION
          , CT_CMS_Site.SYS_CHANGE_OPERATION
          , CT_CMS_Tree.SYS_CHANGE_OPERATION
          , CT_CMS_User.SYS_CHANGE_OPERATION
          , CT_COM_SKU.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMatrixQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentModule.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentMultipleChoiceQuestion.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskArea.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssesmentRiskCategory.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessment.SYS_CHANGE_OPERATION
          , CT_HFit_HealthAssessmentFreeForm.SYS_CHANGE_OPERATION
          ) AS CHANGE_TYPE_CODE
          FROM
              --dbo.View_CMS_Tree_Joined AS VCTJ
              --INNER JOIN dbo.CMS_Site AS CS ON VCTJ.NodeSiteID = cs.SiteID
              --INNER JOIN HFit_Account hfa WITH(NOLOCK) ON cs.SiteID = hfa.SiteID

              --Campaign links Client which links to Assessment
              --INNER JOIN dbo.View_HFit_HACampaign_Joined as c WITH(NOLOCK) ON VCTJ.NodeID = c.NodeParentID	--Note: 

              View_HFit_HealthAssessment_Joined AS HA WITH (NOLOCK) 
                  INNER JOIN dbo.View_HFit_HealthAssesmentModule_Joined AS VHFHAMJ
                      ON HA.NodeID = VHFHAMJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskCategory_Joined AS VHFHARCJ
                      ON VHFHAMJ.DocumentNodeID = VHFHARCJ.NodeParentID
                    INNER JOIN dbo.View_HFit_HealthAssesmentRiskArea_Joined AS VHFHARAJ
                      ON VHFHARCJ.DocumentNodeID = VHFHARAJ.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ
                      ON VHFHARAJ.DocumentNodeID = VHFHAQ.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA
                      ON VHFHAQ.NodeID = VHFHAA.NodeParentID --matrix level 1 questiongroup
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ2 ON VHFHAQ.NodeID = VHFHAQ2.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA2 ON VHFHAQ2.NodeID = VHFHAA2.NodeParentID

              --Branching Level 1 Question 
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ3
                      ON VHFHAA.NodeID = VHFHAQ3.NodeParentID
                    LEFT OUTER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA3
                      ON VHFHAQ3.NodeID = VHFHAA3.NodeParentID --Matrix Level 2 Question Group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ7 ON VHFHAQ3.NodeID = VHFHAQ7.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA7 ON VHFHAQ7.NodeID = VHFHAA7.NodeParentID

              --Matrix branching level 1 question group
              --INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ8 ON VHFHAA7.NodeID = VHFHAQ8.NodeParentID
              --INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA8 ON VHFHAQ8.NodeID = VHFHAA8.NodeParentID

              --Branching level 2 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ4
                      ON VHFHAA3.NodeID = VHFHAQ4.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                      ON VHFHAQ4.NodeID = VHFHAA4.NodeParentID --Branching level 3 Question Group
              --select count(*) from dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA4
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ5
                      ON VHFHAA4.NodeID = VHFHAQ5.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA5
                      ON VHFHAQ5.NodeID = VHFHAA5.NodeParentID --Branching level 4 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ6
                      ON VHFHAA5.NodeID = VHFHAQ6.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA6
                      ON VHFHAQ6.NodeID = VHFHAA6.NodeParentID --Branching level 5 Question Group
                    INNER JOIN dbo.View_EDW_HealthAssesmentQuestions AS VHFHAQ9
                      ON VHFHAA6.NodeID = VHFHAQ9.NodeParentID
                    INNER JOIN dbo.View_EDW_HealthAssesmentAnswers AS VHFHAA9
                      ON VHFHAQ9.NodeID = VHFHAA9.NodeParentID
                    LEFT OUTER JOIN View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS HAMCQ
                      ON VHFHAQ.Nodeguid = HAMCQ.Nodeguid
                     AND HAMCQ.DocumentCulture = 'en-US' --************************************************************************************************
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Class, NULL) AS CT_CMS_Class
                      ON HA.NodeClassID = CT_CMS_Class.ClassID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Document, NULL) AS CT_CMS_Document
                      ON HA.DocumentID = CT_CMS_Document.DocumentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Site, NULL) AS CT_CMS_Site
                      ON HA.NodeSiteID = CT_CMS_Site.SiteID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT_CMS_Tree
                      ON HA.NodeID = CT_CMS_Tree.NodeID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES CMS_User, NULL) AS CT_CMS_User
                      ON HA.DocumentCreatedByUserID = CT_CMS_User.UserID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES COM_SKU, NULL) AS CT_COM_SKU
                      ON HA.SKUID = CT_COM_SKU.SKUID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT_HFit_HealthAssesmentMatrixQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentModule, NULL) AS CT_HFit_HealthAssesmentModule
                      ON VHFHAMJ.HealthAssesmentModuleID = CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT_HFit_HealthAssesmentMultipleChoiceQuestion
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID --LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentPredefinedAnswer, NULL) AS CT_HFit_HealthAssesmentPredefinedAnswer
              --    ON XX_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID = CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskArea, NULL) AS CT_HFit_HealthAssesmentRiskArea
                      ON VHFHARAJ.HealthAssesmentRiskAreaID = CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssesmentRiskCategory, NULL) AS CT_HFit_HealthAssesmentRiskCategory
                      ON VHFHARCJ.HealthAssesmentRiskCategoryID = CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT_HFit_HealthAssessment
                      ON HA.HealthAssessmentID = CT_HFit_HealthAssessment.HealthAssessmentID
                    LEFT OUTER JOIN CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT_HFit_HealthAssessmentFreeForm
                      ON HAMCQ.HealthAssesmentMultipleChoiceQuestionID = CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID
     --**********************************************************************************************************
     WHERE  VHFHAQ.DocumentCulture = 'en-us'
        AND (VHFHAA.DocumentCulture = 'en-us'
          OR VHFHAA.DocumentCulture IS NULL) 
        AND VHFHARCJ.DocumentCulture = 'en-us'
        AND VHFHARAJ.DocumentCulture = 'en-us'
        AND VHFHAMJ.DocumentCulture = 'en-us'	--WDM 08.12.2014	
        AND HA.DocumentCulture = 'en-us'	--WDM 08.12.2014		
        AND VHFHAA9.NodeGuid IS NOT NULL;		--ref: #47517
--********************************************
--AND (
--    CT_CMS_Class.ClassID IS NOT NULL
-- OR CT_CMS_Document.DocumentID IS NOT NULL
-- OR CT_CMS_Site.SiteID IS NOT NULL
-- OR CT_CMS_Tree.NodeID IS NOT NULL
-- OR CT_CMS_User.UserID IS NOT NULL
-- OR CT_COM_SKU.SKUID IS NOT NULL
-- OR CT_HFit_HealthAssesmentMatrixQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
-- OR CT_HFit_HealthAssesmentModule.HealthAssesmentModuleID IS NOT NULL
-- OR CT_HFit_HealthAssesmentMultipleChoiceQuestion.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
-- --OR CT_HFit_HealthAssesmentPredefinedAnswer.HealthAssesmentPredefinedAnswerID_CtID IS NOT NULL
-- OR CT_HFit_HealthAssesmentRiskArea.HealthAssesmentRiskAreaID IS NOT NULL
-- OR CT_HFit_HealthAssesmentRiskCategory.HealthAssesmentRiskCategoryID IS NOT NULL
-- OR CT_HFit_HealthAssessment.HealthAssessmentID IS NOT NULL
-- OR CT_HFit_HealthAssessmentFreeForm.HealthAssesmentMultipleChoiceQuestionID IS NOT NULL
--    );

GO

PRINT 'Processed: view_EDW_HealthAssessmentDefinition_CT ';
GO
--  
--  
GO
PRINT '***** FROM: view_EDW_HealthAssessmentDefinition_CT.sql';
GO

--select * 
--into STAGED_EDW_HealthAssessmentDefinition
--from view_EDW_HealthAssessmentDefinition_CT
--go