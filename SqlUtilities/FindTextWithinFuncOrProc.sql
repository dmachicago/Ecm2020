SELECT ROUTINE_NAME, ROUTINE_DEFINITION , ROUTINE_TYPE
	FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE ROUTINE_DEFINITION LIKE '%udf_HasProfessionallyCollectedData%' 
		AND (ROUTINE_TYPE='FUNCTION' or ROUTINE_TYPE='PROCEDURE')
	ORDER BY ROUTINE_NAME
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
