

go 
print 'Executing view_EDW_CT_VersionTracking' ;
go
if exists (select name from sys.views where name = 'view_EDW_CT_VersionTracking')
    drop view view_EDW_CT_VersionTracking;
go

create view view_EDW_CT_VersionTracking
as 
SELECT
       *
       FROM CT_VersionTracking ;

go 
print 'Executed view_EDW_CT_VersionTracking' ;
go
