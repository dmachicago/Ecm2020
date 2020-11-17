--Remove Duplicate Emails
use EmailAddr
go
/****** Script for SelectTopNRows command from SSMS  ******/
SET NOCOUNT OFF
go
PRINT getdate()
drop TABLE #EmailAddressDups;
go
CREATE TABLE #EmailAddressDups (CNT int, [FNAME] VARCHAR(50), [LNAME] VARCHAR(50), [ADDRESS] VARCHAR(50),[CITY] VARCHAR(50), [STATE] varchar(50), RowHash nvarchar(50) );
INSERT INTO #EmailAddressDups (CNT
      ,[FNAME]
      ,[LNAME]
      ,[ADDRESS]
      ,[CITY]
	  ,[STATE]
	  ,RowHash) 
SELECT DISTINCT count(*)
      ,[FNAME]
      ,[LNAME]
      ,[ADDRESS]
      ,[CITY]
	  ,[STATE] 
	  ,[RowHash]
  FROM [EmailAddr].[dbo].[EmailAddress]  
  where state = 'PA'    
  group by [FNAME]
      ,[LNAME]
      ,[ADDRESS]
      ,[CITY] 
	  ,[STATE] 
	  ,[RowHash]    
having count(*) > 1
go
PRINT getdate()

DECLARE @EmailCursor CURSOR
DECLARE @RowCursor CURSOR
declare @CNT int
declare @FNAME varchar(50) 
declare @LNAME varchar(50) 
declare @ADDRESS varchar(50) 
declare @CITY varchar(50) 
declare @STATE varchar(50) 
declare @HASH varchar(50) 
declare @ROWHASH nvarchar(50) 
declare @CombinedEmails nvarchar(250) 
declare @icnt int
declare @iDups int
declare @iAddr int
DECLARE @combinedString VARCHAR(2000);

set @icnt = 0 ;

SET @RowCursor = CURSOR FOR
SELECT CNT
      ,[FNAME]
      ,[LNAME]
      ,[ADDRESS]
      ,[CITY]
	  ,[STATE]
	  ,[RowHash]
FROM #EmailAddressDups;
OPEN @RowCursor;
FETCH NEXT
	FROM @RowCursor INTO @CNT, @FNAME , @LNAME , @ADDRESS, @CITY , @STATE , @ROWHASH

WHILE @@FETCH_STATUS = 0 
BEGIN
		set @combinedString = '' ;
		set @icnt = @icnt + 1 ;
		--print SYSDATETIME() ;
		SELECT @combinedString = COALESCE(@combinedString + ' : ', '') + email
			FROM EmailAddress
			WHERE [ADDRESS] = @ADDRESS and [RowHash] = @ROWHASH;
		--print 'C: ' + @combinedString ;
		update EmailAddress set EmailAll = @combinedString WHERE [ADDRESS] = @ADDRESS and [RowHash] = @ROWHASH; 

		--print SYSDATETIME() ;
		--print '-----'
		FETCH NEXT
				FROM @RowCursor INTO  @CNT, @FNAME , @LNAME , @ADDRESS, @CITY , @STATE, @ROWHASH

	END
CLOSE @RowCursor
DEALLOCATE @RowCursor

PRINT getdate()
select top 1000 * from EmailAddress where state = 'PA'

update EmailAddress set emailall = email where emailall is null


--DELETE
--FROM EmailAddress
--WHERE RowNbr NOT IN
--(
--SELECT MAX(RowNbr)
--FROM EmailAddress
--Where [STATE] = 'PA'
--GROUP BY [address], RowHash)
--and [State] = 'PA'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
