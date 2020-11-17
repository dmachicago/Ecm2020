--select * from syscolumns where name like 'HFitUserMpiNumber'

SELECT t.name AS table_name,
SCHEMA_NAME(schema_id) AS schema_name,
c.name AS column_name
FROM sys.tables AS t
INNER JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
--WHERE c.name LIKE '%IsProfessionallyCollected%' 
WHERE c.name LIKE '%HealthAssesmentRiskCategory%' 
ORDER BY schema_name, table_name;

select v.Table_Name, c.Column_Name 
from INFORMATION_SCHEMA.VIEWS v
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = v.TABLE_SCHEMA
and c.TABLE_NAME = v.TABLE_NAME
and column_name like '%IsProfessionallyCollected%'

select * from view_EDW_HFit_HealthAssesmentUserQuestion
where CodeName = 'BloodPressure'
order by UserID

select TABLE_NAME, COLUMN_NAME,
CASE 
	when CHARINDEX('modified',COLUMN_NAME) > 0 THEN
		'**'
	ELSE
		''
END as ModDate
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME in(select ObjectName from TEMP_EDW_ViewObjects)
and DATA_TYPE = 'datetime'
order by TABLE_NAME, COLUMN_NAME 

select distinct TABLE_NAME from INFORMATION_SCHEMA.COLUMNS 
where TABLE_NAME like '%EDW%'
--and COLUMN_NAME like '%date%'
--and DATA_TYPE = 'datetime'

--Get the tables
SELECT t.name AS table_name,
--SCHEMA_NAME(schema_id) AS schema_name,
c.name AS column_name
FROM sys.tables AS t
left outer JOIN sys.columns c ON t.OBJECT_ID = c.OBJECT_ID
WHERE t.name in(select ObjectName from TEMP_EDW_ViewObjects) and system_type_id = 61 and c.name like '%date%'

union

--Get the views
select v.Table_Name, c.Column_Name 
from INFORMATION_SCHEMA.VIEWS v
join INFORMATION_SCHEMA.COLUMNS c on c.TABLE_SCHEMA = v.TABLE_SCHEMA
and c.TABLE_NAME = v.TABLE_NAME
and v.TABLE_NAME in(select ObjectName from TEMP_EDW_ViewObjects) 
and c.Column_Name like '%date%'

order by t.name
