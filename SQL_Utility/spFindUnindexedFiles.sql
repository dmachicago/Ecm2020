
if exists (select 1 from sys.procedures where name = 'spFindUnindexedFiles')
drop procedure spFindUnindexedFiles
go
-- exec spFindUnindexedFiles
create procedure spFindUnindexedFiles
as
begin
create table #iFilters(
	Componenttype nvarchAR(50) NULL,
	Componentname nvarchAR(50) NULL,
	clsid nvarchAR(50) NULL,
	fullpath nvarchAR(250) NULL,
	[version] nvarchAR(50) NULL,
	manufacturer nvarchAR(150) NULL,
)
insert into #iFilters
EXEC sp_help_fulltext_system_components 'filter'; 
select SourceName, OriginalFileType,SourceTypeCode, 
CASE
    WHEN OriginalFileType in (select ImageTypeCode from ImageTypeCodes) then 'Y'
    ELSE 'N' 
END as OcrReq,
RowGuid from DataSource 
where OriginalFileType not in (select Componentname from #iFilters) 
and SourceTypeCode not in (select Componentname from #iFilters)
end