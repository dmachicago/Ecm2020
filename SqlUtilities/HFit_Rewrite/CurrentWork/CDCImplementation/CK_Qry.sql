
-- select * from dma_FtpDirectory
-- select * from TEMP_DIR_FILES
/*
truncate table [dbo].[BASE_view_RDW_ClinicalIndicators]
truncate table [dbo].[BASE_view_RDW_ClinicalIndicators_DEL]
truncate table [dbo].[BASE_view_SIEBEL_ClinicalIndicators]
truncate table [dbo].[BASE_view_SIEBEL_ClinicalIndicators_DEL]
truncate table [dbo].[STAGING_view_RDW_ClinicalIndicators]
truncate table [dbo].[STAGING_view_SIEBEL_ClinicalIndicators]
truncate table [dbo].[TEMP_RDW_ClinicalIndicators]
truncate table [dbo].[TEMP_SIEBEL_ClinicalIndicators]
truncate table [dbo].FTP_ProcessStatus 
truncate table FTP_ClinicalIndicators_LOG
*/

select * from FTP_ClinicalIndicators_LOG order by logdate desc
Select * from FTP_ClinicalIndicators_LOG where logentry like 'INSERTED%' or logentry like '#DELETED%' or logentry like 'UPDATED%' order by logdate desc
-- delete from FTP_ClinicalIndicators_LOG where logentry like '%CLEANUp%'
-- delete from FTP_ClinicalIndicators_LOG where logentry like '%processing fqn%'


select * from FTP_ClinicalIndicators_LOG where logentry like '%SIEBEL%' order by logdate desc 

select * from FTP_ProcessStatus

select top 1000 * from [dbo].[BASE_view_SIEBEL_ClinicalIndicators]
order by MPI

select top 1000 * from [dbo].BASE_view_RDW_ClinicalIndicators
order by MPI, MeasureCode


select count(*) from [dbo].[TEMP_RDW_ClinicalIndicators]
select count(*) from [dbo].[TEMP_SIEBEL_ClinicalIndicators] 

select count(*) from [dbo].[TEMP_RDW_ClinicalIndicators]
select count(*) as BASE_view_SIEBEL_ClinicalIndicators from [dbo].[BASE_view_SIEBEL_ClinicalIndicators]
select count(*) as BASE_view_RDW_ClinicalIndicators from [dbo].[BASE_view_RDW_ClinicalIndicators]

select count(*) as BASE_view_SIEBEL_ClinicalIndicators_DEL from [dbo].[BASE_view_SIEBEL_ClinicalIndicators_DEL]
select count(*) as BASE_view_RDW_ClinicalIndicators_DEL from [dbo].[BASE_view_RDW_ClinicalIndicators_DEL]
