SELECT  distinct 'Y' as Outdoor, LNAME, FNAME, E.email, p.email, CITY, ADDRESS, 
		--[COALITION: Hunter], OUTDOOR, 
		VETERAN, CHILDREN, MARRIED, E.GENDER, E.AGE, E.DOB, INCOME, 
		LANGUAGE, ETHNICITY, GOLF, TRAVEL_ARTS, POLITICAL, HEALTH, 
        hitech, bankcard, stockbonds, premiumbankcard, oilcard, 
		financecard, retailcard, RowNbr, STATE, ZIP
FROM     EmailAddress E, [PA_ALL_Tags] P
WHERE  ([PrimaryAddress1][ADDRESS] in (select [PrimaryAddress1] from [PA_ALL_Tags]))
and e.state = 'PA'
and ZIP in (select ZipCode from [PA_ZipCount])
and (OUTDOOR = 'Y' or [COALITION: Hunter] = 'X')
order by LNAME, FNAME

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
