
--Copyright @ DMA Limited, October 2008, all rights reserved.
--Find view column ordinals and alias
--Author: W. Dale Miller
--FindViewColumnOrdinalsAlias
SELECT c.name as 'ColumnName', c.column_id as 'Ordinal' FROM sys.columns c, sys.views v
   WHERE c.object_id = v.object_id
   AND v.name = 'view_EDW_HealthAssesment'
--and c.name = 'UserQuestionCodeName'
GO
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
