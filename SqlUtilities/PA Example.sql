--select top 100 * from EmailAddress where state = 'pa' and City like 'PHIL%'

select count(*) from EmailAddress 
where 
state = 'pa'
and FEMALEOCCCODE != '0' 
and cast(age as int) between 45 and 65
and cast(income as int) > 45000
and FEMALEOCCCODE is not null
and City like 'PHIL%'

select distinct CITY, count(*) 
from EmailAddress
where 
state = 'pa'
group by CITY
order by CITY

select distinct ZIP, count(*) as CNT
from EmailAddress
where 
state = 'pa' and CITY like 'PHIL%'
group by ZIP
order by CNT desc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
