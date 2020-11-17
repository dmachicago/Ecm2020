UPDATE Email 
set RecHash = 
HashBytes('md5', subject + cast(body as varchar) + cast (CreationTime as varchar) + SenderEmailAddress + CAST(nbrAttachments as varchar) + SourceTypeCode)


select distinct count(*), RecHash  from Email 
group by RecHash
having COUNT(*) > 2
order by RecHash

select * from Email where RecHash = '02344f1b5e6ecf3d01976f51bdd58753'

select top 4 * from email


select count(*) from Email where RecHash is not null

update Email set RecHash = NULL where RecHash is not null