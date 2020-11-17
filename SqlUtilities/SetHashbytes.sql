update PA_ALL_TAGS set RowHash = HASHBYTES('SHA1', PrimaryAddress1 + LastName + FirstName + PrimaryState)
go
update EmailAddress set RowHash = HASHBYTES('SHA1', [ADDRESS] + LNAME + FNAME + [STATE])
where [state] = 'PA'
go
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
