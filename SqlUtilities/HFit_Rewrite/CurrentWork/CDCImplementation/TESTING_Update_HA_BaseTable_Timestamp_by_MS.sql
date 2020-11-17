/*------------------------------------------------------
***** Script for SelectTopNRows command from SSMS  *****
*/
UPDATE dbo.BASE_HFit_HealthAssesmentUserAnswers
       SET
           ItemModifiedWhen = DATEADD (ms , 3 , ItemModifiedWhen) 
WHERE
      ItemID IN (
      SELECT TOP 2500
             T.ItemID
             FROM
                 KenticoCMS_Prod1.dbo.BASE_HFit_HealthAssesmentUserAnswers AS T
                     INNER JOIN FACT_EDW_HFIT_HealthAssesmentUserAnswers AS S
                         ON S.Itemid = T.ItemID) ;
go
delete from dbo.BASE_HFit_HealthAssesmentUserAnswers       
WHERE
      ItemID IN (
      SELECT TOP 2
             T.ItemID
             FROM
                 KenticoCMS_Prod1.dbo.BASE_HFit_HealthAssesmentUserAnswers AS T
                     INNER JOIN FACT_EDW_HFIT_HealthAssesmentUserAnswers AS S
                         ON S.Itemid = T.ItemID 
			 order by T.ItemID desc) ;
