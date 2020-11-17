
declare @AccountID as int = 0 ;
declare @AccountCD_Changed as int = 0 ;
declare @AccountName_Changed as int = 0 ;

declare @Change_Columns as varbinary(100) = (select SYS_CHANGE_COLUMNS  FROM CHANGETABLE (CHANGES HFit_Account, null) as C) ;

declare @ColID as int = (select (COLUMNPROPERTY(OBJECT_ID('HFit_HealthAssesmentUserQuestion'), 'ItemModifiedWhen', 'ColumnId'))) ;
declare @ColID2 as int = (select (COLUMNPROPERTY(OBJECT_ID('HFit_Account'), 'AccountName', 'ColumnId'))) ;

SELECT
   COLUMNPROPERTY (OBJECT_ID ('HFit_HealthAssesmentUserQuestion') , 'ItemModifiedWhen', 'ColumnId') ;

/******************************************************************************************************
FIND ALL ROWS THAT HAVE CHANGED AND IF A PARTICULAR COLUMN WAS INCLUDED AS PART OF THE CHANGE. 
USE A RIGHT OUTER JOIN TO GET THE DELETED RECORDS AS WELL.
******************************************************************************************************/
select QUES.ItemID , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION, CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION, CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_COLUMNS,
CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('HFit_HealthAssesmentUserQuestion'), 'ItemModifiedWhen', 'ColumnId'),SYS_CHANGE_COLUMNS) as ItemModifiedWhen_FLG,
CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('HFit_HealthAssesmentUserQuestion'), 'HAQuestionWeight', 'ColumnId'),SYS_CHANGE_COLUMNS) as HAQuestionWeight_FLG,
CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('HFit_HealthAssesmentUserQuestion'), 'ItemCreatedWhen', 'ColumnId'),SYS_CHANGE_COLUMNS) as ItemCreatedWhen_FLG
from HFit_HealthAssesmentUserQuestion as QUES
    right OUTER JOIN CHANGETABLE(CHANGES HFit_HealthAssesmentUserQuestion , NULL)AS CT_HFit_HealthAssesmentUserQuestion
			 ON QUES.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID


SELECT A.AccountCD, A.AccountName,
    c.SYS_CHANGE_VERSION, c.SYS_CHANGE_CONTEXT
FROM [HFit_Account] AS A
CROSS APPLY CHANGETABLE 
    (VERSION HFit_Account, (AccountID), (A.AccountID)) AS c;

SELECT A.ItemID, A.ItemModifiedWhen, A.HAQuestionWeight, A.ItemCreatedWhen,
    c.SYS_CHANGE_VERSION, c.SYS_CHANGE_CONTEXT as [Context] ,SYS_CHANGE_OPERATION,SYS_CHANGE_CREATION_VERSION as [Version] ,SYS_CHANGE_COLUMNS
FROM HFit_HealthAssesmentUserQuestion AS A
CROSS APPLY CHANGETABLE 
    (CHANGES HFit_HealthAssesmentUserQuestion, null) AS c;


	   Select 'CMS_Class' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Class, NULL) AS CT
	   UNION
	   Select 'cms_document' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Document, NULL) AS CT
	   UNION
	   Select 'CMS_Site',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Site, NULL) AS CT
	   UNION
	   Select 'CMS_Tree',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_Tree, NULL) AS CT
	   UNION
	   Select 'CMS_User' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_User, NULL) AS CT
	   UNION
	   Select 'CMS_UserSettings',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSettings, NULL) AS CT
	   UNION
	   Select 'CMS_UserSite',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES CMS_UserSite, NULL) AS CT
	   UNION
	   Select 'COM_SKU' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES COM_SKU, NULL) AS CT
	   UNION
	   Select 'HFit_Account' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_Account, NULL) AS CT
	   UNION
	   Select 'HFit_HACampaign' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HACampaign, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentMatrixQuestion' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentMatrixQuestion, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentMultipleChoiceQuestion' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentMultipleChoiceQuestion, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserAnswers' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserAnswers, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserAnswers' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserModule, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserQuestion' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestion, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserQuestionGroupResults' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserQuestionGroupResults, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserRiskArea' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskArea, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserRiskCategory' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserRiskCategory, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssesmentUserStarted' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssesmentUserStarted, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssessment' as TBLNAME ,SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssessment, NULL) AS CT
	   UNION
	   Select 'HFit_HealthAssessmentFreeForm',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_HealthAssessmentFreeForm, NULL) AS CT
	   UNION
	   Select 'HFit_LKP_EDW_RejectMPI',SYS_CHANGE_OPERATION FROM CHANGETABLE (CHANGES HFit_LKP_EDW_RejectMPI, NULL) AS CT ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
