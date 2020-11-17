

select 'DROP' as evt, 'IF EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(''[dbo].'+name+'''))' +char(10) 
+ '     DROP TRIGGER [dbo].['+name+'] ' + char(10) + 'GO'
FROM sys.triggers 
union
select 'GEN' as evt, [definition] + 'GO' 
from sys.sql_modules m
inner join sys.objects obj on obj.object_id=m.object_id 
 where obj.type ='TR'
order by 1
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
