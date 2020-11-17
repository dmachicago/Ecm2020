
SELECT
       COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserQuestion') , 'ItemModifiedWhen', 'ColumnId') ;

/******************************************************************************************************
FIND ALL ROWS THAT HAVE CHANGED AND IF A PARTICULAR COLUMN WAS INCLUDED AS PART OF THE CHANGE. 
USE A RIGHT OUTER JOIN TO GET THE DELETED RECORDS AS WELL.
******************************************************************************************************/
SELECT
       QUES.ItemID
     , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_VERSION
     , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_OPERATION
     , CT_HFit_HealthAssesmentUserQuestion.SYS_CHANGE_COLUMNS
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserQuestion') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemModifiedWhen_FLG
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserQuestion') , 'HAQuestionWeight', 'ColumnId') , SYS_CHANGE_COLUMNS) AS HAQuestionWeight_FLG
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserQuestion') , 'ItemCreatedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemCreatedWhen_FLG
       FROM BASE_HFit_HealthAssesmentUserQuestion AS QUES
                RIGHT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserQuestion, NULL) AS CT_HFit_HealthAssesmentUserQuestion
                    ON QUES.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID;


SELECT top 100
	   CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'HashCode', 'ColumnId') , SYS_CHANGE_COLUMNS) AS HashCode_FLG
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'ItemModifiedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemModifiedWhen_FLG
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'HAQuestionWeight', 'ColumnId') , SYS_CHANGE_COLUMNS) AS HAQuestionWeight_FLG
     ,CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'ItemCreatedWhen', 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemCreatedWhen_FLG
       FROM BASE_HFit_HealthAssesmentUserStarted AS QUES
                RIGHT OUTER JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted, NULL) AS CT_HFit_HealthAssesmentUserQuestion
                    ON QUES.ItemID = CT_HFit_HealthAssesmentUserQuestion.ItemID;