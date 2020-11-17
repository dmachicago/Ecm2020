		IF OBJECT_ID('tempdb..#TEMP_EDW_DEFF') IS NOT NULL 
		BEGIN
			drop table #TEMP_EDW_DEFF
		END

		IF OBJECT_ID('tempdb..#TEMP_EDW_FACT') IS NOT NULL 
		BEGIN
			drop table #TEMP_EDW_FACT
		END

		--drop table #TEMP_EDW_QuesValidation3
		print ('1');
		print (getdate());

		select  [AnsDocumentGuid] , [HANodeGUID] , [ModDocGuid],[RCDocumentGUID],[RADocumentGuid],[QuesDocumentGuid]
		into #TEMP_EDW_DEFF
		from [view_EDW_HealthAssesmentDeffinition]

		print ('2');
		print (getdate());

		select [HAAnswerNodeGUID] , [HealthAssesmentUserStartedNodeGUID] , [HAModuleNodeGUID],
			[HARiskCategoryNodeGUID],[HARiskAreaNodeGUID],[HAQuestionGuid]
		into #TEMP_EDW_FACT
		from view_EDW_HealthAssesmentV2
 

		print ('3');
		print (getdate());
  

		CREATE CLUSTERED INDEX TEMP_EDW_HA ON [dbo].#TEMP_EDW_FACT
			(
				[HAAnswerNodeGUID] , [HealthAssesmentUserStartedNodeGUID] , [HAModuleNodeGUID],
				[HARiskCategoryNodeGUID],[HARiskAreaNodeGUID],[HAQuestionGuid]
			)

		print ('4');
		print (getdate());

		CREATE CLUSTERED INDEX [PK_TEMP_EDW_HADEF] ON [dbo].#TEMP_EDW_DEFF
				(
					[AnsDocumentGuid] , [HANodeGUID] , [ModDocGuid],[RCDocumentGUID],[RADocumentGuid],[QuesDocumentGuid]
				)

		print ('5');
		print (getdate());

		select count(*) as Cnt_TEMP_EDW_FACT from #TEMP_EDW_FACT
		select count(*) as TEMP_EDW_DEFF from #TEMP_EDW_DEFF

		print ('6');
		print (getdate());
		--select * from #TEMP_EDW_FACT
		select count(*) as ErrCNT
		from #TEMP_EDW_FACT as HADEF       
		WHERE HADEF.[HAQuestionGuid] is NOT NULL
		AND NOT EXISTS (select [AnsDocumentGuid] from #TEMP_EDW_DEFF )		--  Any values returned is a failed test

		print ('7 COMPLETE AT:');
		print (getdate());