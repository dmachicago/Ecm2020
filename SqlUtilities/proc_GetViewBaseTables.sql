
/***********************************************************
Copyright @ DMA Limited, June 2012, all rights reserved.
FIND a top level view's nested tables and views using a CTE.
Author: W. Dale Miller
Description:
  A recursive CTE requires four elements in order to work properly.
  Anchor query (runs once and the results ‘seed’ the Recursive query)
  Recursive query (runs multiple times and is the criteria for the remaining results)
  UNION ALL statement to bind the Anchor and Recursive queries together.
  INNER JOIN statement to bind the Recursive query to the results of the CTE.
***********************************************************/


/***************************************************************
exec proc_GetViewBaseTables 'view_EDW_HealthAssesment'
exec proc_GetViewBaseTablesExpanded 'view_EDW_HealthAssesment'
exec proc_GetViewBaseTables 'View_EDW_HealthAssesmentQuestions'
exec proc_GetViewBaseTables 'view_EDW_BioMetrics'
exec proc_GetViewBaseTables 'view_EDW_TrackerCompositeDetails'
***************************************************************/

go

if exists (select name from sys.procedures where name = 'proc_GetViewBaseTables')
BEGIN
    drop procedure proc_GetViewBaseTables ;
END

GO
create procedure proc_GetViewBaseTables (@tgtView as nvarchar(100))
as 
begin
WITH mycte
    AS (SELECT 
               --TU.view_name
             TU.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS TU WITH (NOLOCK) 
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = TU.TABLE_NAME
          WHERE view_name = @tgtView

        UNION ALL

        SELECT 
             --  ISV.view_name
             ISV.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISV
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = ISV.TABLE_NAME
                        INNER JOIN mycte
                            ON ISV.view_name = mycte.table_name
    ) 

    SELECT DISTINCT  table_name, table_type
           FROM mycte
      ORDER BY
               table_name;
end 

go


if exists (select name from sys.procedures where name = 'proc_GetViewBaseTablesExpanded')
BEGIN
    drop procedure proc_GetViewBaseTablesExpanded ;
END
go
--exec proc_GetViewBaseTablesExpanded 'view_EDW_HealthAssesment'
create procedure proc_GetViewBaseTablesExpanded (@tgtView as nvarchar(100))
as 
begin
WITH mycte
    AS (SELECT 
               TU.view_name
             , TU.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS TU WITH (NOLOCK) 
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = TU.TABLE_NAME
          WHERE view_name = @tgtView

        UNION ALL

        SELECT 
               ISV.view_name
             , ISV.Table_Name
             , IST.TABLE_TYPE
               FROM
                    INFORMATION_SCHEMA.VIEW_TABLE_USAGE AS ISV
                        JOIN INFORMATION_SCHEMA.tables AS IST
                            ON IST.TABLE_NAME = ISV.TABLE_NAME
                        INNER JOIN mycte
                            ON ISV.view_name = mycte.table_name
    ) 

    SELECT DISTINCT view_name, table_name, table_type
           FROM mycte
      ORDER BY
               view_name, table_name;
end 

go

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
