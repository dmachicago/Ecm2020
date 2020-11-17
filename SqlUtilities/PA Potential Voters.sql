use [EmailAddr]
go
-- select top 100 * from [EmailAddress]
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT city, zip , count(*) as CNT FROM [EmailAddress]
where state = 'PA'
and (gender = 'F' or gender is null)
and cast(age as int) between 30 and 45
and cast(income as int) > 70000
and hitech = 'y'
group by city, zip
order by 3 desc
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
