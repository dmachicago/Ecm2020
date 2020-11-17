SELECT STUFF((SELECT [email] + '; '
			  FROM EmailAddress
			  WHERE [ADDRESS] = '1 Westmoreland Dr' and [state] = 'PA'
			  ORDER BY [email]
			  FOR XML PATH('')), 1, 1, '') AS [Output]

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
