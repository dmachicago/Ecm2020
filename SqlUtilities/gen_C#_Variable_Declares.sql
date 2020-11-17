

SELECT 'string ' + [StdColumnName] + ' = "" ; ' 
  FROM [ViperMY].[dbo].[ColumnStandardNames]
  where StdColumnName not like '%[_]standardized'  
union
SELECT 'int i'+[StdColumnName] + ' = 0 ; ' 
  FROM [ViperMY].[dbo].[ColumnStandardNames]
  where StdColumnName not like '%[_]standardized'   


SELECT 'if (FtpFileCols.TryGetValue("' + [StdColumnName] + '", out i'+[StdColumnName]+')) ' + [StdColumnName] + ' = colData[i' + [StdColumnName] + '];'
  FROM [ViperMY].[dbo].[ColumnStandardNames]
  where StdColumnName not like '%[_]standardized'


-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
