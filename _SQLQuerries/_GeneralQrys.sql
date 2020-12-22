

select count(*) as NbrOfProcessedZips from DataSource where SourceGuid in (select distinct ParentGuid from DataSource)
select count(*) as NbrOfUNProcessedZips from DataSource where SourceGuid not in (select distinct ParentGuid from DataSource)

/* Really, you only have to run this one as the prior two are just used for verification */
update DataSource set ZipExploded = 'Y' where SourceGuid in
(
select SourceGuid from DataSource where SourceGuid in (select distinct ParentGuid from DataSource)
)



select * from PgmTrace order by CreateDate desc