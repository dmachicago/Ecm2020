


declare @out table (out int) ;
declare @S as nvarchar(500) = 'select count(*) from KenticoCMS_3.information_schema.tables where table_name = ''CMS_User''' ;
insert into @out exec(@S) ;
select * from @out