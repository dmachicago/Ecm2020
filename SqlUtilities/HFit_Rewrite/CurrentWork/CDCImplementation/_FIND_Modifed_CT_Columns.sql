
/*
use KenticoCMS_Datamart_2
go
select * from BASE_HFit_HealthAssesmentUserAnswers where SurrogateKey_HFit_HealthAssesmentUserAnswers between 60000 and 60010

update BASE_HFit_HealthAssesmentUserAnswers 
set HAAnswerValue  = 'NA'
where SurrogateKey_HFit_HealthAssesmentUserAnswers between 60000 and 60010 and HAAnswerValue = '' 

update BASE_HFit_HealthAssesmentUserAnswers 
set LastModifiedDate  = getdate()
where SurrogateKey_HFit_HealthAssesmentUserAnswers between 40000 and 40010

*/

-- SELECT COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'ItemModifiedWhen' , 'ColumnId') ;
-- select  CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers , null) 

-- SELECT * FROM CHANGETABLE(CHANGES dbo.BASE_HFit_HealthAssesmentUserAnswers, null) AS CT

/*---------------------------------------------------------------------------------------------------
USe KenticoCMS_Datamart_2
*****************************************************************************************************
@Copyright  D. Miller & Associates, Ltd., Highland Park, IL, 1.1.1960 allrights reserved.
License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.

Author:	  W. Dale Miller
Date:	  1-1-1960
Purpose:	  FIND ALL ROWS THAT HAVE CHANGED AND IF A PARTICULAR COLUMN WAS INCLUDED AS PART OF THE CHANGE. 
		  USE A RIGHT OUTER JOIN TO GET THE DELETED RECORDS AS WELL
		  OR IN THIS CASE, AN INNER JOIN TO ONLY BRING BACK CHANGED ROWS.
Key Words:  Change Tracking Modified Columns in Row
USE:		  select * from  CHANGETABLE(CHANGES BASE_HFit_HealthAssesmentUserAnswers , NULL)AS CTBL
*****************************************************************************************************
*/

with cte (SurrogateKey_HFit_HealthAssesmentUserAnswers
    ,SYS_CHANGE_VERSION
    ,SYS_CHANGE_OPERATION
    ,HashCode_FLG
    ,ItemModifiedWhen_FLG
    ,LastModifiedDate_FLG)
as (
SELECT DISTINCT
     CTBL.SurrogateKey_HFit_HealthAssesmentUserAnswers
     , CTBL.SYS_CHANGE_VERSION
     , CTBL.SYS_CHANGE_OPERATION
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'HashCode' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS HashCode_FLG
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'ItemModifiedWhen' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemModifiedWhen_FLG
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'LastModifiedDate' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS LastModifiedDate_FLG
from CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers , null) AS CTBL  )
select SurrogateKey_HFit_HealthAssesmentUserAnswers
    from 

DROP TABLE
     #BASE_HFit_HealthAssesmentUserAnswers_Changes;
GO


SELECT DISTINCT
     CTBL.SurrogateKey_HFit_HealthAssesmentUserAnswers
     , CTBL.SYS_CHANGE_VERSION
     , CTBL.SYS_CHANGE_OPERATION
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'HashCode' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS HashCode_FLG
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'ItemModifiedWhen' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS ItemModifiedWhen_FLG
     , CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserAnswers') , 'LastModifiedDate' , 'ColumnId') , SYS_CHANGE_COLUMNS) AS LastModifiedDate_FLG
INTO #BASE_HFit_HealthAssesmentUserAnswers_Changes
FROM
     BASE_HFit_HealthAssesmentUserAnswers AS BT
     JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserAnswers , null) AS CTBL     
     ON
       BT.SurrogateKey_HFit_HealthAssesmentUserAnswers = CTBL.SurrogateKey_HFit_HealthAssesmentUserAnswers

SELECT
       *
FROM #BASE_HFit_HealthAssesmentUserAnswers_Changes
    where HashCode_FLG = 1 or ItemModifiedWhen_FLG = 1 or LastModifiedDate_FLG = 1 





