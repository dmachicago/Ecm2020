alter trigger SetHashUpdatePA on dbo.PA_ALL_Tags
after update, insert
as
begin
 set nocount on
 IF ( UPDATE(LastName) OR UPDATE(FirstName) or UPDATE(MiddleName) )
	BEGIN
		update PA_ALL_Tags
		set RowHash = HASHBYTES('SHA1', i.PrimaryAddress1 + i.LastName + i.FirstName + i.PrimaryState)	,		 
		LastName=UPPER(LEFT(i.LastName,1))+LOWER(SUBSTRING(i.LastName,2,LEN(i.LastName))), 
		FirstName=UPPER(LEFT(i.FirstName,1))+LOWER(SUBSTRING(i.FirstName,2,LEN(i.FirstName))),
		MiddleName=UPPER(LEFT(i.MiddleName,1))+LOWER(SUBSTRING(i.MiddleName,2,LEN(i.MiddleName)))
		from inserted as i
		inner join PA_ALL_Tags on PA_ALL_Tags.RowNbr = i.RowNbr
	END 
end  --  
  --  
GO 
print('***** FROM: triggerSetHashUpdatePA.sql'); 
GO 
