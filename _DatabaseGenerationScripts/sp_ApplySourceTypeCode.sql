
if exists (select 1 from sys.procedures where name = 'sp_ApplySourceTypeCode')
	drop procedure sp_ApplySourceTypeCode;
go

if (select count(*) from DataSource where LTRIM(RTRIM(FQN)) = '' or FQN is null) > 0 
begin
	delete from DataSource where LTRIM(RTRIM(FQN)) = '';
end

go

-- select top 10 * from DataSOurce WHERE SOURCEGUID = 'ef15fce1-c7d0-4dcc-bcf5-135012f93925';
-- exec sp_ApplySourceTypeCode '.DOCX', '00256ad3-e5f4-4d40-8039-820edd14ba01'
if exists (select 1 from sys.procedures where name = 'sp_ApplySourceTypeCode')
	drop procedure sp_ApplySourceTypeCode;
go

create procedure sp_ApplySourceTypeCode (@MachineID nvarchar(80), @UserID nvarchar(50), @SourceName nvarchar(255), @FileExt nvarchar(50), @SourceGuid nvarchar(50))
as 
begin

	declare @ProcessAs as  nvarchar(50) ;
	set @ProcessAs = (select ProcessExtCode from ProcessFileAs where ExtCode = @FileExt);

	if @ProcessAs is not null 
	begin
		update DataSource set MachineID = @MachineID, DataSourceOwnerUserID = @UserID, UserID = @UserID,  [SourceTypeCode] = @ProcessAs, SourceName = @SourceName where SourceGuid = @SourceGuid ;
	end
	else 
	begin
		update DataSource set MachineID = @MachineID, DataSourceOwnerUserID = @UserID, UserID = @UserID, [SourceTypeCode] = @FileExt, SourceName = @SourceName where SourceGuid = @SourceGuid ;
	end

end

