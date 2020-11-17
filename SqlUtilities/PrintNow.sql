

go
print 'Creating procedure PrintNow' ;
print 'FROM PrintNow.sql' ;
go
if exists (select name from sys.procedures where name = 'PrintNow')
    drop procedure PrintNow;

go

create procedure PrintNow (@msg as nvarchar(500))
as
begin
raiserror (@msg, 10,1) with nowait;
end 

go
print 'Created procedure PrintNow' ;

go

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
