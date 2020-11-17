select top 100 * from EmailAddress where state = 'PA'
and  address = '1 2ND ST'

DECLARE @ret nvarchar(150)= NULL; 
EXEC @ret = DBO.funcMergeEmailAddr '1 2ND ST', 'HERMINIE', 'PA' ;
print (@ret);

alter FUNCTION funcMergeEmailAddr(@StreetAddr nvarchar(100), @City  nvarchar(50), @State nvarchar(10)) 
       RETURNS nvarchar (250)
AS 
BEGIN; 
	DECLARE @combinedString VARCHAR(2000);
	DECLARE @cString VARCHAR(2000);
	SELECT @combinedString = COALESCE(@combinedString + ' : ', '') + email
	FROM EmailAddress
	WHERE [ADDRESS] = @StreetAddr 
		and [state] = @State 
		and CITY = @City;
	set @cString = (SELECT @combinedString );
  RETURN @cString ;
END; 
go 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
