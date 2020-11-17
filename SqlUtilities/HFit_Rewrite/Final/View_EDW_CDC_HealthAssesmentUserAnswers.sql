
if exists (select * from sysobjects where name = 'View_EDW_CDC_HealthAssesmentUserAnswers' and Xtype = 'V')
BEGIN
	drop view View_EDW_CDC_HealthAssesmentUserAnswers ;
END 
go

create View 
[dbo].[View_EDW_CDC_HealthAssesmentUserAnswers]
as
--***********************************************************************************************
--This view will not be used as CDC has been determined NOT TO BE needed or wanted.
--***********************************************************************************************
SELECT
	MAX(ltm.tran_begin_time) InsertUpdateDate
		, DHFHAUAC.ItemID
		, MAX(DHFHAUAC.[__$operation]) Operation
	FROM
		cdc.dbo_HFit_HealthAssesmentUserAnswers_CT AS DHFHAUAC
		INNER JOIN cdc.lsn_time_mapping AS LTM ON DHFHAUAC.[__$start_lsn] = LTM.start_lsn
	WHERE
		DHFHAUAC.[__$operation] IN ( 2, 4 )
	GROUP BY
		DHFHAUAC.ItemID

GO



GRANT SELECT
	ON [dbo].[View_EDW_CDC_HealthAssesmentUserAnswers]
	TO [EDWReader_PRD]
GO
