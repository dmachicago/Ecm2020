
GO
PRINT 'Processing: View_EDW_HealthAssesmentQuestions ';
GO

IF EXISTS (SELECT
                  TABLE_NAME
                  FROM INFORMATION_SCHEMA.VIEWS
                  WHERE
                  TABLE_NAME = 'View_EDW_HealthAssesmentQuestions') 
    BEGIN
        DROP VIEW
             View_EDW_HealthAssesmentQuestions;
    END;
GO

CREATE VIEW dbo.View_EDW_HealthAssesmentQuestions

AS
--**********************************************************************************
--09.11.2014 (wdm) Added the DocumentModifiedWhen to facilitate the EDW need to 
--		determine the last mod date of a record.
--10.17.2014 (wdm)
-- view_EDW_HealthAssesmentDeffinition calls 
-- View_EDW_HealthAssesmentQuestions which calls
-- View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
--		and two other JOINED views.
--View view_EDW_HealthAssesmentDeffinition has a filter on document culture of 'EN-US'
--		which limits the retured data to Engoish only.
--Today, John found a number of TITLES in view_EDW_HealthAssesmentDeffinition that were Spanish.
--The problem seems to come from sevel levels of nesting causing intersection data to seep through 
--the EN-US filter if placed at the highest level of a set of nested views.
--I took the filter and applied it to all the joined views within View_EDW_HealthAssesmentQuestions 
--		and the issue seems to have resolved itself.
--10.17.2014 (wdm) Added a filter "DocumentCulture" - the issue appears to be 
--			caused in view view_EDW_HealthAssesmentDeffinition becuase
--			the FILTER at that level on EN-US allows a portion of the intersection 
--			data to be missed for whatever reason. Adding the filter at this level
--			of the nesting seems to omit the non-english titles found by John Croft.
--**********************************************************************************
--select * from View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined
SELECT
       VHFHAMCQJ.ClassName AS QuestionType
     , cast(VHFHAMCQJ.Title as nvarchar(2000)) as Title
     , VHFHAMCQJ.Weight
     , cast(VHFHAMCQJ.IsRequired  as int) as IsRequired
     , VHFHAMCQJ.QuestionImageLeft
     , VHFHAMCQJ.QuestionImageRight
     , VHFHAMCQJ.NodeGUID
     , VHFHAMCQJ.DocumentCulture
     , VHFHAMCQJ.IsEnabled
     , VHFHAMCQJ.IsVisible
     , VHFHAMCQJ.IsStaging
     , VHFHAMCQJ.CodeName
     , VHFHAMCQJ.QuestionGroupCodeName
     , VHFHAMCQJ.NodeAliasPath
     , VHFHAMCQJ.DocumentPublishedVersionHistoryID
     , VHFHAMCQJ.NodeLevel
     , VHFHAMCQJ.NodeOrder
     , VHFHAMCQJ.NodeID
     , VHFHAMCQJ.NodeParentID
     , VHFHAMCQJ.NodeLinkedNodeID
     , 0 AS DontKnowEnabled
     , '' AS DontKnowLabel
     , (
       SELECT  TOP 1
              pp.NodeOrder
              FROM
                   dbo.BASE_CMS_Tree AS pp
                        INNER JOIN dbo.BASE_CMS_Tree AS p
                        ON
              p.NodeParentID = pp.NodeID
              WHERE
              p.NodeID = VHFHAMCQJ.NodeParentID AND
              p.SVR = VHFHAMCQJ.SVR AND
              p.DBNAME = VHFHAMCQJ.DBNAME) AS ParentNodeOrder

     , VHFHAMCQJ.DocumentGuid
     , CAST (VHFHAMCQJ.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
	 ,  VHFHAMCQJ.SVR
,  VHFHAMCQJ.DBNAME
       FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH (NOLOCK) 
       WHERE
       VHFHAMCQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL
SELECT
       VHFHAMQJ.ClassName AS QuestionType
     , cast(VHFHAMQJ.Title as nvarchar(2000)) as Title
     , VHFHAMQJ.Weight
     , cast(VHFHAMQJ.IsRequired as int)  as IsRequired
     , VHFHAMQJ.QuestionImageLeft
     , VHFHAMQJ.QuestionImageRight
     , VHFHAMQJ.NodeGUID
     , VHFHAMQJ.DocumentCulture
     , VHFHAMQJ.IsEnabled
     , VHFHAMQJ.IsVisible
     , VHFHAMQJ.IsStaging
     , VHFHAMQJ.CodeName
     , VHFHAMQJ.QuestionGroupCodeName
     , VHFHAMQJ.NodeAliasPath
     , VHFHAMQJ.DocumentPublishedVersionHistoryID
     , VHFHAMQJ.NodeLevel
     , VHFHAMQJ.NodeOrder
     , VHFHAMQJ.NodeID
     , VHFHAMQJ.NodeParentID
     , VHFHAMQJ.NodeLinkedNodeID
     , 0 AS DontKnowEnabled
     , '' AS DontKnowLabel
     , (
       SELECT TOP 1
              pp.NodeOrder
              FROM
                   dbo.BASE_CMS_Tree AS pp
                        INNER JOIN dbo.BASE_CMS_Tree AS p
                        ON
              p.NodeParentID = pp.NodeID
              WHERE
              p.NodeID = VHFHAMQJ.NodeParentID AND
              p.SVR = VHFHAMQJ.SVR AND
              p.DBNAME = VHFHAMQJ.DBNAME
       ) AS ParentNodeOrder
     , VHFHAMQJ.DocumentGuid
     , CAST (VHFHAMQJ.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen
,  VHFHAMQJ.SVR
,  VHFHAMQJ.DBNAME
       FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH (NOLOCK) 
       WHERE
       VHFHAMQJ.DocumentCulture = 'en-US'   --(WDM) 10.19.2014 added to filter at this level of nesting

UNION ALL
SELECT
       VHFHAFFJ.ClassName AS QuestionType
     , cast(VHFHAFFJ.Title as nvarchar(2000)) as Title
     , VHFHAFFJ.Weight
     , cast(VHFHAFFJ.IsRequired as int) as IsRequired 
     , VHFHAFFJ.QuestionImageLeft
     , '' AS QuestionImageRight
     , VHFHAFFJ.NodeGUID
     , VHFHAFFJ.DocumentCulture
     , VHFHAFFJ.IsEnabled
     , VHFHAFFJ.IsVisible
     , VHFHAFFJ.IsStaging
     , VHFHAFFJ.CodeName
     , VHFHAFFJ.QuestionGroupCodeName
     , VHFHAFFJ.NodeAliasPath
     , VHFHAFFJ.DocumentPublishedVersionHistoryID
     , VHFHAFFJ.NodeLevel
     , VHFHAFFJ.NodeOrder
     , VHFHAFFJ.NodeID
     , VHFHAFFJ.NodeParentID
     , VHFHAFFJ.NodeLinkedNodeID
     , VHFHAFFJ.DontKnowEnabled
     , VHFHAFFJ.DontKnowLabel
     , (
       SELECT TOP 1
              pp.NodeOrder
              FROM
                   dbo.BASE_CMS_Tree AS pp
                        INNER JOIN dbo.BASE_CMS_Tree AS p
                        ON
              p.NodeParentID = pp.NodeID
              WHERE
              p.NodeID = VHFHAFFJ.NodeParentID AND
              p.SVR = pp.SVR AND
              p.DBNAME = pp.DBNAME
       ) AS ParentNodeOrder
     , VHFHAFFJ.DocumentGuid
     , CAST (VHFHAFFJ.DocumentModifiedWhen AS DATETIME) AS DocumentModifiedWhen	
,  VHFHAFFJ.SVR
,  VHFHAFFJ.DBNAME
       FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH (NOLOCK) 
       WHERE
       VHFHAFFJ.DocumentCulture = 'en-US';   --(WDM) 10.19.2014 added to filter at this level of nesting

GO
PRINT 'Processed: View_EDW_HealthAssesmentQuestions ';
GO

--  
--  
GO
PRINT '***** FROM: View_EDW_HealthAssesmentQuestions.sql';
GO 
