if exists (select name from sys.objects where type = 'P' and name = 'UTIL_CorrectMispelling')
BEGIN
	drop procedure UTIL_CorrectMispelling ;
END
go
create proc UTIL_CorrectMispelling (@TBL as nvarchar(50), 
					@COL as nvarchar(75), 
					@BadSpelling as nvarchar(75), 
					@CorrectSpelling as nvarchar(75))
as 
BEGIN
	declare @SQL as nvarchar(2000) ;
	set @SQL = 'update ' + @TBL + ' set ' + @COL + ' = REPLACE(' + @COL + ' COLLATE Latin1_General_BIN, ''' + @BadSpelling + ''', ''' + @CorrectSpelling+''' ) 
		    where ' +  @COL + ' like ' + '''%' + @BadSpelling + '%''' ;
	print (@SQL) ;
	exec (@SQL) ;
END
--update EDW_HealthAssessment 
--set UserRiskCategoryCodeName = REPLACE(UserRiskCategoryCodeName COLLATE Latin1_General_BIN, 'PreventitiveCare', 'PreventativeCare' )
--where UserRiskCategoryCodeName like '%PreventitiveCare%' 
exec UTIL_CorrectMispelling 'EDW_HealthAssessment', 'UserRiskAreaCodeName', 'Preventive Care', 'Preventative Care'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
