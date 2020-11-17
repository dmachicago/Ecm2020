
IF EXISTS (SELECT
                  object_id ('tempdb..#FACT_TBL')) 
    BEGIN
        DROP TABLE
             #FACT_TBL;
    END;
GO
SELECT DISTINCT
       o.id
     , o.name AS 'Procedure_Name'
     , oo.name AS 'Table_Name'
     , d.depid
--, d.depnumber  -- comment this out returns unique tables only
INTO
     #FACT_TBL
FROM sysdepends AS d , sysobjects AS o , sysobjects AS oo
WHERE
o.id = d.id
--AND o.name like 'proc_GenTrackerFactTable'   -- Stored Procedure Name
AND
oo.id = d.depid
--and depnumber=1
ORDER BY
         o.name , oo.name;
GO
DELETE FROM #FACT_TBL
WHERE
      TABLE_NAME NOT IN (SELECT
                                TABLE_NAME
                         FROM information_schema.tables
                         WHERE
                                table_type = 'BASE TABLE') ;
GO
SELECT
       *
FROM #FACT_TBL
WHERE Table_name LIKE '%base[_]%'
union
SELECT
       *
FROM #FACT_TBL
WHERE Table_name LIKE '%view[_]%'
order by Table_name, Procedure_Name
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
