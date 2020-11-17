--select COUNT(*) from Email
select distinct RecHash, COUNT(*) from Email 
group by RecHash
having COUNT(*) > 1

