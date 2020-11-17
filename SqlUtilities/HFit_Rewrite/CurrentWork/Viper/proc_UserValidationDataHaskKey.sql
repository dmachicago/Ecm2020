
-- exec proc_UserValidationDataHaskKey
alter procedure proc_UserValidationDataHaskKey
as
begin 
    
    update UserValidationData
    set MpiHashKey =  HASHBYTES('SHA1', isnull(FirstName, '-') 
				    + isnull(MiddleInit,'-') 
				    + isnull(LastName,'-') 
				    + isnull(cast(BirthDate as nvarchar(25)), '-')
				    + isnull(SSN,'-'))
    where MpiHashKey is null ;

end 