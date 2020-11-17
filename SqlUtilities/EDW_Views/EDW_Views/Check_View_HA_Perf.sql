Select * from view_EDW_HealthAssesment
where 
(ItemModifiedWhen between '2014-10-03 00:00:00' and '2014-10-04 09:01:11.500'
OR HARiskCategory_ItemModifiedWhen between '2014-10-03 00:00:00' and '2014-10-04 09:01:11.500'
OR HAUserQuestion_ItemModifiedWhen between '2014-10-03 00:00:00' and '2014-10-04 09:01:11.500'
OR HAUserAnswers_ItemModifiedWhen between '2014-10-03 00:00:00' and '2014-10-04 09:01:11.500')   --  
   --  
GO 
print('FROM: Check_View_HA_Perf.sql'); 
GO 
  --  
  --  
GO 
print('***** FROM: Check_View_HA_Perf.sql'); 
GO 
