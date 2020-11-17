use [TS_PSCAR_Data];
go

declare @stmt nvarchar(4000);

set @stmt = 'ALTER INDEX ALL ON ? REORGANIZE ' ;
exec sp_MsForEachTable @stmt ;