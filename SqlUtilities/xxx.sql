use KenticoCMS_Prod2
go

--drop table #TEMP_EDW_QuesValidation6
--drop view view_EDW_HealthAssesment2

print ('1');
print (getdate());
 select HADEF.[AnsDocumentGuid] 
 into #TEMP_EDW_QuesValidation6
 from [dbo].[view_EDW_HealthAssesmentDeffinition] as HADEF
		join  view_EDW_HealthAssesment2 as HAFACT
		ON    HADEF.[HANodeGUID] = HAFACT.[HealthAssesmentUserStartedNodeGUID]
		and   HADEF.[ModDocGuid] = HAFACT.[HAModuleNodeGUID]
		and   HADEF.[RCDocumentGUID] = HAFACT.[HARiskCategoryNodeGUID] 
		and   HADEF.[RADocumentGuid] = HAFACT.[HARiskAreaNodeGUID]  
		and   HADEF.[QuesDocumentGuid] = HAFACT.[HAQuestionGuid]     
		and   HADEF.[AnsDocumentGuid] = HAFACT.[HAAnswerNodeGUID] 	 	 
print ('2');
print (getdate());

	CREATE CLUSTERED INDEX [PK_TEMP_EDW_QuesValidation] ON [dbo].[#TEMP_EDW_QuesValidation6]
			(
				[AnsDocumentGuid] ASC
			)
print ('3');
print (getdate());

select count(*) as BadRowCnt from #TEMP_EDW_QuesValidation6

print ('4');
print (getdate());

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
