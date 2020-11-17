
Print('Generating: UTIL_CorrectMispelling');
GO

if exists (select name from sys.objects where type = 'P' and name = 'UTIL_CorrectMispelling')
BEGIN
	drop procedure UTIL_CorrectMispelling ;
END
go
create proc UTIL_CorrectMispelling (@TBL as nvarchar(50), 
					@COL as nvarchar(75), 
					@BadSpelling as nvarchar(75), 
					@CorrectSpelling as nvarchar(75), 
					@LastModDateColName as nvarchar(75),
					@CountOnly as nchar(1))
as 
BEGIN
	--BASIS:
		--update EDW_HealthAssessment 
		--set UserRiskCategoryCodeName = REPLACE(UserRiskCategoryCodeName COLLATE Latin1_General_BIN, 'PreventitiveCare', 'PreventativeCare' )
		--where UserRiskCategoryCodeName like '%PreventitiveCare%' 
	--USE: exec UTIL_CorrectMispelling 'EDW_HealthAssessment', 'UserRiskAreaCodeName', 'Preventive Care', 'Preventative Care', 'ItemModifiedWhen', NULL
	--USE: exec UTIL_CorrectMispelling 'EDW_HealthAssessment', 'UserRiskAreaCodeName', 'Preventive Care', 'Preventative Care', 'ItemModifiedWhen', 'Y'

	declare @SQL as nvarchar(2000) ;
	if (@CountOnly is NOT null)
	Begin
		set @SQL = 'Select count(*) from ' + @TBL + ' where ' +  @COL + ' like ' + '''%' + @BadSpelling + '%''' ;
	End
	Else
	Begin	
		set @SQL = 'update ' + @TBL + ' set ' + @COL + ' = REPLACE(' + @COL + ' COLLATE Latin1_General_BIN, ''' + @BadSpelling + ''', ''' + @CorrectSpelling+''' ) 
				,' + @LastModDateColName + ' = getdate() where ' +  @COL + ' like ' + '''%' + @BadSpelling + '%''' ;
	End
	print (@SQL) ;
	exec (@SQL) ;
END



GO
