--select * from EmailAddress
--where FName = 'Marisa'
--and Lname = 'Abbott' 
--and [address] = '237 Van Meter Rd'
--and City = 'Belle Vernon'

--Remove Duplicate Emails
use EmailAddr
go
/****** Script for SelectTopNRows command from SSMS  ******/
SET NOCOUNT off
PRINT getdate()

DECLARE @EmailCursor CURSOR
DECLARE @RowCursor CURSOR
declare @CNT int
declare @EMAIL varchar(500) 
declare @FNAME varchar(50) 
declare @LNAME varchar(50) 
declare @ADDRESS varchar(50) 
declare @CITY varchar(50) 
declare @STATE varchar(50) 
declare @HASH varchar(50) 
declare @ROWNBR int
declare @CombinedEmails nvarchar(250) 
declare @icnt int
declare @iDups int
declare @iAddr int
DECLARE @combinedString VARCHAR(2000);

set @icnt = 0 ;

SET @RowCursor = CURSOR FOR
SELECT FirstName
      ,LastName
      ,PrimaryAddress1
      ,PrimaryCity
FROM PA_ALL_Tags;

OPEN @RowCursor;
FETCH NEXT
	FROM @RowCursor INTO @FNAME , @LNAME , @ADDRESS, @CITY

WHILE @@FETCH_STATUS = 0 
BEGIN
		set @EMAIL = (SELECT top 1 EMAIL
			FROM PA
			WHERE [ADDRESS] = @ADDRESS 
					and [FIRST NAME] = @FNAME
					and [LAST NAME] = @LNAME
					and CITY = @CITY
					and [STATE] = 'PA3') 	
			if @EMAIL is not null 
			BEGIN 
				set @iAddr = @iAddr + 1;
				print 'EM: ' + @EMAIL

				update PA_ALL_Tags set EMail = @EMAIL
					where PrimaryAddress1 = @ADDRESS
						and FirstName = @FNAME
						and LastName = @LNAME
						and PrimaryCity = @CITY
						and EMAIL is null ;
			END		
		
		

		--print SYSDATETIME() ;
		--print '-----'
		FETCH NEXT
				FROM @RowCursor INTO @FNAME , @LNAME , @ADDRESS, @CITY

	END
CLOSE @RowCursor
DEALLOCATE @RowCursor

PRINT getdate()
select * from PA_ALL_Tags where email is null ;

select * from EmailAddress
where [ADDRESS] like '334 Spring Rd'
and CITY = 'Belle Vernon'
and FNAME = 'xx'
and LNAME = 'axx' 

and [state] = 'PA'


†ⴭ†਍†ⴭ†਍佇ഠ瀊楲瑮✨⨪⨪‪剆䵏›潐異慬整慐浅楡獬畃獲牯献汱⤧※਍佇ഠ�