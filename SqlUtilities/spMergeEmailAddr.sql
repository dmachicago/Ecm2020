Alter Proc spMergeEmailAddr 
	@Address nvarchar(100), 
	@City nvarchar(100), 
	@State nvarchar(10),
	@FName nvarchar(50),
	@LName nvarchar(50)
as
SET ANSI_NULLS ON ;
declare @xAddress nvarchar(100) = @Address ;
declare @xCity nvarchar(100) = @City  ;
declare @xState nvarchar(10) = @State;
declare @xFName nvarchar(50) = @FName ;
declare @xLName nvarchar(50) = @LName ;

DECLARE @combinedString VARCHAR(MAX)
SELECT @combinedString = COALESCE(@combinedString + ' : ', '') + email
FROM EmailAddress
WHERE 
	[ADDRESS] = @xAddress 
	and [CITY] = @xCity
	and [STATE] = @xState
	and [FNAME] = @xFName
	and [LNAME] = @xLName
SELECT @combinedString as StringValue ;


--exec spMergeEmailAddr 'PO BOX 193', 'KENT', 'CT','Catherine', 'Mahoney'
select top 100 * from EmailAddress

SET STATISTICS IO ON;
DBCC FREEPROCCACHE;
exec spTextx 'PO BOX 193', 'KENT', 'CT', 'Catherine', 'Mahoney';
go

go
alter proc spTextx @Address nvarchar(50), 
	@City nvarchar(50), 
	@State nvarchar(50),
	@FName nvarchar(50),
	@LName nvarchar(50)
	WITH RECOMPILE
as
DECLARE @combinedString VARCHAR(MAX)
SELECT @combinedString = COALESCE(@combinedString + ' : ', '') + email
FROM EmailAddress
WHERE 
	[ADDRESS] = @Address
	and [CITY] = @City
	and [STATE] = @State
	and [FNAME] = @FName
	and [LNAME] = @LName
SELECT @combinedString as StringValue ;

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
