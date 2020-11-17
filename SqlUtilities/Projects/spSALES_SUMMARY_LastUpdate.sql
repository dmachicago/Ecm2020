--exec spSALES_SUMMARY_LastUpdate
alter procedure spSALES_SUMMARY_LastUpdate
as
	/*
	This procedure allows us to capture and migrate ONLY records that 
	have changed since the last data migration. It speeds up the process 
	of data migration significantly.
	*/
	
	IF  not EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEMP_MAXDATE_SALES_SUMMARY]') AND type in (N'U'))
	begin		
		CREATE TABLE [dbo].[TEMP_MAXDATE_SALES_SUMMARY](
			[maxLastUpdate] [datetime] NOT NULL
		) ;
		CREATE NONCLUSTERED INDEX [PI_TEMP_MAXDATE_SALES_SUMMARY] ON [dbo].[TEMP_MAXDATE_SALES_SUMMARY] 
		(
			[maxLastUpdate] ASC
		);
	end ;


	declare @MaxDate as datetime ;
	set @MaxDate = (Select max(UPDATE_DTTM) from MIRROR_DM_F_SALES_SUMMARY) ;
	set @MaxDate = isnull(@MaxDate, '1960-01-01')

	truncate table TEMP_MAXDATE_SALES_SUMMARY ;
	INSERT INTO [dbo].[TEMP_MAXDATE_SALES_SUMMARY] (maxLastUpdate) VALUES (@MaxDate) ;

	Truncate Table TEMP_SALES_SUMMARY_KEY ; 

	INSERT INTO TEMP_SALES_SUMMARY_KEY (RECORD_KEY)
	SELECT RECORD_KEY
	FROM BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY S
	WHERE S.UPDATE_DTTM > @MaxDate ;

/*
Remove all the UDPATED records from the Mirror Table.
*/	
Delete from MIRROR_DM_F_SALES_SUMMARY
where RECORD_KEY in (select record_key from TEMP_SALES_SUMMARY_KEY)

----433403
--select count(*) from TEMP_SALES_SUMMARY_KEY ;

----433403
--select count(*) from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY S
--where UPDATE_DTTM > (Select max(UPDATE_DTTM) from MIRROR_DM_F_SALES_SUMMARY)

--select count(*), 4558429 - count(*) from MIRROR_DM_F_SALES_SUMMARY
--select top 1 MAxdate from TEMP_MAXDATE_SALES_SUMMARY ;
--spMIRROR_DM_F_SALES_SUMMARY

--4558429
select * from BDCSQLSP.SMART_DB.dbo.DM_F_SALES_SUMMARY
where RECORD_KEY in (select record_key from TEMP_SALES_SUMMARY_KEY)