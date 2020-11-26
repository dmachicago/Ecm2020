DROP TABLE IF EXISTS #tmp
go
create table #tmp (
	COMPONENTTYPE nvarchAR(100),
	COMPONENTname nvarchAR(100),
	clsid nvarchAR(100),
	fullpath nvarchAR(100),
	version nvarchAR(100),
	Manufacturer nvarchAR(100)
)
go
insert into #tmp
EXEC sp_help_fulltext_system_components 'filter';    
go
delete from loadprofile where ProfileName = 'All Filters';
go
insert into loadprofile (ProfileName, ProfileDesc) values ('All Filters','All filters registered on the current server');
go
delete from LoadProfileItem where ProfileName = 'All Filters';
go
delete from sourcetype where SourceTypeCode in (select lower(ComponentName) from #tmp  )
go
insert into sourcetype (SourceTypeCode, SourceTypeDesc) 
select distinct ComponentName, Manufacturer from #tmp
go
insert into LoadProfileItem (ProfileName, SourceTypeCode) 
select distinct 'All Filters', lower(ComponentName) from #tmp;
 
--select * from sourcetype
--select * from LoadProfileItem
go
DROP TABLE IF EXISTS #tmpGraphic
go
create table #tmpGraphic (
	GraphicFileTypeExt nvarchAR(50)
)
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.AI');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.BMP');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.EPS');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.GIF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.HEIF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.INDD');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JFI');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JFIF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JIF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JPE');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JPEG');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JPEG 2000');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.JPG');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.PNG');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.PSD');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.RAW');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.SVG');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.TIF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.TIFF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.TRF');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.WEBP');
go
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jfi');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jfif');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jif');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jpe');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.webp');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.psd');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.k25');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.nrw');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.cr2');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.arw');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.dib');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.heic');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.heif');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.indt');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.indd');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.ind');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.mj2');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jpm');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jpx');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jpf');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.j2k');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.jp2');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.svgz');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.svg');
insert into #tmpGraphic(GraphicFileTypeExt) values ('.eps');
go
delete from GraphicFileType where GraphicFileTypeExt in (select distinct GraphicFileTypeExt from #tmpGraphic)
go
INSERT INTO GraphicFileType (GraphicFileTypeExt)
SELECT GraphicFileTypeExt from #tmpGraphic
EXCEPT
SELECT GraphicFileTypeExt from GraphicFileType
-- select * from GraphicFileType