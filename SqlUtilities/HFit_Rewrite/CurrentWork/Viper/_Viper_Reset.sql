
-- select top 1000 * from VIPER_MPI where 
USE [ViperArchive]
GO
select distinct RunID, count(*) 
from FTP_RAW_Data
group by RunID
go

exec xtremeReset

alter procedure xtremeReset
as
begin

begin try 
ALTER TABLE ViperArchive.[dbo].[MPI_Processing] DROP CONSTRAINT [FK_MPI_Processing_RowIdent]
end try 
begin catch 
print 'XXX' ;
end catch 

truncate table viper.dbo.VIPER_MPI
truncate table ViperArchive.[dbo].FTP_ProcessStatus
truncate table ViperArchive.[dbo].FTP_Raw_data
truncate table viper.dbo.ELIGIBILITY_MPI_TEMP

ALTER TABLE ViperArchive.[dbo].[MPI_Processing]  WITH CHECK ADD  CONSTRAINT [FK_MPI_Processing_RowIdent] FOREIGN KEY([RowIdent])
REFERENCES ViperArchive.[dbo].[FTP_Raw_data] ([RowIdent])


ALTER TABLE ViperArchive.[dbo].[MPI_Processing] CHECK CONSTRAINT [FK_MPI_Processing_RowIdent]


exec viper.dbo.dma_ProcessFtpDirectory

end 
go

select distinct RunID, count(*) 
from FTP_RAW_Data
group by RunID
