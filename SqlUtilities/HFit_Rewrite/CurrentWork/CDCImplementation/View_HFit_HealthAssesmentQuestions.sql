USE [KenticoCMS_DataMart];
GO

/*--------------------------------------------------------------------------------------------------------
***** Object:  View [dbo].[View_HFit_HealthAssesmentQuestions]    Script Date: 11/26/2015 8:27:21 AM *****
*/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT
                  table_name
                  FROM information_schema.tables
                  WHERE
                  table_name = 'VIEW_EDW_HEALTHASSESMENTQUESTIONS') 
    BEGIN
        DROP VIEW
             VIEW_EDW_HEALTHASSESMENTQUESTIONS;
    END;
GO

-- select * from VIEW_EDW_HEALTHASSESMENTQUESTIONS

CREATE VIEW VIEW_EDW_HEALTHASSESMENTQUESTIONS
AS SELECT
          VHFHAMCQJ.SVR
        , VHFHAMCQJ.DBNAME
        , VHFHAMCQJ.ClassName AS QuestionType
        , VHFHAMCQJ.Title
        , VHFHAMCQJ.Weight
        , VHFHAMCQJ.IsRequired
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
       SELECT TOP 1
              pp.NodeOrder
              FROM dbo.BASE_CMS_Tree AS pp
                       INNER JOIN dbo.BASE_CMS_Tree AS p
                           ON p.NodeParentID = pp.NodeID
                          AND p.SVR = pp.SVR
                          AND p.DBNAME = pp.DBNAME
              WHERE
              p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
          FROM dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH (NOLOCK) 
          WHERE VHFHAMCQJ.DocumentCulture = 'en-US'

   UNION ALL
   SELECT
          VHFHAMQJ.SVR
        , VHFHAMQJ.DBNAME
        , VHFHAMQJ.ClassName AS QuestionType
        , VHFHAMQJ.Title
        , VHFHAMQJ.Weight
        , VHFHAMQJ.IsRequired
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
              FROM dbo.BASE_CMS_Tree AS pp
                       INNER JOIN dbo.BASE_CMS_Tree AS p
                           ON p.NodeParentID = pp.NodeID
                          AND p.SVR = pp.SVR
                          AND p.DBNAME = pp.DBNAME
              WHERE
              p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
          FROM dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH (NOLOCK) 
          WHERE VHFHAMQJ.DocumentCulture = 'en-US'
   UNION ALL
   SELECT
          VHFHAMQJ.SVR
        , VHFHAMQJ.DBNAME
        , VHFHAMQJ.ClassName AS QuestionType
        , VHFHAMQJ.Title
        , VHFHAMQJ.Weight
        , VHFHAMQJ.IsRequired
        , VHFHAMQJ.QuestionImageLeft
        , '' AS QuestionImageRight
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
        , VHFHAMQJ.DontKnowEnabled
        , VHFHAMQJ.DontKnowLabel
        , (
       SELECT TOP 1
              pp.NodeOrder
              FROM dbo.BASE_CMS_Tree AS pp
                       INNER JOIN dbo.BASE_CMS_Tree AS p
                           ON p.NodeParentID = pp.NodeID
                          AND p.SVR = pp.SVR
                          AND p.DBNAME = pp.DBNAME
              WHERE
              p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
          FROM dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAMQJ WITH (NOLOCK) 
          WHERE VHFHAMQJ.DocumentCulture = 'en-US';
----**********************************************************************************************
--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAMCQJ.ClassName AS QuestionType
--     ,VHFHAMCQJ.Title
--     ,VHFHAMCQJ.Weight
--     ,VHFHAMCQJ.IsRequired
--     ,VHFHAMCQJ.QuestionImageLeft
--     ,VHFHAMCQJ.QuestionImageRight
--     ,VHFHAMCQJ.NodeGUID
--     ,VHFHAMCQJ.DocumentCulture
--     ,VHFHAMCQJ.IsEnabled
--     ,VHFHAMCQJ.IsVisible
--     ,VHFHAMCQJ.IsStaging
--     ,VHFHAMCQJ.CodeName
--     ,VHFHAMCQJ.QuestionGroupCodeName
--     ,VHFHAMCQJ.NodeAliasPath
--     ,VHFHAMCQJ.DocumentPublishedVersionHistoryID
--     ,VHFHAMCQJ.NodeLevel
--     ,VHFHAMCQJ.NodeOrder
--     ,VHFHAMCQJ.NodeID
--     ,VHFHAMCQJ.NodeParentID
--     ,VHFHAMCQJ.NodeLinkedNodeID
--     ,0 AS DontKnowEnabled
--     ,'' AS DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_2.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_2.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_2.dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH (NOLOCK) 

--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAMQJ.ClassName AS QuestionType
--     ,VHFHAMQJ.Title
--     ,VHFHAMQJ.Weight
--     ,VHFHAMQJ.IsRequired
--     ,VHFHAMQJ.QuestionImageLeft
--     ,VHFHAMQJ.QuestionImageRight
--     ,VHFHAMQJ.NodeGUID
--     ,VHFHAMQJ.DocumentCulture
--     ,VHFHAMQJ.IsEnabled
--     ,VHFHAMQJ.IsVisible
--     ,VHFHAMQJ.IsStaging
--     ,VHFHAMQJ.CodeName
--     ,VHFHAMQJ.QuestionGroupCodeName
--     ,VHFHAMQJ.NodeAliasPath
--     ,VHFHAMQJ.DocumentPublishedVersionHistoryID
--     ,VHFHAMQJ.NodeLevel
--     ,VHFHAMQJ.NodeOrder
--     ,VHFHAMQJ.NodeID
--     ,VHFHAMQJ.NodeParentID
--     ,VHFHAMQJ.NodeLinkedNodeID
--     ,0 AS DontKnowEnabled
--     ,'' AS DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_2.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_2.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_2.dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH (NOLOCK) 

--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAFFJ.ClassName AS QuestionType
--     ,VHFHAFFJ.Title
--     ,VHFHAFFJ.Weight
--     ,VHFHAFFJ.IsRequired
--     ,VHFHAFFJ.QuestionImageLeft
--     ,'' AS QuestionImageRight
--     ,VHFHAFFJ.NodeGUID
--     ,VHFHAFFJ.DocumentCulture
--     ,VHFHAFFJ.IsEnabled
--     ,VHFHAFFJ.IsVisible
--     ,VHFHAFFJ.IsStaging
--     ,VHFHAFFJ.CodeName
--     ,VHFHAFFJ.QuestionGroupCodeName
--     ,VHFHAFFJ.NodeAliasPath
--     ,VHFHAFFJ.DocumentPublishedVersionHistoryID
--     ,VHFHAFFJ.NodeLevel
--     ,VHFHAFFJ.NodeOrder
--     ,VHFHAFFJ.NodeID
--     ,VHFHAFFJ.NodeParentID
--     ,VHFHAFFJ.NodeLinkedNodeID
--     ,VHFHAFFJ.DontKnowEnabled
--     ,VHFHAFFJ.DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_2.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_2.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_2.dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH (NOLOCK) 
----**********************************************************************************************
--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAMCQJ.ClassName AS QuestionType
--     ,VHFHAMCQJ.Title
--     ,VHFHAMCQJ.Weight
--     ,VHFHAMCQJ.IsRequired
--     ,VHFHAMCQJ.QuestionImageLeft
--     ,VHFHAMCQJ.QuestionImageRight
--     ,VHFHAMCQJ.NodeGUID
--     ,VHFHAMCQJ.DocumentCulture
--     ,VHFHAMCQJ.IsEnabled
--     ,VHFHAMCQJ.IsVisible
--     ,VHFHAMCQJ.IsStaging
--     ,VHFHAMCQJ.CodeName
--     ,VHFHAMCQJ.QuestionGroupCodeName
--     ,VHFHAMCQJ.NodeAliasPath
--     ,VHFHAMCQJ.DocumentPublishedVersionHistoryID
--     ,VHFHAMCQJ.NodeLevel
--     ,VHFHAMCQJ.NodeOrder
--     ,VHFHAMCQJ.NodeID
--     ,VHFHAMCQJ.NodeParentID
--     ,VHFHAMCQJ.NodeLinkedNodeID
--     ,0 AS DontKnowEnabled
--     ,'' AS DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_3.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_3.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAMCQJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_3.dbo.View_HFit_HealthAssesmentMultipleChoiceQuestion_Joined AS VHFHAMCQJ WITH (NOLOCK) 

--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAMQJ.ClassName AS QuestionType
--     ,VHFHAMQJ.Title
--     ,VHFHAMQJ.Weight
--     ,VHFHAMQJ.IsRequired
--     ,VHFHAMQJ.QuestionImageLeft
--     ,VHFHAMQJ.QuestionImageRight
--     ,VHFHAMQJ.NodeGUID
--     ,VHFHAMQJ.DocumentCulture
--     ,VHFHAMQJ.IsEnabled
--     ,VHFHAMQJ.IsVisible
--     ,VHFHAMQJ.IsStaging
--     ,VHFHAMQJ.CodeName
--     ,VHFHAMQJ.QuestionGroupCodeName
--     ,VHFHAMQJ.NodeAliasPath
--     ,VHFHAMQJ.DocumentPublishedVersionHistoryID
--     ,VHFHAMQJ.NodeLevel
--     ,VHFHAMQJ.NodeOrder
--     ,VHFHAMQJ.NodeID
--     ,VHFHAMQJ.NodeParentID
--     ,VHFHAMQJ.NodeLinkedNodeID
--     ,0 AS DontKnowEnabled
--     ,'' AS DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_3.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_3.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAMQJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_3.dbo.View_HFit_HealthAssesmentMatrixQuestion_Joined AS VHFHAMQJ WITH (NOLOCK) 

--UNION ALL
--SELECT
--       @@SERVERNAME AS SVR
--     ,DB_NAME () AS DBNAME
--     ,VHFHAFFJ.ClassName AS QuestionType
--     ,VHFHAFFJ.Title
--     ,VHFHAFFJ.Weight
--     ,VHFHAFFJ.IsRequired
--     ,VHFHAFFJ.QuestionImageLeft
--     ,'' AS QuestionImageRight
--     ,VHFHAFFJ.NodeGUID
--     ,VHFHAFFJ.DocumentCulture
--     ,VHFHAFFJ.IsEnabled
--     ,VHFHAFFJ.IsVisible
--     ,VHFHAFFJ.IsStaging
--     ,VHFHAFFJ.CodeName
--     ,VHFHAFFJ.QuestionGroupCodeName
--     ,VHFHAFFJ.NodeAliasPath
--     ,VHFHAFFJ.DocumentPublishedVersionHistoryID
--     ,VHFHAFFJ.NodeLevel
--     ,VHFHAFFJ.NodeOrder
--     ,VHFHAFFJ.NodeID
--     ,VHFHAFFJ.NodeParentID
--     ,VHFHAFFJ.NodeLinkedNodeID
--     ,VHFHAFFJ.DontKnowEnabled
--     ,VHFHAFFJ.DontKnowLabel
--     ,(SELECT
--              pp.NodeOrder
--              FROM
--                   KenticoCMS_3.dbo.BASE_CMS_Tree AS pp
--                        INNER JOIN KenticoCMS_3.dbo.BASE_CMS_Tree AS p
--                        ON
--              p.NodeParentID = pp.NodeID
--              WHERE
--              p.NodeID = VHFHAFFJ.NodeParentID) AS ParentNodeOrder
--       FROM KenticoCMS_3.dbo.View_HFit_HealthAssessmentFreeForm_Joined AS VHFHAFFJ WITH (NOLOCK) ;

GO

