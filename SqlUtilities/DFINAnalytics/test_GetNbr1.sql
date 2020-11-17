
declare @i int ;
exec @i = test_GetNbr1;
print @i;
go
create procedure test_GetNbr1
as
return 10;