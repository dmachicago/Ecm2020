go

print 'EXecute PrintNow.sql' ;

go

if exists (select name from sys.procedures where name = 'PrintNow')
    DROP PROCEDURE [dbo].[PrintNow] ;

GO

create procedure [dbo].[PrintNow] (@msg as nvarchar(500))
as
begin
raiserror (@msg, 10,1) with nowait;
end 


GO


print 'Executed PrintNow.sql' ;

go
