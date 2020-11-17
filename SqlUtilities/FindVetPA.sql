drop table PA_Vets
go
SELECT DISTINCT 
                  'VET' AS CLS, PA_ALL_Tags.PartyCode, PA_ALL_Tags.PrimaryAddress1, PA_ALL_Tags.LastName, PA_ALL_Tags.FirstName, PA_ALL_Tags.MiddleName, 
                  PA_ALL_Tags.SuffixName, PA_ALL_Tags.PrimaryPhone,
				  EmailAddress.EmailAll as DMAEmail, PA_ALL_Tags.EMail as PAEmail, 
				  PA_ALL_Tags.PrimaryCity, PA_ALL_Tags.PrimaryZip, PA_ALL_Tags.PrimaryZip4, PA_ALL_Tags.DOB, PA_ALL_Tags.Age, PA_ALL_Tags.Gender, 
                  PA_ALL_Tags.PrecinctNumber, PA_ALL_Tags.PrecinctName, PA_ALL_Tags.[COALITION: Hunter], PA_ALL_Tags.[COALITION: Sportsman], EmailAddress.MARRIED, 
                  EmailAddress.CHILDREN, EmailAddress.INCOME, EmailAddress.HOMEOWNER, EmailAddress.LANGUAGE, EmailAddress.GOLF, EmailAddress.OUTDOOR, 
                  EmailAddress.POLITICAL, 				  
				  EmailAddress.hitech, EmailAddress.bankcard, EmailAddress.stockbonds, 
                  EmailAddress.premiumbankcard, EmailAddress.oilcard, EmailAddress.financecard, EmailAddress.retailcard, EmailAddress.SOURCE, PA_ALL_Tags.[COALTION: Catholic], 
                  PA_ALL_Tags.[COALITION: Social Conservative], PA_ALL_Tags.[COALITION: Agriculture], PA_ALL_Tags.[COALITION: Evangelical], EmailAddress.ETHNICITY, 
                  EmailAddress.TRAVEL_ARTS, EmailAddress.HEALTH, EmailAddress.OPTDATE, EmailAddress.VETERAN
INTO PA_Vets
FROM     PA_ALL_Tags LEFT OUTER JOIN
                  EmailAddress ON PA_ALL_Tags.PrimaryCity = EmailAddress.CITY AND PA_ALL_Tags.LastName = EmailAddress.LNAME AND 
                  PA_ALL_Tags.FirstName = EmailAddress.FNAME AND PA_ALL_Tags.PrimaryZip = EmailAddress.ZIP AND PA_ALL_Tags.PrimaryState = EmailAddress.STATE AND 
                  PA_ALL_Tags.PrimaryAddress1 = EmailAddress.ADDRESS
WHERE  ((PA_ALL_Tags.[COALITION: Veteran] = 'X') OR
                  (EmailAddress.VETERAN = 'Y'))
				  --and (EmailAddress.EmailAll is not null
				  --or PA_ALL_Tags.Email is not null)
ORDER BY PA_ALL_Tags.PrimaryAddress1, PA_ALL_Tags.PrimaryCity, PA_ALL_Tags.LastName, PA_ALL_Tags.FirstName

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
