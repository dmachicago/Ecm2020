
use KenticoCMS_Datamart_2
go

if not exists (Select name from sys.tables where name = 'dups')
    create table dups (code nvarchar(50)) ;

insert into dups (code) values ('XX') ;
insert into dups (code) values ('XX') ;
insert into dups (code) values ('XX') ;
insert into dups (code) values ('XX') ;
insert into dups (code) values ('YY') ;
insert into dups (code) values ('YY') ;
insert into dups (code) values ('YY') ;
insert into dups (code) values ('ZZ') ;
insert into dups (code) values ('ZZ') ;
insert into dups (code) values ('AA') ;
insert into dups (code) values ('BB') ;
insert into dups (code) values ('CC') ;

select * from dups

USE KenticoCMS_Datamart_2;
GO
WITH CTE (
   code
   , DuplicateCount) 
    AS (
    SELECT
          code
         , ROW_NUMBER () OVER (PARTITION BY code ORDER BY code) AS DuplicateCount
    FROM dups
    ) 
delete
    FROM CTE
    WHERE
           DuplicateCount > 1; 

select * from #TEMP_XX
select * from dups
