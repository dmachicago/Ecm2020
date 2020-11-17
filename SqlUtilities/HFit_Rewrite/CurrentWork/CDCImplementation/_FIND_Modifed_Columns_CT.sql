SELECT
       COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'ItemModifiedWhen' , 'ColumnId') ;

select top 100 * from BASE_HFit_HealthAssesmentUserStarted
/*---------------------------------------------------------------------------------------------------
USe KenticoCMS_Datamart_2
*****************************************************************************************************
@Copyright D. Miller & Associates, Ltd., Highland Park, IL, 1.1.1960 allrights reserved.
License:	  This procedure can be used freely as long as the copyright and this header
		  are preserved.

Author:	  W. Dale Miller
Date:	  1-1-1960
Purpose:	  FIND ALL ROWS THAT HAVE CHANGED AND IF A PARTICULAR COLUMN WAS INCLUDED AS PART OF THE CHANGE. 
		  USE A RIGHT OUTER JOIN TO GET THE DELETED RECORDS AS WELL
		  OR IN THIS CASE, AN INNER JOIN TO ONLY BRING BACK CHANGED ROWS
USE:		  select * from  CHANGETABLE(CHANGES BASE_HFit_HealthAssesmentUserStarted , NULL)AS CTBL
*****************************************************************************************************
*/
select top 100 * from BASE_HFit_HealthAssesmentUserStarted

update BASE_HFit_HealthAssesmentUserStarted set HALastSectionCompleted = 'Survey' 
    where HALastSectionCompleted = 'Survey' and SurrogateKey_HFit_HealthAssesmentUserStarted between 100 and 150
update BASE_HFit_HealthAssesmentUserStarted set LastModifiedDate = getdate()
    where SurrogateKey_HFit_HealthAssesmentUserStarted between 200 and 205

DROP TABLE
     #BASE_HFit_HealthAssesmentUserStarted;
GO
SELECT DISTINCT
       BT.SVR
     , BT.DBNAME
     , BT.SurrogateKey_HFit_HealthAssesmentUserStarted
     , CTBL.SYS_CHANGE_VERSION
     , CTBL.SYS_CHANGE_OPERATION
     , case
	   when CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'HALastSectionCompleted' , 'ColumnId') , SYS_CHANGE_COLUMNS) = 1 
		  then 1
	   --when CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'ItemModifiedWhen' , 'ColumnId') , SYS_CHANGE_COLUMNS) = 1 
		  --then 1
	   when CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'LastModifiedDate' , 'ColumnId') , SYS_CHANGE_COLUMNS) =1 
		  then 1
	   --when CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'IsProfessionallyCollected' , 'ColumnId') , SYS_CHANGE_COLUMNS) =1 
		  --then 1
	   --when CHANGE_TRACKING_IS_COLUMN_IN_MASK (COLUMNPROPERTY (OBJECT_ID ('BASE_HFit_HealthAssesmentUserStarted') , 'Notes' , 'ColumnId') , SYS_CHANGE_COLUMNS) =1 
		  --then 1
	   else 0
	   end as RowDataChanged
INTO
     #BASE_HFit_HealthAssesmentUserStarted
FROM
     BASE_HFit_HealthAssesmentUserStarted AS BT
     JOIN CHANGETABLE (CHANGES BASE_HFit_HealthAssesmentUserStarted , null) AS CTBL
     ON
       BT.SurrogateKey_HFit_HealthAssesmentUserStarted = CTBL.SurrogateKey_HFit_HealthAssesmentUserStarted;

SELECT * FROM #BASE_HFit_HealthAssesmentUserStarted;