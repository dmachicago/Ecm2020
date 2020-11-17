alter  trigger SetHashUpdate on dbo.EmailAddress
after update, insert
as
begin
 set nocount on
 IF ( UPDATE(LName) OR UPDATE(fname) )
	BEGIN
		 update EmailAddress
		 set RowHash = HASHBYTES('SHA1', i.[address] + i.LName + i.Fname + i.[State]),
				LName=UPPER(LEFT(i.LName,1))+LOWER(SUBSTRING(i.LName,2,LEN(i.LName))), 
				fname=UPPER(LEFT(i.fname,1))+LOWER(SUBSTRING(i.fname,2,LEN(i.fname)))
		 from inserted as i
		 inner join EmailAddress on EmailAddress.RowNbr = i.RowNbr
 END
end
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
