

/*
DECLARE @result VARCHAR(1000) ;
EXEC GenWhereInClause 'wmiller', 'C:\Users\wmiller\Desktop\Documents', @result OUTPUT
print @result  ;
*/

if exists (select 1 from sys.procedures where name  = 'GenWhereInClause')
	drop procedure GenWhereInClause;
go
create procedure GenWhereInClause(@UserID varchar(50), @DIR nvarchar(1000) ,@result nvarchar(1000) out) 
as 
begin
declare @r nvarchar(1000) = '' ;
--declare @result nvarchar(1000) = '' ;
--declare @UserID varchar(50) = 'wmiller';
--declare @DIR nvarchar(1000) = 'C:\Users\wmiller\Desktop\Documents';
select @r = + @r + N'''' + Extcode + N''',' from IncludedFiles where UserID = @UserID and fqn = @DIR;
set @result = '(' + @r + ')' ;
--print @result
end