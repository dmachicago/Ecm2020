USE [ECM.Library.FS]
GO
/****** Object:  User [ecmadmin]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ecmadmin] FOR LOGIN [ecmadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ECMLibrary]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ECMLibrary] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecmlogin]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ecmlogin] FOR LOGIN [BUILTIN\Administrators]
GO
/****** Object:  User [ecmocr]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ecmocr] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecmsys]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ecmsys] FOR LOGIN [ecmsys] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ecmuser]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE USER [ecmuser] FOR LOGIN [ecmuser] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ECMLibrary]
GO
ALTER ROLE [db_owner] ADD MEMBER [ecmocr]
GO
/****** Object:  Schema [lsnr]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE SCHEMA [lsnr]
GO
/****** Object:  FullTextCatalog [EM_IMAGE]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [EM_IMAGE] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftCatalog]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftCatalog] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftDataSource]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftDataSource] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftDataSourceImage]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftDataSourceImage] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftEmail]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftEmail] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftEmailAttachment]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftEmailAttachment] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  FullTextCatalog [ftEmailCatalog]    Script Date: 11/20/2020 1:41:14 PM ******/
CREATE FULLTEXT CATALOG [ftEmailCatalog] WITH ACCENT_SENSITIVITY = OFF
GO
/****** Object:  UserDefinedFunction [dbo].[BinToBase64]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[BinToBase64](@Bin varbinary(max)) returns varchar(max) 
as begin   
	return CAST(N'' AS XML).value('xs:base64Binary(xs:hexBinary(sql:variable("@Bin")))', 'VARCHAR(MAX)') 
end


GO
/****** Object:  UserDefinedFunction [dbo].[CalcRetentionDate]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[CalcRetentionDate] (@SourceGuid nvarchar(50), @RetentionCode nvarchar(50), @StartDate datetime)
returns datetime
AS
begin
	Declare @RetentionPeriod nvarchar(50), @RetentionUnits int, @CalcDate datetime

	set @RetentionPeriod = (Select RetentionPeriod from Retention where Retention.RetentionCode = @RetentionCode) 
	set @RetentionUnits = (Select RetentionUnits from Retention where Retention.RetentionCode = @RetentionCode) 

	if @RetentionPeriod is null Begin
		set @RetentionPeriod = (SELECT MAX(RetentionUnits) from Retention where RetentionPeriod = 'Year')
	END

	if @RetentionPeriod = 'Day' begin
		set @CalcDate = DATEADD(day,@RetentionUnits,getdate()) 		
	END
	if @RetentionPeriod = 'Month' begin
		set @CalcDate = DATEADD(month,@RetentionUnits,getdate()) 		
	END
	if @RetentionPeriod = 'Year' begin
		set @CalcDate = DATEADD(year,@RetentionUnits,getdate()) 		
	END
	return (@CalcDate) ;
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnDefaultExists]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnDefaultExists] ( 
                @TBL NVARCHAR(250) , 
                @COL NVARCHAR(250)
                                ) 
RETURNS INT
AS
     BEGIN
         DECLARE @b INT= 0;
         IF NOT EXISTS ( SELECT 1
                         FROM INFORMATION_SCHEMA.COLUMNS
                         WHERE TABLE_NAME = @TBL
                               AND 
                               COLUMN_NAME = @COL
                               AND 
                               COLUMN_DEFAULT IS NOT NULL
                       ) 
             BEGIN
                 SET @b = 0;
         END;
             ELSE
             BEGIN
                 SET @b = 1;
         END;
         RETURN @b;
     END;
GO
/****** Object:  UserDefinedFunction [dbo].[getAdmin]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getAdmin](@userLoginID nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
        DECLARE @UserAdmin nvarchar(max) = ''

        SET @UserAdmin = (SELECT TOP 1 admin FROM Users WHERE UserLoginID = @userLoginID)

        RETURN @UserAdmin
END
GO
/****** Object:  UserDefinedFunction [dbo].[getSQLHash]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[getSQLHash]
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @result NVARCHAR(150)= '';
set @result = (select convert(char(128), HASHBYTES('sha2_512', @FullName), 1));
RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[getUserID]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getUserID](@userLoginID nvarchar(max))
RETURNS nvarchar(max)
AS
BEGIN
        DECLARE @UserID nvarchar(max) = ''

        SET @UserID = (SELECT TOP 1 userid FROM Users WHERE UserLoginID = @userLoginID)

        RETURN @UserID
END
GO
/****** Object:  UserDefinedFunction [dbo].[Isfullpath]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Isfullpath]
(@FullName VARCHAR(500)
)
RETURNS BIT
AS
BEGIN
DECLARE @result BIT;
IF CHARINDEX('\', @FullName) = 0
SET @result = 0;
ELSE
SET @result = 1;
RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[IsGuid]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[IsGuid] ( @testString varchar(38))
returns int
as
begin
    declare @ret int
    select  @ret = 0,
            @testString = replace(replace(@testString, '{', ''), '}', '')
    if len(isnull(@testString, '')) = 36 and
       @testString NOT LIKE '%[^0-9A-Fa-f-]%' and
       -- check for proper positions of hyphens (-)  
       charindex('-', @testString) = 9 and 
       charindex('-', @testString, 10) = 14 and 
       charindex('-', @testString, 15) = 19 and 
       charindex('-', @testString, 20) = 24 and 
       charindex('-', @testString, 25) = 0
          set @ret = 1
    
    return @ret
end


GO
/****** Object:  UserDefinedFunction [dbo].[LastIndexOf]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LastIndexOf](@source nvarchar(4000), @pattern char)
RETURNS int
BEGIN
RETURN (LEN(@source)) -  CHARINDEX(@pattern, REVERSE(@source))
END;
GO
/****** Object:  UserDefinedFunction [dbo].[PathfFilename]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*   HOW TO USE:
SELECT dbo.PathfFilename('C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2\MSSQL\Log\system_health_0_131996396680890000.xel')
*/

CREATE FUNCTION [dbo].[PathfFilename]
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @FindChar VARCHAR(1)= '\';
DECLARE @result VARCHAR(500)= '';
IF(dbo.Isfullpath(@FullName) = 1)
SET @result =
(
SELECT RIGHT(@FullName, CHARINDEX(@FindChar, REVERSE(@FullName)) - 1)
);
RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[Pathfromfullname]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*   HOW TO USE:
SELECT dbo.Pathfromfullname('C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2\MSSQL\Log\system_health_0_131996396680890000.xel')
*/

CREATE FUNCTION [dbo].[Pathfromfullname]
(@FullName VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
DECLARE @result VARCHAR(500);
IF(dbo.Isfullpath(@FullName) = 1)
SELECT @result = LEFT(@FullName, LEN(@FullName) - CHARINDEX('\', REVERSE(@FullName)));
RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[sp_ecmGenHashString]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[sp_ecmGenHashString] (@StringToHash nvarchar)
returns nvarchar(50)
as
begin
	DECLARE @HashVal nvarchar(50)
	DECLARE @hash varbinary(max)
	SELECT @hash = HashBytes('SHA1', @StringToHash)
    set @HashVal = SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @StringToHash)), 3, 50) 
    set @HashVal = master.dbo.fn_varbintohexsubstring(0,@hash,0,0)
    return @HashVal
end


GO
/****** Object:  UserDefinedFunction [dbo].[sp_genHashString]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[sp_genHashString] (@StringToHash nvarchar)
returns nvarchar
as
begin
	return SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @StringToHash)), 3, 50) 
end


GO
/****** Object:  UserDefinedFunction [dbo].[sp_GetContent]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sp_GetContent](@SourceGuid nvarchar)
RETURNS varbinary(MAX)
AS
BEGIN
DECLARE @Source varbinary(max)
SELECT @Source = SourceImage
FROM DataSource
WHERE SourceGuid = @SourceGuid
RETURN @Source
END


GO
/****** Object:  UserDefinedFunction [dbo].[sp_GetSourceContent]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sp_GetSourceContent](@SourceGuid nvarchar)
RETURNS varbinary(MAX)
AS
BEGIN
DECLARE @Source varbinary(max)
SELECT @Source = SourceImage
FROM DataSource
WHERE SourceGuid = @SourceGuid
RETURN @Source
END


GO
/****** Object:  UserDefinedFunction [dbo].[sp_SHA512_128]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[sp_SHA512_128] (@strtext varchar(1000))
RETURNS varchar(128) AS
BEGIN
	declare @hash varchar(128) = '';
    set @hash = (SELECT convert(char(125), HASHBYTES('sha2_512', @strtext), 2 ));
    RETURN @hash
END
GO
/****** Object:  UserDefinedFunction [dbo].[spEcmDateConvert]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spEcmDateConvert]
(
	@Date datetime,
	@fORMAT VARCHAR(80)
)
RETURNS NVARCHAR(80)
AS
BEGIN
	DECLARE @nDateFmt INT
	DECLARE @vcReturnDte VARCHAR(80)
	DECLARE @TwelveHourClock INT
	DECLARE @Before INT
	DECLARE @pos INT
	DECLARE @Escape INT 
-- (c) Dale Miller 2010
SELECT @vcReturnDte='error! unrecognised format '+@format
SELECT @nDateFmt=CASE @format
	WHEN 'mmm dd yyyy hh:mm AM/PM' THEN 100
	WHEN 'mm/dd/yy' THEN 1
	WHEN 'mm/dd/yyyy' THEN 101
	WHEN 'yy.mm.dd' THEN 2
	WHEN 'dd/mm/yy' THEN 3
	WHEN 'dd.mm.yy' THEN 4
	WHEN 'dd-mm-yy' THEN 5
	WHEN 'dd Mmm yy' THEN 6
	WHEN 'Mmm dd, yy' THEN 7
	WHEN 'hh:mm:ss' THEN 8
	WHEN 'yyyy.mm.dd' THEN 102
	WHEN 'dd/mm/yyyy' THEN 103
	WHEN 'dd.mm.yyyy' THEN 104
	WHEN 'dd-mm-yyyy' THEN 105
	WHEN 'dd Mmm yyyy' THEN 106
	WHEN 'Mmm dd, yyyy' THEN 107
	WHEN 'Mmm dd yyyy hh:mm:ss:ms AM/PM' THEN 9
	WHEN 'Mmm dd yyyy hh:mi:ss:mmm AM/PM' THEN 9
	WHEN 'Mmm dd yy hh:mm:ss:ms AM/PM' THEN 109
	WHEN 'mm-dd-yy' THEN 10
	WHEN 'mm-dd-yyyy' THEN 110
	WHEN 'yy/mm/dd' THEN 11
	WHEN 'yyyy/mm/dd' THEN 111
	WHEN 'yymmdd' THEN 12
	WHEN 'yyyymmdd' THEN 112
	WHEN 'dd Mmm yyyy hh:mm:ss:Ms' THEN 113
	WHEN 'hh:mm:ss:Ms' THEN 14
	WHEN 'yyyy-mm-dd hh:mm:ss' THEN 120
	WHEN 'yyyy-mm-dd hh:mm:ss.Ms' THEN 121
	WHEN 'yyyy-mm-ddThh:mm:ss.Ms' THEN 126
	WHEN 'dd Mmm yyyy hh:mm:ss:ms AM/PM' THEN 130
	WHEN 'dd/mm/yy hh:mm:ss:ms AM/PM' THEN 131
	WHEN 'RFC822' THEN 2
	WHEN 'dd Mmm yyyy hh:mm' THEN 4
ELSE 1 END

SELECT @vcReturnDte='error! unrecognised format ' +@format+CONVERT(VARCHAR(10),@nDateFmt)
IF @nDateFmt>=0
	SELECT @vcReturnDte=CONVERT(VARCHAR(80),@Date,@nDateFmt)
	--check for favurite and custom formats that can be done quickly
ELSE IF @nDateFmt=-2--then it is RFC822 format
	SELECT @vcReturnDte=LEFT(DATENAME(dw, @Date),3) + ', ' + STUFF(CONVERT(NVARCHAR,@Date,113),21,4,' GMT')
ELSE IF @nDateFmt=-4--then it is european day format with minutes
	SELECT @vcReturnDte=CONVERT(CHAR(17),@Date,113)
ELSE
BEGIN
	SELECT @Before=LEN(@format)
	SELECT @Format=REPLACE(REPLACE(REPLACE( @Format,'AM/PM','#'),'AM','#'),'PM','#')
	SELECT @TwelveHourClock=CASE WHEN @Before >LEN(@format) THEN 109 ELSE 113 END, @vcReturnDte=''
	WHILE (1=1)--forever
	BEGIN
		SELECT @pos=PATINDEX('%[yqmidwhs:#]%',@format+' ')
		IF @pos=0--no more date format strings
		BEGIN
		SELECT @vcReturnDte=@vcReturnDte+@format
		BREAK
	END
	IF @pos>1--some stuff to pass through first
	BEGIN
		SELECT @escape=CHARINDEX ('\',@Format+'\') --is it a literal character that is escaped?
		IF @escape<@pos BEGIN
		SET @vcReturnDte=@vcReturnDte+SUBSTRING(@Format,1,@escape-1) +SUBSTRING(@format,@escape+1,1)
		SET @format=RTRIM(SUBSTRING(@Format,@Escape+2,80))
		CONTINUE
	END
	SET @vcReturnDte=@vcReturnDte+SUBSTRING(@Format,1,@pos-1)
	SET @format=RTRIM(SUBSTRING(@Format,@pos,80))
	END
	
	SELECT @pos=PATINDEX('%[^yqmidwhs:#]%',@format+' ')--get the end
	SELECT @vcReturnDte=@vcReturnDte+--'('+substring(@Format,1,@pos-1)+')'+

	CASE SUBSTRING(@Format,1,@pos-1)
		--Mmmths as 1--12
		WHEN 'M' THEN CONVERT(VARCHAR(2),DATEPART(MONTH,@Date))
		--Mmmths as 01--12
		WHEN 'Mm' THEN CONVERT(CHAR(2),@Date,101)
		--Mmmths as Jan--Dec
		WHEN 'Mmm' THEN CONVERT(CHAR(3),DATENAME(MONTH,@Date))
		--Mmmths as January--December
		WHEN 'Mmmm' THEN DATENAME(MONTH,@Date)
		--Mmmths as the first letter of the Mmmth
		WHEN 'Mmmmm' THEN CONVERT(CHAR(1),DATENAME(MONTH,@Date))
		--Days as 1--31
		WHEN 'D' THEN CONVERT(VARCHAR(2),DATEPART(DAY,@Date))
		--Days as 01--31
		WHEN 'Dd' THEN CONVERT(CHAR(2),@date,103)
		--Days as Sun--Sat
		WHEN 'Ddd' THEN CONVERT(CHAR(3),DATENAME(weekday,@Date))
		--Days as Sunday--Saturday
		WHEN 'Dddd' THEN DATENAME(weekday,@Date)
		--Years as 00--99
		WHEN 'Yy' THEN CONVERT(CHAR(2),@Date,12)
		--Years as 1900--9999
		WHEN 'Yyyy' THEN DATENAME(YEAR,@Date)
		WHEN 'hh:mm:ss' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,8)
		WHEN 'hh:mm:ss:ms' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'h:mm:ss' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,8)
		--tthe SQL Server BOL syntax, for compatibility
		WHEN 'hh:mi:ss:mmm' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'h:mm:ss:ms' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'H:m:s' THEN SUBSTRING(REPLACE(':'+SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,8),':0',':'),2,30)
		WHEN 'H:m:s:ms' THEN SUBSTRING(REPLACE(':'+SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,12),':0',':'),2,30)
		--Hours as 00--23
		WHEN 'hh' THEN REPLACE(SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,2),' ','0')
		--Hours as 0--23
		WHEN 'h' THEN LTRIM(SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,2))
		--Minutes as 00--59
		WHEN 'Mi' THEN DATENAME(minute,@date)
		WHEN 'mm' THEN DATENAME(minute,@date)
		WHEN 'm' THEN CONVERT(VARCHAR(2),DATEPART(minute,@date))
		--Seconds as 0--59
		WHEN 'ss' THEN DATENAME(second,@date)
		--Seconds as 0--59
		WHEN 'S' THEN CONVERT(VARCHAR(2),DATEPART(second,@date))
		--AM/PM
		WHEN 'ms' THEN DATENAME(millisecond,@date)
		WHEN 'mmm' THEN DATENAME(millisecond,@date)
		WHEN 'dy' THEN DATENAME(dy,@date)
		WHEN 'qq' THEN DATENAME(qq,@date)
		WHEN 'ww' THEN DATENAME(ww,@date)
		WHEN '#' THEN REVERSE(SUBSTRING(REVERSE(CONVERT(CHAR(26), @date,109)),1,2))
	ELSE
		SUBSTRING(@Format,1,@pos-1)
	END
	SET @format=RTRIM(SUBSTRING(@Format,@pos,80))
	END
END
RETURN @vcReturnDte
END


GO
/****** Object:  UserDefinedFunction [dbo].[spGetDateOnly]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spGetDateOnly] ()
RETURNS DATETIME
BEGIN
	declare  @pInputDate    DATETIME ;
	set @pInputDate = getdate()
    RETURN CAST(CAST(YEAR(@pInputDate) AS VARCHAR(4)) + '/' +
                CAST(MONTH(@pInputDate) AS VARCHAR(2)) + '/' +
                CAST(DAY(@pInputDate) AS VARCHAR(2)) AS DATETIME)

END


GO
/****** Object:  UserDefinedFunction [dbo].[spTBL_RowCOUNT]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spTBL_RowCOUNT] (
 
         @sTableName sysname  -- Table to retrieve Row Count
         )
 
     RETURNS INT -- Row count of the table, NULL if not found.
 
 /*
 * Returns the row count for a table by examining sysindexes.
 * This function must be run in the same database as the table.
 *
 * Common Usage:   
 SELECT dbo.udf_Tbl_RowCOUNT ('')
 
 * Test   
  PRINT 'Test 1 Bad table ' + CASE WHEN SELECT 
        dbo.udf_Tbl_RowCOUNT ('foobar') is NULL
         THEN 'Worked' ELSE 'Error' END
         
 * © Copyright 2004 W. Dale Miller dm@DmaChicago.com, all rights reserved.
 ***************************************************************/
 
 AS BEGIN
     
     DECLARE @nRowCount INT -- the rows
     DECLARE @nObjectID int -- Object ID
 
     SET @nObjectID = OBJECT_ID(@sTableName)
 
     -- Object might not be found
     IF @nObjectID is null RETURN NULL
 
     SELECT TOP 1 @nRowCount = rows 
         FROM sysindexes 
         WHERE id = @nObjectID AND indid < 2
 
     RETURN @nRowCount
 END


GO
/****** Object:  UserDefinedFunction [dbo].[StringBeforeLastIndex]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StringBeforeLastIndex](@source nvarchar(4000), @pattern char)
RETURNS nvarchar(80)
BEGIN
DECLARE @lastIndex int
SET @lastIndex = (LEN(@source)) -  CHARINDEX(@pattern, REVERSE(@source))

RETURN SUBSTRING(@source, 0, @lastindex + 1)
-- +1 because index starts at 0, but length at 1, so to get up to 11th index, we need LENGTH 11+1=12
END;
GO
/****** Object:  UserDefinedFunction [dbo].[udf_SHA512_128]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_SHA512_128]
(@strtext VARCHAR(1000)
)
RETURNS VARCHAR(128)
AS
BEGIN
DECLARE @hash VARCHAR(128)= '';
SET @hash =
(
SELECT CONVERT(CHAR(128), HASHBYTES('sha2_512', @strtext), 1)
);
RETURN @hash;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[udfWhereInClause]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[udfWhereInClause]
(
@UserID VARCHAR(50),
@DIR    NVARCHAR(1000)
)
RETURNS varchar(2000) -- or whatever length you need
AS
BEGIN
Declare @result varchar(2000);

BEGIN
DECLARE @r NVARCHAR(1000)= '';
SELECT @r = +@r + N'''' + Extcode + N''','
FROM IncludedFiles
WHERE UserID = @UserID
AND fqn = @DIR;
SET @result = '(' + @r + ')';
END;

RETURN  @result

END
GO
/****** Object:  Table [dbo].[WebSource]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSource](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [image] NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[CreationDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WebSource] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_WebSource]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_WebSource]
AS
/*
** Select all rows from the WebSource table
** and the lookup expressions defined for associated tables
*/
SELECT [WebSource].* FROM [WebSource]

GO
/****** Object:  Table [dbo].[CorpFunction]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorpFunction](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpFuncDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK1] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_CorpFunction]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CorpFunction]
AS
/*
** Select all rows from the CorpFunction table
** and the lookup expressions defined for associated tables
*/
SELECT [CorpFunction].* FROM [CorpFunction]

GO
/****** Object:  Table [dbo].[RiskLevel]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskLevel](
	[RiskCode] [char](10) NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RiskLevel]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RiskLevel]
AS
/*
** Select all rows from the RiskLevel table
** and the lookup expressions defined for associated tables
*/
SELECT [RiskLevel].* FROM [RiskLevel]

GO
/****** Object:  Table [dbo].[InformationProduct]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformationProduct](
	[CreateDate] [datetime] NULL,
	[Code] [char](10) NOT NULL,
	[RetentionCode] [nvarchar](50) NOT NULL,
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK5] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_InformationProduct]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_InformationProduct]
AS
/*
** Select all rows from the InformationProduct table
** and the lookup expressions defined for associated tables
*/
SELECT [InformationProduct].* FROM [InformationProduct]

GO
/****** Object:  Table [dbo].[ExchangeHostPop]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeHostPop](
	[HostNameIp] [nvarchar](100) NOT NULL,
	[UserLoginID] [nvarchar](80) NOT NULL,
	[LoginPw] [nvarchar](50) NOT NULL,
	[SSL] [bit] NULL,
	[PortNbr] [int] NULL,
	[DeleteAfterDownload] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[IMap] [bit] NULL,
	[Userid] [nvarchar](50) NULL,
	[FolderName] [nvarchar](80) NULL,
	[isPublic] [bit] NULL,
	[LibraryName] [nvarchar](80) NULL,
	[DaysToHold] [int] NULL,
	[strReject] [nvarchar](250) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vExchangeHostPop]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vExchangeHostPop] as 
SELECT [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop]

GO
/****** Object:  Table [dbo].[DataTypeCodes]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataTypeCodes](
	[FileType] [nvarchar](255) NULL,
	[VerNbr] [nvarchar](255) NULL,
	[Publisher] [nvarchar](255) NULL,
	[Definition] [nvarchar](255) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DataTypeCodes]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataTypeCodes]
AS
/*
** Select all rows from the DataTypeCodes table
** and the lookup expressions defined for associated tables
*/
SELECT [DataTypeCodes].* FROM [DataTypeCodes]

GO
/****** Object:  Table [dbo].[ZippedFiles]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZippedFiles](
	[ContentGUID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[SourceImage] [image] NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK88] PRIMARY KEY CLUSTERED 
(
	[ContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ZippedFiles]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ZippedFiles]
AS
/*
** Select all rows from the ZippedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [ZippedFiles].* FROM [ZippedFiles]

GO
/****** Object:  Table [dbo].[DB_UpdateHist]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_UpdateHist](
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DB_UpdateHist]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DB_UpdateHist]
AS
/*
** Select all rows from the DB_UpdateHist table
** and the lookup expressions defined for associated tables
*/
SELECT [DB_UpdateHist].* FROM [DB_UpdateHist]

GO
/****** Object:  Table [dbo].[QtyDocs]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QtyDocs](
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK9] PRIMARY KEY NONCLUSTERED 
(
	[QtyDocCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_QtyDocs]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QtyDocs]
AS
/*
** Select all rows from the QtyDocs table
** and the lookup expressions defined for associated tables
*/
SELECT [QtyDocs].* FROM [QtyDocs]

GO
/****** Object:  Table [dbo].[DataSourceRestoreHistory]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceRestoreHistory](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[RestoredToMachine] [nvarchar](50) NULL,
	[RestoreUserName] [nvarchar](50) NULL,
	[RestoreUserID] [nvarchar](50) NULL,
	[RestoreUserDomain] [nvarchar](254) NULL,
	[RestoreDate] [datetime] NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
	[TypeContentCode] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[DocumentName] [nvarchar](254) NULL,
	[FQN] [nvarchar](500) NULL,
	[VerifiedData] [nchar](1) NULL,
	[OrigCrc] [nvarchar](50) NULL,
	[RestoreCrc] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK83] PRIMARY KEY CLUSTERED 
(
	[SeqNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DataSourceRestoreHistory]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataSourceRestoreHistory]
AS
/*
** Select all rows from the DataSourceRestoreHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [DataSourceRestoreHistory].* FROM [DataSourceRestoreHistory]

GO
/****** Object:  Table [dbo].[ProcessFileAs]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessFileAs](
	[ExtCode] [nvarchar](50) NOT NULL,
	[ProcessExtCode] [nvarchar](50) NOT NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__ProcessFileAs__5887175A] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ProcessFileAs]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ProcessFileAs]
AS
/*
** Select all rows from the ProcessFileAs table
** and the lookup expressions defined for associated tables
*/
SELECT [ProcessFileAs].* FROM [ProcessFileAs]

GO
/****** Object:  Table [dbo].[IncludeImmediate]    Script Date: 11/20/2020 1:41:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncludeImmediate](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_IncludeImmediate] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_IncludeImmediate]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_IncludeImmediate]
AS
/*
** Select all rows from the IncludeImmediate table
** and the lookup expressions defined for associated tables
*/
SELECT [IncludeImmediate].* FROM [IncludeImmediate]
GO
/****** Object:  Table [dbo].[Corporation]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corporation](
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK26] PRIMARY KEY CLUSTERED 
(
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Corporation]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Corporation]
AS
/*
** Select all rows from the Corporation table
** and the lookup expressions defined for associated tables
*/
SELECT [Corporation].* FROM [Corporation]

GO
/****** Object:  Table [dbo].[QuickDirectory]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickDirectory](
	[UserID] [nvarchar](50) NOT NULL,
	[IncludeSubDirs] [char](1) NULL,
	[FQN] [varchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[VersionFiles] [char](1) NULL,
	[ckMetaData] [nchar](1) NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[QuickRefEntry] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKII2QD] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_QuickDirectory]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickDirectory]
AS
/*
** Select all rows from the QuickDirectory table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickDirectory].* FROM [QuickDirectory]

GO
/****** Object:  Table [dbo].[Databases]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Databases](
	[DB_ID] [nvarchar](50) NOT NULL,
	[DB_CONN_STR] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK6Databases] PRIMARY KEY CLUSTERED 
(
	[DB_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Databases]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Databases]
AS
/*
** Select all rows from the Databases table
** and the lookup expressions defined for associated tables
*/
SELECT [Databases].* FROM [Databases]

GO
/****** Object:  Table [dbo].[RepeatData]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepeatData](
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[RepeatDataDesc] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK14] PRIMARY KEY CLUSTERED 
(
	[RepeatDataCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RepeatData]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RepeatData]
AS
/*
** Select all rows from the RepeatData table
** and the lookup expressions defined for associated tables
*/
SELECT [RepeatData].* FROM [RepeatData]

GO
/****** Object:  Table [dbo].[DataOwners]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataOwners](
	[PrimaryOwner] [bit] NULL,
	[OwnerTypeCode] [nvarchar](50) NULL,
	[FullAccess] [bit] NULL,
	[ReadOnly] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[Searchable] [bit] NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK42] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DataOwners]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataOwners]
AS
/*
** Select all rows from the DataOwners table
** and the lookup expressions defined for associated tables
*/
SELECT [DataOwners].* FROM [DataOwners]

GO
/****** Object:  Table [dbo].[Volitility]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volitility](
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[VolitilityDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK19] PRIMARY KEY CLUSTERED 
(
	[VolitilityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Volitility]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Volitility]
AS
/*
** Select all rows from the Volitility table
** and the lookup expressions defined for associated tables
*/
SELECT [Volitility].* FROM [Volitility]

GO
/****** Object:  Table [dbo].[EcmUser]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EcmUser](
	[EMail] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[YourName] [nvarchar](100) NULL,
	[YourCompany] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[Authority] [nchar](1) NULL,
	[CreateDate] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK8] PRIMARY KEY CLUSTERED 
(
	[EMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_EcmUser]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EcmUser]
AS
/*
** Select all rows from the EcmUser table
** and the lookup expressions defined for associated tables
*/
SELECT [EcmUser].* FROM [EcmUser]

GO
/****** Object:  Table [dbo].[Recipients]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipients](
	[Recipient] [nvarchar](254) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[TypeRecp] [nchar](10) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK32A] PRIMARY KEY CLUSTERED 
(
	[Recipient] ASC,
	[EmailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Recipients]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Recipients]
AS
/*
** Select all rows from the Recipients table
** and the lookup expressions defined for associated tables
*/
SELECT [Recipients].* FROM [Recipients]

GO
/****** Object:  Table [dbo].[FilesToDelete]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesToDelete](
	[UserID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](100) NULL,
	[FQN] [nvarchar](254) NULL,
	[PendingDelete] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_FilesToDelete]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FilesToDelete]
AS
/*
** Select all rows from the FilesToDelete table
** and the lookup expressions defined for associated tables
*/
SELECT [FilesToDelete].* FROM [FilesToDelete]

GO
/****** Object:  Table [dbo].[DataSource]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSource](
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](1000) NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](2000) NULL,
	[VersionNbr] [int] NOT NULL,
	[LastAccessDate] [datetime] NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[isPublic] [nchar](1) NULL,
	[FileDirectory] [nvarchar](1000) NULL,
	[OriginalFileType] [nvarchar](50) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[isContainedWithinZipFile] [nchar](1) NULL,
	[IsZipFile] [nchar](1) NULL,
	[DataVerified] [bit] NULL,
	[ZipFileGuid] [nvarchar](50) NULL,
	[ZipFileFQN] [varchar](712) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[OcrPerformed] [nchar](1) NULL,
	[isGraphic] [nchar](1) NULL,
	[GraphicContainsText] [nchar](1) NULL,
	[OcrText] [nvarchar](max) NULL,
	[ImageHiddenText] [nvarchar](max) NULL,
	[isWebPage] [nchar](1) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[CRC] [nvarchar](250) NULL,
	[SharePoint] [bit] NULL,
	[SharePointDoc] [bit] NULL,
	[SharePointList] [bit] NULL,
	[SharePointListItem] [bit] NULL,
	[StructuredData] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ContainedWithin] [nvarchar](50) NULL,
	[RecLen] [float] NULL,
	[RecHash] [nvarchar](250) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](150) NULL,
	[HashName] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[RequireOcr] [bit] NULL,
	[RssLinkFlg] [bit] NULL,
	[RssLinkGuid] [nvarchar](50) NULL,
	[PageURL] [nvarchar](4000) NULL,
	[RetentionDate] [datetime] NULL,
	[URLHash] [nvarchar](50) NULL,
	[WebPagePublishDate] [nvarchar](50) NULL,
	[SapData] [bit] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Imagehash] [nvarchar](250) NULL,
	[ImageLen] [int] NULL,
	[FileDirectoryName] [nvarchar](1000) NULL,
	[FqnHASH] [nvarchar](150) NULL,
	[SourceImageOrigin] [nvarchar](10) NULL,
	[RecTimeStamp] [datetime] NOT NULL,
	[SourceImage] [varbinary](max) FILESTREAM  NULL,
	[RowGuid2] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DataSource_1] PRIMARY KEY NONCLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] FILESTREAM_ON [FG_ECM_FileStream]
GO
/****** Object:  Table [dbo].[DataSourceImage]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceImage](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[OriginalFileType] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[OcrText] [nvarchar](max) NULL,
	[OcrPerformed] [nchar](1) NULL,
	[SourceImage] [varbinary](max) NULL,
	[SourceName] [nvarchar](254) NULL,
	[Imagehash] [nvarchar](80) NULL,
	[ImageLen] [int] NULL,
	[FileLength] [int] NULL,
	[LastUpdate] [datetime] NULL,
	[CRC] [nvarchar](50) NULL,
 CONSTRAINT [PKey_DataSourceImage] PRIMARY KEY NONCLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vDataSource]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vDataSource] as
SELECT DS.[RowGuid]
      ,[SourceGuid]
      ,[CreateDate]
      ,DSI.[SourceName]
      ,DSI.[SourceImage]
      ,DSI.[SourceTypeCode]
      ,[FQN]
      ,[VersionNbr]
      ,[LastAccessDate]
      ,DSI.[FileLength]
      ,[LastWriteTime]
      ,[UserID]
      ,[DataSourceOwnerUserID]
      ,[isPublic]
      ,[FileDirectory]
      ,[OriginalFileType]
      ,[RetentionExpirationDate]
      ,[IsPublicPreviousState]
      ,[isAvailable]
      ,[isContainedWithinZipFile]
      ,[IsZipFile]
      ,[DataVerified]
      ,[ZipFileGuid]
      ,[ZipFileFQN]
      ,DSI.[Description]
      ,DSI.[KeyWords]
      ,DSI.[Notes]
      ,[isPerm]
      ,[isMaster]
      ,[CreationDate]
      ,DSI.[OcrPerformed]
      ,[isGraphic]
      ,[GraphicContainsText]
      ,DSI.[OcrText]
      ,[ImageHiddenText]
      ,[isWebPage]
      ,[ParentGuid]
      ,[RetentionCode]
      ,[MachineID]
      ,[SharePoint]
      ,[SharePointDoc]
      ,[SharePointList]
      ,[SharePointListItem]
      ,[StructuredData]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
      ,[ContainedWithin]
      ,[RecLen]
      ,[RecHash]
      ,[OriginalSize]
      ,[CompressedSize]
      ,[txStartTime]
      ,[txEndTime]
      ,[txTotalTime]
      ,[TransmitTime]
      ,[FileAttached]
      ,[BPS]
      ,[RepoName]
      ,[HashFile]
      ,[HashName]
      ,[OcrSuccessful]
      ,[OcrPending]
      ,[PdfIsSearchable]
      ,[PdfOcrRequired]
      ,[PdfOcrSuccess]
      ,[PdfOcrTextExtracted]
      ,[PdfPages]
      ,[PdfImages]
      ,[RequireOcr]
      ,[RssLinkFlg]
      ,[RssLinkGuid]
      ,[PageURL]
      ,[RetentionDate]
      ,[URLHash]
      ,[WebPagePublishDate]
      ,[SapData]
      ,DS.[RowID]
      --,DSI.[Imagehash]
      ,DSI.[ImageLen]
  FROM [dbo].[DataSource] DS
  join [dbo].[DataSourceImage] DSI
  on DS.SourceGuid = DSI.DataSourceGuid
GO
/****** Object:  Table [dbo].[ProdCaptureItems]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdCaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[SendAlert] [bit] NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK21] PRIMARY KEY NONCLUSTERED 
(
	[CaptureItemsCode] ASC,
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ProdCaptureItems]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ProdCaptureItems]
AS
/*
** Select all rows from the ProdCaptureItems table
** and the lookup expressions defined for associated tables
*/
SELECT [ProdCaptureItems].* FROM [ProdCaptureItems]

GO
/****** Object:  Table [dbo].[CorpContainer]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorpContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK2] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_CorpContainer]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CorpContainer]
AS
/*
** Select all rows from the CorpContainer table
** and the lookup expressions defined for associated tables
*/
SELECT [CorpContainer].* FROM [CorpContainer]

GO
/****** Object:  Table [dbo].[GlobalSeachResults]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalSeachResults](
	[ContentTitle] [nvarchar](254) NULL,
	[ContentAuthor] [nvarchar](254) NULL,
	[ContentType] [nvarchar](50) NULL,
	[CreateDate] [nvarchar](50) NULL,
	[ContentExt] [nvarchar](50) NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[FileName] [nvarchar](254) NULL,
	[FileSize] [int] NULL,
	[NbrOfAttachments] [int] NULL,
	[FromEmailAddress] [nvarchar](254) NULL,
	[AllRecipiants] [nvarchar](max) NULL,
	[Weight] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_GlobalSeachResults]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GlobalSeachResults]
AS
/*
** Select all rows from the GlobalSeachResults table
** and the lookup expressions defined for associated tables
*/
SELECT [GlobalSeachResults].* FROM [GlobalSeachResults]

GO
/****** Object:  Table [dbo].[Storage]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[StoreDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK17] PRIMARY KEY CLUSTERED 
(
	[StoreCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Storage]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Storage]
AS
/*
** Select all rows from the Storage table
** and the lookup expressions defined for associated tables
*/
SELECT [Storage].* FROM [Storage]

GO
/****** Object:  Table [dbo].[SystemParms]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemParms](
	[SysParm] [nvarchar](50) NULL,
	[SysParmDesc] [nvarchar](250) NULL,
	[SysParmVal] [nvarchar](250) NULL,
	[flgActive] [nchar](1) NULL,
	[isDirectory] [nchar](1) NULL,
	[isEmailFolder] [nchar](1) NULL,
	[flgAllSubDirs] [nchar](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SystemParms]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SystemParms]
AS
/*
** Select all rows from the SystemParms table
** and the lookup expressions defined for associated tables
*/
SELECT [SystemParms].* FROM [SystemParms]

GO
/****** Object:  Table [dbo].[GroupLibraryAccess]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupLibraryAccess](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK70] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_GroupLibraryAccess]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GroupLibraryAccess]
AS
/*
** Select all rows from the GroupLibraryAccess table
** and the lookup expressions defined for associated tables
*/
SELECT [GroupLibraryAccess].* FROM [GroupLibraryAccess]

GO
/****** Object:  Table [dbo].[SearhParmsHistory]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearhParmsHistory](
	[UserID] [nvarchar](50) NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[Screen] [nvarchar](50) NOT NULL,
	[QryParms] [nvarchar](max) NOT NULL,
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SearhParmsHistory]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SearhParmsHistory]
AS
/*
** Select all rows from the SearhParmsHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [SearhParmsHistory].* FROM [SearhParmsHistory]

GO
/****** Object:  Table [dbo].[HelpText]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpText](
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_HelpText]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_HelpText]
AS
/*
** Select all rows from the HelpText table
** and the lookup expressions defined for associated tables
*/
SELECT [HelpText].* FROM [HelpText]

GO
/****** Object:  Table [dbo].[SourceType]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceType](
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[StoreExternal] [bit] NULL,
	[SourceTypeDesc] [nvarchar](254) NULL,
	[Indexable] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK34] PRIMARY KEY CLUSTERED 
(
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SourceType]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceType]
AS
/*
** Select all rows from the SourceType table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceType].* FROM [SourceType]

GO
/****** Object:  Table [dbo].[SubDir]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubDir](
	[UserID] [nvarchar](50) NOT NULL,
	[SUBFQN] [nvarchar](254) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[OcrDirectory] [nchar](1) NULL,
	[VersionFiles] [nchar](1) NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI14] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC,
	[SUBFQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SubDir]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SubDir]
AS
/*
** Select all rows from the SubDir table
** and the lookup expressions defined for associated tables
*/
SELECT [SubDir].* FROM [SubDir]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/20/2020 1:41:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](254) NULL,
	[UserPassword] [nvarchar](254) NULL,
	[Admin] [nchar](1) NULL,
	[isActive] [nchar](1) NULL,
	[UserLoginID] [nvarchar](50) NULL,
	[ClientOnly] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ActiveGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK41] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vMigrateUsers]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vMigrateUsers] as
Select UserName as ECM_UserName, 
		UserLoginID as ECM_UserID, 
		UserPassword as ECM_UserPW, 
		EmailAddress as ECM_UserEmail,
		'xx' as ECM_GroupName, 
		'LL' as ECM_Library, 
		'U' as ECM_Authority,
		ClientOnly as ECM_ClientOnly
		from Users

GO
/****** Object:  Table [dbo].[ExcludeFrom]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExcludeFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ExcludeFrom] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ExcludeFrom]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ExcludeFrom]
AS
/*
** Select all rows from the ExcludeFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ExcludeFrom].* FROM [ExcludeFrom]

GO
/****** Object:  Table [dbo].[SourceAttribute]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceAttribute](
	[AttributeValue] [nvarchar](254) NULL,
	[AttributeName] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK35] PRIMARY KEY NONCLUSTERED 
(
	[AttributeName] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SourceAttribute]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceAttribute]
AS
/*
** Select all rows from the SourceAttribute table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceAttribute].* FROM [SourceAttribute]

GO
/****** Object:  Table [dbo].[SubLibrary]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubLibrary](
	[UserID] [nvarchar](50) NOT NULL,
	[SubUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[SubLibraryName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK90] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[SubUserID] ASC,
	[SubLibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SubLibrary]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SubLibrary]
AS
/*
** Select all rows from the SubLibrary table
** and the lookup expressions defined for associated tables
*/
SELECT [SubLibrary].* FROM [SubLibrary]

GO
/****** Object:  Table [dbo].[SourceContainer]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[ContainerDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK3] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SourceContainer]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceContainer]
AS
/*
** Select all rows from the SourceContainer table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceContainer].* FROM [SourceContainer]

GO
/****** Object:  Table [dbo].[EmailFolder]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailFolder](
	[UserID] [nvarchar](50) NOT NULL,
	[FolderName] [varchar](450) NULL,
	[ParentFolderName] [varchar](200) NULL,
	[FolderID] [varchar](100) NOT NULL,
	[ParentFolderID] [varchar](100) NULL,
	[SelectedForArchive] [char](1) NULL,
	[StoreID] [varchar](600) NOT NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[ContainerName] [varchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[FileDirectory] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_EmailFolder]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailFolder]
AS
/*
** Select all rows from the EmailFolder table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailFolder].* FROM [EmailFolder]

GO
/****** Object:  Table [dbo].[ImageTypeCodes]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageTypeCodes](
	[ImageTypeCode] [nvarchar](50) NULL,
	[ImageTypeCodeDesc] [nvarchar](250) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ImageTypeCodes]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ImageTypeCodes]
AS
/*
** Select all rows from the ImageTypeCodes table
** and the lookup expressions defined for associated tables
*/
SELECT [ImageTypeCodes].* FROM [ImageTypeCodes]

GO
/****** Object:  Table [dbo].[SavedItems]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavedItems](
	[Userid] [nvarchar](50) NOT NULL,
	[SaveName] [nvarchar](50) NOT NULL,
	[SaveTypeCode] [nvarchar](50) NOT NULL,
	[ValName] [nvarchar](50) NOT NULL,
	[ValValue] [nvarchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SavedItems]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SavedItems]
AS
/*
** Select all rows from the SavedItems table
** and the lookup expressions defined for associated tables
*/
SELECT [SavedItems].* FROM [SavedItems]

GO
/****** Object:  Table [dbo].[RuntimeErrors]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuntimeErrors](
	[ErrorMsg] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[IdNbr] [nvarchar](50) NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RuntimeErrors]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RuntimeErrors]
AS
/*
** Select all rows from the RuntimeErrors table
** and the lookup expressions defined for associated tables
*/
SELECT [RuntimeErrors].* FROM [RuntimeErrors]

GO
/****** Object:  Table [dbo].[IncludedFiles]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI3] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_IncludedFiles]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_IncludedFiles]
AS
/*
** Select all rows from the IncludedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [IncludedFiles].* FROM [IncludedFiles]

GO
/****** Object:  Table [dbo].[License]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[License](
	[Agreement] [nvarchar](max) NULL,
	[VersionNbr] [int] NOT NULL,
	[ActivationDate] [datetime] NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[CustomerID] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](254) NOT NULL,
	[LicenseID] [int] IDENTITY(1,1) NOT NULL,
	[XrtNxr1] [nvarchar](50) NULL,
	[ServerIdentifier] [varchar](100) NULL,
	[SqlInstanceIdentifier] [varchar](100) NULL,
	[MachineID] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ServerName] [nvarchar](254) NULL,
	[SqlInstanceName] [nvarchar](254) NULL,
	[SqlServerInstanceName] [nvarchar](254) NULL,
	[SqlServerMachineName] [nvarchar](254) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_License]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_License]
AS
/*
** Select all rows from the License table
** and the lookup expressions defined for associated tables
*/
SELECT [License].* FROM [License]

GO
/****** Object:  Table [dbo].[RunParms]    Script Date: 11/20/2020 1:41:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunParms](
	[Parm] [nvarchar](250) NOT NULL,
	[ParmValue] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmDesc] [nvarchar](500) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI8] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[Parm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RunParms]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RunParms]
AS
/*
** Select all rows from the RunParms table
** and the lookup expressions defined for associated tables
*/
SELECT [RunParms].* FROM [RunParms]

GO
/****** Object:  Table [dbo].[UserCurrParm]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCurrParm](
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_UserCurrParm]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserCurrParm]
AS
/*
** Select all rows from the UserCurrParm table
** and the lookup expressions defined for associated tables
*/
SELECT [UserCurrParm].* FROM [UserCurrParm]

GO
/****** Object:  Table [dbo].[UrlList]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrlList](
	[URL] [nvarchar](425) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_UrlList]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UrlList]
AS
/*
** Select all rows from the UrlList table
** and the lookup expressions defined for associated tables
*/
SELECT [UrlList].* FROM [UrlList]

GO
/****** Object:  Table [dbo].[Container]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Container](
	[ContainerGuid] [uniqueidentifier] NOT NULL,
	[ContainerName] [nvarchar](449) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[FileDirectoryName] [nvarchar](500) NULL,
 CONSTRAINT [PK193] PRIMARY KEY CLUSTERED 
(
	[ContainerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PI_Container01] UNIQUE NONCLUSTERED 
(
	[ContainerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentContainer]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentContainer](
	[ContentUserRowGuid] [uniqueidentifier] NOT NULL,
	[ContainerGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK194] PRIMARY KEY NONCLUSTERED 
(
	[ContentUserRowGuid] ASC,
	[ContainerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContentUser]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentUser](
	[ContentTypeCode] [nchar](1) NOT NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[NbrOccurances] [int] NOT NULL,
	[ContentUserRowGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[CreateDate] [datetime] NULL,
	[LastAdded] [datetime] NULL,
 CONSTRAINT [PK187] PRIMARY KEY NONCLUSTERED 
(
	[ContentUserRowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ContentUserIdx] UNIQUE CLUSTERED 
(
	[ContentGuid] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vFileDirectory]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vFileDirectory]
as 
SELECT DISTINCT Container.ContainerName, ContentUser.UserID, ContentUser.ContentTypeCode
FROM         Container INNER JOIN
                      ContentContainer ON Container.ContainerGuid = ContentContainer.ContainerGuid INNER JOIN
                      ContentUser ON ContentContainer.ContentUserRowGuid = ContentUser.ContentUserRowGuid
where ContentUser.ContentTypeCode = 'C'                      
GROUP BY Container.ContainerName, ContentUser.UserID, ContentUser.ContentTypeCode 

GO
/****** Object:  Table [dbo].[UserReassignHist]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserReassignHist](
	[PrevUserID] [nvarchar](50) NOT NULL,
	[PrevUserName] [nvarchar](50) NULL,
	[PrevEmailAddress] [nvarchar](254) NULL,
	[PrevUserPassword] [nvarchar](254) NULL,
	[PrevAdmin] [nchar](1) NULL,
	[PrevisActive] [nchar](1) NULL,
	[PrevUserLoginID] [nvarchar](50) NOT NULL,
	[ReassignedUserID] [nvarchar](50) NULL,
	[ReassignedUserName] [nvarchar](50) NOT NULL,
	[ReassignedEmailAddress] [nvarchar](254) NULL,
	[ReassignedUserPassword] [nvarchar](254) NULL,
	[ReassignedAdmin] [nchar](1) NULL,
	[ReassignedisActive] [nchar](1) NULL,
	[ReassignedUserLoginID] [nvarchar](50) NULL,
	[ReassignmentDate] [datetime] NOT NULL,
	[RowID] [uniqueidentifier] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vReassignedTable]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vReassignedTable]  AS
SELECT [PrevUserName]
,[ReassignedUserName]
      ,[PrevUserLoginID] 
,[ReassignedUserLoginID]
      ,[PrevUserID]
,[ReassignedUserID]
      ,[PrevEmailAddress]
      ,[PrevUserPassword]
      ,[PrevAdmin]
      ,[PrevisActive]          
      ,[ReassignedEmailAddress]
      ,[ReassignedUserPassword]
      ,[ReassignedAdmin]
      ,[ReassignedisActive]      
      ,[ReassignmentDate]
FROM [UserReassignHist]

GO
/****** Object:  Table [dbo].[UD_Qty]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UD_Qty](
	[Code] [char](10) NOT NULL,
	[Description] [char](10) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK4] PRIMARY KEY NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_UD_Qty]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UD_Qty]
AS
/*
** Select all rows from the UD_Qty table
** and the lookup expressions defined for associated tables
*/
SELECT [UD_Qty].* FROM [UD_Qty]

GO
/****** Object:  Table [dbo].[EmailToDelete]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailToDelete](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[StoreID] [nvarchar](500) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[MessageID] [nchar](100) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_EmailToDelete]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailToDelete]
AS
/*
** Select all rows from the EmailToDelete table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailToDelete].* FROM [EmailToDelete]

GO
/****** Object:  Table [dbo].[UrlRejection]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrlRejection](
	[RejectionPattern] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_UrlRejection]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UrlRejection]
AS
/*
** Select all rows from the UrlRejection table
** and the lookup expressions defined for associated tables
*/
SELECT [UrlRejection].* FROM [UrlRejection]

GO
/****** Object:  View [dbo].[gv_UserReassignHist]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserReassignHist]
AS
/*
** Select all rows from the UserReassignHist table
** and the lookup expressions defined for associated tables
*/
SELECT [UserReassignHist].* FROM [UserReassignHist]

GO
/****** Object:  Table [dbo].[SearchHistory]    Script Date: 11/20/2020 1:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchHistory](
	[SearchSql] [nvarchar](max) NULL,
	[SearchDate] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ReturnedRows] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CalledFrom] [nvarchar](50) NULL,
	[TypeSearch] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[SearchParms] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SearchHistory]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SearchHistory]
AS
/*
** Select all rows from the SearchHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [SearchHistory].* FROM [SearchHistory]

GO
/****** Object:  Table [dbo].[QuickRefItems]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickRefItems](
	[QuickRefIdNbr] [int] NULL,
	[FQN] [nvarchar](300) NULL,
	[QuickRefItemGuid] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NULL,
	[Author] [nvarchar](300) NULL,
	[Description] [nvarchar](max) NULL,
	[Keywords] [nvarchar](2000) NULL,
	[FileName] [nvarchar](80) NULL,
	[DirName] [nvarchar](254) NULL,
	[MarkedForDeletion] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MetadataTag] [nvarchar](50) NULL,
	[MetadataValue] [nvarchar](50) NULL,
	[Library] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK93] PRIMARY KEY CLUSTERED 
(
	[QuickRefItemGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_QuickRefItems]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickRefItems]
AS
/*
** Select all rows from the QuickRefItems table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickRefItems].* FROM [QuickRefItems]

GO
/****** Object:  Table [dbo].[upgrade_status]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[upgrade_status](
	[name] [varchar](30) NOT NULL,
	[status] [varchar](10) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_upgrade_status]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_upgrade_status]
AS
/*
** Select all rows from the upgrade_status table
** and the lookup expressions defined for associated tables
*/
SELECT [upgrade_status].* FROM [upgrade_status]

GO
/****** Object:  Table [dbo].[DeleteFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeleteFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK40] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DeleteFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[gv_DeleteFrom]
AS
/*
** Select all rows from the DeleteFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [DeleteFrom].* FROM [DeleteFrom]
GO
/****** Object:  Table [dbo].[ArchiveFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK39] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ArchiveFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[gv_ArchiveFrom]
AS
/*
** Select all rows from the ArchiveFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveFrom].* FROM [ArchiveFrom]
GO
/****** Object:  Table [dbo].[InformationType]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformationType](
	[CreateDate] [datetime] NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK6] PRIMARY KEY NONCLUSTERED 
(
	[InfoTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_InformationType]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_InformationType]
AS
/*
** Select all rows from the InformationType table
** and the lookup expressions defined for associated tables
*/
SELECT [InformationType].* FROM [InformationType]

GO
/****** Object:  Table [dbo].[ExcludedFiles]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExcludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKII4] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ExcludedFiles]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ExcludedFiles]
AS
/*
** Select all rows from the ExcludedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [ExcludedFiles].* FROM [ExcludedFiles]

GO
/****** Object:  Table [dbo].[LibraryItems]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryItems](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[ItemTitle] [nvarchar](254) NULL,
	[ItemType] [nvarchar](50) NULL,
	[LibraryItemGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[AddedByUserGuidId] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK89] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[LibraryItemGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_LibraryItems]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibraryItems]
AS
/*
** Select all rows from the LibraryItems table
** and the lookup expressions defined for associated tables
*/
SELECT [LibraryItems].* FROM [LibraryItems]

GO
/****** Object:  Table [dbo].[FUncSkipWords]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUncSkipWords](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[tgtWord] [nvarchar](18) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK24] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[tgtWord] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_FUncSkipWords]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FUncSkipWords]
AS
/*
** Select all rows from the FUncSkipWords table
** and the lookup expressions defined for associated tables
*/
SELECT [FUncSkipWords].* FROM [FUncSkipWords]

GO
/****** Object:  Table [dbo].[Machine]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
	[MachineName] [nvarchar](80) NOT NULL,
	[FQN] [nvarchar](254) NULL,
	[ContentType] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Machine]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Machine]
AS
/*
** Select all rows from the Machine table
** and the lookup expressions defined for associated tables
*/
SELECT [Machine].* FROM [Machine]

GO
/****** Object:  Table [dbo].[ContactsArchive]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactsArchive](
	[Email1Address] [nvarchar](80) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Account] [nvarchar](4000) NULL,
	[Anniversary] [nvarchar](4000) NULL,
	[Application] [nvarchar](4000) NULL,
	[AssistantName] [nvarchar](4000) NULL,
	[AssistantTelephoneNumber] [nvarchar](4000) NULL,
	[BillingInformation] [nvarchar](4000) NULL,
	[Birthday] [nvarchar](4000) NULL,
	[Business2TelephoneNumber] [nvarchar](4000) NULL,
	[BusinessAddress] [nvarchar](4000) NULL,
	[BusinessAddressCity] [nvarchar](4000) NULL,
	[BusinessAddressCountry] [nvarchar](4000) NULL,
	[BusinessAddressPostalCode] [nvarchar](4000) NULL,
	[BusinessAddressPostOfficeBox] [nvarchar](4000) NULL,
	[BusinessAddressState] [nvarchar](4000) NULL,
	[BusinessAddressStreet] [nvarchar](4000) NULL,
	[BusinessCardType] [nvarchar](4000) NULL,
	[BusinessFaxNumber] [nvarchar](4000) NULL,
	[BusinessHomePage] [nvarchar](4000) NULL,
	[BusinessTelephoneNumber] [nvarchar](4000) NULL,
	[CallbackTelephoneNumber] [nvarchar](4000) NULL,
	[CarTelephoneNumber] [nvarchar](4000) NULL,
	[Categories] [nvarchar](4000) NULL,
	[Children] [nvarchar](4000) NULL,
	[xClass] [nvarchar](4000) NULL,
	[Companies] [nvarchar](4000) NULL,
	[CompanyName] [nvarchar](4000) NULL,
	[ComputerNetworkName] [nvarchar](4000) NULL,
	[Conflicts] [nvarchar](4000) NULL,
	[ConversationTopic] [nvarchar](4000) NULL,
	[CreationTime] [nvarchar](4000) NULL,
	[CustomerID] [nvarchar](4000) NULL,
	[Department] [nvarchar](4000) NULL,
	[Email1AddressType] [nvarchar](4000) NULL,
	[Email1DisplayName] [nvarchar](4000) NULL,
	[Email1EntryID] [nvarchar](4000) NULL,
	[Email2Address] [nvarchar](4000) NULL,
	[Email2AddressType] [nvarchar](4000) NULL,
	[Email2DisplayName] [nvarchar](4000) NULL,
	[Email2EntryID] [nvarchar](4000) NULL,
	[Email3Address] [nvarchar](4000) NULL,
	[Email3AddressType] [nvarchar](4000) NULL,
	[Email3DisplayName] [nvarchar](4000) NULL,
	[Email3EntryID] [nvarchar](4000) NULL,
	[FileAs] [nvarchar](4000) NULL,
	[FirstName] [nvarchar](4000) NULL,
	[FTPSite] [nvarchar](4000) NULL,
	[Gender] [nvarchar](4000) NULL,
	[GovernmentIDNumber] [nvarchar](4000) NULL,
	[Hobby] [nvarchar](4000) NULL,
	[Home2TelephoneNumber] [nvarchar](4000) NULL,
	[HomeAddress] [nvarchar](4000) NULL,
	[HomeAddressCountry] [nvarchar](4000) NULL,
	[HomeAddressPostalCode] [nvarchar](4000) NULL,
	[HomeAddressPostOfficeBox] [nvarchar](4000) NULL,
	[HomeAddressState] [nvarchar](4000) NULL,
	[HomeAddressStreet] [nvarchar](4000) NULL,
	[HomeFaxNumber] [nvarchar](4000) NULL,
	[HomeTelephoneNumber] [nvarchar](4000) NULL,
	[IMAddress] [nvarchar](4000) NULL,
	[Importance] [nvarchar](4000) NULL,
	[Initials] [nvarchar](4000) NULL,
	[InternetFreeBusyAddress] [nvarchar](4000) NULL,
	[JobTitle] [nvarchar](4000) NULL,
	[Journal] [nvarchar](4000) NULL,
	[Language] [nvarchar](4000) NULL,
	[LastModificationTime] [nvarchar](4000) NULL,
	[LastName] [nvarchar](4000) NULL,
	[LastNameAndFirstName] [nvarchar](4000) NULL,
	[MailingAddress] [nvarchar](4000) NULL,
	[MailingAddressCity] [nvarchar](4000) NULL,
	[MailingAddressCountry] [nvarchar](4000) NULL,
	[MailingAddressPostalCode] [nvarchar](4000) NULL,
	[MailingAddressPostOfficeBox] [nvarchar](4000) NULL,
	[MailingAddressState] [nvarchar](4000) NULL,
	[MailingAddressStreet] [nvarchar](4000) NULL,
	[ManagerName] [nvarchar](4000) NULL,
	[MiddleName] [nvarchar](4000) NULL,
	[Mileage] [nvarchar](4000) NULL,
	[MobileTelephoneNumber] [nvarchar](4000) NULL,
	[NetMeetingAlias] [nvarchar](4000) NULL,
	[NetMeetingServer] [nvarchar](4000) NULL,
	[NickName] [nvarchar](4000) NULL,
	[Title] [nvarchar](4000) NULL,
	[Body] [nvarchar](4000) NULL,
	[OfficeLocation] [nvarchar](4000) NULL,
	[Subject] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK45] PRIMARY KEY NONCLUSTERED 
(
	[Email1Address] ASC,
	[FullName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ContactsArchive]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ContactsArchive]
AS
/*
** Select all rows from the ContactsArchive table
** and the lookup expressions defined for associated tables
*/
SELECT [ContactsArchive].* FROM [ContactsArchive]

GO
/****** Object:  Table [dbo].[LoadProfile]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadProfile](
	[ProfileName] [nvarchar](50) NOT NULL,
	[ProfileDesc] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK101] PRIMARY KEY CLUSTERED 
(
	[ProfileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_LoadProfile]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LoadProfile]
AS
/*
** Select all rows from the LoadProfile table
** and the lookup expressions defined for associated tables
*/
SELECT [LoadProfile].* FROM [LoadProfile]

GO
/****** Object:  Table [dbo].[FunctionProdJargon]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FunctionProdJargon](
	[KeyFlag] [binary](50) NULL,
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK13] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_FunctionProdJargon]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FunctionProdJargon]
AS
/*
** Select all rows from the FunctionProdJargon table
** and the lookup expressions defined for associated tables
*/
SELECT [FunctionProdJargon].* FROM [FunctionProdJargon]

GO
/****** Object:  Table [dbo].[OutlookFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OutlookFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Verified] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [OutlookFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_OutlookFrom]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[gv_OutlookFrom]
AS
/*
** Select all rows from the OutlookFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [OutlookFrom].* FROM [OutlookFrom]
GO
/****** Object:  Table [dbo].[ArchiveHistContentType]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveHistContentType](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[Directory] [nvarchar](254) NOT NULL,
	[FileType] [nvarchar](50) NOT NULL,
	[NbrFilesArchived] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK111] PRIMARY KEY NONCLUSTERED 
(
	[ArchiveID] ASC,
	[Directory] ASC,
	[FileType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ArchiveHistContentType]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveHistContentType]
AS
/*
** Select all rows from the ArchiveHistContentType table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveHistContentType].* FROM [ArchiveHistContentType]

GO
/****** Object:  Table [dbo].[MyTempTable]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyTempTable](
	[docid] [int] NOT NULL,
	[key] [nvarchar](100) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__MyTempTa__0638DBFA6C0DB436] PRIMARY KEY CLUSTERED 
(
	[docid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_MyTempTable]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_MyTempTable]
AS
/*
** Select all rows from the MyTempTable table
** and the lookup expressions defined for associated tables
*/
SELECT [MyTempTable].* FROM [MyTempTable]

GO
/****** Object:  Table [dbo].[LibDirectory]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibDirectory](
	[DirectoryName] [nvarchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[IncludeSubDirs] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK98] PRIMARY KEY CLUSTERED 
(
	[DirectoryName] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_LibDirectory]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibDirectory]
AS
/*
** Select all rows from the LibDirectory table
** and the lookup expressions defined for associated tables
*/
SELECT [LibDirectory].* FROM [LibDirectory]

GO
/****** Object:  Table [dbo].[OwnerHistory]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerHistory](
	[PreviousOwnerUserID] [nvarchar](50) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK76] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_OwnerHistory]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_OwnerHistory]
AS
/*
** Select all rows from the OwnerHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [OwnerHistory].* FROM [OwnerHistory]

GO
/****** Object:  Table [dbo].[ArchiveStats]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveStats](
	[ArchiveStartDate] [datetime] NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Successful] [nchar](1) NULL,
	[ArchiveType] [nvarchar](50) NOT NULL,
	[TotalEmailsInRepository] [int] NULL,
	[TotalContentInRepository] [int] NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ArchiveEndDate] [datetime] NULL,
	[StatGuid] [nvarchar](50) NOT NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ArchiveStats]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveStats]
AS
/*
** Select all rows from the ArchiveStats table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveStats].* FROM [ArchiveStats]

GO
/****** Object:  Table [dbo].[SkipWords]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkipWords](
	[tgtWord] [nvarchar](18) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK22] PRIMARY KEY NONCLUSTERED 
(
	[tgtWord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_SkipWords]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SkipWords]
AS
/*
** Select all rows from the SkipWords table
** and the lookup expressions defined for associated tables
*/
SELECT [SkipWords].* FROM [SkipWords]

GO
/****** Object:  Table [dbo].[BusinessFunctionJargon]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessFunctionJargon](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[JargonWords_tgtWord] [nvarchar](50) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK23] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[WordID] ASC,
	[JargonWords_tgtWord] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_BusinessFunctionJargon]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_BusinessFunctionJargon]
AS
/*
** Select all rows from the BusinessFunctionJargon table
** and the lookup expressions defined for associated tables
*/
SELECT [BusinessFunctionJargon].* FROM [BusinessFunctionJargon]

GO
/****** Object:  View [dbo].[gv_Users]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Users]
AS
/*
** Select all rows from the Users table
** and the lookup expressions defined for associated tables
*/
SELECT [Users].* FROM [Users]

GO
/****** Object:  Table [dbo].[AssignableUserParameters]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignableUserParameters](
	[ParmName] [nchar](50) NOT NULL,
	[isPerm] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_AssignableUserParameters]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AssignableUserParameters]
AS
/*
** Select all rows from the AssignableUserParameters table
** and the lookup expressions defined for associated tables
*/
SELECT [AssignableUserParameters].* FROM [AssignableUserParameters]

GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK43] PRIMARY KEY CLUSTERED 
(
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_UserGroup]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserGroup]
AS
/*
** Select all rows from the UserGroup table
** and the lookup expressions defined for associated tables
*/
SELECT [UserGroup].* FROM [UserGroup]

GO
/****** Object:  Table [dbo].[LibEmail]    Script Date: 11/20/2020 1:41:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibEmail](
	[EmailFolderEntryID] [nvarchar](200) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[FolderName] [nvarchar](250) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK99] PRIMARY KEY CLUSTERED 
(
	[EmailFolderEntryID] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_LibEmail]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibEmail]
AS
/*
** Select all rows from the LibEmail table
** and the lookup expressions defined for associated tables
*/
SELECT [LibEmail].* FROM [LibEmail]

GO
/****** Object:  Table [dbo].[LibraryUsers]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryUsers](
	[ReadOnly] [bit] NULL,
	[CreateAccess] [bit] NULL,
	[UpdateAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[NotAddedAsGroupMember] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[SingleUser] [bit] NULL,
	[GroupUser] [bit] NULL,
	[GroupCnt] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK87] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vLibraryUsers]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vLibraryUsers]
as
SELECT     LibraryUsers.UserID, LibraryUsers.LibraryName, LibraryUsers.LibraryOwnerUserID, Users.UserName
FROM         LibraryUsers INNER JOIN
                      Users ON LibraryUsers.UserID = Users.UserID

GO
/****** Object:  Table [dbo].[ContactFrom]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Verified] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [ContactFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ContactFrom]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[gv_ContactFrom]
AS
/*
** Select all rows from the ContactFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ContactFrom].* FROM [ContactFrom]
GO
/****** Object:  Table [dbo].[LoadProfileItem]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadProfileItem](
	[ProfileName] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK102] PRIMARY KEY NONCLUSTERED 
(
	[ProfileName] ASC,
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_LoadProfileItem]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LoadProfileItem]
AS
/*
** Select all rows from the LoadProfileItem table
** and the lookup expressions defined for associated tables
*/
SELECT [LoadProfileItem].* FROM [LoadProfileItem]

GO
/****** Object:  Table [dbo].[ArchiveHist]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveHist](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[ArchiveDate] [datetime] NULL,
	[NbrFilesArchived] [int] NULL,
	[UserGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK110] PRIMARY KEY CLUSTERED 
(
	[ArchiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ArchiveHist]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveHist]
AS
/*
** Select all rows from the ArchiveHist table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveHist].* FROM [ArchiveHist]

GO
/****** Object:  View [dbo].[vUserGrid]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vUserGrid] as
SELECT [UserID]
      ,[UserName]
      ,[EmailAddress]
      ,[Admin]
      ,[isActive]
      ,[UserLoginID]
      ,[ClientOnly]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
  FROM [Users]

GO
/****** Object:  Table [dbo].[Library]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[isPublic] [nchar](1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK52] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vLibraryStats]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vLibraryStats] as
 select LibraryName, isPublic, 
 (select COUNT(*) from LibraryItems where LibraryItems.LibraryName = Library.LibraryName) as Items,
 (select COUNT(*) from LibraryUsers where LibraryUsers.LibraryName = Library.LibraryName) as Members, 
 UserID
 from Library

GO
/****** Object:  Table [dbo].[ActiveSearchGuids]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveSearchGuids](
	[UserID] [nvarchar](50) NOT NULL,
	[DocGuid] [nvarchar](50) NOT NULL,
	[SeqNO] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ActiveSearchGuids]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ActiveSearchGuids]
AS
/*
** Select all rows from the ActiveSearchGuids table
** and the lookup expressions defined for associated tables
*/
SELECT [ActiveSearchGuids].* FROM [ActiveSearchGuids]

GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PgmTrace](
	[UserID] [nvarchar](50) NULL,
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](50) NULL,
	[Stmt] [nvarchar](max) NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[ConnectiveGuid] [uniqueidentifier] NULL,
	[IDGUID] [uniqueidentifier] NULL,
	[LastModDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_PgmTrace]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_PgmTrace]
AS
/*
** Select all rows from the PgmTrace table
** and the lookup expressions defined for associated tables
*/
SELECT * FROM [PgmTrace]

GO
/****** Object:  Table [dbo].[GroupUsers]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupUsers](
	[UserID] [nvarchar](50) NOT NULL,
	[FullAccess] [bit] NULL,
	[ReadOnlyAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[Searchable] [bit] NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK44] PRIMARY KEY NONCLUSTERED 
(
	[GroupName] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_GroupUsers]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GroupUsers]
AS
/*
** Select all rows from the GroupUsers table
** and the lookup expressions defined for associated tables
*/
SELECT [GroupUsers].* FROM [GroupUsers]

GO
/****** Object:  Table [dbo].[AttachmentType]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttachmentType](
	[AttachmentCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](254) NULL,
	[isZipFormat] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK29] PRIMARY KEY CLUSTERED 
(
	[AttachmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_AttachmentType]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AttachmentType]
AS
/*
** Select all rows from the AttachmentType table
** and the lookup expressions defined for associated tables
*/
SELECT [AttachmentType].* FROM [AttachmentType]

GO
/****** Object:  View [dbo].[gv_LibraryUsers]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibraryUsers]
AS
/*
** Select all rows from the LibraryUsers table
** and the lookup expressions defined for associated tables
*/
SELECT [LibraryUsers].* FROM [LibraryUsers]

GO
/****** Object:  Table [dbo].[EmailArchParms]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailArchParms](
	[UserID] [nvarchar](50) NOT NULL,
	[ArchiveEmails] [char](1) NULL,
	[RemoveAfterArchive] [char](1) NULL,
	[SetAsDefaultFolder] [char](1) NULL,
	[ArchiveAfterXDays] [char](1) NULL,
	[RemoveAfterXDays] [char](1) NULL,
	[RemoveXDays] [int] NULL,
	[ArchiveXDays] [int] NULL,
	[FolderName] [nvarchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[ArchiveOnlyIfRead] [nchar](1) NULL,
	[isSysDefault] [bit] NULL,
	[ContainerName] [nvarchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_EmailArchParms]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailArchParms]
AS
/*
** Select all rows from the EmailArchParms table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailArchParms].* FROM [EmailArchParms]

GO
/****** Object:  Table [dbo].[BusinessJargonCode]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessJargonCode](
	[JargonCode] [nvarchar](50) NOT NULL,
	[JargonDesc] [nvarchar](18) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK11] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_BusinessJargonCode]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_BusinessJargonCode]
AS
/*
** Select all rows from the BusinessJargonCode table
** and the lookup expressions defined for associated tables
*/
SELECT [BusinessJargonCode].* FROM [BusinessJargonCode]

GO
/****** Object:  Table [dbo].[DataSourceCheckOut]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceCheckOut](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[CheckedOutByUserID] [nvarchar](50) NOT NULL,
	[isReadOnly] [bit] NULL,
	[isForUpdate] [bit] NULL,
	[checkOutDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK82] PRIMARY KEY NONCLUSTERED 
(
	[CheckedOutByUserID] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_DataSourceCheckOut]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataSourceCheckOut]
AS
/*
** Select all rows from the DataSourceCheckOut table
** and the lookup expressions defined for associated tables
*/
SELECT [DataSourceCheckOut].* FROM [DataSourceCheckOut]

GO
/****** Object:  Table [dbo].[CaptureItems]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[CaptureItemsDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK20] PRIMARY KEY CLUSTERED 
(
	[CaptureItemsCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_CaptureItems]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CaptureItems]
AS
/*
** Select all rows from the CaptureItems table
** and the lookup expressions defined for associated tables
*/
SELECT [CaptureItems].* FROM [CaptureItems]

GO
/****** Object:  Table [dbo].[AvailFileTypesUndefined]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailFileTypesUndefined](
	[FileType] [nvarchar](50) NOT NULL,
	[SubstituteType] [nvarchar](50) NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_AvailFileTypesUndefined]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AvailFileTypesUndefined]
AS
/*
** Select all rows from the AvailFileTypesUndefined table
** and the lookup expressions defined for associated tables
*/
SELECT [AvailFileTypesUndefined].* FROM [AvailFileTypesUndefined]

GO
/****** Object:  Table [dbo].[JargonWords]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JargonWords](
	[tgtWord] [nvarchar](50) NOT NULL,
	[jDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK12] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC,
	[tgtWord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_JargonWords]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_JargonWords]
AS
/*
** Select all rows from the JargonWords table
** and the lookup expressions defined for associated tables
*/
SELECT [JargonWords].* FROM [JargonWords]

GO
/****** Object:  Table [dbo].[AttributeDatatype]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeDatatype](
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK109] PRIMARY KEY CLUSTERED 
(
	[AttributeDataType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_AttributeDatatype]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AttributeDatatype]
AS
/*
** Select all rows from the AttributeDatatype table
** and the lookup expressions defined for associated tables
*/
SELECT [AttributeDatatype].* FROM [AttributeDatatype]

GO
/****** Object:  Table [dbo].[CoOwner]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoOwner](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[PreviousOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK76_1] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_CoOwner]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CoOwner]
AS
/*
** Select all rows from the CoOwner table
** and the lookup expressions defined for associated tables
*/
SELECT [CoOwner].* FROM [CoOwner]

GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[AttributeName] [nvarchar](50) NOT NULL,
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[AttributeDesc] [nvarchar](2000) NULL,
	[AssoApplication] [nvarchar](50) NULL,
	[AllowedValues] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK36] PRIMARY KEY CLUSTERED 
(
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Attributes]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Attributes]
AS
/*
** Select all rows from the Attributes table
** and the lookup expressions defined for associated tables
*/
SELECT [Attributes].* FROM [Attributes]

GO
/****** Object:  Table [dbo].[ContainerStorage]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContainerStorage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK18] PRIMARY KEY NONCLUSTERED 
(
	[StoreCode] ASC,
	[ContainerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ContainerStorage]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ContainerStorage]
AS
/*
** Select all rows from the ContainerStorage table
** and the lookup expressions defined for associated tables
*/
SELECT [ContainerStorage].* FROM [ContainerStorage]

GO
/****** Object:  Table [dbo].[AvailFileTypes]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailFileTypes](
	[ExtCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI7] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_AvailFileTypes]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AvailFileTypes]
AS
/*
** Select all rows from the AvailFileTypes table
** and the lookup expressions defined for associated tables
*/
SELECT [AvailFileTypes].* FROM [AvailFileTypes]

GO
/****** Object:  Table [dbo].[ConvertedDocs]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConvertedDocs](
	[FQN] [nvarchar](254) NOT NULL,
	[FileName] [nvarchar](254) NULL,
	[XMLName] [nvarchar](254) NULL,
	[XMLDIr] [nvarchar](254) NULL,
	[FileDir] [nvarchar](254) NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK25] PRIMARY KEY CLUSTERED 
(
	[FQN] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_ConvertedDocs]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ConvertedDocs]
AS
/*
** Select all rows from the ConvertedDocs table
** and the lookup expressions defined for associated tables
*/
SELECT [ConvertedDocs].* FROM [ConvertedDocs]

GO
/****** Object:  Table [dbo].[HelpTextUser]    Script Date: 11/20/2020 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpTextUser](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_HelpTextUser]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_HelpTextUser]
AS
/*
** Select all rows from the HelpTextUser table
** and the lookup expressions defined for associated tables
*/
SELECT [HelpTextUser].* FROM [HelpTextUser]

GO
/****** Object:  Table [dbo].[EmailAttachmentSearchList]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAttachmentSearchList](
	[UserID] [nvarchar](50) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[Weight] [int] NULL,
	[RowID] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_EmailAttachmentSearchList]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailAttachmentSearchList]
AS
/*
** Select all rows from the EmailAttachmentSearchList table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailAttachmentSearchList].* FROM [EmailAttachmentSearchList]

GO
/****** Object:  Table [dbo].[RetentionTemp]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RetentionTemp](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[TypeContent] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RetentionTemp]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RetentionTemp]
AS
/*
** Select all rows from the RetentionTemp table
** and the lookup expressions defined for associated tables
*/
SELECT [RetentionTemp].* FROM [RetentionTemp]

GO
/****** Object:  Table [dbo].[Directory]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directory](
	[UserID] [nvarchar](50) NOT NULL,
	[IncludeSubDirs] [char](1) NULL,
	[FQN] [varchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[VersionFiles] [char](1) NULL,
	[ckMetaData] [nchar](1) NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[QuickRefEntry] [char](10) NULL,
	[isSysDefault] [bit] NULL,
	[OcrDirectory] [nchar](1) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isServerDirectory] [bit] NULL,
	[isMappedDrive] [bit] NULL,
	[isNetworkDrive] [bit] NULL,
	[RequiresAuthentication] [bit] NULL,
	[AdminDisabled] [bit] NULL,
	[ArchiveSkipBit] [bit] NULL,
	[ListenForChanges] [bit] NULL,
	[ListenDirectory] [bit] NULL,
	[ListenSubDirectory] [bit] NULL,
	[DirGuid] [uniqueidentifier] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[OcrPdf] [nchar](1) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[DeleteOnArchive] [nchar](1) NULL,
 CONSTRAINT [PKII2] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Directory]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Directory]
AS
/*
** Select all rows from the Directory table
** and the lookup expressions defined for associated tables
*/
SELECT [Directory].* FROM [Directory]

GO
/****** Object:  View [dbo].[gv_Library]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Library]
AS
/*
** Select all rows from the Library table
** and the lookup expressions defined for associated tables
*/
SELECT [Library].* FROM [Library]

GO
/****** Object:  Table [dbo].[Retention]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Retention](
	[RetentionCode] [nvarchar](50) NOT NULL,
	[RetentionDesc] [nvarchar](max) NULL,
	[RetentionUnits] [int] NOT NULL,
	[RetentionAction] [nvarchar](50) NOT NULL,
	[ManagerID] [nvarchar](50) NULL,
	[ManagerName] [nvarchar](200) NULL,
	[DaysWarning] [int] NULL,
	[ResponseRequired] [char](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RetentionPeriod] [nvarchar](10) NULL,
 CONSTRAINT [PK16] PRIMARY KEY CLUSTERED 
(
	[RetentionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_Retention]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Retention]
AS
/*
** Select all rows from the Retention table
** and the lookup expressions defined for associated tables
*/
SELECT [Retention].* FROM [Retention]

GO
/****** Object:  Table [dbo].[RestorationHistory]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestorationHistory](
	[SourceType] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[OriginalCrc] [nvarchar](50) NOT NULL,
	[RestoredCrc] [nvarchar](50) NOT NULL,
	[RestorationDate] [nchar](10) NOT NULL,
	[RestorationID] [int] IDENTITY(1,1) NOT NULL,
	[RestoredBy] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_RestorationHistory]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RestorationHistory]
AS
/*
** Select all rows from the RestorationHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [RestorationHistory].* FROM [RestorationHistory]

GO
/****** Object:  Table [dbo].[QuickRef]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickRef](
	[UserID] [nvarchar](50) NOT NULL,
	[QuickRefName] [nvarchar](50) NULL,
	[QuickRefIdNbr] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK91] PRIMARY KEY CLUSTERED 
(
	[QuickRefIdNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[gv_QuickRef]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickRef]
AS
/*
** Select all rows from the QuickRef table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickRef].* FROM [QuickRef]

GO
/****** Object:  Table [dbo].[_DataTest]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_DataTest](
	[ROWGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DataName] [nchar](10) NOT NULL,
	[Data] [varbinary](max) FILESTREAM  NULL,
	[Data2] [nchar](10) NULL,
UNIQUE NONCLUSTERED 
(
	[ROWGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] FILESTREAM_ON [FG_ECM_FileStream]
GO
/****** Object:  Table [dbo].[_DuplicateFiles]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_DuplicateFiles](
	[GroupID] [int] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[SourceName] [nvarchar](254) NULL,
	[FQN] [varchar](712) NULL,
	[VersionNbr] [int] NOT NULL,
	[FileLength] [int] NULL,
	[UserID] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[FileDirectory] [nvarchar](300) NULL,
	[OriginalFileType] [nvarchar](50) NULL,
	[OcrText] [nvarchar](max) NULL,
	[RecHash] [varchar](50) NULL,
	[RowID] [int] NOT NULL,
	[Imagehash] [nvarchar](80) NULL,
	[ImageLen] [int] NULL,
	[EntryDate] [datetime] NULL,
	[TotalDuplicates] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_TEMPCOUNT]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_TEMPCOUNT](
	[GROUPID] [int] NULL,
	[CNT] [int] NULL,
	[DUPS] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_TempHash]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_TempHash](
	[ImageHash] [nvarchar](80) NULL,
	[Imagelen] [int] NULL,
	[FileLength] [int] NULL,
	[CNT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActiveDirUser]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveDirUser](
	[AdUserLoginID] [nvarchar](50) NOT NULL,
	[AdUserName] [nvarchar](80) NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActiveSession]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveSession](
	[SessionGuid] [uniqueidentifier] NOT NULL,
	[Parm] [nvarchar](50) NOT NULL,
	[InitDate] [datetime] NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertContact]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertContact](
	[ContactEmail] [nvarchar](80) NOT NULL,
	[ContactIM] [nvarchar](50) NULL,
	[ContactName] [nvarchar](50) NULL,
	[Carrier] [nvarchar](75) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertHistory]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertHistory](
	[AlertWord] [nvarchar](100) NOT NULL,
	[ByUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertWord]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertWord](
	[AlertWord] [nvarchar](50) NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AnalyticText]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AnalyticText](
	[AnalyticGUID] [uniqueidentifier] NOT NULL,
	[Location] [nvarchar](50) NULL,
	[AnalyticValue] [nvarchar](max) NULL,
	[AnalyticDatatype] [nvarchar](50) NULL,
	[AnalyticCode] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[Plane] [int] NULL,
	[Radial] [int] NULL,
	[VectorMagnitude] [decimal](18, 4) NULL,
	[VectorPower] [int] NULL,
	[OwnerGUID] [uniqueidentifier] NULL,
	[MonitoredSystemCode] [nvarchar](50) NULL,
	[SystemCode] [nvarchar](15) NOT NULL,
	[RowIdentifier] [uniqueidentifier] NULL,
 CONSTRAINT [PK1_1] PRIMARY KEY CLUSTERED 
(
	[AnalyticGUID] ASC,
	[SystemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLC_DIR]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLC_DIR](
	[UserID] [nvarchar](50) NOT NULL,
	[DirName] [nvarchar](50) NOT NULL,
	[FullPath] [nvarchar](4000) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLC_Download]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLC_Download](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentTable] [nvarchar](50) NOT NULL,
	[ContentGuid] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLC_Preview]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLC_Preview](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentTable] [nvarchar](50) NOT NULL,
	[ContentGuid] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CLCState]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLCState](
	[CLCInstalled] [bit] NULL,
	[CLCActive] [bit] NULL,
	[MachineID] [nvarchar](80) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConnectionStrings]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStrings](
	[DBMS] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](254) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConnectionStringsRegistered]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStringsRegistered](
	[ConnName] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](254) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConnectionStringsSaved]    Script Date: 11/20/2020 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStringsSaved](
	[ConnstrName] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](2000) NOT NULL,
	[TypeDB] [nvarchar](15) NULL,
	[CustomColSelectionSQL] [nvarchar](max) NULL,
	[CustomTableDataSQL] [nvarchar](max) NULL,
	[SelectedColumns] [nvarchar](max) NULL,
	[Schedule] [nvarchar](2000) NULL,
	[TableName] [nvarchar](2000) NULL,
	[LastArchiveDate] [datetime] NULL,
	[Library] [nvarchar](50) NULL,
	[LibraryOwnerGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[CombinedSql] [nvarchar](max) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CS]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CS](
	[ConnectionString] [varchar](300) NOT NULL,
	[ConnectionType] [nchar](25) NOT NULL,
	[ConnectionName] [nvarchar](50) NOT NULL,
	[SharePointURL] [nvarchar](500) NULL,
	[LoginID] [nvarchar](80) NULL,
	[LoginPW] [nvarchar](80) NULL,
	[ID_NBR] [varchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CS_SharePoint]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CS_SharePoint](
	[SP_ConnectionString] [varchar](300) NOT NULL,
	[ECM_ConnectionString] [varchar](300) NOT NULL,
	[ConnectionName] [nvarchar](50) NOT NULL,
	[isPublic] [bit] NULL,
	[LibraryName] [nvarchar](80) NULL,
	[LoginID] [nvarchar](80) NULL,
	[LoginPW] [nvarchar](80) NULL,
	[ID_NBR] [varchar](50) NULL,
	[ID_NBR_ECM] [varchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseFiles]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseFiles](
	[file_id] [int] NOT NULL,
	[file_guid] [uniqueidentifier] NULL,
	[type] [tinyint] NOT NULL,
	[type_desc] [nvarchar](60) NULL,
	[data_space_id] [int] NOT NULL,
	[name] [sysname] NOT NULL,
	[physical_name] [nvarchar](260) NOT NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[size] [int] NOT NULL,
	[max_size] [int] NOT NULL,
	[growth] [int] NOT NULL,
	[is_media_read_only] [bit] NOT NULL,
	[is_read_only] [bit] NOT NULL,
	[is_sparse] [bit] NOT NULL,
	[is_percent_growth] [bit] NOT NULL,
	[is_name_reserved] [bit] NOT NULL,
	[create_lsn] [numeric](25, 0) NULL,
	[drop_lsn] [numeric](25, 0) NULL,
	[read_only_lsn] [numeric](25, 0) NULL,
	[read_write_lsn] [numeric](25, 0) NULL,
	[differential_base_lsn] [numeric](25, 0) NULL,
	[differential_base_guid] [uniqueidentifier] NULL,
	[differential_base_time] [datetime] NULL,
	[redo_start_lsn] [numeric](25, 0) NULL,
	[redo_start_fork_guid] [uniqueidentifier] NULL,
	[redo_target_lsn] [numeric](25, 0) NULL,
	[redo_target_fork_guid] [uniqueidentifier] NULL,
	[backup_lsn] [numeric](25, 0) NULL,
	[CreationDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSource_Temp]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSource_Temp](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [varbinary](max) NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](712) NULL,
	[VersionNbr] [int] NOT NULL,
	[LastAccessDate] [datetime] NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[isPublic] [nchar](1) NULL,
	[FileDirectory] [nvarchar](300) NULL,
	[OriginalFileType] [nvarchar](50) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[isContainedWithinZipFile] [nchar](1) NULL,
	[IsZipFile] [nchar](1) NULL,
	[DataVerified] [bit] NULL,
	[ZipFileGuid] [nvarchar](50) NULL,
	[ZipFileFQN] [varchar](712) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[OcrPerformed] [nchar](1) NULL,
	[isGraphic] [nchar](1) NULL,
	[GraphicContainsText] [nchar](1) NULL,
	[OcrText] [nvarchar](max) NULL,
	[ImageHiddenText] [nvarchar](max) NULL,
	[isWebPage] [nchar](1) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[CRC] [nvarchar](250) NOT NULL,
	[SharePoint] [bit] NULL,
	[SharePointDoc] [bit] NULL,
	[SharePointList] [bit] NULL,
	[SharePointListItem] [bit] NULL,
	[StructuredData] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ContainedWithin] [nvarchar](50) NULL,
	[RecLen] [float] NULL,
	[RecHash] [varchar](50) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[RequireOcr] [bit] NULL,
	[RssLinkFlg] [bit] NULL,
	[RssLinkGuid] [nvarchar](50) NULL,
	[PageURL] [nvarchar](4000) NULL,
	[RetentionDate] [datetime] NULL,
	[URLHash] [nvarchar](50) NULL,
	[WebPagePublishDate] [nvarchar](50) NULL,
	[SapData] [bit] NULL,
	[RowID] [int] NOT NULL,
	[Imagehash] [nvarchar](250) NOT NULL,
	[ImageLen] [int] NULL,
	[FileDirectoryName] [nvarchar](500) NULL,
 CONSTRAINT [PK_DataSource_TEMP] PRIMARY KEY NONCLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceActivePeriod]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceActivePeriod](
	[PeriodID] [nvarchar](50) NOT NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ImageRowGuid] [uniqueidentifier] NOT NULL,
	[Imagehash] [nvarchar](80) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[FqnHASH] [nvarchar](150) NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK212] PRIMARY KEY NONCLUSTERED 
(
	[PeriodID] ASC,
	[SourceGuid] ASC,
	[FqnHASH] ASC,
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceAsso]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceAsso](
	[DataSourceImageGuid] [uniqueidentifier] NOT NULL,
	[DataSourceGuid] [uniqueidentifier] NOT NULL,
	[ImageHash] [nvarchar](80) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceChildren]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceChildren](
	[ParentSourceGuid] [nchar](50) NOT NULL,
	[ChildSourceGuid] [nchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceCols]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceCols](
	[UserID] [nvarchar](50) NOT NULL,
	[ColName] [nvarchar](50) NOT NULL,
	[ReturnCol] [bit] NULL,
 CONSTRAINT [PK210] PRIMARY KEY NONCLUSTERED 
(
	[ColName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceDelHist]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceDelHist](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](max) NULL,
	[DeletedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceFQN]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceFQN](
	[FqnHASH] [nvarchar](150) NOT NULL,
	[FQN] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataSourceOwner]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceOwner](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_Updates]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_Updates](
	[SqlStmt] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[FixDescription] [nvarchar](4000) NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[AppliedDate] [datetime] NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DBUpdate]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBUpdate](
	[FileName] [nvarchar](900) NOT NULL,
	[DateApplied] [datetime] NOT NULL,
	[RowCreateDate] [datetime] NOT NULL,
	[UpdateApplied] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirArchLib]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirArchLib](
	[DirOwnerUserID] [nvarchar](50) NOT NULL,
	[LibOwnerUserID] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryArchive]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryArchive](
	[DirKey] [varchar](1000) NOT NULL,
	[Machinename] [varchar](250) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[FQN] [varchar](max) NOT NULL,
	[NbrFiles] [int] NULL,
	[LastArchive] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DirectoryArchive] PRIMARY KEY NONCLUSTERED 
(
	[Machinename] ASC,
	[UserID] ASC,
	[DirKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryGuids]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryGuids](
	[DirFQN] [varchar](800) NOT NULL,
	[DirGuid] [nchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryListener]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryListener](
	[UserID] [nvarchar](50) NOT NULL,
	[AdminDisabled] [bit] NULL,
	[ListenerLoaded] [bit] NULL,
	[ListenerActive] [bit] NULL,
	[ListenerPaused] [bit] NULL,
	[ListenDirectory] [bit] NULL,
	[ListenSubDirectory] [bit] NULL,
	[DirGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryListenerFiles]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryListenerFiles](
	[DirGuid] [nvarchar](50) NOT NULL,
	[SourceFile] [varchar](720) NOT NULL,
	[Archived] [bit] NOT NULL,
	[EntryDate] [date] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[MachineName] [varchar](80) NOT NULL,
	[NameHash] [decimal](15, 8) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryLongName]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryLongName](
	[RowGuid] [uniqueidentifier] NULL,
	[DIRHASH] [varchar](150) NULL,
	[DirLongName] [nvarchar](max) NOT NULL,
	[RowCreateDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryMonitorLog]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryMonitorLog](
	[AccessedBy] [nvarchar](50) NULL,
	[DirFQN] [nvarchar](2000) NULL,
	[TypeAccess] [nvarchar](20) NULL,
	[AccessDate] [datetime] NULL,
	[FileFQN] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectoryTemp]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryTemp](
	[DirFQN] [nvarchar](300) NOT NULL,
	[CurrUserGuidId] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[SkipDir] [char](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[UserID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirProfiles]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirProfiles](
	[ProfileName] [nvarchar](50) NOT NULL,
	[Parms] [nvarchar](max) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DuplicateContent]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DuplicateContent](
	[HashID] [nvarchar](50) NULL,
	[ContentUniqueName] [varchar](900) NULL,
	[Occurances] [int] NULL,
	[Guids] [varchar](max) NULL,
	[ContentType] [char](1) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [UK_Dups] UNIQUE NONCLUSTERED 
(
	[ContentUniqueName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Email]    Script Date: 11/20/2020 1:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Email](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[SUBJECT] [nvarchar](2000) NULL,
	[SentTO] [nvarchar](max) NULL,
	[Body] [text] NULL,
	[Bcc] [nvarchar](max) NULL,
	[BillingInformation] [nvarchar](200) NULL,
	[CC] [nvarchar](max) NULL,
	[Companies] [nvarchar](2000) NULL,
	[CreationTime] [datetime] NULL,
	[ReadReceiptRequested] [nvarchar](50) NULL,
	[ReceivedByName] [nvarchar](80) NOT NULL,
	[ReceivedTime] [datetime] NOT NULL,
	[AllRecipients] [nvarchar](max) NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[SenderEmailAddress] [nvarchar](80) NOT NULL,
	[SenderName] [nvarchar](100) NOT NULL,
	[Sensitivity] [nvarchar](50) NULL,
	[SentOn] [datetime] NOT NULL,
	[MsgSize] [int] NULL,
	[DeferredDeliveryTime] [datetime] NULL,
	[EntryID] [varchar](150) NULL,
	[ExpiryTime] [datetime] NULL,
	[LastModificationTime] [datetime] NULL,
	[EmailImage] [varbinary](max) NULL,
	[Accounts] [nvarchar](2000) NULL,
	[ShortSubj] [nvarchar](250) NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[OriginalFolder] [nvarchar](254) NULL,
	[StoreID] [varchar](750) NULL,
	[isPublic] [nchar](1) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[CurrMailFolderID] [nvarchar](300) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[NbrAttachments] [int] NULL,
	[CRC] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[EmailIdentifier] [nvarchar](450) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[UIDL] [int] NULL,
	[RecLen] [float] NULL,
	[RecHash] [nvarchar](50) NOT NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[ContainsAttachment] [char](1) NULL,
	[NbrAttachment] [int] NULL,
	[NbrZipFiles] [int] NULL,
	[NbrZipFilesCnt] [int] NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[MachineID] [nvarchar](80) NULL,
	[notes] [nvarchar](4000) NULL,
	[NbrOccurances] [int] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[Imagehash] [nvarchar](80) NULL,
	[RecTimeStamp] [datetime] NOT NULL,
 CONSTRAINT [PKI_Email_FTI] PRIMARY KEY CLUSTERED 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAttachment]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAttachment](
	[RowGuid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AttachmentName] [nvarchar](254) NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[AttachmentCode] [nvarchar](50) NULL,
	[AttachmentType] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[isZipFileEntry] [bit] NULL,
	[OcrText] [nvarchar](max) NULL,
	[isPublic] [char](1) NULL,
	[AttachmentLength] [int] NULL,
	[OriginalFileTypeCode] [nvarchar](20) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RecLen] [float] NULL,
	[RecHash] [varchar](50) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[CRC] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[OcrPerformed] [char](1) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RequireOcr] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RecTimeStamp] [datetime] NOT NULL,
	[Attachment] [varbinary](max) FILESTREAM  NULL,
	[ArchiveTimestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK__EmailAtt__B975DD8289908A26] PRIMARY KEY CLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] FILESTREAM_ON [FG_ECM_FileStream]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] FILESTREAM_ON [FG_ECM_FileStream]
GO
/****** Object:  Table [dbo].[EmailRunningTotal]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailRunningTotal](
	[Ord] [int] IDENTITY(1,1) NOT NULL,
	[YR] [int] NULL,
	[Period] [varchar](50) NULL,
	[PeriodVal] [float] NULL,
	[Total] [float] NULL,
	[RunningTotal] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLogs](
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[LogName] [nvarchar](50) NOT NULL,
	[LoggedMessage] [nvarchar](4000) NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[EntryUserID] [nvarchar](50) NOT NULL,
	[Severity] [nvarchar](10) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExcgKey]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExcgKey](
	[MailKey] [varchar](500) NOT NULL,
	[InsertDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExchangeHostSmtp]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeHostSmtp](
	[HostNameIp] [nvarchar](100) NOT NULL,
	[UserLoginID] [nvarchar](80) NOT NULL,
	[LoginPw] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileKey]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKey](
	[FileKey] [nvarchar](300) NOT NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileKeyMachine]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKeyMachine](
	[Machine] [nvarchar](80) NOT NULL,
	[FileKey] [nvarchar](300) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileKeyMachineDir]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKeyMachineDir](
	[Machine] [nvarchar](80) NOT NULL,
	[Dir] [nvarchar](254) NOT NULL,
	[FileKey] [nvarchar](300) NOT NULL,
	[HashKey] [nvarchar](100) NOT NULL,
	[FileKeyMachineDirGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileLongName]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileLongName](
	[RowGuid] [uniqueidentifier] NULL,
	[FileHASH] [varchar](150) NULL,
	[FilesLongName] [nvarchar](max) NOT NULL,
	[RowCreateDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileNeedProcessing]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileNeedProcessing](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ContainingFile] [nvarchar](100) NOT NULL,
	[FQN] [nvarchar](1000) NOT NULL,
	[LineID] [int] NULL,
	[LastProcessDate] [datetime] NULL,
	[FileApplied] [int] NULL,
	[RowCreateDate] [datetime] NULL,
	[OldFileName] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FileType]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileType](
	[FileExt] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FulltextSUpportedFileExtension]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FulltextSUpportedFileExtension](
	[document_type] [nvarchar](128) NOT NULL,
	[version] [nvarchar](128) NOT NULL,
	[manufacturer] [nvarchar](128) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalAsso]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalAsso](
	[LocationID] [uniqueidentifier] NOT NULL,
	[MachineID] [uniqueidentifier] NOT NULL,
	[DirID] [uniqueidentifier] NOT NULL,
	[FileID] [uniqueidentifier] NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalDirectory]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalDirectory](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalEmail]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalEmail](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalFile]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalFile](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalLocation]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalLocation](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GlobalMachine]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalMachine](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GraphicFileType]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GraphicFileType](
	[GraphicFileTypeExt] [nvarchar](50) NOT NULL,
 CONSTRAINT [pkGraphicFileType] PRIMARY KEY CLUSTERED 
(
	[GraphicFileTypeExt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HashDir]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HashDir](
	[Hash] [decimal](18, 0) NULL,
	[HashedString] [varchar](max) NULL,
	[HashID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HashFile]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HashFile](
	[Hash] [decimal](18, 0) NULL,
	[HashedString] [varchar](max) NULL,
	[HashID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HelpInfo]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpInfo](
	[HelpName] [nvarchar](50) NOT NULL,
	[HelpEmailAddr] [nvarchar](50) NOT NULL,
	[HelpPhone] [nvarchar](50) NOT NULL,
	[AreaOfFocus] [nvarchar](50) NULL,
	[HoursAvail] [nvarchar](50) NULL,
	[EmailNotification] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HiveServers]    Script Date: 11/20/2020 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HiveServers](
	[SeverAlias] [nvarchar](100) NOT NULL,
	[ServerInstance] [nvarchar](100) NULL,
	[isHiveserver] [bit] NULL,
	[isLInked] [bit] NULL,
	[LinkedDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[DirFqn] [varchar](720) NULL,
	[FQN] [varchar](100) NULL,
	[FileSize] [int] NULL,
	[ExistInRepo] [bit] NULL,
	[UserLogin] [nvarchar](50) NULL,
	[DirHash] [numeric](18, 5) NULL,
	[FileHash] [numeric](18, 5) NULL,
	[CombinedHash] [varchar](50) NULL,
	[MachineName] [varbinary](80) NULL,
	[Verified] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IP]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IP](
	[HostName] [nvarchar](150) NOT NULL,
	[AccessingIP] [nvarchar](50) NOT NULL,
	[AccessCnt] [int] NULL,
	[BlockIP] [bit] NULL,
	[SearchCnt] [int] NULL,
	[FirstAccessDate] [datetime] NULL,
	[LastAccessDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JsonData]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JsonData](
	[RowKey] [uniqueidentifier] NOT NULL,
	[JsonData] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KTBL]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KTBL](
	[KID] [int] IDENTITY(1,1) NOT NULL,
	[KGUID] [uniqueidentifier] NOT NULL,
	[KIV] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_NewTable] PRIMARY KEY NONCLUSTERED 
(
	[KID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginClient]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginClient](
	[MachineName] [nvarchar](80) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginMachine]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginMachine](
	[MachineName] [nvarchar](80) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginUser]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginUser](
	[LoginID] [nvarchar](50) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[UID] [nvarchar](50) NULL,
	[ErrorMsg] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MachineRegistered]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineRegistered](
	[MachineGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [nvarchar](80) NOT NULL,
	[NetWorkName] [nvarchar](80) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK150] PRIMARY KEY NONCLUSTERED 
(
	[MachineGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PK_MR01] UNIQUE NONCLUSTERED 
(
	[MachineName] ASC,
	[NetWorkName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Query]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Query](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[SUBJECT] [nvarchar](2000) NULL,
	[SentTO] [ntext] NULL,
	[Body] [text] NULL,
	[Bcc] [ntext] NULL,
	[BillingInformation] [nvarchar](200) NULL,
	[CC] [ntext] NULL,
	[Companies] [nvarchar](2000) NULL,
	[CreationTime] [datetime2](3) NULL,
	[ReadReceiptRequested] [nvarchar](50) NULL,
	[ReceivedByName] [nvarchar](80) NOT NULL,
	[ReceivedTime] [datetime2](3) NOT NULL,
	[AllRecipients] [ntext] NULL,
	[UserID] [nvarchar](50) NULL,
	[SenderEmailAddress] [nvarchar](80) NOT NULL,
	[SenderName] [nvarchar](100) NOT NULL,
	[Sensitivity] [nvarchar](50) NULL,
	[SentOn] [datetime2](3) NOT NULL,
	[MsgSize] [int] NULL,
	[DeferredDeliveryTime] [datetime2](3) NULL,
	[EntryID] [varchar](150) NULL,
	[ExpiryTime] [datetime2](3) NULL,
	[LastModificationTime] [datetime2](3) NULL,
	[EmailImage] [image] NULL,
	[Accounts] [nvarchar](2000) NULL,
	[RowID] [int] NOT NULL,
	[ShortSubj] [nvarchar](250) NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[OriginalFolder] [nvarchar](254) NULL,
	[StoreID] [varchar](750) NULL,
	[isPublic] [nchar](1) NULL,
	[RetentionExpirationDate] [datetime2](3) NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[CurrMailFolderID] [nvarchar](300) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime2](3) NULL,
	[NbrAttachments] [int] NULL,
	[CRC] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[EmailIdentifier] [nvarchar](450) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime2](3) NULL,
	[RowLastModDate] [datetime2](3) NULL,
	[UIDL] [int] NULL,
	[RecLen] [float] NULL,
	[RecHash] [nvarchar](50) NOT NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime2](3) NULL,
	[txEndTime] [datetime2](3) NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[ContainsAttachment] [char](1) NULL,
	[NbrAttachment] [int] NULL,
	[NbrZipFiles] [int] NULL,
	[NbrZipFilesCnt] [int] NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[MachineID] [nvarchar](80) NULL,
	[notes] [nvarchar](4000) NULL,
	[NbrOccurances] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectFileType]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectFileType](
	[FileExt] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reports]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reports](
	[rptDisplayname] [nvarchar](80) NOT NULL,
	[rptDesc] [nvarchar](1000) NOT NULL,
	[rptFqn] [nvarchar](254) NOT NULL,
	[rptCreatedForCustomerID] [nvarchar](50) NULL,
	[rptFqnDate] [datetime] NULL,
	[rptExists] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKreports] PRIMARY KEY CLUSTERED 
(
	[rptFqn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Repository]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Repository](
	[ConnectionName] [nvarchar](50) NOT NULL,
	[ConnectionData] [nvarchar](2000) NULL,
	[ConnectionDataThesaurus] [nvarchar](2000) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestoreQueue]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestoreQueue](
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](80) NOT NULL,
	[FQN] [nvarchar](2500) NULL,
	[FileSize] [int] NULL,
	[ContentType] [varchar](15) NOT NULL,
	[Preview] [bit] NULL,
	[Restore] [bit] NULL,
	[ProcessingCompleted] [bit] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[StartDownloadTime] [datetime] NULL,
	[EndDownloadTime] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RestoreQueueHistory]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestoreQueueHistory](
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UseriD] [nvarchar](50) NULL,
	[MachineID] [nvarchar](80) NULL,
	[FQN] [nvarchar](2500) NULL,
	[FileSize] [int] NULL,
	[ContentType] [varchar](15) NOT NULL,
	[Preview] [bit] NULL,
	[Restore] [bit] NULL,
	[ProcessingCompleted] [bit] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[StartDownloadTime] [datetime] NULL,
	[EndDownloadTime] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RSSChildren]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RSSChildren](
	[RssRowGuid] [nchar](50) NOT NULL,
	[SourceGuid] [nchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RssPull]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RssPull](
	[RssName] [nvarchar](80) NULL,
	[RssUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchGuids]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchGuids](
	[Classification] [nvarchar](10) NOT NULL,
	[IDGuid] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SearchGuids] PRIMARY KEY CLUSTERED 
(
	[IDGuid] ASC,
	[SourceGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchSchedule]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchSchedule](
	[SearchName] [nvarchar](50) NOT NULL,
	[NotificationSMS] [nvarchar](20) NULL,
	[SearchDesc] [nvarchar](2000) NOT NULL,
	[OwnerID] [nvarchar](50) NOT NULL,
	[SearchQuery] [nvarchar](max) NOT NULL,
	[SendToEmail] [nvarchar](2000) NULL,
	[ScheduleUnit] [nchar](10) NOT NULL,
	[ScheduleHour] [nchar](10) NULL,
	[ScheduleDaysOfWeek] [nchar](50) NULL,
	[ScheduleDaysOfMonth] [nchar](70) NULL,
	[ScheduleMonthOfQtr] [nchar](10) NULL,
	[StartToRunDate] [datetime] NULL,
	[EndRunDate] [datetime] NULL,
	[SearchParameters] [nvarchar](4000) NULL,
	[LastRunDate] [datetime] NULL,
	[NumberOfExecutions] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastModDate] [datetime] NOT NULL,
	[ScheduleHourInterval] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[Carrier] [nvarchar](75) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchUser]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchUser](
	[SearchName] [nvarchar](75) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[SearchParms] [nvarchar](max) NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastUsedDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceActivity]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceActivity](
	[StmtID] [int] NOT NULL,
	[Msg] [varchar](max) NOT NULL,
	[EntryTime] [datetime] NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionID]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionID](
	[UserID] [nvarchar](50) NOT NULL,
	[SessionID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SessionID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionVar]    Script Date: 11/20/2020 1:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionVar](
	[SessionGuid] [varchar](50) NOT NULL,
	[SessionVar] [varchar](50) NOT NULL,
	[SessionVarVal] [nvarchar](254) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SourceInjector]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceInjector](
	[ClassName] [varchar](80) NOT NULL,
	[FuncName] [varchar](80) NULL,
	[LineID] [int] NOT NULL,
	[LastExecDate] [datetime] NULL,
	[Executed] [bit] NULL,
	[NbrExecutions] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK192] PRIMARY KEY CLUSTERED 
(
	[LineID] ASC,
	[ClassName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SqlDataTypes]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SqlDataTypes](
	[_nvarchar] [nchar](10) NULL,
	[_bigint] [bigint] NULL,
	[_binary] [binary](50) NULL,
	[_bit] [bit] NULL,
	[_char] [char](10) NULL,
	[_datetime] [datetime] NULL,
	[_datetimeoffset] [datetimeoffset](7) NULL,
	[_decimal] [decimal](18, 2) NULL,
	[_float] [float] NULL,
	[_geography] [geography] NULL,
	[_geometry] [geometry] NULL,
	[_hierarchyid] [hierarchyid] NULL,
	[_image] [image] NULL,
	[_int] [int] NULL,
	[_money] [money] NULL,
	[_nchar] [nchar](10) NULL,
	[_ntext] [ntext] NULL,
	[_numeric] [numeric](18, 2) NULL,
	[_nvarchar_max] [nvarchar](max) NULL,
	[_real] [real] NULL,
	[_smalldatetime] [smalldatetime] NULL,
	[_smallint] [smallint] NULL,
	[_smallmoney] [smallmoney] NULL,
	[_sql_variant] [sql_variant] NULL,
	[_text] [text] NULL,
	[_time7] [time](7) NULL,
	[_timestamp] [timestamp] NULL,
	[_tinyint] [tinyint] NULL,
	[_uniqueidentifier] [uniqueidentifier] NULL,
	[_varbinary] [varbinary](50) NULL,
	[_varchar] [varchar](50) NULL,
	[_varcharMAX] [varchar](max) NULL,
	[_xml] [xml] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StagedSQL]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StagedSQL](
	[ExecutionID] [varchar](50) NOT NULL,
	[SqlStmt] [nvarchar](max) NOT NULL,
	[EntryTime] [datetime] NULL,
	[StmtID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatsClick]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatsClick](
	[LocationID] [int] NOT NULL,
	[ClickDate] [datetime] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ClickID] [int] IDENTITY(1,1) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatsClick] PRIMARY KEY CLUSTERED 
(
	[ClickID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatSearch]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatSearch](
	[WordID] [int] NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[TypeSearch] [char](1) NOT NULL,
	[ClickID] [int] IDENTITY(1,1) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatSearch] PRIMARY KEY CLUSTERED 
(
	[ClickID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatWord]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatWord](
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[Word] [nvarchar](100) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatWord] PRIMARY KEY CLUSTERED 
(
	[Word] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructuredData]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructuredData](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[ColumnName] [nvarchar](120) NOT NULL,
	[ColVal] [nvarchar](50) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructuredDataProcessed]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructuredDataProcessed](
	[EcmGuid] [nvarchar](50) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SystemMessage]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemMessage](
	[UserID] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[EntryGuid] [nvarchar](50) NULL,
	[EntryMsg] [nvarchar](max) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_dir]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_dir](
	[UserID] [nvarchar](50) NOT NULL,
	[IncludeSubDirs] [char](1) NULL,
	[FQN] [varchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[VersionFiles] [char](1) NULL,
	[ckMetaData] [nchar](1) NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[QuickRefEntry] [char](10) NULL,
	[isSysDefault] [bit] NULL,
	[OcrDirectory] [nchar](1) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isServerDirectory] [bit] NULL,
	[isMappedDrive] [bit] NULL,
	[isNetworkDrive] [bit] NULL,
	[RequiresAuthentication] [bit] NULL,
	[AdminDisabled] [bit] NULL,
	[ArchiveSkipBit] [bit] NULL,
	[ListenForChanges] [bit] NULL,
	[ListenDirectory] [bit] NULL,
	[ListenSubDirectory] [bit] NULL,
	[DirGuid] [uniqueidentifier] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[OcrPdf] [nchar](1) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[DeleteOnArchive] [nchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempUserLibItems]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempUserLibItems](
	[UserID] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTbl]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTbl](
	[TestCol] [varchar](50) NULL,
	[iCol] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trace]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trace](
	[EntryDate] [datetime] NOT NULL,
	[LogEntry] [nvarchar](max) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txTimes]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txTimes](
	[StmtID] [int] NOT NULL,
	[txTime] [decimal](12, 4) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGridState]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGridState](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](50) NOT NULL,
	[GridName] [nvarchar](50) NOT NULL,
	[ColName] [nvarchar](50) NULL,
	[ColOrder] [int] NULL,
	[ColWidth] [int] NULL,
	[ColVisible] [bit] NULL,
	[ColReadOnly] [bit] NULL,
	[ColSortOrder] [int] NULL,
	[ColSortAsc] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserScreenState]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserScreenState](
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[ParmDataType] [nvarchar](15) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSearchState]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSearchState](
	[SearchID] [int] NOT NULL,
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[ParmDataType] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VersionInfo]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VersionInfo](
	[Product] [nvarchar](50) NOT NULL,
	[ProductVersion] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebScreen]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebScreen](
	[WebScreen] [nvarchar](80) NULL,
	[WebUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebSite]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSite](
	[WebSite] [nvarchar](80) NULL,
	[WebUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[Depth] [int] NULL,
	[Width] [int] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [lsnr].[DirListener]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lsnr].[DirListener](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ListenerFileName] [varchar](800) NOT NULL,
	[LastIdProcessed] [int] NULL,
	[LastProcessDate] [datetime] NULL,
	[FileCanBeDropped] [int] NULL,
	[RowCreateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [lsnr].[Exts]    Script Date: 11/20/2020 1:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lsnr].[Exts](
	[UserID] [varchar](50) NOT NULL,
	[Extension] [varchar](50) NULL,
	[Validated] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [lsnr].[FileNeedProcessing]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lsnr].[FileNeedProcessing](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ContainingFile] [varchar](100) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[FQN] [varchar](800) NOT NULL,
	[LineID] [int] NULL,
	[LastProcessDate] [datetime] NULL,
	[FileApplied] [int] NULL,
	[RowCreateDate] [datetime] NULL,
	[OldFileName] [varchar](800) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [lsnr].[ProcessedListenerFiles]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [lsnr].[ProcessedListenerFiles](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ListenerFileName] [varchar](100) NOT NULL,
	[RowCreateDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[_DuplicateFiles] ADD  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[ActiveDirUser] ADD  CONSTRAINT [DF__ActiveDir__RowGu__1590259A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ActiveSearchGuids] ADD  CONSTRAINT [DF__ActiveSea__RowGu__168449D3]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ActiveSession] ADD  CONSTRAINT [DF_ActiveSession_InitDate]  DEFAULT (getdate()) FOR [InitDate]
GO
ALTER TABLE [dbo].[ActiveSession] ADD  CONSTRAINT [DF__ActiveSes__RowGu__186C9245]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertContact] ADD  CONSTRAINT [DF__AlertCont__RowGu__1960B67E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertHistory] ADD  CONSTRAINT [DF_AlertWord2_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[AlertHistory] ADD  CONSTRAINT [DF_AlertWord2_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_ExpirationDate]  DEFAULT (getdate()+(90)) FOR [ExpirationDate]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveFrom] ADD  CONSTRAINT [DF__ArchiveFr__RowGu__1F198FD4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveHist] ADD  CONSTRAINT [DF__ArchiveHi__Archi__1D864D1D]  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [dbo].[ArchiveHist] ADD  CONSTRAINT [DF__ArchiveHi__RowGu__2101D846]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveHistContentType] ADD  CONSTRAINT [DF__ArchiveHi__RowGu__21F5FC7F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveStats] ADD  CONSTRAINT [DF__ArchiveSt__RowGu__22EA20B8]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AssignableUserParameters] ADD  CONSTRAINT [DF_AssignableUserParameters_isPerm]  DEFAULT ((0)) FOR [isPerm]
GO
ALTER TABLE [dbo].[AssignableUserParameters] ADD  CONSTRAINT [DF__Assignabl__RowGu__24D2692A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AttachmentType] ADD  CONSTRAINT [DF_AttachmentType_isZipFormat]  DEFAULT ((0)) FOR [isZipFormat]
GO
ALTER TABLE [dbo].[AttachmentType] ADD  CONSTRAINT [DF__Attachmen__RowGu__26BAB19C]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AttributeDatatype] ADD  CONSTRAINT [DF__Attribute__RowGu__27AED5D5]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_AttributeDataType]  DEFAULT ('nvarchar') FOR [AttributeDataType]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF__Attribute__RowGu__29971E47]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AvailFileTypes] ADD  CONSTRAINT [DF__AvailFile__RowGu__2A8B4280]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AvailFileTypesUndefined] ADD  CONSTRAINT [DF_AvailFileTypesUndefined_Applied]  DEFAULT ((0)) FOR [Applied]
GO
ALTER TABLE [dbo].[AvailFileTypesUndefined] ADD  CONSTRAINT [DF__AvailFile__RowGu__2C738AF2]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] ADD  CONSTRAINT [DF__BusinessF__RowGu__2D67AF2B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[BusinessJargonCode] ADD  CONSTRAINT [DF__BusinessJ__RowGu__2E5BD364]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CaptureItems] ADD  CONSTRAINT [DF__CaptureIt__RowGu__2F4FF79D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_DIR] ADD  CONSTRAINT [DF__CLC_DIR__RowGuid__30441BD6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_Download] ADD  CONSTRAINT [DF__CLC_Downl__RowGu__3138400F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_Preview] ADD  CONSTRAINT [DF__CLC_Previ__RowGu__322C6448]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLCState] ADD  CONSTRAINT [DF_CLCState_CLCInstalled]  DEFAULT ((0)) FOR [CLCInstalled]
GO
ALTER TABLE [dbo].[CLCState] ADD  CONSTRAINT [DF_CLCState_CLCActive]  DEFAULT ((0)) FOR [CLCActive]
GO
ALTER TABLE [dbo].[CLCState] ADD  CONSTRAINT [DF__CLCState__RowGui__3508D0F3]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStrings] ADD  CONSTRAINT [DF__Connectio__RowGu__35FCF52C]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStringsRegistered] ADD  CONSTRAINT [DF__Connectio__RowGu__36F11965]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStringsSaved] ADD  CONSTRAINT [DF_ConnectionStringsSaved_LastArchiveDate]  DEFAULT ('01/01/1920') FOR [LastArchiveDate]
GO
ALTER TABLE [dbo].[ConnectionStringsSaved] ADD  CONSTRAINT [DF__Connectio__RowGu__38D961D7]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContactFrom] ADD  CONSTRAINT [DF_ContactFrom_Verified]  DEFAULT ((1)) FOR [Verified]
GO
ALTER TABLE [dbo].[ContactFrom] ADD  CONSTRAINT [DF__ContactFr__RowGu__3AC1AA49]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContactsArchive] ADD  CONSTRAINT [DF__ContactsA__RowGu__3BB5CE82]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Container] ADD  CONSTRAINT [DF__Container__Conta__3CA9F2BB]  DEFAULT (newid()) FOR [ContainerGuid]
GO
ALTER TABLE [dbo].[Container] ADD  CONSTRAINT [DF__Container__RowGu__3D9E16F4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContainerStorage] ADD  CONSTRAINT [DF__Container__RowGu__3E923B2D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  CONSTRAINT [DF__ContentCo__Conte__3F865F66]  DEFAULT (newid()) FOR [ContentUserRowGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  CONSTRAINT [DF__ContentCo__Conta__407A839F]  DEFAULT (newid()) FOR [ContainerGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  CONSTRAINT [DF__ContentCo__RowGu__416EA7D8]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContentUser] ADD  CONSTRAINT [DF__ContentUs__NbrOc__4262CC11]  DEFAULT ((1)) FOR [NbrOccurances]
GO
ALTER TABLE [dbo].[ContentUser] ADD  CONSTRAINT [DF__ContentUs__Conte__4356F04A]  DEFAULT (newid()) FOR [ContentUserRowGuid]
GO
ALTER TABLE [dbo].[ContentUser] ADD  CONSTRAINT [DF__ContentUs__RowGu__444B1483]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContentUser] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ContentUser] ADD  DEFAULT (getdate()) FOR [LastAdded]
GO
ALTER TABLE [dbo].[ConvertedDocs] ADD  CONSTRAINT [DF__Converted__RowGu__453F38BC]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CoOwner] ADD  CONSTRAINT [DF__CoOwner__CreateD__36F11965]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CoOwner] ADD  CONSTRAINT [DF__CoOwner__RowGuid__4727812E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CorpContainer] ADD  CONSTRAINT [DF__CorpConta__RowGu__481BA567]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CorpFunction] ADD  CONSTRAINT [DF__CorpFunct__RowGu__490FC9A0]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Corporation] ADD  CONSTRAINT [DF__Corporati__RowGu__4A03EDD9]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CS] ADD  CONSTRAINT [DF_CS_ConnectionType]  DEFAULT ('ECMLIB') FOR [ConnectionType]
GO
ALTER TABLE [dbo].[CS] ADD  CONSTRAINT [DF__CS__RowGuid__4BEC364B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CS_SharePoint] ADD  CONSTRAINT [DF__CS_ShareP__RowGu__4CE05A84]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DatabaseFiles] ADD  CONSTRAINT [DF__DatabaseF__Creat__4DD47EBD]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[DatabaseFiles] ADD  CONSTRAINT [DF__DatabaseF__RowGu__4EC8A2F6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Databases] ADD  CONSTRAINT [DF__Databases__RowGu__4FBCC72F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataOwners] ADD  CONSTRAINT [DF__DataOwner__RowGu__50B0EB68]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SourceGuid]  DEFAULT ('NA') FOR [SourceGuid]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [df_DataSource_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SourceName]  DEFAULT ('NA') FOR [SourceName]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SourceTypeCode]  DEFAULT ('NA') FOR [SourceTypeCode]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_VersionNbr]  DEFAULT ((4)) FOR [VersionNbr]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_LastAccessDate]  DEFAULT (getdate()) FOR [LastAccessDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_FileLength]  DEFAULT ((0)) FOR [FileLength]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_LastWriteTime]  DEFAULT (getdate()) FOR [LastWriteTime]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_UserID]  DEFAULT ('NA') FOR [UserID]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_DataSourceOwnerUserID]  DEFAULT ('NA') FOR [DataSourceOwnerUserID]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isPublic]  DEFAULT ('N') FOR [isPublic]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_FileDirectory]  DEFAULT ('NA') FOR [FileDirectory]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OriginalFileType]  DEFAULT ('NA') FOR [OriginalFileType]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RetentionExpirationDate]  DEFAULT (getdate()) FOR [RetentionExpirationDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_IsPublicPreviousState]  DEFAULT ('Y') FOR [IsPublicPreviousState]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isAvailable]  DEFAULT ('Y') FOR [isAvailable]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isContainedWithinZipFile]  DEFAULT ('N') FOR [isContainedWithinZipFile]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_IsZipFile]  DEFAULT ('N') FOR [IsZipFile]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_DataVerified]  DEFAULT ((0)) FOR [DataVerified]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_ZipFileGuid]  DEFAULT ('NA') FOR [ZipFileGuid]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_Description]  DEFAULT ('NA') FOR [Description]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_KeyWords]  DEFAULT ('NA') FOR [KeyWords]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_Notes]  DEFAULT ('NA') FOR [Notes]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isPerm]  DEFAULT ('N') FOR [isPerm]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isMaster]  DEFAULT ('N') FOR [isMaster]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OcrPerformed]  DEFAULT ('N') FOR [OcrPerformed]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isGraphic]  DEFAULT ('N') FOR [isGraphic]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_GraphicContainsText]  DEFAULT ('N') FOR [GraphicContainsText]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OcrText]  DEFAULT ('NA') FOR [OcrText]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_ImageHiddenText]  DEFAULT ('NA') FOR [ImageHiddenText]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_isWebPage]  DEFAULT ('N') FOR [isWebPage]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_ParentGuid]  DEFAULT ('NA') FOR [ParentGuid]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RetentionCode]  DEFAULT ('NA') FOR [RetentionCode]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_MachineID]  DEFAULT ('NA') FOR [MachineID]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_CRC]  DEFAULT ('NA') FOR [CRC]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SharePoint]  DEFAULT ((0)) FOR [SharePoint]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SharePointDoc]  DEFAULT ((0)) FOR [SharePointDoc]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SharePointList]  DEFAULT ((0)) FOR [SharePointList]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SharePointListItem]  DEFAULT ((0)) FOR [SharePointListItem]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_StructuredData]  DEFAULT ((0)) FOR [StructuredData]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_HiveConnectionName]  DEFAULT ('NA') FOR [HiveConnectionName]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_HiveActive]  DEFAULT ((0)) FOR [HiveActive]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[DataSource] ADD  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_ContainedWithin]  DEFAULT ('NA') FOR [ContainedWithin]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RecLen]  DEFAULT ((0)) FOR [RecLen]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RecHash]  DEFAULT ('NA') FOR [RecHash]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OriginalSize]  DEFAULT ((0)) FOR [OriginalSize]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_CompressedSize]  DEFAULT ((0)) FOR [CompressedSize]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_txStartTime]  DEFAULT (getdate()) FOR [txStartTime]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_txEndTime]  DEFAULT (getdate()) FOR [txEndTime]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_txTotalTime]  DEFAULT ((0)) FOR [txTotalTime]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_TransmitTime]  DEFAULT ((0)) FOR [TransmitTime]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_FileAttached]  DEFAULT ((0)) FOR [FileAttached]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_BPS]  DEFAULT ((0)) FOR [BPS]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RepoName]  DEFAULT (@@servername) FOR [RepoName]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_HashFile]  DEFAULT ('NA') FOR [HashFile]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_HashName]  DEFAULT ('SHA512') FOR [HashName]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OcrSuccessful]  DEFAULT ('N') FOR [OcrSuccessful]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_OcrPending]  DEFAULT ('N') FOR [OcrPending]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfIsSearchable]  DEFAULT ('N') FOR [PdfIsSearchable]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfOcrRequired]  DEFAULT ('N') FOR [PdfOcrRequired]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfOcrSuccess]  DEFAULT ('N') FOR [PdfOcrSuccess]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfOcrTextExtracted]  DEFAULT ('N') FOR [PdfOcrTextExtracted]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfPages]  DEFAULT ((0)) FOR [PdfPages]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PdfImages]  DEFAULT ((0)) FOR [PdfImages]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RequireOcr]  DEFAULT ((0)) FOR [RequireOcr]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RssLinkFlg]  DEFAULT ((0)) FOR [RssLinkFlg]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RssLinkGuid]  DEFAULT ('NA') FOR [RssLinkGuid]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_PageURL]  DEFAULT ('NA') FOR [PageURL]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_RetentionDate]  DEFAULT (getdate()) FOR [RetentionDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_URLHash]  DEFAULT ('NA') FOR [URLHash]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_WebPagePublishDate]  DEFAULT ('NA') FOR [WebPagePublishDate]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SapData]  DEFAULT ((0)) FOR [SapData]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_Imagehash]  DEFAULT ('NA') FOR [Imagehash]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_ImageLen]  DEFAULT ((0)) FOR [ImageLen]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_FileDirectoryName]  DEFAULT ('NA') FOR [FileDirectoryName]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_FqnHASH]  DEFAULT ('NA') FOR [FqnHASH]
GO
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [def_SourceImageOrigin]  DEFAULT ('NA') FOR [SourceImageOrigin]
GO
ALTER TABLE [dbo].[DataSource] ADD  DEFAULT (getdate()) FOR [RecTimeStamp]
GO
ALTER TABLE [dbo].[DataSource] ADD  DEFAULT (newid()) FOR [RowGuid2]
GO
ALTER TABLE [dbo].[DataSourceCheckOut] ADD  CONSTRAINT [DF__DataSourc__check__74EE4BDE]  DEFAULT (getdate()) FOR [checkOutDate]
GO
ALTER TABLE [dbo].[DataSourceCheckOut] ADD  CONSTRAINT [DF__DataSourc__RowGu__529933DA]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceDelHist] ADD  DEFAULT (getdate()) FOR [DeletedDate]
GO
ALTER TABLE [dbo].[DataSourceImage] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceImage] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[DataSourceOwner] ADD  CONSTRAINT [DF__DataSourc__RowGu__538D5813]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Resto__7E77B618]  DEFAULT (getdate()) FOR [RestoreDate]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Creat__7F6BDA51]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF_DataSourceRestoreHistory_VerifiedData]  DEFAULT ('N') FOR [VerifiedData]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__RowGu__575DE8F7]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataTypeCodes] ADD  CONSTRAINT [DF__DataTypeC__RowGu__58520D30]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DB_UpdateHist] ADD  CONSTRAINT [DF__DB_Update__RowGu__59463169]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DB_Updates] ADD  CONSTRAINT [DF__DB_Update__RowGu__5A3A55A2]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DBUpdate] ADD  DEFAULT (getdate()) FOR [DateApplied]
GO
ALTER TABLE [dbo].[DBUpdate] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [dbo].[DBUpdate] ADD  DEFAULT ((0)) FOR [UpdateApplied]
GO
ALTER TABLE [dbo].[DeleteFrom] ADD  CONSTRAINT [DF__DeleteFro__RowGu__5B2E79DB]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirArchLib] ADD  CONSTRAINT [DF__DirArchLi__RowGu__5C229E14]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_QuickRefEntry]  DEFAULT ((0)) FOR [QuickRefEntry]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_isSysDefault]  DEFAULT ((0)) FOR [isSysDefault]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF__Directory__DirGu__60E75331]  DEFAULT (newid()) FOR [DirGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF__Directory__RowGu__61DB776A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF__Directory__Delet__62CF9BA3]  DEFAULT ('N') FOR [DeleteOnArchive]
GO
ALTER TABLE [dbo].[DirectoryArchive] ADD  DEFAULT ((0)) FOR [NbrFiles]
GO
ALTER TABLE [dbo].[DirectoryArchive] ADD  DEFAULT ('01/01/1900') FOR [LastArchive]
GO
ALTER TABLE [dbo].[DirectoryArchive] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryGuids] ADD  CONSTRAINT [DF__Directory__RowGu__63C3BFDC]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryListener] ADD  CONSTRAINT [DF__Directory__RowGu__64B7E415]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryListenerFiles] ADD  CONSTRAINT [DF_DirectoryListenerFiles_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[DirectoryListenerFiles] ADD  CONSTRAINT [DF__Directory__RowGu__66A02C87]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryLongName] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryLongName] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [dbo].[DirectoryMonitorLog] ADD  CONSTRAINT [DF_DirectoryMonitorLog_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DirectoryMonitorLog] ADD  CONSTRAINT [DF_DirectoryMonitorLog_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryTemp] ADD  CONSTRAINT [DF__Directory__RowGu__6A70BD6B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirProfiles] ADD  CONSTRAINT [DF__DirProfil__RowGu__6B64E1A4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DuplicateContent] ADD  CONSTRAINT [DF__Duplicate__RowGu__6C5905DD]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [UserAuthority]  DEFAULT ('U') FOR [Authority]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF_EcmUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF__EcmUser__LastUpd__31B762FC]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF__EcmUser__RowGuid__702996C1]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Email] ADD  DEFAULT (getdate()) FOR [RecTimeStamp]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_ArchiveOnlyIfRead]  DEFAULT ('N') FOR [ArchiveOnlyIfRead]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF__EmailArch__RowGu__73FA27A5]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailAttachment] ADD  CONSTRAINT [DF_EmailAttachment_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EmailAttachment] ADD  DEFAULT (getdate()) FOR [RecTimeStamp]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  CONSTRAINT [DF_EmailAttachmentSearchList_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  CONSTRAINT [DF_EmailAttachmentSearchList_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  CONSTRAINT [DF__EmailAtta__RowGu__76D69450]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailFolder] ADD  CONSTRAINT [DF_EmailFolder_isSysDefulat]  DEFAULT ((0)) FOR [isSysDefault]
GO
ALTER TABLE [dbo].[EmailFolder] ADD  CONSTRAINT [DF__EmailFold__RowGu__78BEDCC2]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailRunningTotal] ADD  CONSTRAINT [DF__EmailRunn__RowGu__79B300FB]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailToDelete] ADD  CONSTRAINT [DF__EmailToDe__RowGu__7AA72534]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF_ErrorLogs_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF_ErrorLogs_Severity]  DEFAULT (N'ERROR') FOR [Severity]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF__ErrorLogs__RowGu__7D8391DF]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcgKey] ADD  CONSTRAINT [DF_ExcgKey_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [dbo].[ExcgKey] ADD  CONSTRAINT [DF__ExcgKey__RowGuid__7F6BDA51]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_SSL]  DEFAULT ((0)) FOR [SSL]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_PortNbr]  DEFAULT ((-1)) FOR [PortNbr]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_DeleteAfterDownload]  DEFAULT ((0)) FOR [DeleteAfterDownload]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_IMap]  DEFAULT ((0)) FOR [IMap]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF__ExchangeH__RowGu__04308F6E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExchangeHostSmtp] ADD  CONSTRAINT [DF__ExchangeH__RowGu__0524B3A7]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcludedFiles] ADD  CONSTRAINT [DF__ExcludedF__RowGu__0618D7E0]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcludeFrom] ADD  CONSTRAINT [DF__ExcludeFr__RowGu__070CFC19]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKey] ADD  CONSTRAINT [DF__FileKey__RowGuid__08012052]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKeyMachine] ADD  CONSTRAINT [DF__FileKeyMa__RowGu__08F5448B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKeyMachineDir] ADD  CONSTRAINT [DF__FileKeyMa__RowGu__09E968C4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileLongName] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileLongName] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [dbo].[FileNeedProcessing] ADD  DEFAULT ((0)) FOR [FileApplied]
GO
ALTER TABLE [dbo].[FileNeedProcessing] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [dbo].[FilesToDelete] ADD  CONSTRAINT [DF__FilesToDe__RowGu__0ADD8CFD]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileType] ADD  CONSTRAINT [DF__FileType__RowGui__0BD1B136]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FUncSkipWords] ADD  CONSTRAINT [DF__FUncSkipW__RowGu__0CC5D56F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FunctionProdJargon] ADD  CONSTRAINT [DF__FunctionP__RowGu__0DB9F9A8]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalAsso] ADD  CONSTRAINT [DF__GlobalAss__RowGu__0EAE1DE1]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalDirectory] ADD  CONSTRAINT [DF__GlobalDir__RowGu__0FA2421A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalEmail] ADD  CONSTRAINT [DF__GlobalEma__RowGu__10966653]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalFile] ADD  CONSTRAINT [DF__GlobalFil__RowGu__118A8A8C]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalLocation] ADD  CONSTRAINT [DF__GlobalLoc__RowGu__127EAEC5]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalMachine] ADD  CONSTRAINT [DF__GlobalMac__RowGu__1372D2FE]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalSeachResults] ADD  CONSTRAINT [DF_GlobalSeachResults_Weight]  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[GlobalSeachResults] ADD  CONSTRAINT [DF__GlobalSea__RowGu__155B1B70]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_HiveActive]  DEFAULT ((0)) FOR [HiveActive]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF__GroupLibr__RowGu__1B13F4C6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GroupUsers] ADD  CONSTRAINT [DF__GroupUser__RowGu__1C0818FF]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HashDir] ADD  CONSTRAINT [DF__HashDir__RowGuid__1CFC3D38]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HashFile] ADD  CONSTRAINT [DF__HashFile__RowGui__1DF06171]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpInfo] ADD  CONSTRAINT [DF__HelpInfo__RowGui__1EE485AA]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_DisplayHelpText]  DEFAULT ((1)) FOR [DisplayHelpText]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF__HelpText__RowGui__22B5168E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpText_DisplayHelpTextUsers]  DEFAULT ((1)) FOR [DisplayHelpText]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF__HelpTextU__RowGu__2685A772]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HiveServers] ADD  CONSTRAINT [DF_HiveServers_LinkedDate]  DEFAULT (getdate()) FOR [LinkedDate]
GO
ALTER TABLE [dbo].[HiveServers] ADD  CONSTRAINT [DF__HiveServe__RowGu__286DEFE4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ImageTypeCodes] ADD  CONSTRAINT [DF__ImageType__RowGu__2962141D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IncludedFiles] ADD  CONSTRAINT [DF__IncludedF__RowGu__2A563856]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IncludeImmediate] ADD  CONSTRAINT [DF__IncludeIm__RowGu__2B4A5C8F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[InformationProduct] ADD  CONSTRAINT [DF__Informati__RowGu__2C3E80C8]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[InformationType] ADD  CONSTRAINT [DF__Informati__RowGu__2D32A501]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF__Inventory__RowGu__2E26C93A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IP] ADD  CONSTRAINT [DF__IP__RowGuid__2F1AED73]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[JargonWords] ADD  CONSTRAINT [DF__JargonWor__RowGu__300F11AC]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[JsonData] ADD  CONSTRAINT [DF_JsonData_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_KGUID]  DEFAULT (newid()) FOR [KGUID]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_KIV]  DEFAULT (newid()) FOR [KIV]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF__KTBL__RowGuid__33DFA290]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibDirectory] ADD  CONSTRAINT [DF__LibDirect__RowGu__34D3C6C9]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibEmail] ADD  CONSTRAINT [DF__LibEmail__RowGui__35C7EB02]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_isPublic]  DEFAULT ('N') FOR [isPublic]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF__Library__RowGuid__39987BE6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibraryItems] ADD  CONSTRAINT [DF__LibraryIt__RowGu__3A8CA01F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__ReadO__1FD8A9E3]  DEFAULT ((0)) FOR [ReadOnly]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Creat__20CCCE1C]  DEFAULT ((0)) FOR [CreateAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Updat__21C0F255]  DEFAULT ((1)) FOR [UpdateAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Delet__22B5168E]  DEFAULT ((0)) FOR [DeleteAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF_LibraryUsers_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF_LibraryUsers_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__RowGu__41399DAE]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_ActivationDate]  DEFAULT (getdate()) FOR [ActivationDate]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_InstallDate]  DEFAULT (getdate()) FOR [InstallDate]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF__License__RowGuid__44160A59]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoadProfile] ADD  CONSTRAINT [DF__LoadProfi__RowGu__450A2E92]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoadProfileItem] ADD  CONSTRAINT [DF__LoadProfi__RowGu__45FE52CB]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginClient] ADD  CONSTRAINT [DF_LoginClient_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginClient] ADD  CONSTRAINT [DF__LoginClie__RowGu__47E69B3D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginMachine] ADD  CONSTRAINT [DF_LoginMachine_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginMachine] ADD  CONSTRAINT [DF__LoginMach__RowGu__49CEE3AF]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginUser] ADD  CONSTRAINT [DF_LoginUser_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginUser] ADD  CONSTRAINT [DF__LoginUser__RowGu__4BB72C21]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [DF_Logs_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [DF__Logs__RowGuid__4D9F7493]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Machine] ADD  CONSTRAINT [DF__Machine__RowGuid__4E9398CC]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  CONSTRAINT [DF__MachineRe__Machi__4F87BD05]  DEFAULT (newid()) FOR [MachineGuid]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  CONSTRAINT [DF_MachineRegistered_NetWorkName]  DEFAULT ('NA') FOR [NetWorkName]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  CONSTRAINT [DF__MachineRe__RowGu__51700577]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[MyTempTable] ADD  CONSTRAINT [DF__MyTempTab__RowGu__526429B0]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[OutlookFrom] ADD  CONSTRAINT [DF_OutlookFrom_Verified]  DEFAULT ((1)) FOR [Verified]
GO
ALTER TABLE [dbo].[OutlookFrom] ADD  CONSTRAINT [DF__OutlookFr__RowGu__544C7222]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF__OwnerHist__Creat__2D67AF2B]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF_OwnerHistory_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF__OwnerHist__RowGu__5728DECD]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (newid()) FOR [RowIdentifier]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (newid()) FOR [ConnectiveGuid]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (newid()) FOR [IDGUID]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (getdate()) FOR [LastModDate]
GO
ALTER TABLE [dbo].[ProcessFileAs] ADD  CONSTRAINT [DF__ProcessFi__RowGu__5A054B78]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ProdCaptureItems] ADD  CONSTRAINT [DF__ProdCaptu__RowGu__5AF96FB1]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QtyDocs] ADD  CONSTRAINT [DF__QtyDocs__RowGuid__5BED93EA]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_QuickRefEntry]  DEFAULT ((1)) FOR [QuickRefEntry]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [DF__QuickDire__RowGu__5FBE24CE]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickRef] ADD  CONSTRAINT [DF__QuickRef__RowGui__60B24907]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickRefItems] ADD  CONSTRAINT [DF_QuickRefItems_MarkedForDeletion]  DEFAULT ((0)) FOR [MarkedForDeletion]
GO
ALTER TABLE [dbo].[QuickRefItems] ADD  CONSTRAINT [DF__QuickRefI__RowGu__629A9179]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Recipients] ADD  CONSTRAINT [DF__Recipient__RowGu__638EB5B2]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RepeatData] ADD  CONSTRAINT [DF__RepeatDat__RowGu__6482D9EB]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[reports] ADD  CONSTRAINT [DF__reports__RowGuid__6576FE24]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Repository] ADD  CONSTRAINT [DF__Repositor__RowGu__666B225D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestorationHistory] ADD  CONSTRAINT [DF_RestorationHistory_RestorationDate]  DEFAULT (getdate()) FOR [RestorationDate]
GO
ALTER TABLE [dbo].[RestorationHistory] ADD  CONSTRAINT [DF__Restorati__RowGu__68536ACF]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestoreQueue] ADD  CONSTRAINT [DF_RestoreQueue_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RestoreQueue] ADD  CONSTRAINT [DF_RestoreQueue_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT ((0)) FOR [ProcessingCompleted]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (getdate()) FOR [StartDownloadTime]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT ((30)) FOR [DaysWarning]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT ('Y') FOR [ResponseRequired]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT ((0)) FOR [HiveActive]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Retention] ADD  CONSTRAINT [DF__Retention__Reten__6E0C4425]  DEFAULT ('Year') FOR [RetentionPeriod]
GO
ALTER TABLE [dbo].[RetentionTemp] ADD  CONSTRAINT [DF__Retention__RowGu__6F00685E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RiskLevel] ADD  CONSTRAINT [DF__RiskLevel__RowGu__6FF48C97]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RssPull] ADD  CONSTRAINT [DF_RssPull_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[RssPull] ADD  CONSTRAINT [DF_RssPull_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RssPull] ADD  CONSTRAINT [DF__RssPull__isPubli__72D0F942]  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[RunParms] ADD  CONSTRAINT [DF__RunParms__RowGui__73C51D7B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RuntimeErrors] ADD  CONSTRAINT [DF_RuntimeErrors_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RuntimeErrors] ADD  CONSTRAINT [DF__RuntimeEr__RowGu__75AD65ED]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SavedItems] ADD  CONSTRAINT [DF__SavedItem__RowGu__76A18A26]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchGuids] ADD  DEFAULT (newid()) FOR [SourceGuid]
GO
ALTER TABLE [dbo].[SearchHistory] ADD  CONSTRAINT [DF_SearchHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[SearchHistory] ADD  CONSTRAINT [DF__SearchHis__RowGu__7889D298]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_NumberOfExecutions]  DEFAULT ((0)) FOR [NumberOfExecutions]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_LastModDate]  DEFAULT (getdate()) FOR [LastModDate]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF__SearchSch__RowGu__7C5A637C]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchUser] ADD  CONSTRAINT [DF__SearchUse__RowGu__7D4E87B5]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchUser] ADD  CONSTRAINT [DF__SearchUse__Creat__7E42ABEE]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SearchUser] ADD  CONSTRAINT [DF__SearchUse__LastU__7F36D027]  DEFAULT (getdate()) FOR [LastUsedDate]
GO
ALTER TABLE [dbo].[SearhParmsHistory] ADD  CONSTRAINT [DF_SearhParmsHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[SearhParmsHistory] ADD  CONSTRAINT [DF__SearhParm__RowGu__011F1899]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ServiceActivity] ADD  CONSTRAINT [DF__ServiceAc__RowGu__02133CD2]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SessionID] ADD  CONSTRAINT [DF_SessionID_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SessionVar] ADD  CONSTRAINT [DF_SessionVar_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SessionVar] ADD  CONSTRAINT [DF__SessionVa__RowGu__03FB8544]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SkipWords] ADD  CONSTRAINT [DF__SkipWords__RowGu__04EFA97D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceAttribute] ADD  CONSTRAINT [DF__SourceAtt__RowGu__05E3CDB6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceContainer] ADD  CONSTRAINT [DF__SourceCon__RowGu__06D7F1EF]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  CONSTRAINT [DF__SourceInj__LastE__07CC1628]  DEFAULT ('01-01-1960') FOR [LastExecDate]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  CONSTRAINT [DF__SourceInj__NbrEx__08C03A61]  DEFAULT ((0)) FOR [NbrExecutions]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  CONSTRAINT [DF__SourceInj__RowGu__09B45E9A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [FALSE]  DEFAULT ((0)) FOR [StoreExternal]
GO
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [TRUE]  DEFAULT ((1)) FOR [Indexable]
GO
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [DF__SourceTyp__RowGu__0C90CB45]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SqlDataTypes] ADD  CONSTRAINT [DF__SqlDataTy__RowGu__0D84EF7E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StagedSQL] ADD  CONSTRAINT [DF_StagedSQL_EntryTime]  DEFAULT (getdate()) FOR [EntryTime]
GO
ALTER TABLE [dbo].[StagedSQL] ADD  CONSTRAINT [DF__StagedSQL__RowGu__0F6D37F0]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatsClick] ADD  CONSTRAINT [DF_Table_1_ClickDate]  DEFAULT (getdate()) FOR [ClickDate]
GO
ALTER TABLE [dbo].[StatsClick] ADD  CONSTRAINT [DF__StatsClic__RowGu__11558062]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatSearch] ADD  CONSTRAINT [DF_StatSearch_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[StatSearch] ADD  CONSTRAINT [DF__StatSearc__RowGu__133DC8D4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatWord] ADD  CONSTRAINT [DF__StatWord__RowGui__1431ED0D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Storage] ADD  CONSTRAINT [DF__Storage__RowGuid__15261146]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StructuredData] ADD  CONSTRAINT [DF__Structure__RowGu__161A357F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StructuredDataProcessed] ADD  CONSTRAINT [DF__Structure__RowGu__170E59B8]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SubDir] ADD  CONSTRAINT [DF_SubDir_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[SubDir] ADD  CONSTRAINT [DF__SubDir__RowGuid__18F6A22A]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SubLibrary] ADD  CONSTRAINT [DF__SubLibrar__RowGu__19EAC663]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SystemMessage] ADD  CONSTRAINT [DF__SystemMes__RowGu__1ADEEA9C]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SystemParms] ADD  CONSTRAINT [DF__SystemPar__RowGu__1BD30ED5]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[TempUserLibItems] ADD  CONSTRAINT [DF__TempUserL__RowGu__1CC7330E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[TestTbl] ADD  CONSTRAINT [DF__TestTbl__RowGuid__1DBB5747]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Trace] ADD  CONSTRAINT [DF_Trace_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Trace] ADD  CONSTRAINT [DF__Trace__RowGuid__1FA39FB9]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[txTimes] ADD  CONSTRAINT [DF_txTimes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[txTimes] ADD  CONSTRAINT [DF__txTimes__RowGuid__218BE82B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UD_Qty] ADD  CONSTRAINT [DF__UD_Qty__RowGuid__22800C64]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[upgrade_status] ADD  CONSTRAINT [DF__upgrade_s__statu__2374309D]  DEFAULT ('INCOMPLETE') FOR [status]
GO
ALTER TABLE [dbo].[upgrade_status] ADD  CONSTRAINT [DF__upgrade_s__RowGu__246854D6]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UrlList] ADD  CONSTRAINT [DF__UrlList__RowGuid__255C790F]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UrlRejection] ADD  CONSTRAINT [DF__UrlReject__RowGu__26509D48]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserCurrParm] ADD  CONSTRAINT [DF__UserCurrP__RowGu__2744C181]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserGridState] ADD  CONSTRAINT [DF__UserGridS__RowGu__2838E5BA]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserGroup] ADD  CONSTRAINT [DF__UserGroup__RowGu__292D09F3]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_ReassignmentDate]  DEFAULT (getdate()) FOR [ReassignmentDate]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_RowID]  DEFAULT (newid()) FOR [RowID]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF__UserReass__RowGu__2C09769E]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Admin]  DEFAULT ('U') FOR [Admin]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isActive]  DEFAULT ('Y') FOR [isActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_ActiveGuid]  DEFAULT (newid()) FOR [ActiveGuid]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF__Users__RowGuid__2FDA0782]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserScreenState] ADD  CONSTRAINT [DF__UserScree__RowGu__30CE2BBB]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserSearchState] ADD  CONSTRAINT [DF__UserSearc__RowGu__31C24FF4]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[VersionInfo] ADD  CONSTRAINT [DF__VersionIn__RowGu__32B6742D]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Volitility] ADD  CONSTRAINT [DF__Volitilit__RowGu__33AA9866]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebScreen] ADD  CONSTRAINT [DF_WebScreen_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebScreen] ADD  CONSTRAINT [DF_WebScreen_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebScreen] ADD  CONSTRAINT [DF__WebScreen__isPub__36870511]  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF_WebSite_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF_WebSite_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF__WebSite__Depth__396371BC]  DEFAULT ((0)) FOR [Depth]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF__WebSite__Width__3A5795F5]  DEFAULT ((0)) FOR [Width]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF__WebSite__isPubli__3B4BBA2E]  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [CURRDATE_WebSource]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_RetentionExpirationDate]  DEFAULT (getdate()+(3650)) FOR [RetentionExpirationDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF__WebSource__RowGu__3F1C4B12]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ZippedFiles] ADD  CONSTRAINT [DF__ZippedFil__RowGu__40106F4B]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [lsnr].[DirListener] ADD  DEFAULT ((0)) FOR [FileCanBeDropped]
GO
ALTER TABLE [lsnr].[DirListener] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [lsnr].[FileNeedProcessing] ADD  DEFAULT ((0)) FOR [FileApplied]
GO
ALTER TABLE [lsnr].[FileNeedProcessing] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [lsnr].[ProcessedListenerFiles] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction30] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefCorpFunction30]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefJargonWords33] FOREIGN KEY([JargonCode], [JargonWords_tgtWord])
REFERENCES [dbo].[JargonWords] ([JargonCode], [tgtWord])
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefJargonWords33]
GO
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer18] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefSourceContainer18]
GO
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefStorage17] FOREIGN KEY([StoreCode])
REFERENCES [dbo].[Storage] ([StoreCode])
GO
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefStorage17]
GO
ALTER TABLE [dbo].[ContentContainer]  WITH CHECK ADD  CONSTRAINT [RefContainer76] FOREIGN KEY([ContainerGuid])
REFERENCES [dbo].[Container] ([ContainerGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentContainer] CHECK CONSTRAINT [RefContainer76]
GO
ALTER TABLE [dbo].[ContentContainer]  WITH CHECK ADD  CONSTRAINT [RefContentUser75] FOREIGN KEY([ContentUserRowGuid])
REFERENCES [dbo].[ContentUser] ([ContentUserRowGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentContainer] CHECK CONSTRAINT [RefContentUser75]
GO
ALTER TABLE [dbo].[ContentUser]  WITH CHECK ADD  CONSTRAINT [RefUsers64] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentUser] CHECK CONSTRAINT [RefUsers64]
GO
ALTER TABLE [dbo].[ConvertedDocs]  WITH CHECK ADD  CONSTRAINT [RefCorporation38] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
ALTER TABLE [dbo].[ConvertedDocs] CHECK CONSTRAINT [RefCorporation38]
GO
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers86] FOREIGN KEY([PreviousOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers86]
GO
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers87] FOREIGN KEY([CurrentOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers87]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction24] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefCorpFunction24]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefQtyDocs10] FOREIGN KEY([QtyDocCode])
REFERENCES [dbo].[QtyDocs] ([QtyDocCode])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefQtyDocs10]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer2] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefSourceContainer2]
GO
ALTER TABLE [dbo].[CorpFunction]  WITH CHECK ADD  CONSTRAINT [RefCorporation37] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
ALTER TABLE [dbo].[CorpFunction] CHECK CONSTRAINT [RefCorporation37]
GO
ALTER TABLE [dbo].[DataSourceCheckOut]  WITH CHECK ADD  CONSTRAINT [RefUsers90] FOREIGN KEY([CheckedOutByUserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DataSourceCheckOut] CHECK CONSTRAINT [RefUsers90]
GO
ALTER TABLE [dbo].[Directory]  WITH CHECK ADD  CONSTRAINT [RefUsers3] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Directory] CHECK CONSTRAINT [RefUsers3]
GO
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefDatabases8] FOREIGN KEY([DB_ID])
REFERENCES [dbo].[Databases] ([DB_ID])
GO
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefDatabases8]
GO
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefUsers4] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefUsers4]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList]  WITH CHECK ADD  CONSTRAINT [RefUsers82] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] CHECK CONSTRAINT [RefUsers82]
GO
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction34] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefCorpFunction34]
GO
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefSkipWords35] FOREIGN KEY([tgtWord])
REFERENCES [dbo].[SkipWords] ([tgtWord])
GO
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefSkipWords35]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode29] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefBusinessJargonCode29]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction28] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefCorpFunction28]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefRepeatData15] FOREIGN KEY([RepeatDataCode])
REFERENCES [dbo].[RepeatData] ([RepeatDataCode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefRepeatData15]
GO
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers52] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [RefUsers52]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefCorpContainer25] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpContainer] ([ContainerType], [CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefCorpContainer25]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefInformationType36] FOREIGN KEY([InfoTypeCode])
REFERENCES [dbo].[InformationType] ([InfoTypeCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefInformationType36]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefRetention16] FOREIGN KEY([RetentionCode])
REFERENCES [dbo].[Retention] ([RetentionCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefRetention16]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefUD_Qty7] FOREIGN KEY([Code])
REFERENCES [dbo].[UD_Qty] ([Code])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefUD_Qty7]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefVolitility19] FOREIGN KEY([VolitilityCode])
REFERENCES [dbo].[Volitility] ([VolitilityCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefVolitility19]
GO
ALTER TABLE [dbo].[JargonWords]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode27] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
GO
ALTER TABLE [dbo].[JargonWords] CHECK CONSTRAINT [RefBusinessJargonCode27]
GO
ALTER TABLE [dbo].[LibDirectory]  WITH NOCHECK ADD  CONSTRAINT [RefLibrary124] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibDirectory] CHECK CONSTRAINT [RefLibrary124]
GO
ALTER TABLE [dbo].[LibEmail]  WITH NOCHECK ADD  CONSTRAINT [RefLibrary123] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibEmail] CHECK CONSTRAINT [RefLibrary123]
GO
ALTER TABLE [dbo].[Library]  WITH NOCHECK ADD  CONSTRAINT [FK__Library__UserID__1BB31344] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Library] CHECK CONSTRAINT [FK__Library__UserID__1BB31344]
GO
ALTER TABLE [dbo].[LibraryUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers99] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[LibraryUsers] CHECK CONSTRAINT [RefUsers99]
GO
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefLoadProfile1271] FOREIGN KEY([ProfileName])
REFERENCES [dbo].[LoadProfile] ([ProfileName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefLoadProfile1271]
GO
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefSourceType1281] FOREIGN KEY([SourceTypeCode])
REFERENCES [dbo].[SourceType] ([SourceTypeCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefSourceType1281]
GO
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefCaptureItems22] FOREIGN KEY([CaptureItemsCode])
REFERENCES [dbo].[CaptureItems] ([CaptureItemsCode])
GO
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefCaptureItems22]
GO
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefInformationProduct21] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[InformationProduct] ([ContainerType], [CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefInformationProduct21]
GO
ALTER TABLE [dbo].[QuickRef]  WITH CHECK ADD  CONSTRAINT [RefUsers112] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[QuickRef] CHECK CONSTRAINT [RefUsers112]
GO
ALTER TABLE [dbo].[QuickRefItems]  WITH CHECK ADD  CONSTRAINT [RefQuickRef115] FOREIGN KEY([QuickRefIdNbr])
REFERENCES [dbo].[QuickRef] ([QuickRefIdNbr])
GO
ALTER TABLE [dbo].[QuickRefItems] CHECK CONSTRAINT [RefQuickRef115]
GO
ALTER TABLE [dbo].[RssPull]  WITH CHECK ADD  CONSTRAINT [RssPullCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RssPull] CHECK CONSTRAINT [RssPullCascadeDelete]
GO
ALTER TABLE [dbo].[SubDir]  WITH CHECK ADD  CONSTRAINT [RefDirectory15] FOREIGN KEY([UserID], [FQN])
REFERENCES [dbo].[Directory] ([UserID], [FQN])
GO
ALTER TABLE [dbo].[SubDir] CHECK CONSTRAINT [RefDirectory15]
GO
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4BB72C21] FOREIGN KEY([SubUserID], [SubLibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4BB72C21]
GO
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4CAB505A] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4CAB505A]
GO
ALTER TABLE [dbo].[UserGroup]  WITH CHECK ADD  CONSTRAINT [FK__UserGroup__Group__2077C861] FOREIGN KEY([GroupOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK__UserGroup__Group__2077C861]
GO
ALTER TABLE [dbo].[WebScreen]  WITH CHECK ADD  CONSTRAINT [WebScreenCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebScreen] CHECK CONSTRAINT [WebScreenCascadeDelete]
GO
ALTER TABLE [dbo].[WebSite]  WITH CHECK ADD  CONSTRAINT [WebSiteCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSite] CHECK CONSTRAINT [WebSiteCascadeDelete]
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD  CONSTRAINT [CK__upgrade_s__statu__6FBF826D] CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
ALTER TABLE [dbo].[upgrade_status] CHECK CONSTRAINT [CK__upgrade_s__statu__6FBF826D]
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD  CONSTRAINT [CK__upgrade_s__statu__70B3A6A6] CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
ALTER TABLE [dbo].[upgrade_status] CHECK CONSTRAINT [CK__upgrade_s__statu__70B3A6A6]
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD  CONSTRAINT [CK__upgrade_s__statu__71A7CADF] CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
ALTER TABLE [dbo].[upgrade_status] CHECK CONSTRAINT [CK__upgrade_s__statu__71A7CADF]
GO
/****** Object:  StoredProcedure [dbo].[_searchDocs_31]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[_searchDocs_31]
(@P1_keyword    NVARCHAR(MAX), 
 @P2_ecmLoginID NVARCHAR(MAX) = ''
)
AS
    BEGIN
        DECLARE @sql NVARCHAR(MAX);
        DECLARE @uid NVARCHAR(MAX);
        DECLARE @admin NVARCHAR;
        BEGIN
            IF OBJECT_ID('tempdb..#tmpSourceGuids') IS NOT NULL
                BEGIN
                    DROP TABLE #Results;
            END;
            SET @uid = dbo.getUserID(@P2_ecmLoginID);
            SET @admin = dbo.getAdmin(@P2_ecmLoginID);
            IF(@uid IS NULL
               OR @uid = '')
                BEGIN
                    RETURN;
            END;
            IF(@admin IS NULL
               OR @admin = '')
                BEGIN
                    RETURN;
            END;
        END;

        -- jlc: moved join of library tables from DataSource join into #tmpSourceGuids table

        SELECT LibraryItems.SourceGuid
        INTO #tmpSourceGuids
        FROM LibraryItems
             INNER JOIN Library ON LibraryItems.LibraryName = Library.LibraryName
             INNER JOIN LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName
             INNER JOIN GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName
             INNER JOIN GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
        WHERE LibraryUsers.userid = @uid
        UNION
        SELECT LI.SourceGuid
        FROM LibraryItems AS LI
             INNER JOIN LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName
        WHERE LU.UserID = @uid;
        CREATE CLUSTERED INDEX TEMP_IDX_SourceGuid ON #tmpSourceGuids(SourceGuid);
        SET @sql = 'SELECT      SourceGuid,
                        SourceName AS Document,
                        OriginalFileType AS Type,
                        FileLength AS Size,

                        REPLACE ( FileDirectory, ''\\PICAA0200900743\'', '''' )   AS  Path

        FROM    DataSource

        WHERE CONTAINS (*, ''' + @P1_keyword + ''')
        AND
        SourceGuid IN 
        (
                SELECT SourceGuid       
                FROM   #tmpSourceGuids  )

        ORDER BY SourceName';
        EXEC (@sql);
        IF OBJECT_ID('tempdb..#tmpSourceGuids') IS NOT NULL
            BEGIN
                DROP TABLE #Results;
        END;
    END;

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -- 

/*

EXEC _searchDocs_31_V2 'tolerance', 'prashant.savalia', GeneratedSQL --as nvarchar

*/

GO
/****** Object:  StoredProcedure [dbo].[_searchDocs_31_V2]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[_searchDocs_31_V2]
(@P1_keyword    NVARCHAR(MAX), 
 @P2_ecmLoginID NVARCHAR(MAX) = '', 
 @sql           NVARCHAR(MAX)
)
AS
    BEGIN   
        --DECLARE @sql    nvarchar(max)
        DECLARE @uid NVARCHAR(MAX);
        DECLARE @admin NVARCHAR;
        BEGIN
            SET @uid = dbo.getUserID(@P2_ecmLoginID);
            SET @admin = dbo.getAdmin(@P2_ecmLoginID);
			IF(@uid IS NULL
               OR @uid = '')
                RETURN;
            IF(@admin IS NULL
               OR @admin = '')
                RETURN;
        END;

        -- jlc: moved join of library tables from DataSource join into #tmpSourceGuids table

        SELECT LibraryItems.SourceGuid
        INTO #tmpSourceGuids
        FROM LibraryItems
             INNER JOIN Library ON LibraryItems.LibraryName = Library.LibraryName
             INNER JOIN LibraryUsers ON Library.LibraryName = LibraryUsers.LibraryName
             INNER JOIN GroupLibraryAccess ON Library.LibraryName = GroupLibraryAccess.LibraryName
             INNER JOIN GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName
        WHERE LibraryUsers.userid = @uid
        UNION
        SELECT LI.SourceGuid
        FROM LibraryItems AS LI
             INNER JOIN LibraryUsers AS LU ON LI.LibraryName = LU.LibraryName
        WHERE LU.UserID = @uid;

        --     SET @sql =
        --'SELECT      SourceGuid,
        --                     SourceName AS Document,
        --                     OriginalFileType AS Type,
        --                     FileLength AS Size,
        --                     REPLACE ( FileDirectory, ''\\PICAA0200900743\'', '''' )   AS  Path
        --     FROM    DataSource
        --     WHERE CONTAINS (*, ''' + @P1_keyword + ''')
        --     AND
        --     SourceGuid IN 
        --     (
        --             SELECT SourceGuid       
        --             FROM   #tmpSourceGuids  )
        --     ORDER BY SourceName'   

        EXEC (@sql);
    END;
        DROP TABLE #tmpSourceGuids;

--  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  --  -- 

/*

EXEC _searchDocs_31 'tolerance', 'prashant.savalia'

*/

GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AppliedDbUpdatesSelProc] ( 
                @CompanyID NVARCHAR(50) , 
                @FixID     NVARCHAR(50)
                                            ) 
AS
    BEGIN
        SELECT CompanyID , FixID , STATUS , ReturnMsg , ApplyDate
        FROM AppliedDbUpdates
        WHERE CompanyID = @CompanyID
              AND 
              FixID = @FixID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ArchiveFromSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ArchiveFromSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                       ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID
        FROM ArchiveFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: ArchiveHistContentTypeSelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistContentTypeSelProc] ( 
                @ArchiveID NVARCHAR(50) , 
                @Directory NVARCHAR(254) , 
                @FileType  NVARCHAR(50)
                                                  ) 
AS
    BEGIN
        SELECT ArchiveID , Directory , FileType , NbrFilesArchived
        FROM ArchiveHistContentType
        WHERE ArchiveID = @ArchiveID
              AND 
              Directory = @Directory
              AND 
              FileType = @FileType;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: ArchiveHistSelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistSelProc] ( 
                @ArchiveID NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT ArchiveID , ArchiveDate , NbrFilesArchived , UserGuid
        FROM ArchiveHist
        WHERE ArchiveID = @ArchiveID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[AtributeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AtributeSelProc] ( 
                @AttributeName NVARCHAR(50)
                                    ) 
AS
    BEGIN
        SELECT AttributeName , AttributeDataType , AttributeDesc
        FROM Atribute
        WHERE AttributeName = @AttributeName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: AttachmentTypeSelProc 
 */

CREATE PROCEDURE [dbo].[AttachmentTypeSelProc] ( 
                @AttachmentCode NVARCHAR(50)
                                          ) 
AS
    BEGIN
        SELECT AttachmentCode , Description
        FROM AttachmentType
        WHERE AttachmentCode = @AttachmentCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[AttributeDatatypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: AttributeDatatypeSelProc 
 */

CREATE PROCEDURE [dbo].[AttributeDatatypeSelProc] ( 
                @AttributeDataType NVARCHAR(50)
                                             ) 
AS
    BEGIN
        SELECT AttributeDataType
        FROM AttributeDatatype
        WHERE AttributeDataType = @AttributeDataType;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[AttributesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: AttributesSelProc 
 */

CREATE PROCEDURE [dbo].[AttributesSelProc] ( 
                @AttributeName NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT AttributeName , AttributeDataType , AttributeDesc , AssoApplication
        FROM Attributes
        WHERE AttributeName = @AttributeName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[AvailFileTypesSelProc] ( 
                @ExtCode NVARCHAR(50)
                                          ) 
AS
    BEGIN
        SELECT ExtCode
        FROM AvailFileTypes
        WHERE ExtCode = @ExtCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[BusinessFunctionJargonSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: BusinessFunctionJargonSelProc 
 */

CREATE PROCEDURE [dbo].[BusinessFunctionJargonSelProc] ( 
                @CorpFuncName        NVARCHAR(80) , 
                @WordID              INT , 
                @JargonWords_tgtWord NVARCHAR(50) , 
                @JargonCode          NVARCHAR(50) , 
                @CorpName            NVARCHAR(50)
                                                  ) 
AS
    BEGIN
        SELECT CorpFuncName , WordID , JargonWords_tgtWord , JargonCode , CorpName
        FROM BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              WordID = @WordID
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWord
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: BusinessJargonCodeSelProc 
 */

CREATE PROCEDURE [dbo].[BusinessJargonCodeSelProc] ( 
                @JargonCode NVARCHAR(50)
                                              ) 
AS
    BEGIN
        SELECT JargonCode , JargonDesc
        FROM BusinessJargonCode
        WHERE JargonCode = @JargonCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: CaptureItemsSelProc 
 */

CREATE PROCEDURE [dbo].[CaptureItemsSelProc] ( 
                @CaptureItemsCode NVARCHAR(50)
                                        ) 
AS
    BEGIN
        SELECT CaptureItemsCode , CaptureItemsDesc , CreateDate
        FROM CaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CategorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: CategorySelProc 
 */

CREATE PROCEDURE [dbo].[CategorySelProc] ( 
                @CategoryName NVARCHAR(50)
                                    ) 
AS
    BEGIN
        SELECT CategoryName , Description
        FROM Category
        WHERE CategoryName = @CategoryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CompanySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: CompanySelProc 
 */

CREATE PROCEDURE [dbo].[CompanySelProc] ( 
                @CompanyID NVARCHAR(50)
                                   ) 
AS
    BEGIN
        SELECT CompanyID , CompanyName
        FROM Company
        WHERE CompanyID = @CompanyID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContactFromSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ContactFromSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                       ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID , Verified
        FROM ContactFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ContactsArchiveSelProc] ( 
                @Email1Address NVARCHAR(80) , 
                @FullName      NVARCHAR(80) , 
                @UserID        CHAR(25)
                                           ) 
AS
    BEGIN
        SELECT Email1Address , FullName , UserID , Account , Anniversary , Application , AssistantName , AssistantTelephoneNumber , BillingInformation , Birthday , Business2TelephoneNumber , BusinessAddress , BusinessAddressCity , BusinessAddressCountry , BusinessAddressPostalCode , BusinessAddressPostOfficeBox , BusinessAddressState , BusinessAddressStreet , BusinessCardType , BusinessFaxNumber , BusinessHomePage , BusinessTelephoneNumber , CallbackTelephoneNumber , CarTelephoneNumber , Categories , Children , xClass , Companies , CompanyName , ComputerNetworkName , Conflicts , ConversationTopic , CreationTime , CustomerID , Department , Email1AddressType , Email1DisplayName , Email1EntryID , Email2Address , Email2AddressType , Email2DisplayName , Email2EntryID , Email3Address , Email3AddressType , Email3DisplayName , Email3EntryID , FileAs , FirstName , FTPSite , Gender , GovernmentIDNumber , Hobby , Home2TelephoneNumber , HomeAddress , HomeAddressCountry , HomeAddressPostalCode , HomeAddressPostOfficeBox , HomeAddressState , HomeAddressStreet , HomeFaxNumber , HomeTelephoneNumber , IMAddress , Importance , Initials , InternetFreeBusyAddress , JobTitle , Journal , Language , LastModificationTime , LastName , LastNameAndFirstName , MailingAddress , MailingAddressCity , MailingAddressCountry , MailingAddressPostalCode , MailingAddressPostOfficeBox , MailingAddressState , MailingAddressStreet , ManagerName , MiddleName , Mileage , MobileTelephoneNumber , NetMeetingAlias , NetMeetingServer , NickName , Title , Body , OfficeLocation , Subject
        FROM ContactsArchive
        WHERE Email1Address = @Email1Address
              AND 
              FullName = @FullName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContainerSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: ContainerSelProc 
 */

CREATE PROCEDURE [dbo].[ContainerSelProc] ( 
                @ContainerGuid UNIQUEIDENTIFIER
                                     ) 
AS
    BEGIN
        SELECT ContainerGuid , ContainerName
        FROM Container
        WHERE ContainerGuid = @ContainerGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContainerStorageSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: ContainerStorageSelProc 
 */

CREATE PROCEDURE [dbo].[ContainerStorageSelProc] ( 
                @StoreCode     NVARCHAR(50) , 
                @ContainerType NVARCHAR(25)
                                            ) 
AS
    BEGIN
        SELECT StoreCode , ContainerType
        FROM ContainerStorage
        WHERE StoreCode = @StoreCode
              AND 
              ContainerType = @ContainerType;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ContentUserSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: ContentUserSelProc 
 */

CREATE PROCEDURE [dbo].[ContentUserSelProc] ( 
                @ContentTypeCode NCHAR(1) , 
                @ContentGuid     NVARCHAR(50) , 
                @UserID          NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT ContentTypeCode , ContentGuid , UserID , NbrOccurances
        FROM ContentUser
        WHERE ContentTypeCode = @ContentTypeCode
              AND 
              ContentGuid = @ContentGuid
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: ConvertedDocsSelProc 
 */

CREATE PROCEDURE [dbo].[ConvertedDocsSelProc] ( 
                @FQN      NVARCHAR(254) , 
                @CorpName NVARCHAR(50)
                                         ) 
AS
    BEGIN
        SELECT FQN , FileName , XMLName , XMLDIr , FileDir , CorpName
        FROM ConvertedDocs
        WHERE FQN = @FQN
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CoOwnerSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CoOwnerSelProc] ( 
                @RowId INT
                                   ) 
AS
    BEGIN
        SELECT RowId , CurrentOwnerUserID , CreateDate , PreviousOwnerUserID
        FROM CoOwner
        WHERE RowId = @RowId;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CorpContainerSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: CorpContainerSelProc 
 */

CREATE PROCEDURE [dbo].[CorpContainerSelProc] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                         ) 
AS
    BEGIN
        SELECT ContainerType , QtyDocCode , CorpFuncName , CorpName
        FROM CorpContainer
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: CorpFunctionSelProc 
 */

CREATE PROCEDURE [dbo].[CorpFunctionSelProc] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                        ) 
AS
    BEGIN
        SELECT CorpFuncName , CorpFuncDesc , CreateDate , CorpName
        FROM CorpFunction
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[CorporationSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: CorporationSelProc 
 */

CREATE PROCEDURE [dbo].[CorporationSelProc] ( 
                @CorpName NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT CorpName
        FROM Corporation
        WHERE CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DatabasesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DatabasesSelProc] ( 
                @DB_ID NVARCHAR(50)
                                     ) 
AS
    BEGIN
        SELECT DB_ID , DB_CONN_STR
        FROM Databases
        WHERE DB_ID = @DB_ID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DataOwnersSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DataOwnersSelProc] ( 
                @SourceGuid            NVARCHAR(50) , 
                @UserID                NVARCHAR(50) , 
                @GroupOwnerUserID      NVARCHAR(50) , 
                @GroupName             NVARCHAR(80) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT PrimaryOwner , OwnerTypeCode , FullAccess , ReadOnly , DeleteAccess , Searchable , SourceGuid , UserID , GroupOwnerUserID , GroupName , DataSourceOwnerUserID
        FROM DataOwners
        WHERE SourceGuid = @SourceGuid
              AND 
              UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DataSourceCheckOutSelProc] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @CheckedOutByUserID    NVARCHAR(50)
                                              ) 
AS
    BEGIN
        SELECT SourceGuid , DataSourceOwnerUserID , CheckedOutByUserID , isReadOnly , isForUpdate , checkOutDate
        FROM DataSourceCheckOut
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              CheckedOutByUserID = @CheckedOutByUserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DataSourceRestoreHistorySelProc] ( 
                @SeqNo INT
                                                    ) 
AS
    BEGIN
        SELECT SourceGuid , RestoredToMachine , RestoreUserName , RestoreUserID , RestoreUserDomain , RestoreDate , DataSourceOwnerUserID , SeqNo , TypeContentCode , CreateDate , DocumentName , FQN , VerifiedData
        FROM DataSourceRestoreHistory
        WHERE SeqNo = @SeqNo;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DataSourceSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: DataSourceSelProc 
 */

CREATE PROCEDURE [dbo].[DataSourceSelProc] ( 
                @SourceGuid NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT SourceGuid , CreateDate , SourceName , SourceImage , SourceTypeCode
        FROM DataSource
        WHERE SourceGuid = @SourceGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: DB_UpdatesSelProc 
 */

CREATE PROCEDURE [dbo].[DB_UpdatesSelProc] ( 
                @FixID NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT SqlStmt , CreateDate , FixID , FixDescription , DBName , CompanyID , MachineName
        FROM DB_Updates
        WHERE FixID = @FixID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[delete_DirectoryArchive]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[delete_DirectoryArchive] (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	--declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	--set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		delete from DirectoryArchive where UserID = @UserID and FQN = @DirName;
	end

end

GO
/****** Object:  StoredProcedure [dbo].[DeleteFromSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DeleteFromSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                      ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID
        FROM DeleteFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[DirectorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[DirectorySelProc] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                     ) 
AS
    BEGIN
        SELECT UserID , IncludeSubDirs , FQN , DB_ID , VersionFiles , ckMetaData , ckPublic , ckDisableDir , QuickRefEntry , isSysDefault
        FROM Directory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ECM_HivePerftest]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [ECM_HivePerftest]

CREATE PROCEDURE [dbo].[ECM_HivePerftest]
AS
    BEGIN
        DECLARE @result INT;
        BEGIN
            DECLARE @datetime1 DATETIME;
            DECLARE @datetime2 DATETIME;
            DECLARE @elapsed_seconds INT;
            DECLARE @elapsed_milliseconds INT;
            DECLARE @elapsed_time DATETIME;
            DECLARE @elapsed_days INT;
            DECLARE @elapsed_hours INT;
            DECLARE @elapsed_minutes INT;
            DECLARE @iCount INT;
            SELECT @datetime1 = GETDATE();
            SET @iCount = ( SELECT COUNT(*)
                            FROM datasource
                            WHERE SourceGuid = 'xx'
                          );
            SET @iCount = ( SELECT COUNT(*)
                            FROM Email
                            WHERE EmailGuid = 'xx'
                          );
            SET @iCount = ( SELECT COUNT(*)
                            FROM EmailAttachment
                            WHERE EmailGuid = 'xx'
                          );
            SET @iCount = ( SELECT COUNT(*)
                            FROM SourceAttribute
                            WHERE SourceGuid = 'xx'
                          );
            SELECT @datetime2 = GETDATE();
            SELECT @elapsed_time = @datetime2 - @datetime1;
            SELECT @elapsed_days = DATEDIFF(day , 0 , @elapsed_time);
            SELECT @elapsed_hours = DATEPART(hour , @elapsed_time);
            SELECT @elapsed_minutes = DATEPART(minute , @elapsed_time);
            SELECT @elapsed_seconds = DATEPART(second , @elapsed_time);
            SELECT @elapsed_milliseconds = DATEPART(millisecond , @elapsed_time);
            DECLARE @cr VARCHAR(4) , @cr2 VARCHAR(4);
            SELECT @cr = CHAR(13) + CHAR(10);
            SELECT @cr2 = @cr + @cr;

/*
 	print	'Elapsed Time: '+convert(varchar(30),@elapsed_time,121)+' ='+@cr+
 		'	 '+convert(varchar(30),@datetime2,121)+
 		' - '+convert(varchar(30),@datetime1,121)+@cr2
 
 	print	'Elapsed Time Parts:'+@cr+
 		' Days         = '+convert(varchar(20),@elapsed_days)+@cr+
 		' Hours        = '+convert(varchar(20),@elapsed_hours)+@cr+
 		' Minutess     = '+convert(varchar(20),@elapsed_minutes)+@cr+
 		' Secondss     = '+convert(varchar(20),@elapsed_seconds)+@cr+
 		' Milliseconds = '+convert(varchar(20), @elapsed_milliseconds)+@cr2+@cr2
 
 		SET @result = @elapsed_milliseconds
 */

            SELECT @elapsed_milliseconds AS Result;
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ECM_HivePerftestV2]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ECM_HivePerftestV2] ( 
                @MilliSeconds INT OUTPUT
                                       ) 
AS
    BEGIN
        DECLARE @datetime1 DATETIME;
        DECLARE @datetime2 DATETIME;
        DECLARE @elapsed_seconds INT;
        DECLARE @elapsed_milliseconds INT;
        DECLARE @elapsed_time DATETIME;
        DECLARE @elapsed_days INT;
        DECLARE @elapsed_hours INT;
        DECLARE @elapsed_minutes INT;
        DECLARE @iCount INT;
        SELECT @datetime1 = GETDATE();
        SET @iCount = ( SELECT COUNT(*)
                        FROM datasource
                        WHERE SourceGuid = 'xx'
                      );
        SET @iCount = ( SELECT COUNT(*)
                        FROM Email
                        WHERE EmailGuid = 'xx'
                      );
        SET @iCount = ( SELECT COUNT(*)
                        FROM EmailAttachment
                        WHERE EmailGuid = 'xx'
                      );
        SET @iCount = ( SELECT COUNT(*)
                        FROM SourceAttribute
                        WHERE SourceGuid = 'xx'
                      );
        SELECT @datetime2 = GETDATE();
        SELECT @elapsed_time = @datetime2 - @datetime1;
        SELECT @elapsed_days = DATEDIFF(day , 0 , @elapsed_time);
        SELECT @elapsed_hours = DATEPART(hour , @elapsed_time);
        SELECT @elapsed_minutes = DATEPART(minute , @elapsed_time);
        SELECT @elapsed_seconds = DATEPART(second , @elapsed_time);
        SELECT @elapsed_milliseconds = DATEPART(millisecond , @elapsed_time);
        DECLARE @cr VARCHAR(4) , @cr2 VARCHAR(4);
        SELECT @cr = CHAR(13) + CHAR(10);
        SELECT @cr2 = @cr + @cr;

/*
  	print	'Elapsed Time: '+convert(varchar(30),@elapsed_time,121)+' ='+@cr+
  		'	 '+convert(varchar(30),@datetime2,121)+
  		' - '+convert(varchar(30),@datetime1,121)+@cr2
  
  	print	'Elapsed Time Parts:'+@cr+
  		' Days         = '+convert(varchar(20),@elapsed_days)+@cr+
  		' Hours        = '+convert(varchar(20),@elapsed_hours)+@cr+
  		' Minutess     = '+convert(varchar(20),@elapsed_minutes)+@cr+
  		' Secondss     = '+convert(varchar(20),@elapsed_seconds)+@cr+
  		' Milliseconds = '+convert(varchar(20), @elapsed_milliseconds)+@cr2+@cr2
  
  		SET @result = @elapsed_milliseconds
  */

        SELECT @MilliSeconds = @elapsed_milliseconds;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ECM_spaceused]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ECM_spaceused] --- 2003/05/19 14:00
                @objname     NVARCHAR(776) = NULL , -- The object we want size on.
                @updateusage VARCHAR(5)    = false		-- Param. for specifying that
-- usage info. should be updated.
AS
    BEGIN
        DECLARE @id INT , -- The object id that takes up space 
        @type CHARACTER(2) , -- The object type. 
        @pages BIGINT , -- Working variable for size calc. 
        @dbname SYSNAME , @dbsize BIGINT , @logsize BIGINT , @reservedpages BIGINT , @usedpages BIGINT , @rowCount BIGINT;

/*
**  Check to see if user wants usages updated.
*/

        IF @updateusage IS NOT NULL
            BEGIN
                SELECT @updateusage = LOWER(@updateusage);
                IF @updateusage NOT IN('true' , 'false')
                    BEGIN
                        RAISERROR(15143 , -1 , -1 , @updateusage);
                        RETURN 1;
                END;
        END;

/*
**  Check to see that the objname is local.
*/

        IF @objname IS NOT NULL
            BEGIN
                SELECT @dbname = PARSENAME(@objname , 3);
                IF @dbname IS NOT NULL
                   AND 
                   @dbname <> DB_NAME()
                    BEGIN
                        RAISERROR(15250 , -1 , -1);
                        RETURN 1;
                END;
                IF @dbname IS NULL
                    BEGIN
                        SELECT @dbname = DB_NAME();
                END;

/*
	**  Try to find the object.
	*/

                SELECT @id = object_id , @type = type
                FROM sys.objects
                WHERE object_id = OBJECT_ID(@objname);
                -- Translate @id to internal-table for queue
                IF @type = 'SQ'
                    BEGIN
                        SELECT @id = object_id
                        FROM sys.internal_tables
                        WHERE parent_id = @id
                              AND 
                              internal_type = 201;
                END; --ITT_ServiceQueue
/*
	**  Does the object exist?
	*/

                IF @id IS NULL
                    BEGIN
                        RAISERROR(15009 , -1 , -1 , @objname , @dbname);
                        RETURN 1;
                END;
                -- Is it a table, view or queue?
                IF @type NOT IN('U ' , 'S ' , 'V ' , 'SQ' , 'IT')
                    BEGIN
                        RAISERROR(15234 , -1 , -1);
                        RETURN 1;
                END;
        END;

/*
**  Update usages if user specified to do so.
*/

        IF @updateusage = 'true'
            BEGIN
                IF @objname IS NULL
                    BEGIN
                        DBCC UPDATEUSAGE(0) WITH NO_INFOMSGS;
                END;
                    ELSE
                    BEGIN
                        DBCC UPDATEUSAGE(0 , @objname) WITH NO_INFOMSGS;
                END;
                PRINT ' ';
        END;
        SET NOCOUNT ON;

/*
**  If @id is null, then we want summary data.
*/

        IF @id IS NULL
            BEGIN
                SELECT @dbsize = SUM(CONVERT(BIGINT ,
                                             CASE
                                                 WHEN STATUS&64 = 0
                                                 THEN size
                                                 ELSE 0
                                             END)) , @logsize = SUM(CONVERT(BIGINT ,
                                                                            CASE
                                                                                WHEN STATUS&64 <> 0
                                                                                THEN size
                                                                                ELSE 0
                                                                            END))
                FROM dbo.sysfiles;
                SELECT @reservedpages = SUM(a.total_pages) , @usedpages = SUM(a.used_pages) , @pages = SUM(CASE
                                                                                                           -- XML-Index and FT-Index internal tables are not considered `data`, but is part of `index_size`
                                                                                                               WHEN it.internal_type IN(202 , 204 , 211 , 212 , 213 , 214 , 215 , 216)
                                                                                                               THEN 0
                                                                                                               WHEN a.type <> 1
                                                                                                               THEN a.used_pages
                                                                                                               WHEN p.index_id < 2
                                                                                                               THEN a.data_pages
                                                                                                               ELSE 0
                                                                                                           END)
                FROM sys.partitions AS p JOIN sys.allocation_units AS a ON p.partition_id = a.container_id
                                         LEFT JOIN sys.internal_tables AS it ON p.object_id = it.object_id;

                /* unallocated space could not be negative */

                --select 
                --	database_name = db_name(),
                --	database_size = ltrim(str((convert (dec (15,2),@dbsize) + convert (dec (15,2),@logsize)) 
                --		* 8192 / 1048576,15,2) + ' MB'),
                --	'unallocated space' = ltrim(str((case when @dbsize >= @reservedpages then
                --		(convert (dec (15,2),@dbsize) - convert (dec (15,2),@reservedpages)) 
                --		* 8192 / 1048576 else 0 end),15,2) + ' MB')
/*
	**  Now calculate the summary data.
	**  reserved: sum(reserved) where indid in (0, 1, 255)
	** data: sum(data_pages) + sum(text_used)
	** index: sum(used) where indid in (0, 1, 255) - data
	** unused: sum(reserved) - sum(used) where indid in (0, 1, 255)
	*/

                --select
                --	reserved = ltrim(str(@reservedpages * 8192 / 1024.,15,0) + ' KB'),
                --	data = ltrim(str(@pages * 8192 / 1024.,15,0) + ' KB'),
                --	index_size = ltrim(str((@usedpages - @pages) * 8192 / 1024.,15,0) + ' KB'),
                --	unused = ltrim(str((@reservedpages - @usedpages) * 8192 / 1024.,15,0) + ' KB')
        END;

/*
**  We want a particular object.
*/

            ELSE
            BEGIN

/*
	** Now calculate the summary data. 
	*  Note that LOB Data and Row-overflow Data are counted as Data Pages.
	*/

                SELECT @reservedpages = SUM(reserved_page_count) , @usedpages = SUM(used_page_count) , @pages = SUM(CASE
                                                                                                                        WHEN index_id < 2
                                                                                                                        THEN in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count
                                                                                                                        ELSE lob_used_page_count + row_overflow_used_page_count
                                                                                                                    END) , @rowCount = SUM(CASE
                                                                                                                                               WHEN index_id < 2
                                                                                                                                               THEN row_count
                                                                                                                                               ELSE 0
                                                                                                                                           END)
                FROM sys.dm_db_partition_stats
                WHERE object_id = @id;

/*
	** Check if table has XML Indexes or Fulltext Indexes which use internal tables tied to this table
	*/

                IF ( SELECT COUNT(*)
                     FROM sys.internal_tables
                     WHERE parent_id = @id
                           AND 
                           internal_type IN ( 202 , 204 , 211 , 212 , 213 , 214 , 215 , 216
                                            )
                   ) > 0
                    BEGIN

/*
		**  Now calculate the summary data. Row counts in these internal tables don't 
		**  contribute towards row count of original table.
		*/

                        SELECT @reservedpages = @reservedpages + SUM(reserved_page_count) , @usedpages = @usedpages + SUM(used_page_count)
                        FROM sys.dm_db_partition_stats AS p , sys.internal_tables AS it
                        WHERE it.parent_id = @id
                              AND 
                              it.internal_type IN ( 202 , 204 , 211 , 212 , 213 , 214 , 215 , 216
                                                  )
                              AND 
                              p.object_id = it.object_id;
                END;
                SELECT name = OBJECT_NAME(@id) , rows = CONVERT(CHAR(11) , @rowCount) , reserved = LTRIM(STR(@reservedpages * 8 , 15 , 0) + ' KB') , data = LTRIM(STR(@pages * 8 , 15 , 0) + ' KB') , index_size = LTRIM(STR(CASE
                                                                                                                                                                                                                                 WHEN @usedpages > @pages
                                                                                                                                                                                                                                 THEN @usedpages - @pages
                                                                                                                                                                                                                                 ELSE 0
                                                                                                                                                                                                                             END * 8 , 15 , 0) + ' KB') , unused = LTRIM(STR(CASE
                                                                                                                                                                                                                                                                                 WHEN @reservedpages > @usedpages
                                                                                                                                                                                                                                                                                 THEN @reservedpages - @usedpages
                                                                                                                                                                                                                                                                                 ELSE 0
                                                                                                                                                                                                                                                                             END * 8 , 15 , 0) + ' KB');
        END;
        SELECT database_name = DB_NAME() , database_size = LTRIM(STR( ( CONVERT(DEC(15 , 2) , @dbsize) + CONVERT(DEC(15 , 2) , @logsize) ) * 8192 / 1048576 , 15 , 2) + ' MB') , index_size = LTRIM(STR(CASE
                                                                                                                                                                                                            WHEN @usedpages > @pages
                                                                                                                                                                                                            THEN @usedpages - @pages
                                                                                                                                                                                                            ELSE 0
                                                                                                                                                                                                        END * 8 , 15 , 0) + ' KB');
        RETURN 0;
    END; -- sp_spaceused
GO
/****** Object:  StoredProcedure [dbo].[EcmIssueSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: EcmIssueSelProc 
 */

CREATE PROCEDURE [dbo].[EcmIssueSelProc] ( 
                @IssueTitle NVARCHAR(250)
                                    ) 
AS
    BEGIN
        SELECT IssueTitle , IssueDescription , CreationDate , StatusCode , SeverityCode , CategoryName , EMail
        FROM EcmIssue
        WHERE IssueTitle = @IssueTitle;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EcmResponseSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: EcmResponseSelProc 
 */

CREATE PROCEDURE [dbo].[EcmResponseSelProc] ( 
                @IssueTitle NVARCHAR(250) , 
                @ResponseID INT
                                       ) 
AS
    BEGIN
        SELECT IssueTitle , Response , CreateDate , LastModDate , ResponseID
        FROM EcmResponse
        WHERE IssueTitle = @IssueTitle
              AND 
              ResponseID = @ResponseID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EcmUserSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: EcmUserSelProc 
 */

CREATE PROCEDURE [dbo].[EcmUserSelProc] ( 
                @EMail NVARCHAR(50)
                                   ) 
AS
    BEGIN
        SELECT EMail , PhoneNumber , YourName , YourCompany , PassWord , Authority , CreateDate , CompanyID , LastUpdate
        FROM EcmUser
        WHERE EMail = @EMail;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[EmailArchParmsSelProc] ( 
                @UserID     NVARCHAR(50) , 
                @FolderName NVARCHAR(254)
                                          ) 
AS
    BEGIN
        SELECT UserID , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , FolderName , DB_ID , ArchiveOnlyIfRead
        FROM EmailArchParms
        WHERE UserID = @UserID
              AND 
              FolderName = @FolderName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EmailImageSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: EmailImageSelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageSelProc] ( 
                @EmailGuid     NVARCHAR(50) , 
                @ImageTypeCode NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT emailImage , EmailGuid , ImageTypeCode
        FROM EmailImage
        WHERE EmailGuid = @EmailGuid
              AND 
              ImageTypeCode = @ImageTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: EmailImageTypeSelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageTypeSelProc] ( 
                @ImageTypeCode NVARCHAR(50)
                                          ) 
AS
    BEGIN
        SELECT ImageTypeCode , Description
        FROM EmailImageType
        WHERE ImageTypeCode = @ImageTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[EmailSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[EmailSelProc] ( 
                @EmailGuid NVARCHAR(50)
                                 ) 
AS
    BEGIN
        SELECT EmailGuid , SUBJECT , SentTO , Body , Bcc , BillingInformation , CC , Companies , CreationTime , ReadReceiptRequested , ReceivedByName , ReceivedTime , AllRecipients , UserID , SenderEmailAddress , SenderName , Sensitivity , SentOn , MsgSize , DeferredDeliveryTime , EntryID , ExpiryTime , LastModificationTime , EmailImage , Accounts , RowID , ShortSubj , SourceTypeCode , OriginalFolder , StoreID , isPublic , RetentionExpirationDate , IsPublicPreviousState , isAvailable , CurrMailFolderID , isPerm , isMaster , CreationDate
        FROM Email
        WHERE EmailGuid = @EmailGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ExcludedFilesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ExcludedFilesSelProc] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     VARCHAR(254)
                                         ) 
AS
    BEGIN
        SELECT UserID , ExtCode , FQN
        FROM ExcludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ExcludeFromSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ExcludeFromSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                       ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID
        FROM ExcludeFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[funcEcmUpdateDB]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[funcEcmUpdateDB] 
                @pSql NVARCHAR(MAX)
AS
    BEGIN
        EXEC sp_executesql @pSql;
    END;
GO
/****** Object:  StoredProcedure [dbo].[FUncSkipWordsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: FUncSkipWordsSelProc 
 */

CREATE PROCEDURE [dbo].[FUncSkipWordsSelProc] ( 
                @CorpFuncName NVARCHAR(80) , 
                @tgtWord      NVARCHAR(18) , 
                @CorpName     NVARCHAR(50)
                                         ) 
AS
    BEGIN
        SELECT CorpFuncName , tgtWord , CorpName
        FROM FUncSkipWords
        WHERE CorpFuncName = @CorpFuncName
              AND 
              tgtWord = @tgtWord
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: FunctionProdJargonSelProc 
 */

CREATE PROCEDURE [dbo].[FunctionProdJargonSelProc] ( 
                @CorpFuncName NVARCHAR(80) , 
                @JargonCode   NVARCHAR(50) , 
                @CorpName     NVARCHAR(50)
                                              ) 
AS
    BEGIN
        SELECT KeyFlag , RepeatDataCode , CorpFuncName , JargonCode , CorpName
        FROM FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[GenWhereInClause]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenWhereInClause]
(@UserID VARCHAR(50),
@DIR    NVARCHAR(1000),
@result NVARCHAR(1000) OUT
)
AS
BEGIN
DECLARE @r NVARCHAR(1000)= '';
SELECT @r = +@r + N'''' + Extcode + N''','
FROM IncludedFiles
WHERE UserID = @UserID
AND fqn = @DIR;
SET @result = '(' + @r + ')';
END;

GO
/****** Object:  StoredProcedure [dbo].[GetAllTableSizes]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GetAllTableSizes]
AS
    BEGIN

/*
    Obtains spaced used data for ALL user tables in the database
*/

        DECLARE @TableName VARCHAR(100);    --For storing values in the cursor
        --Cursor to get the name of all user tables from the sysobjects listing
        DECLARE tableCursor CURSOR
        FOR SELECT name
            FROM dbo.sysobjects
            WHERE OBJECTPROPERTY(id , N'IsUserTable') = 1
        FOR READ ONLY;
        --A procedure level temp table to store the results
        CREATE TABLE #TempTable ( 
                     tableName    VARCHAR(100) , 
                     numberofRows VARCHAR(100) , 
                     reservedSize VARCHAR(50) , 
                     dataSize     VARCHAR(50) , 
                     indexSize    VARCHAR(50) , 
                     unusedSize   VARCHAR(50)
                                );
        --Open the cursor
        OPEN tableCursor;
        --Get the first table name from the cursor
        FETCH NEXT FROM tableCursor INTO @TableName;
        --Loop until the cursor was not able to fetch
        WHILE @@Fetch_Status >= 0
            BEGIN
                --Dump the results of the sp_spaceused query to the temp table
                INSERT INTO #TempTable
                EXEC sp_spaceused @TableName;
                --Get the next table name
                FETCH NEXT FROM tableCursor INTO @TableName;
            END;
        --Get rid of the cursor
        CLOSE tableCursor;
        DEALLOCATE tableCursor;
        --Select all records so we can use the reults
        SELECT *
        FROM #TempTable;
        --Final cleanup!
        DROP TABLE #TempTable;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Delete] ( 
                @UserID  NVARCHAR(50) , 
                @DocGuid NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Delete a row from the ActiveSearchGuids table
*/

        DELETE FROM ActiveSearchGuids
        WHERE UserID = @UserID
              AND 
              DocGuid = @DocGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ActiveSearchGuids table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Insert] ( 
                @UserID  NVARCHAR(50) , 
                @DocGuid NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Add a row to the ActiveSearchGuids table
*/

        INSERT INTO ActiveSearchGuids ( UserID , DocGuid
                                      ) 
        VALUES ( @UserID , @DocGuid
               );

/*
** Select the new row
*/

        SELECT gv_ActiveSearchGuids.*
        FROM gv_ActiveSearchGuids
        WHERE UserID = @UserID
              AND 
              DocGuid = @DocGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ActiveSearchGuids table
*/

        SELECT gv_ActiveSearchGuids.*
        FROM gv_ActiveSearchGuids
        ORDER BY UserID , DocGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_SelectByUserIDAndDocGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_SelectByUserIDAndDocGuid] ( 
                @UserID  NVARCHAR(50) , 
                @DocGuid NVARCHAR(50)
                                                                  ) 
AS
    BEGIN

/*
** Select a row from the ActiveSearchGuids table by primary key
*/

        SELECT gv_ActiveSearchGuids.*
        FROM gv_ActiveSearchGuids
        WHERE UserID = @UserID
              AND 
              DocGuid = @DocGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Update] ( 
                @UserIDOriginal  NVARCHAR(50) , 
                @UserID          NVARCHAR(50) , 
                @DocGuidOriginal NVARCHAR(50) , 
                @DocGuid         NVARCHAR(50) , 
                @SeqNO           INT
                                                ) 
AS
    BEGIN

/*
** Update a row in the ActiveSearchGuids table using the primary key
*/

        UPDATE ActiveSearchGuids
               SET UserID = @UserID , DocGuid = @DocGuid
        WHERE UserID = @UserIDOriginal
              AND 
              DocGuid = @DocGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_ActiveSearchGuids.*
        FROM gv_ActiveSearchGuids
        WHERE UserID = @UserIDOriginal
              AND 
              DocGuid = @DocGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the ArchiveFrom table
*/

        DELETE FROM ArchiveFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ArchiveFrom table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Add a row to the ArchiveFrom table
*/

        INSERT INTO ArchiveFrom ( FromEmailAddr , SenderName , UserID
                                ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_ArchiveFrom.*
        FROM gv_ArchiveFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveFrom_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ArchiveFrom table
*/

        SELECT gv_ArchiveFrom.*
        FROM gv_ArchiveFrom
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveFrom_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                               ) 
AS
    BEGIN

/*
** Select a row from the ArchiveFrom table by primary key
*/

        SELECT gv_ArchiveFrom.*
        FROM gv_ArchiveFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Update a row in the ArchiveFrom table using the primary key
*/

        UPDATE ArchiveFrom
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ArchiveFrom.*
        FROM gv_ArchiveFrom
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHist_Delete] ( 
                @ArchiveID NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the ArchiveHist table
*/

        DELETE FROM ArchiveHist
        WHERE ArchiveID = @ArchiveID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ArchiveHist table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHist_Insert] ( 
                @ArchiveID        NVARCHAR(50) , 
                @ArchiveDate      DATETIME , 
                @NbrFilesArchived INT , 
                @UserGuid         NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Add a row to the ArchiveHist table
*/

        INSERT INTO ArchiveHist ( ArchiveID , ArchiveDate , NbrFilesArchived , UserGuid
                                ) 
        VALUES ( @ArchiveID , @ArchiveDate , @NbrFilesArchived , @UserGuid
               );

/*
** Select the new row
*/

        SELECT gv_ArchiveHist.*
        FROM gv_ArchiveHist
        WHERE ArchiveID = @ArchiveID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHist_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ArchiveHist table
*/

        SELECT gv_ArchiveHist.*
        FROM gv_ArchiveHist
        ORDER BY ArchiveID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_SelectByArchiveID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHist_SelectByArchiveID] ( 
                @ArchiveID NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Select a row from the ArchiveHist table by primary key
*/

        SELECT gv_ArchiveHist.*
        FROM gv_ArchiveHist
        WHERE ArchiveID = @ArchiveID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHist_Update] ( 
                @ArchiveIDOriginal NVARCHAR(50) , 
                @ArchiveID         NVARCHAR(50) , 
                @ArchiveDate       DATETIME , 
                @NbrFilesArchived  INT , 
                @UserGuid          NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Update a row in the ArchiveHist table using the primary key
*/

        UPDATE ArchiveHist
               SET ArchiveID = @ArchiveID , ArchiveDate = @ArchiveDate , NbrFilesArchived = @NbrFilesArchived , UserGuid = @UserGuid
        WHERE ArchiveID = @ArchiveIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ArchiveHist.*
        FROM gv_ArchiveHist
        WHERE ArchiveID = @ArchiveIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Delete] ( 
                @ArchiveID NVARCHAR(50) , 
                @Directory NVARCHAR(254) , 
                @FileType  NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Delete a row from the ArchiveHistContentType table
*/

        DELETE FROM ArchiveHistContentType
        WHERE ArchiveID = @ArchiveID
              AND 
              Directory = @Directory
              AND 
              FileType = @FileType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ArchiveHistContentType table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Insert] ( 
                @ArchiveID        NVARCHAR(50) , 
                @Directory        NVARCHAR(254) , 
                @FileType         NVARCHAR(50) , 
                @NbrFilesArchived INT
                                                     ) 
AS
    BEGIN

/*
** Add a row to the ArchiveHistContentType table
*/

        INSERT INTO ArchiveHistContentType ( ArchiveID , Directory , FileType , NbrFilesArchived
                                           ) 
        VALUES ( @ArchiveID , @Directory , @FileType , @NbrFilesArchived
               );

/*
** Select the new row
*/

        SELECT gv_ArchiveHistContentType.*
        FROM gv_ArchiveHistContentType
        WHERE ArchiveID = @ArchiveID
              AND 
              Directory = @Directory
              AND 
              FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ArchiveHistContentType table
*/

        SELECT gv_ArchiveHistContentType.*
        FROM gv_ArchiveHistContentType
        ORDER BY ArchiveID , Directory , FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectByArchiveID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectByArchiveID] ( 
                @ArchiveID NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select rows from the ArchiveHistContentType table by ArchiveID
*/

        SELECT gv_ArchiveHistContentType.*
        FROM gv_ArchiveHistContentType
        WHERE ArchiveID = @ArchiveID
        ORDER BY ArchiveID , Directory , FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectByArchiveIDAndDirectoryAndFileType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectByArchiveIDAndDirectoryAndFileType] ( 
                @ArchiveID NVARCHAR(50) , 
                @Directory NVARCHAR(254) , 
                @FileType  NVARCHAR(50)
                                                                                       ) 
AS
    BEGIN

/*
** Select a row from the ArchiveHistContentType table by primary key
*/

        SELECT gv_ArchiveHistContentType.*
        FROM gv_ArchiveHistContentType
        WHERE ArchiveID = @ArchiveID
              AND 
              Directory = @Directory
              AND 
              FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Update] ( 
                @ArchiveIDOriginal NVARCHAR(50) , 
                @ArchiveID         NVARCHAR(50) , 
                @DirectoryOriginal NVARCHAR(254) , 
                @Directory         NVARCHAR(254) , 
                @FileTypeOriginal  NVARCHAR(50) , 
                @FileType          NVARCHAR(50) , 
                @NbrFilesArchived  INT
                                                     ) 
AS
    BEGIN

/*
** Update a row in the ArchiveHistContentType table using the primary key
*/

        UPDATE ArchiveHistContentType
               SET ArchiveID = @ArchiveID , Directory = @Directory , FileType = @FileType , NbrFilesArchived = @NbrFilesArchived
        WHERE ArchiveID = @ArchiveIDOriginal
              AND 
              Directory = @DirectoryOriginal
              AND 
              FileType = @FileTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_ArchiveHistContentType.*
        FROM gv_ArchiveHistContentType
        WHERE ArchiveID = @ArchiveIDOriginal
              AND 
              Directory = @DirectoryOriginal
              AND 
              FileType = @FileTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveStats_Delete] ( 
                @StatGuid NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the ArchiveStats table
*/

        DELETE FROM ArchiveStats
        WHERE StatGuid = @StatGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ArchiveStats table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveStats_Insert] ( 
                @ArchiveStartDate         DATETIME , 
                @Status                   NVARCHAR(50) , 
                @Successful               NCHAR(1) , 
                @ArchiveType              NVARCHAR(50) , 
                @TotalEmailsInRepository  INT , 
                @TotalContentInRepository INT , 
                @UserID                   NVARCHAR(50) , 
                @ArchiveEndDate           DATETIME , 
                @StatGuid                 NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Add a row to the ArchiveStats table
*/

        INSERT INTO ArchiveStats ( ArchiveStartDate , STATUS , Successful , ArchiveType , TotalEmailsInRepository , TotalContentInRepository , UserID , ArchiveEndDate , StatGuid
                                 ) 
        VALUES ( @ArchiveStartDate , @Status , @Successful , @ArchiveType , @TotalEmailsInRepository , @TotalContentInRepository , @UserID , @ArchiveEndDate , @StatGuid
               );

/*
** Select the new row
*/

        SELECT gv_ArchiveStats.*
        FROM gv_ArchiveStats
        WHERE StatGuid = @StatGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveStats_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ArchiveStats table
*/

        SELECT gv_ArchiveStats.*
        FROM gv_ArchiveStats
        ORDER BY StatGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_SelectByStatGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveStats_SelectByStatGuid] ( 
                @StatGuid NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Select a row from the ArchiveStats table by primary key
*/

        SELECT gv_ArchiveStats.*
        FROM gv_ArchiveStats
        WHERE StatGuid = @StatGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ArchiveStats_Update] ( 
                @StatGuidOriginal         NVARCHAR(50) , 
                @StatGuid                 NVARCHAR(50) , 
                @ArchiveStartDate         DATETIME , 
                @Status                   NVARCHAR(50) , 
                @Successful               NCHAR(1) , 
                @ArchiveType              NVARCHAR(50) , 
                @TotalEmailsInRepository  INT , 
                @TotalContentInRepository INT , 
                @UserID                   NVARCHAR(50) , 
                @ArchiveEndDate           DATETIME , 
                @EntrySeq                 INT
                                           ) 
AS
    BEGIN

/*
** Update a row in the ArchiveStats table using the primary key
*/

        UPDATE ArchiveStats
               SET ArchiveStartDate = @ArchiveStartDate , STATUS = @Status , Successful = @Successful , ArchiveType = @ArchiveType , TotalEmailsInRepository = @TotalEmailsInRepository , TotalContentInRepository = @TotalContentInRepository , UserID = @UserID , ArchiveEndDate = @ArchiveEndDate , StatGuid = @StatGuid
        WHERE StatGuid = @StatGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_ArchiveStats.*
        FROM gv_ArchiveStats
        WHERE StatGuid = @StatGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Delete] ( 
                @ParmName NCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Delete a row from the AssignableUserParameters table
*/

        DELETE FROM AssignableUserParameters
        WHERE ParmName = @ParmName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the AssignableUserParameters table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Insert] ( 
                @ParmName NCHAR(50) , 
                @isPerm   BIT
                                                       ) 
AS
    BEGIN

/*
** Add a row to the AssignableUserParameters table
*/

        INSERT INTO AssignableUserParameters ( ParmName , isPerm
                                             ) 
        VALUES ( @ParmName , @isPerm
               );

/*
** Select the new row
*/

        SELECT gv_AssignableUserParameters.*
        FROM gv_AssignableUserParameters
        WHERE ParmName = @ParmName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_SelectAll]
AS
    BEGIN

/*
** Select all rows from the AssignableUserParameters table
*/

        SELECT gv_AssignableUserParameters.*
        FROM gv_AssignableUserParameters
        ORDER BY ParmName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_SelectByParmName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_SelectByParmName] ( 
                @ParmName NCHAR(50)
                                                                 ) 
AS
    BEGIN

/*
** Select a row from the AssignableUserParameters table by primary key
*/

        SELECT gv_AssignableUserParameters.*
        FROM gv_AssignableUserParameters
        WHERE ParmName = @ParmName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Update] ( 
                @ParmNameOriginal NCHAR(50) , 
                @ParmName         NCHAR(50) , 
                @isPerm           BIT
                                                       ) 
AS
    BEGIN

/*
** Update a row in the AssignableUserParameters table using the primary key
*/

        UPDATE AssignableUserParameters
               SET ParmName = @ParmName , isPerm = @isPerm
        WHERE ParmName = @ParmNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_AssignableUserParameters.*
        FROM gv_AssignableUserParameters
        WHERE ParmName = @ParmNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttachmentType_Delete] ( 
                @AttachmentCode NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Delete a row from the AttachmentType table
*/

        DELETE FROM AttachmentType
        WHERE AttachmentCode = @AttachmentCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the AttachmentType table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttachmentType_Insert] ( 
                @AttachmentCode NVARCHAR(50) , 
                @Description    NVARCHAR(254) , 
                @isZipFormat    BIT
                                             ) 
AS
    BEGIN

/*
** Add a row to the AttachmentType table
*/

        INSERT INTO AttachmentType ( AttachmentCode , Description , isZipFormat
                                   ) 
        VALUES ( @AttachmentCode , @Description , @isZipFormat
               );

/*
** Select the new row
*/

        SELECT gv_AttachmentType.*
        FROM gv_AttachmentType
        WHERE AttachmentCode = @AttachmentCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttachmentType_SelectAll]
AS
    BEGIN

/*
** Select all rows from the AttachmentType table
*/

        SELECT gv_AttachmentType.*
        FROM gv_AttachmentType
        ORDER BY AttachmentCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_SelectByAttachmentCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttachmentType_SelectByAttachmentCode] ( 
                @AttachmentCode NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the AttachmentType table by primary key
*/

        SELECT gv_AttachmentType.*
        FROM gv_AttachmentType
        WHERE AttachmentCode = @AttachmentCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttachmentType_Update] ( 
                @AttachmentCodeOriginal NVARCHAR(50) , 
                @AttachmentCode         NVARCHAR(50) , 
                @Description            NVARCHAR(254) , 
                @isZipFormat            BIT
                                             ) 
AS
    BEGIN

/*
** Update a row in the AttachmentType table using the primary key
*/

        UPDATE AttachmentType
               SET AttachmentCode = @AttachmentCode , Description = @Description , isZipFormat = @isZipFormat
        WHERE AttachmentCode = @AttachmentCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_AttachmentType.*
        FROM gv_AttachmentType
        WHERE AttachmentCode = @AttachmentCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Delete] ( 
                @AttributeDataType NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Delete a row from the AttributeDatatype table
*/

        DELETE FROM AttributeDatatype
        WHERE AttributeDataType = @AttributeDataType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the AttributeDatatype table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Insert] ( 
                @AttributeDataType NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Add a row to the AttributeDatatype table
*/

        INSERT INTO AttributeDatatype ( AttributeDataType
                                      ) 
        VALUES ( @AttributeDataType
               );

/*
** Select the new row
*/

        SELECT gv_AttributeDatatype.*
        FROM gv_AttributeDatatype
        WHERE AttributeDataType = @AttributeDataType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttributeDatatype_SelectAll]
AS
    BEGIN

/*
** Select all rows from the AttributeDatatype table
*/

        SELECT gv_AttributeDatatype.*
        FROM gv_AttributeDatatype
        ORDER BY AttributeDataType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_SelectByAttributeDataType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttributeDatatype_SelectByAttributeDataType] ( 
                @AttributeDataType NVARCHAR(50)
                                                                   ) 
AS
    BEGIN

/*
** Select a row from the AttributeDatatype table by primary key
*/

        SELECT gv_AttributeDatatype.*
        FROM gv_AttributeDatatype
        WHERE AttributeDataType = @AttributeDataType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Update] ( 
                @AttributeDataTypeOriginal NVARCHAR(50) , 
                @AttributeDataType         NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Update a row in the AttributeDatatype table using the primary key
*/

        UPDATE AttributeDatatype
               SET AttributeDataType = @AttributeDataType
        WHERE AttributeDataType = @AttributeDataTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_AttributeDatatype.*
        FROM gv_AttributeDatatype
        WHERE AttributeDataType = @AttributeDataTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_Delete] ( 
                @AttributeName NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the Attributes table
*/

        DELETE FROM Attributes
        WHERE AttributeName = @AttributeName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Attributes table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_Insert] ( 
                @AttributeName     NVARCHAR(50) , 
                @AttributeDataType NVARCHAR(50) , 
                @AttributeDesc     NVARCHAR(2000) , 
                @AssoApplication   NVARCHAR(50) , 
                @AllowedValues     NVARCHAR(254)
                                         ) 
AS
    BEGIN

/*
** Add a row to the Attributes table
*/

        INSERT INTO Attributes ( AttributeName , AttributeDataType , AttributeDesc , AssoApplication , AllowedValues
                               ) 
        VALUES ( @AttributeName , @AttributeDataType , @AttributeDesc , @AssoApplication , @AllowedValues
               );

/*
** Select the new row
*/

        SELECT gv_Attributes.*
        FROM gv_Attributes
        WHERE AttributeName = @AttributeName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Attributes table
*/

        SELECT gv_Attributes.*
        FROM gv_Attributes
        ORDER BY AttributeName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectByAttributeDataType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_SelectByAttributeDataType] ( 
                @AttributeDataType NVARCHAR(50)
                                                            ) 
AS
    BEGIN

/*
** Select rows from the Attributes table by AttributeDataType
*/

        SELECT gv_Attributes.*
        FROM gv_Attributes
        WHERE AttributeDataType = @AttributeDataType
        ORDER BY AttributeName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectByAttributeName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_SelectByAttributeName] ( 
                @AttributeName NVARCHAR(50)
                                                        ) 
AS
    BEGIN

/*
** Select a row from the Attributes table by primary key
*/

        SELECT gv_Attributes.*
        FROM gv_Attributes
        WHERE AttributeName = @AttributeName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Attributes_Update] ( 
                @AttributeNameOriginal NVARCHAR(50) , 
                @AttributeName         NVARCHAR(50) , 
                @AttributeDataType     NVARCHAR(50) , 
                @AttributeDesc         NVARCHAR(2000) , 
                @AssoApplication       NVARCHAR(50) , 
                @AllowedValues         NVARCHAR(254)
                                         ) 
AS
    BEGIN

/*
** Update a row in the Attributes table using the primary key
*/

        UPDATE Attributes
               SET AttributeName = @AttributeName , AttributeDataType = @AttributeDataType , AttributeDesc = @AttributeDesc , AssoApplication = @AssoApplication , AllowedValues = @AllowedValues
        WHERE AttributeName = @AttributeNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_Attributes.*
        FROM gv_Attributes
        WHERE AttributeName = @AttributeNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Delete] ( 
                @ExtCode NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Delete a row from the AvailFileTypes table
*/

        DELETE FROM AvailFileTypes
        WHERE ExtCode = @ExtCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the AvailFileTypes table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Insert] ( 
                @ExtCode NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Add a row to the AvailFileTypes table
*/

        INSERT INTO AvailFileTypes ( ExtCode
                                   ) 
        VALUES ( @ExtCode
               );

/*
** Select the new row
*/

        SELECT gv_AvailFileTypes.*
        FROM gv_AvailFileTypes
        WHERE ExtCode = @ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypes_SelectAll]
AS
    BEGIN

/*
** Select all rows from the AvailFileTypes table
*/

        SELECT gv_AvailFileTypes.*
        FROM gv_AvailFileTypes
        ORDER BY ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_SelectByExtCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypes_SelectByExtCode] ( 
                @ExtCode NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Select a row from the AvailFileTypes table by primary key
*/

        SELECT gv_AvailFileTypes.*
        FROM gv_AvailFileTypes
        WHERE ExtCode = @ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Update] ( 
                @ExtCodeOriginal NVARCHAR(50) , 
                @ExtCode         NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Update a row in the AvailFileTypes table using the primary key
*/

        UPDATE AvailFileTypes
               SET ExtCode = @ExtCode
        WHERE ExtCode = @ExtCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_AvailFileTypes.*
        FROM gv_AvailFileTypes
        WHERE ExtCode = @ExtCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Delete] ( 
                @FileType NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Delete a row from the AvailFileTypesUndefined table
*/

        DELETE FROM AvailFileTypesUndefined
        WHERE FileType = @FileType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the AvailFileTypesUndefined table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Insert] ( 
                @FileType       NVARCHAR(50) , 
                @SubstituteType NVARCHAR(50) , 
                @Applied        BIT
                                                      ) 
AS
    BEGIN

/*
** Add a row to the AvailFileTypesUndefined table
*/

        INSERT INTO AvailFileTypesUndefined ( FileType , SubstituteType , Applied
                                            ) 
        VALUES ( @FileType , @SubstituteType , @Applied
               );

/*
** Select the new row
*/

        SELECT gv_AvailFileTypesUndefined.*
        FROM gv_AvailFileTypesUndefined
        WHERE FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_SelectAll]
AS
    BEGIN

/*
** Select all rows from the AvailFileTypesUndefined table
*/

        SELECT gv_AvailFileTypesUndefined.*
        FROM gv_AvailFileTypesUndefined
        ORDER BY FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_SelectByFileType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_SelectByFileType] ( 
                @FileType NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select a row from the AvailFileTypesUndefined table by primary key
*/

        SELECT gv_AvailFileTypesUndefined.*
        FROM gv_AvailFileTypesUndefined
        WHERE FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Update] ( 
                @FileTypeOriginal NVARCHAR(50) , 
                @FileType         NVARCHAR(50) , 
                @SubstituteType   NVARCHAR(50) , 
                @Applied          BIT
                                                      ) 
AS
    BEGIN

/*
** Update a row in the AvailFileTypesUndefined table using the primary key
*/

        UPDATE AvailFileTypesUndefined
               SET FileType = @FileType , SubstituteType = @SubstituteType , Applied = @Applied
        WHERE FileType = @FileTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_AvailFileTypesUndefined.*
        FROM gv_AvailFileTypesUndefined
        WHERE FileType = @FileTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Delete] ( 
                @CorpFuncName        NVARCHAR(80) , 
                @WordID              INT , 
                @JargonWords_tgtWord NVARCHAR(50) , 
                @JargonCode          NVARCHAR(50) , 
                @CorpName            NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Delete a row from the BusinessFunctionJargon table
*/

        DELETE FROM BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              WordID = @WordID
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWord
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the BusinessFunctionJargon table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Insert] ( 
                @CorpFuncName        NVARCHAR(80) , 
                @JargonWords_tgtWord NVARCHAR(50) , 
                @JargonCode          NVARCHAR(50) , 
                @CorpName            NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Add a row to the BusinessFunctionJargon table
*/

        INSERT INTO BusinessFunctionJargon ( CorpFuncName , JargonWords_tgtWord , JargonCode , CorpName
                                           ) 
        VALUES ( @CorpFuncName , @JargonWords_tgtWord , @JargonCode , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              WordID = ( SELECT SCOPE_IDENTITY() )
        AND 
        JargonWords_tgtWord = @JargonWords_tgtWord
        AND 
        JargonCode = @JargonCode
        AND 
        CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectAll]
AS
    BEGIN

/*
** Select all rows from the BusinessFunctionJargon table
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        ORDER BY CorpFuncName , WordID , JargonWords_tgtWord , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                                                              ) 
AS
    BEGIN

/*
** Select rows from the BusinessFunctionJargon table by CorpFuncName and CorpName
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName
        ORDER BY CorpFuncName , WordID , JargonWords_tgtWord , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndWordIDAndJargonWords_tgtWordAndJargonCodeAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndWordIDAndJargonWords_tgtWordAndJargonCodeAndCorpName] ( 
                @CorpFuncName        NVARCHAR(80) , 
                @WordID              INT , 
                @JargonWords_tgtWord NVARCHAR(50) , 
                @JargonCode          NVARCHAR(50) , 
                @CorpName            NVARCHAR(50)
                                                                                                                          ) 
AS
    BEGIN

/*
** Select a row from the BusinessFunctionJargon table by primary key
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              WordID = @WordID
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWord
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByJargonCodeAndJargonWords_tgtWord]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByJargonCodeAndJargonWords_tgtWord] ( 
                @JargonCode          NVARCHAR(50) , 
                @JargonWords_tgtWord NVARCHAR(50)
                                                                                       ) 
AS
    BEGIN

/*
** Select rows from the BusinessFunctionJargon table by JargonCode and JargonWords_tgtWord
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        WHERE JargonCode = @JargonCode
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWord
        ORDER BY CorpFuncName , WordID , JargonWords_tgtWord , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Update] ( 
                @CorpFuncNameOriginal        NVARCHAR(80) , 
                @CorpFuncName                NVARCHAR(80) , 
                @WordIDOriginal              INT , 
                @JargonWords_tgtWordOriginal NVARCHAR(50) , 
                @JargonWords_tgtWord         NVARCHAR(50) , 
                @JargonCodeOriginal          NVARCHAR(50) , 
                @JargonCode                  NVARCHAR(50) , 
                @CorpNameOriginal            NVARCHAR(50) , 
                @CorpName                    NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Update a row in the BusinessFunctionJargon table using the primary key
*/

        UPDATE BusinessFunctionJargon
               SET CorpFuncName = @CorpFuncName , JargonWords_tgtWord = @JargonWords_tgtWord , JargonCode = @JargonCode , CorpName = @CorpName
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              WordID = @WordIDOriginal
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWordOriginal
              AND 
              JargonCode = @JargonCodeOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_BusinessFunctionJargon.*
        FROM gv_BusinessFunctionJargon
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              WordID = @WordIDOriginal
              AND 
              JargonWords_tgtWord = @JargonWords_tgtWordOriginal
              AND 
              JargonCode = @JargonCodeOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Delete] ( 
                @JargonCode NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the BusinessJargonCode table
*/

        DELETE FROM BusinessJargonCode
        WHERE JargonCode = @JargonCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the BusinessJargonCode table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Insert] ( 
                @JargonCode NVARCHAR(50) , 
                @JargonDesc NVARCHAR(18)
                                                 ) 
AS
    BEGIN

/*
** Add a row to the BusinessJargonCode table
*/

        INSERT INTO BusinessJargonCode ( JargonCode , JargonDesc
                                       ) 
        VALUES ( @JargonCode , @JargonDesc
               );

/*
** Select the new row
*/

        SELECT gv_BusinessJargonCode.*
        FROM gv_BusinessJargonCode
        WHERE JargonCode = @JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_SelectAll]
AS
    BEGIN

/*
** Select all rows from the BusinessJargonCode table
*/

        SELECT gv_BusinessJargonCode.*
        FROM gv_BusinessJargonCode
        ORDER BY JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_SelectByJargonCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_SelectByJargonCode] ( 
                @JargonCode NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the BusinessJargonCode table by primary key
*/

        SELECT gv_BusinessJargonCode.*
        FROM gv_BusinessJargonCode
        WHERE JargonCode = @JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Update] ( 
                @JargonCodeOriginal NVARCHAR(50) , 
                @JargonCode         NVARCHAR(50) , 
                @JargonDesc         NVARCHAR(18)
                                                 ) 
AS
    BEGIN

/*
** Update a row in the BusinessJargonCode table using the primary key
*/

        UPDATE BusinessJargonCode
               SET JargonCode = @JargonCode , JargonDesc = @JargonDesc
        WHERE JargonCode = @JargonCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_BusinessJargonCode.*
        FROM gv_BusinessJargonCode
        WHERE JargonCode = @JargonCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CaptureItems_Delete] ( 
                @CaptureItemsCode NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the CaptureItems table
*/

        DELETE FROM CaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the CaptureItems table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CaptureItems_Insert] ( 
                @CaptureItemsCode NVARCHAR(50) , 
                @CaptureItemsDesc NVARCHAR(18) , 
                @CreateDate       DATETIME
                                           ) 
AS
    BEGIN

/*
** Add a row to the CaptureItems table
*/

        INSERT INTO CaptureItems ( CaptureItemsCode , CaptureItemsDesc , CreateDate
                                 ) 
        VALUES ( @CaptureItemsCode , @CaptureItemsDesc , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_CaptureItems.*
        FROM gv_CaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CaptureItems_SelectAll]
AS
    BEGIN

/*
** Select all rows from the CaptureItems table
*/

        SELECT gv_CaptureItems.*
        FROM gv_CaptureItems
        ORDER BY CaptureItemsCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_SelectByCaptureItemsCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CaptureItems_SelectByCaptureItemsCode] ( 
                @CaptureItemsCode NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the CaptureItems table by primary key
*/

        SELECT gv_CaptureItems.*
        FROM gv_CaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CaptureItems_Update] ( 
                @CaptureItemsCodeOriginal NVARCHAR(50) , 
                @CaptureItemsCode         NVARCHAR(50) , 
                @CaptureItemsDesc         NVARCHAR(18) , 
                @CreateDate               DATETIME
                                           ) 
AS
    BEGIN

/*
** Update a row in the CaptureItems table using the primary key
*/

        UPDATE CaptureItems
               SET CaptureItemsCode = @CaptureItemsCode , CaptureItemsDesc = @CaptureItemsDesc , CreateDate = @CreateDate
        WHERE CaptureItemsCode = @CaptureItemsCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_CaptureItems.*
        FROM gv_CaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactFrom_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the ContactFrom table
*/

        DELETE FROM ContactFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ContactFrom table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactFrom_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25) , 
                @Verified      INT
                                          ) 
AS
    BEGIN

/*
** Add a row to the ContactFrom table
*/

        INSERT INTO ContactFrom ( FromEmailAddr , SenderName , UserID , Verified
                                ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID , @Verified
               );

/*
** Select the new row
*/

        SELECT gv_ContactFrom.*
        FROM gv_ContactFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactFrom_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ContactFrom table
*/

        SELECT gv_ContactFrom.*
        FROM gv_ContactFrom
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactFrom_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                               ) 
AS
    BEGIN

/*
** Select a row from the ContactFrom table by primary key
*/

        SELECT gv_ContactFrom.*
        FROM gv_ContactFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactFrom_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25) , 
                @Verified              INT
                                          ) 
AS
    BEGIN

/*
** Update a row in the ContactFrom table using the primary key
*/

        UPDATE ContactFrom
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID , Verified = @Verified
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ContactFrom.*
        FROM gv_ContactFrom
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactsArchive_Delete] ( 
                @Email1Address NVARCHAR(80) , 
                @FullName      NVARCHAR(80) , 
                @UserID        CHAR(25)
                                              ) 
AS
    BEGIN

/*
** Delete a row from the ContactsArchive table
*/

        DELETE FROM ContactsArchive
        WHERE Email1Address = @Email1Address
              AND 
              FullName = @FullName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ContactsArchive table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactsArchive_Insert] ( 
                @Email1Address                NVARCHAR(80) , 
                @FullName                     NVARCHAR(80) , 
                @UserID                       CHAR(25) , 
                @Account                      NVARCHAR(4000) , 
                @Anniversary                  NVARCHAR(4000) , 
                @Application                  NVARCHAR(4000) , 
                @AssistantName                NVARCHAR(4000) , 
                @AssistantTelephoneNumber     NVARCHAR(4000) , 
                @BillingInformation           NVARCHAR(4000) , 
                @Birthday                     NVARCHAR(4000) , 
                @Business2TelephoneNumber     NVARCHAR(4000) , 
                @BusinessAddress              NVARCHAR(4000) , 
                @BusinessAddressCity          NVARCHAR(4000) , 
                @BusinessAddressCountry       NVARCHAR(4000) , 
                @BusinessAddressPostalCode    NVARCHAR(4000) , 
                @BusinessAddressPostOfficeBox NVARCHAR(4000) , 
                @BusinessAddressState         NVARCHAR(4000) , 
                @BusinessAddressStreet        NVARCHAR(4000) , 
                @BusinessCardType             NVARCHAR(4000) , 
                @BusinessFaxNumber            NVARCHAR(4000) , 
                @BusinessHomePage             NVARCHAR(4000) , 
                @BusinessTelephoneNumber      NVARCHAR(4000) , 
                @CallbackTelephoneNumber      NVARCHAR(4000) , 
                @CarTelephoneNumber           NVARCHAR(4000) , 
                @Categories                   NVARCHAR(4000) , 
                @Children                     NVARCHAR(4000) , 
                @xClass                       NVARCHAR(4000) , 
                @Companies                    NVARCHAR(4000) , 
                @CompanyName                  NVARCHAR(4000) , 
                @ComputerNetworkName          NVARCHAR(4000) , 
                @Conflicts                    NVARCHAR(4000) , 
                @ConversationTopic            NVARCHAR(4000) , 
                @CreationTime                 NVARCHAR(4000) , 
                @CustomerID                   NVARCHAR(4000) , 
                @Department                   NVARCHAR(4000) , 
                @Email1AddressType            NVARCHAR(4000) , 
                @Email1DisplayName            NVARCHAR(4000) , 
                @Email1EntryID                NVARCHAR(4000) , 
                @Email2Address                NVARCHAR(4000) , 
                @Email2AddressType            NVARCHAR(4000) , 
                @Email2DisplayName            NVARCHAR(4000) , 
                @Email2EntryID                NVARCHAR(4000) , 
                @Email3Address                NVARCHAR(4000) , 
                @Email3AddressType            NVARCHAR(4000) , 
                @Email3DisplayName            NVARCHAR(4000) , 
                @Email3EntryID                NVARCHAR(4000) , 
                @FileAs                       NVARCHAR(4000) , 
                @FirstName                    NVARCHAR(4000) , 
                @FTPSite                      NVARCHAR(4000) , 
                @Gender                       NVARCHAR(4000) , 
                @GovernmentIDNumber           NVARCHAR(4000) , 
                @Hobby                        NVARCHAR(4000) , 
                @Home2TelephoneNumber         NVARCHAR(4000) , 
                @HomeAddress                  NVARCHAR(4000) , 
                @HomeAddressCountry           NVARCHAR(4000) , 
                @HomeAddressPostalCode        NVARCHAR(4000) , 
                @HomeAddressPostOfficeBox     NVARCHAR(4000) , 
                @HomeAddressState             NVARCHAR(4000) , 
                @HomeAddressStreet            NVARCHAR(4000) , 
                @HomeFaxNumber                NVARCHAR(4000) , 
                @HomeTelephoneNumber          NVARCHAR(4000) , 
                @IMAddress                    NVARCHAR(4000) , 
                @Importance                   NVARCHAR(4000) , 
                @Initials                     NVARCHAR(4000) , 
                @InternetFreeBusyAddress      NVARCHAR(4000) , 
                @JobTitle                     NVARCHAR(4000) , 
                @Journal                      NVARCHAR(4000) , 
                @Language                     NVARCHAR(4000) , 
                @LastModificationTime         NVARCHAR(4000) , 
                @LastName                     NVARCHAR(4000) , 
                @LastNameAndFirstName         NVARCHAR(4000) , 
                @MailingAddress               NVARCHAR(4000) , 
                @MailingAddressCity           NVARCHAR(4000) , 
                @MailingAddressCountry        NVARCHAR(4000) , 
                @MailingAddressPostalCode     NVARCHAR(4000) , 
                @MailingAddressPostOfficeBox  NVARCHAR(4000) , 
                @MailingAddressState          NVARCHAR(4000) , 
                @MailingAddressStreet         NVARCHAR(4000) , 
                @ManagerName                  NVARCHAR(4000) , 
                @MiddleName                   NVARCHAR(4000) , 
                @Mileage                      NVARCHAR(4000) , 
                @MobileTelephoneNumber        NVARCHAR(4000) , 
                @NetMeetingAlias              NVARCHAR(4000) , 
                @NetMeetingServer             NVARCHAR(4000) , 
                @NickName                     NVARCHAR(4000) , 
                @Title                        NVARCHAR(4000) , 
                @Body                         NVARCHAR(4000) , 
                @OfficeLocation               NVARCHAR(4000) , 
                @Subject                      NVARCHAR(4000)
                                              ) 
AS
    BEGIN

/*
** Add a row to the ContactsArchive table
*/

        INSERT INTO ContactsArchive ( Email1Address , FullName , UserID , Account , Anniversary , Application , AssistantName , AssistantTelephoneNumber , BillingInformation , Birthday , Business2TelephoneNumber , BusinessAddress , BusinessAddressCity , BusinessAddressCountry , BusinessAddressPostalCode , BusinessAddressPostOfficeBox , BusinessAddressState , BusinessAddressStreet , BusinessCardType , BusinessFaxNumber , BusinessHomePage , BusinessTelephoneNumber , CallbackTelephoneNumber , CarTelephoneNumber , Categories , Children , xClass , Companies , CompanyName , ComputerNetworkName , Conflicts , ConversationTopic , CreationTime , CustomerID , Department , Email1AddressType , Email1DisplayName , Email1EntryID , Email2Address , Email2AddressType , Email2DisplayName , Email2EntryID , Email3Address , Email3AddressType , Email3DisplayName , Email3EntryID , FileAs , FirstName , FTPSite , Gender , GovernmentIDNumber , Hobby , Home2TelephoneNumber , HomeAddress , HomeAddressCountry , HomeAddressPostalCode , HomeAddressPostOfficeBox , HomeAddressState , HomeAddressStreet , HomeFaxNumber , HomeTelephoneNumber , IMAddress , Importance , Initials , InternetFreeBusyAddress , JobTitle , Journal , Language , LastModificationTime , LastName , LastNameAndFirstName , MailingAddress , MailingAddressCity , MailingAddressCountry , MailingAddressPostalCode , MailingAddressPostOfficeBox , MailingAddressState , MailingAddressStreet , ManagerName , MiddleName , Mileage , MobileTelephoneNumber , NetMeetingAlias , NetMeetingServer , NickName , Title , Body , OfficeLocation , Subject
                                    ) 
        VALUES ( @Email1Address , @FullName , @UserID , @Account , @Anniversary , @Application , @AssistantName , @AssistantTelephoneNumber , @BillingInformation , @Birthday , @Business2TelephoneNumber , @BusinessAddress , @BusinessAddressCity , @BusinessAddressCountry , @BusinessAddressPostalCode , @BusinessAddressPostOfficeBox , @BusinessAddressState , @BusinessAddressStreet , @BusinessCardType , @BusinessFaxNumber , @BusinessHomePage , @BusinessTelephoneNumber , @CallbackTelephoneNumber , @CarTelephoneNumber , @Categories , @Children , @xClass , @Companies , @CompanyName , @ComputerNetworkName , @Conflicts , @ConversationTopic , @CreationTime , @CustomerID , @Department , @Email1AddressType , @Email1DisplayName , @Email1EntryID , @Email2Address , @Email2AddressType , @Email2DisplayName , @Email2EntryID , @Email3Address , @Email3AddressType , @Email3DisplayName , @Email3EntryID , @FileAs , @FirstName , @FTPSite , @Gender , @GovernmentIDNumber , @Hobby , @Home2TelephoneNumber , @HomeAddress , @HomeAddressCountry , @HomeAddressPostalCode , @HomeAddressPostOfficeBox , @HomeAddressState , @HomeAddressStreet , @HomeFaxNumber , @HomeTelephoneNumber , @IMAddress , @Importance , @Initials , @InternetFreeBusyAddress , @JobTitle , @Journal , @Language , @LastModificationTime , @LastName , @LastNameAndFirstName , @MailingAddress , @MailingAddressCity , @MailingAddressCountry , @MailingAddressPostalCode , @MailingAddressPostOfficeBox , @MailingAddressState , @MailingAddressStreet , @ManagerName , @MiddleName , @Mileage , @MobileTelephoneNumber , @NetMeetingAlias , @NetMeetingServer , @NickName , @Title , @Body , @OfficeLocation , @Subject
               );

/*
** Select the new row
*/

        SELECT gv_ContactsArchive.*
        FROM gv_ContactsArchive
        WHERE Email1Address = @Email1Address
              AND 
              FullName = @FullName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactsArchive_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ContactsArchive table
*/

        SELECT gv_ContactsArchive.*
        FROM gv_ContactsArchive
        ORDER BY Email1Address , FullName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_SelectByEmail1AddressAndFullNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactsArchive_SelectByEmail1AddressAndFullNameAndUserID] ( 
                @Email1Address NVARCHAR(80) , 
                @FullName      NVARCHAR(80) , 
                @UserID        CHAR(25)
                                                                                 ) 
AS
    BEGIN

/*
** Select a row from the ContactsArchive table by primary key
*/

        SELECT gv_ContactsArchive.*
        FROM gv_ContactsArchive
        WHERE Email1Address = @Email1Address
              AND 
              FullName = @FullName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContactsArchive_Update] ( 
                @Email1AddressOriginal        NVARCHAR(80) , 
                @Email1Address                NVARCHAR(80) , 
                @FullNameOriginal             NVARCHAR(80) , 
                @FullName                     NVARCHAR(80) , 
                @UserIDOriginal               CHAR(25) , 
                @UserID                       CHAR(25) , 
                @Account                      NVARCHAR(4000) , 
                @Anniversary                  NVARCHAR(4000) , 
                @Application                  NVARCHAR(4000) , 
                @AssistantName                NVARCHAR(4000) , 
                @AssistantTelephoneNumber     NVARCHAR(4000) , 
                @BillingInformation           NVARCHAR(4000) , 
                @Birthday                     NVARCHAR(4000) , 
                @Business2TelephoneNumber     NVARCHAR(4000) , 
                @BusinessAddress              NVARCHAR(4000) , 
                @BusinessAddressCity          NVARCHAR(4000) , 
                @BusinessAddressCountry       NVARCHAR(4000) , 
                @BusinessAddressPostalCode    NVARCHAR(4000) , 
                @BusinessAddressPostOfficeBox NVARCHAR(4000) , 
                @BusinessAddressState         NVARCHAR(4000) , 
                @BusinessAddressStreet        NVARCHAR(4000) , 
                @BusinessCardType             NVARCHAR(4000) , 
                @BusinessFaxNumber            NVARCHAR(4000) , 
                @BusinessHomePage             NVARCHAR(4000) , 
                @BusinessTelephoneNumber      NVARCHAR(4000) , 
                @CallbackTelephoneNumber      NVARCHAR(4000) , 
                @CarTelephoneNumber           NVARCHAR(4000) , 
                @Categories                   NVARCHAR(4000) , 
                @Children                     NVARCHAR(4000) , 
                @xClass                       NVARCHAR(4000) , 
                @Companies                    NVARCHAR(4000) , 
                @CompanyName                  NVARCHAR(4000) , 
                @ComputerNetworkName          NVARCHAR(4000) , 
                @Conflicts                    NVARCHAR(4000) , 
                @ConversationTopic            NVARCHAR(4000) , 
                @CreationTime                 NVARCHAR(4000) , 
                @CustomerID                   NVARCHAR(4000) , 
                @Department                   NVARCHAR(4000) , 
                @Email1AddressType            NVARCHAR(4000) , 
                @Email1DisplayName            NVARCHAR(4000) , 
                @Email1EntryID                NVARCHAR(4000) , 
                @Email2Address                NVARCHAR(4000) , 
                @Email2AddressType            NVARCHAR(4000) , 
                @Email2DisplayName            NVARCHAR(4000) , 
                @Email2EntryID                NVARCHAR(4000) , 
                @Email3Address                NVARCHAR(4000) , 
                @Email3AddressType            NVARCHAR(4000) , 
                @Email3DisplayName            NVARCHAR(4000) , 
                @Email3EntryID                NVARCHAR(4000) , 
                @FileAs                       NVARCHAR(4000) , 
                @FirstName                    NVARCHAR(4000) , 
                @FTPSite                      NVARCHAR(4000) , 
                @Gender                       NVARCHAR(4000) , 
                @GovernmentIDNumber           NVARCHAR(4000) , 
                @Hobby                        NVARCHAR(4000) , 
                @Home2TelephoneNumber         NVARCHAR(4000) , 
                @HomeAddress                  NVARCHAR(4000) , 
                @HomeAddressCountry           NVARCHAR(4000) , 
                @HomeAddressPostalCode        NVARCHAR(4000) , 
                @HomeAddressPostOfficeBox     NVARCHAR(4000) , 
                @HomeAddressState             NVARCHAR(4000) , 
                @HomeAddressStreet            NVARCHAR(4000) , 
                @HomeFaxNumber                NVARCHAR(4000) , 
                @HomeTelephoneNumber          NVARCHAR(4000) , 
                @IMAddress                    NVARCHAR(4000) , 
                @Importance                   NVARCHAR(4000) , 
                @Initials                     NVARCHAR(4000) , 
                @InternetFreeBusyAddress      NVARCHAR(4000) , 
                @JobTitle                     NVARCHAR(4000) , 
                @Journal                      NVARCHAR(4000) , 
                @Language                     NVARCHAR(4000) , 
                @LastModificationTime         NVARCHAR(4000) , 
                @LastName                     NVARCHAR(4000) , 
                @LastNameAndFirstName         NVARCHAR(4000) , 
                @MailingAddress               NVARCHAR(4000) , 
                @MailingAddressCity           NVARCHAR(4000) , 
                @MailingAddressCountry        NVARCHAR(4000) , 
                @MailingAddressPostalCode     NVARCHAR(4000) , 
                @MailingAddressPostOfficeBox  NVARCHAR(4000) , 
                @MailingAddressState          NVARCHAR(4000) , 
                @MailingAddressStreet         NVARCHAR(4000) , 
                @ManagerName                  NVARCHAR(4000) , 
                @MiddleName                   NVARCHAR(4000) , 
                @Mileage                      NVARCHAR(4000) , 
                @MobileTelephoneNumber        NVARCHAR(4000) , 
                @NetMeetingAlias              NVARCHAR(4000) , 
                @NetMeetingServer             NVARCHAR(4000) , 
                @NickName                     NVARCHAR(4000) , 
                @Title                        NVARCHAR(4000) , 
                @Body                         NVARCHAR(4000) , 
                @OfficeLocation               NVARCHAR(4000) , 
                @Subject                      NVARCHAR(4000)
                                              ) 
AS
    BEGIN

/*
** Update a row in the ContactsArchive table using the primary key
*/

        UPDATE ContactsArchive
               SET Email1Address = @Email1Address , FullName = @FullName , UserID = @UserID , Account = @Account , Anniversary = @Anniversary , Application = @Application , AssistantName = @AssistantName , AssistantTelephoneNumber = @AssistantTelephoneNumber , BillingInformation = @BillingInformation , Birthday = @Birthday , Business2TelephoneNumber = @Business2TelephoneNumber , BusinessAddress = @BusinessAddress , BusinessAddressCity = @BusinessAddressCity , BusinessAddressCountry = @BusinessAddressCountry , BusinessAddressPostalCode = @BusinessAddressPostalCode , BusinessAddressPostOfficeBox = @BusinessAddressPostOfficeBox , BusinessAddressState = @BusinessAddressState , BusinessAddressStreet = @BusinessAddressStreet , BusinessCardType = @BusinessCardType , BusinessFaxNumber = @BusinessFaxNumber , BusinessHomePage = @BusinessHomePage , BusinessTelephoneNumber = @BusinessTelephoneNumber , CallbackTelephoneNumber = @CallbackTelephoneNumber , CarTelephoneNumber = @CarTelephoneNumber , Categories = @Categories , Children = @Children , xClass = @xClass , Companies = @Companies , CompanyName = @CompanyName , ComputerNetworkName = @ComputerNetworkName , Conflicts = @Conflicts , ConversationTopic = @ConversationTopic , CreationTime = @CreationTime , CustomerID = @CustomerID , Department = @Department , Email1AddressType = @Email1AddressType , Email1DisplayName = @Email1DisplayName , Email1EntryID = @Email1EntryID , Email2Address = @Email2Address , Email2AddressType = @Email2AddressType , Email2DisplayName = @Email2DisplayName , Email2EntryID = @Email2EntryID , Email3Address = @Email3Address , Email3AddressType = @Email3AddressType , Email3DisplayName = @Email3DisplayName , Email3EntryID = @Email3EntryID , FileAs = @FileAs , FirstName = @FirstName , FTPSite = @FTPSite , Gender = @Gender , GovernmentIDNumber = @GovernmentIDNumber , Hobby = @Hobby , Home2TelephoneNumber = @Home2TelephoneNumber , HomeAddress = @HomeAddress , HomeAddressCountry = @HomeAddressCountry , HomeAddressPostalCode = @HomeAddressPostalCode , HomeAddressPostOfficeBox = @HomeAddressPostOfficeBox , HomeAddressState = @HomeAddressState , HomeAddressStreet = @HomeAddressStreet , HomeFaxNumber = @HomeFaxNumber , HomeTelephoneNumber = @HomeTelephoneNumber , IMAddress = @IMAddress , Importance = @Importance , Initials = @Initials , InternetFreeBusyAddress = @InternetFreeBusyAddress , JobTitle = @JobTitle , Journal = @Journal , Language = @Language , LastModificationTime = @LastModificationTime , LastName = @LastName , LastNameAndFirstName = @LastNameAndFirstName , MailingAddress = @MailingAddress , MailingAddressCity = @MailingAddressCity , MailingAddressCountry = @MailingAddressCountry , MailingAddressPostalCode = @MailingAddressPostalCode , MailingAddressPostOfficeBox = @MailingAddressPostOfficeBox , MailingAddressState = @MailingAddressState , MailingAddressStreet = @MailingAddressStreet , ManagerName = @ManagerName , MiddleName = @MiddleName , Mileage = @Mileage , MobileTelephoneNumber = @MobileTelephoneNumber , NetMeetingAlias = @NetMeetingAlias , NetMeetingServer = @NetMeetingServer , NickName = @NickName , Title = @Title , Body = @Body , OfficeLocation = @OfficeLocation , Subject = @Subject
        WHERE Email1Address = @Email1AddressOriginal
              AND 
              FullName = @FullNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ContactsArchive.*
        FROM gv_ContactsArchive
        WHERE Email1Address = @Email1AddressOriginal
              AND 
              FullName = @FullNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_Delete] ( 
                @StoreCode     NVARCHAR(50) , 
                @ContainerType NVARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Delete a row from the ContainerStorage table
*/

        DELETE FROM ContainerStorage
        WHERE StoreCode = @StoreCode
              AND 
              ContainerType = @ContainerType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ContainerStorage table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_Insert] ( 
                @StoreCode     NVARCHAR(50) , 
                @ContainerType NVARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Add a row to the ContainerStorage table
*/

        INSERT INTO ContainerStorage ( StoreCode , ContainerType
                                     ) 
        VALUES ( @StoreCode , @ContainerType
               );

/*
** Select the new row
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        WHERE StoreCode = @StoreCode
              AND 
              ContainerType = @ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ContainerStorage table
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        ORDER BY StoreCode , ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByContainerType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByContainerType] ( 
                @ContainerType NVARCHAR(25)
                                                              ) 
AS
    BEGIN

/*
** Select rows from the ContainerStorage table by ContainerType
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        WHERE ContainerType = @ContainerType
        ORDER BY StoreCode , ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByStoreCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByStoreCode] ( 
                @StoreCode NVARCHAR(50)
                                                          ) 
AS
    BEGIN

/*
** Select rows from the ContainerStorage table by StoreCode
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        WHERE StoreCode = @StoreCode
        ORDER BY StoreCode , ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByStoreCodeAndContainerType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByStoreCodeAndContainerType] ( 
                @StoreCode     NVARCHAR(50) , 
                @ContainerType NVARCHAR(25)
                                                                          ) 
AS
    BEGIN

/*
** Select a row from the ContainerStorage table by primary key
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        WHERE StoreCode = @StoreCode
              AND 
              ContainerType = @ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ContainerStorage_Update] ( 
                @StoreCodeOriginal     NVARCHAR(50) , 
                @StoreCode             NVARCHAR(50) , 
                @ContainerTypeOriginal NVARCHAR(25) , 
                @ContainerType         NVARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Update a row in the ContainerStorage table using the primary key
*/

        UPDATE ContainerStorage
               SET StoreCode = @StoreCode , ContainerType = @ContainerType
        WHERE StoreCode = @StoreCodeOriginal
              AND 
              ContainerType = @ContainerTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_ContainerStorage.*
        FROM gv_ContainerStorage
        WHERE StoreCode = @StoreCodeOriginal
              AND 
              ContainerType = @ContainerTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Delete] ( 
                @FQN      NVARCHAR(254) , 
                @CorpName NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the ConvertedDocs table
*/

        DELETE FROM ConvertedDocs
        WHERE FQN = @FQN
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ConvertedDocs table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Insert] ( 
                @FQN      NVARCHAR(254) , 
                @FileName NVARCHAR(254) , 
                @XMLName  NVARCHAR(254) , 
                @XMLDIr   NVARCHAR(254) , 
                @FileDir  NVARCHAR(254) , 
                @CorpName NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the ConvertedDocs table
*/

        INSERT INTO ConvertedDocs ( FQN , FileName , XMLName , XMLDIr , FileDir , CorpName
                                  ) 
        VALUES ( @FQN , @FileName , @XMLName , @XMLDIr , @FileDir , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_ConvertedDocs.*
        FROM gv_ConvertedDocs
        WHERE FQN = @FQN
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ConvertedDocs table
*/

        SELECT gv_ConvertedDocs.*
        FROM gv_ConvertedDocs
        ORDER BY FQN , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectByCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectByCorpName] ( 
                @CorpName NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Select rows from the ConvertedDocs table by CorpName
*/

        SELECT gv_ConvertedDocs.*
        FROM gv_ConvertedDocs
        WHERE CorpName = @CorpName
        ORDER BY FQN , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectByFQNAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectByFQNAndCorpName] ( 
                @FQN      NVARCHAR(254) , 
                @CorpName NVARCHAR(50)
                                                            ) 
AS
    BEGIN

/*
** Select a row from the ConvertedDocs table by primary key
*/

        SELECT gv_ConvertedDocs.*
        FROM gv_ConvertedDocs
        WHERE FQN = @FQN
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Update] ( 
                @FQNOriginal      NVARCHAR(254) , 
                @FQN              NVARCHAR(254) , 
                @CorpNameOriginal NVARCHAR(50) , 
                @CorpName         NVARCHAR(50) , 
                @FileName         NVARCHAR(254) , 
                @XMLName          NVARCHAR(254) , 
                @XMLDIr           NVARCHAR(254) , 
                @FileDir          NVARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Update a row in the ConvertedDocs table using the primary key
*/

        UPDATE ConvertedDocs
               SET FQN = @FQN , FileName = @FileName , XMLName = @XMLName , XMLDIr = @XMLDIr , FileDir = @FileDir , CorpName = @CorpName
        WHERE FQN = @FQNOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_ConvertedDocs.*
        FROM gv_ConvertedDocs
        WHERE FQN = @FQNOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_Delete] ( 
                @RowId INT
                                      ) 
AS
    BEGIN

/*
** Delete a row from the CoOwner table
*/

        DELETE FROM CoOwner
        WHERE RowId = @RowId;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the CoOwner table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_Insert] ( 
                @CurrentOwnerUserID  NVARCHAR(50) , 
                @CreateDate          DATETIME , 
                @PreviousOwnerUserID NVARCHAR(50)
                                      ) 
AS
    BEGIN

/*
** Add a row to the CoOwner table
*/

        INSERT INTO CoOwner ( CurrentOwnerUserID , CreateDate , PreviousOwnerUserID
                            ) 
        VALUES ( @CurrentOwnerUserID , @CreateDate , @PreviousOwnerUserID
               );

/*
** Select the new row
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        WHERE RowId = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_SelectAll]
AS
    BEGIN

/*
** Select all rows from the CoOwner table
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByCurrentOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByCurrentOwnerUserID] ( 
                @CurrentOwnerUserID NVARCHAR(50)
                                                          ) 
AS
    BEGIN

/*
** Select rows from the CoOwner table by CurrentOwnerUserID
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        WHERE CurrentOwnerUserID = @CurrentOwnerUserID
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByPreviousOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByPreviousOwnerUserID] ( 
                @PreviousOwnerUserID NVARCHAR(50)
                                                           ) 
AS
    BEGIN

/*
** Select rows from the CoOwner table by PreviousOwnerUserID
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        WHERE PreviousOwnerUserID = @PreviousOwnerUserID
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByRowId]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByRowId] ( 
                @RowId INT
                                             ) 
AS
    BEGIN

/*
** Select a row from the CoOwner table by primary key
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        WHERE RowId = @RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CoOwner_Update] ( 
                @RowIdOriginal       INT , 
                @CurrentOwnerUserID  NVARCHAR(50) , 
                @CreateDate          DATETIME , 
                @PreviousOwnerUserID NVARCHAR(50)
                                      ) 
AS
    BEGIN

/*
** Update a row in the CoOwner table using the primary key
*/

        UPDATE CoOwner
               SET CurrentOwnerUserID = @CurrentOwnerUserID , CreateDate = @CreateDate , PreviousOwnerUserID = @PreviousOwnerUserID
        WHERE RowId = @RowIdOriginal;

/*
** Select the updated row
*/

        SELECT gv_CoOwner.*
        FROM gv_CoOwner
        WHERE RowId = @RowIdOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_Delete] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the CorpContainer table
*/

        DELETE FROM CorpContainer
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the CorpContainer table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_Insert] ( 
                @ContainerType NVARCHAR(25) , 
                @QtyDocCode    NVARCHAR(10) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the CorpContainer table
*/

        INSERT INTO CorpContainer ( ContainerType , QtyDocCode , CorpFuncName , CorpName
                                  ) 
        VALUES ( @ContainerType , @QtyDocCode , @CorpFuncName , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectAll]
AS
    BEGIN

/*
** Select all rows from the CorpContainer table
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByContainerType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByContainerType] ( 
                @ContainerType NVARCHAR(25)
                                                           ) 
AS
    BEGIN

/*
** Select rows from the CorpContainer table by ContainerType
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE ContainerType = @ContainerType
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByContainerTypeAndCorpFuncNameAndCorpName] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                                                                     ) 
AS
    BEGIN

/*
** Select a row from the CorpContainer table by primary key
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByCorpFuncNameAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                                                     ) 
AS
    BEGIN

/*
** Select rows from the CorpContainer table by CorpFuncName and CorpName
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByQtyDocCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByQtyDocCode] ( 
                @QtyDocCode NVARCHAR(10)
                                                        ) 
AS
    BEGIN

/*
** Select rows from the CorpContainer table by QtyDocCode
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE QtyDocCode = @QtyDocCode
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpContainer_Update] ( 
                @ContainerTypeOriginal NVARCHAR(25) , 
                @ContainerType         NVARCHAR(25) , 
                @CorpFuncNameOriginal  NVARCHAR(80) , 
                @CorpFuncName          NVARCHAR(80) , 
                @CorpNameOriginal      NVARCHAR(50) , 
                @CorpName              NVARCHAR(50) , 
                @QtyDocCode            NVARCHAR(10)
                                            ) 
AS
    BEGIN

/*
** Update a row in the CorpContainer table using the primary key
*/

        UPDATE CorpContainer
               SET ContainerType = @ContainerType , QtyDocCode = @QtyDocCode , CorpFuncName = @CorpFuncName , CorpName = @CorpName
        WHERE ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_CorpContainer.*
        FROM gv_CorpContainer
        WHERE ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_Delete] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the CorpFunction table
*/

        DELETE FROM CorpFunction
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the CorpFunction table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_Insert] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpFuncDesc NVARCHAR(4000) , 
                @CreateDate   DATETIME , 
                @CorpName     NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Add a row to the CorpFunction table
*/

        INSERT INTO CorpFunction ( CorpFuncName , CorpFuncDesc , CreateDate , CorpName
                                 ) 
        VALUES ( @CorpFuncName , @CorpFuncDesc , @CreateDate , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_CorpFunction.*
        FROM gv_CorpFunction
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectAll]
AS
    BEGIN

/*
** Select all rows from the CorpFunction table
*/

        SELECT gv_CorpFunction.*
        FROM gv_CorpFunction
        ORDER BY CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectByCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectByCorpFuncNameAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                                                    ) 
AS
    BEGIN

/*
** Select a row from the CorpFunction table by primary key
*/

        SELECT gv_CorpFunction.*
        FROM gv_CorpFunction
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectByCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectByCorpName] ( 
                @CorpName NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Select rows from the CorpFunction table by CorpName
*/

        SELECT gv_CorpFunction.*
        FROM gv_CorpFunction
        WHERE CorpName = @CorpName
        ORDER BY CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_CorpFunction_Update] ( 
                @CorpFuncNameOriginal NVARCHAR(80) , 
                @CorpFuncName         NVARCHAR(80) , 
                @CorpNameOriginal     NVARCHAR(50) , 
                @CorpName             NVARCHAR(50) , 
                @CorpFuncDesc         NVARCHAR(4000) , 
                @CreateDate           DATETIME
                                           ) 
AS
    BEGIN

/*
** Update a row in the CorpFunction table using the primary key
*/

        UPDATE CorpFunction
               SET CorpFuncName = @CorpFuncName , CorpFuncDesc = @CorpFuncDesc , CreateDate = @CreateDate , CorpName = @CorpName
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_CorpFunction.*
        FROM gv_CorpFunction
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Corporation_Delete] ( 
                @CorpName NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the Corporation table
*/

        DELETE FROM Corporation
        WHERE CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Corporation table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Corporation_Insert] ( 
                @CorpName NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Add a row to the Corporation table
*/

        INSERT INTO Corporation ( CorpName
                                ) 
        VALUES ( @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_Corporation.*
        FROM gv_Corporation
        WHERE CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Corporation_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Corporation table
*/

        SELECT gv_Corporation.*
        FROM gv_Corporation
        ORDER BY CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_SelectByCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Corporation_SelectByCorpName] ( 
                @CorpName NVARCHAR(50)
                                                    ) 
AS
    BEGIN

/*
** Select a row from the Corporation table by primary key
*/

        SELECT gv_Corporation.*
        FROM gv_Corporation
        WHERE CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Corporation_Update] ( 
                @CorpNameOriginal NVARCHAR(50) , 
                @CorpName         NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Update a row in the Corporation table using the primary key
*/

        UPDATE Corporation
               SET CorpName = @CorpName
        WHERE CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_Corporation.*
        FROM gv_Corporation
        WHERE CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Databases_Delete] ( 
                @DB_ID NVARCHAR(50)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the Databases table
*/

        DELETE FROM Databases
        WHERE DB_ID = @DB_ID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Databases table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Databases_Insert] ( 
                @DB_ID       NVARCHAR(50) , 
                @DB_CONN_STR NVARCHAR(254)
                                        ) 
AS
    BEGIN

/*
** Add a row to the Databases table
*/

        INSERT INTO Databases ( DB_ID , DB_CONN_STR
                              ) 
        VALUES ( @DB_ID , @DB_CONN_STR
               );

/*
** Select the new row
*/

        SELECT gv_Databases.*
        FROM gv_Databases
        WHERE DB_ID = @DB_ID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Databases_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Databases table
*/

        SELECT gv_Databases.*
        FROM gv_Databases
        ORDER BY DB_ID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_SelectByDB_ID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Databases_SelectByDB_ID] ( 
                @DB_ID NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Select a row from the Databases table by primary key
*/

        SELECT gv_Databases.*
        FROM gv_Databases
        WHERE DB_ID = @DB_ID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Databases_Update] ( 
                @DB_IDOriginal NVARCHAR(50) , 
                @DB_ID         NVARCHAR(50) , 
                @DB_CONN_STR   NVARCHAR(254)
                                        ) 
AS
    BEGIN

/*
** Update a row in the Databases table using the primary key
*/

        UPDATE Databases
               SET DB_ID = @DB_ID , DB_CONN_STR = @DB_CONN_STR
        WHERE DB_ID = @DB_IDOriginal;

/*
** Select the updated row
*/

        SELECT gv_Databases.*
        FROM gv_Databases
        WHERE DB_ID = @DB_IDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataOwners_Delete] ( 
                @SourceGuid            NVARCHAR(50) , 
                @UserID                NVARCHAR(50) , 
                @GroupOwnerUserID      NVARCHAR(50) , 
                @GroupName             NVARCHAR(80) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the DataOwners table
*/

        DELETE FROM DataOwners
        WHERE SourceGuid = @SourceGuid
              AND 
              UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DataOwners table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataOwners_Insert] ( 
                @PrimaryOwner          BIT , 
                @OwnerTypeCode         NVARCHAR(50) , 
                @FullAccess            BIT , 
                @ReadOnly              BIT , 
                @DeleteAccess          BIT , 
                @Searchable            BIT , 
                @SourceGuid            NVARCHAR(50) , 
                @UserID                NVARCHAR(50) , 
                @GroupOwnerUserID      NVARCHAR(50) , 
                @GroupName             NVARCHAR(80) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Add a row to the DataOwners table
*/

        INSERT INTO DataOwners ( PrimaryOwner , OwnerTypeCode , FullAccess , ReadOnly , DeleteAccess , Searchable , SourceGuid , UserID , GroupOwnerUserID , GroupName , DataSourceOwnerUserID
                               ) 
        VALUES ( @PrimaryOwner , @OwnerTypeCode , @FullAccess , @ReadOnly , @DeleteAccess , @Searchable , @SourceGuid , @UserID , @GroupOwnerUserID , @GroupName , @DataSourceOwnerUserID
               );

/*
** Select the new row
*/

        SELECT gv_DataOwners.*
        FROM gv_DataOwners
        WHERE SourceGuid = @SourceGuid
              AND 
              UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataOwners_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DataOwners table
*/

        SELECT gv_DataOwners.*
        FROM gv_DataOwners
        ORDER BY SourceGuid , UserID , GroupOwnerUserID , GroupName , DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_SelectBySourceGuidAndUserIDAndGroupOwnerUserIDAndGroupNameAndDataSourceOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataOwners_SelectBySourceGuidAndUserIDAndGroupOwnerUserIDAndGroupNameAndDataSourceOwnerUserID] ( 
                @SourceGuid            NVARCHAR(50) , 
                @UserID                NVARCHAR(50) , 
                @GroupOwnerUserID      NVARCHAR(50) , 
                @GroupName             NVARCHAR(80) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                                                                                                     ) 
AS
    BEGIN

/*
** Select a row from the DataOwners table by primary key
*/

        SELECT gv_DataOwners.*
        FROM gv_DataOwners
        WHERE SourceGuid = @SourceGuid
              AND 
              UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataOwners_Update] ( 
                @SourceGuidOriginal            NVARCHAR(50) , 
                @SourceGuid                    NVARCHAR(50) , 
                @UserIDOriginal                NVARCHAR(50) , 
                @UserID                        NVARCHAR(50) , 
                @GroupOwnerUserIDOriginal      NVARCHAR(50) , 
                @GroupOwnerUserID              NVARCHAR(50) , 
                @GroupNameOriginal             NVARCHAR(80) , 
                @GroupName                     NVARCHAR(80) , 
                @DataSourceOwnerUserIDOriginal NVARCHAR(50) , 
                @DataSourceOwnerUserID         NVARCHAR(50) , 
                @PrimaryOwner                  BIT , 
                @OwnerTypeCode                 NVARCHAR(50) , 
                @FullAccess                    BIT , 
                @ReadOnly                      BIT , 
                @DeleteAccess                  BIT , 
                @Searchable                    BIT
                                         ) 
AS
    BEGIN

/*
** Update a row in the DataOwners table using the primary key
*/

        UPDATE DataOwners
               SET PrimaryOwner = @PrimaryOwner , OwnerTypeCode = @OwnerTypeCode , FullAccess = @FullAccess , ReadOnly = @ReadOnly , DeleteAccess = @DeleteAccess , Searchable = @Searchable , SourceGuid = @SourceGuid , UserID = @UserID , GroupOwnerUserID = @GroupOwnerUserID , GroupName = @GroupName , DataSourceOwnerUserID = @DataSourceOwnerUserID
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_DataOwners.*
        FROM gv_DataOwners
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSource_Delete] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the DataSource table
*/

        DELETE FROM DataSource
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DataSource table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSource_Insert] ( 
                @SourceGuid               NVARCHAR(50) , 
                @CreateDate               DATETIME , 
                @SourceName               NVARCHAR(254) , 
                @SourceImage              IMAGE , 
                @SourceTypeCode           NVARCHAR(50) , 
                @FQN                      NVARCHAR(254) , 
                @VersionNbr               INT , 
                @LastAccessDate           DATETIME , 
                @FileLength               INT , 
                @LastWriteTime            DATETIME , 
                @UserID                   NVARCHAR(50) , 
                @DataSourceOwnerUserID    NVARCHAR(50) , 
                @isPublic                 NCHAR(1) , 
                @FileDirectory            NVARCHAR(300) , 
                @OriginalFileType         NVARCHAR(50) , 
                @RetentionExpirationDate  DATETIME , 
                @IsPublicPreviousState    NCHAR(1) , 
                @isAvailable              NCHAR(1) , 
                @isContainedWithinZipFile NCHAR(1) , 
                @IsZipFile                NCHAR(1) , 
                @DataVerified             BIT , 
                @ZipFileGuid              NVARCHAR(50) , 
                @ZipFileFQN               NVARCHAR(254) , 
                @Description              NVARCHAR(MAX) , 
                @KeyWords                 NVARCHAR(2000) , 
                @Notes                    NVARCHAR(2000) , 
                @isPerm                   NCHAR(1) , 
                @isMaster                 NCHAR(1) , 
                @CreationDate             DATETIME , 
                @OcrPerformed             NCHAR(1) , 
                @isGraphic                NCHAR(1) , 
                @GraphicContainsText      NCHAR(1) , 
                @OcrText                  NVARCHAR(MAX) , 
                @ImageHiddenText          NVARCHAR(MAX) , 
                @isWebPage                NCHAR(1) , 
                @ParentGuid               NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Add a row to the DataSource table
*/

        INSERT INTO DataSource ( SourceGuid , CreateDate , SourceName , SourceImage , SourceTypeCode , FQN , VersionNbr , LastAccessDate , FileLength , LastWriteTime , UserID , DataSourceOwnerUserID , isPublic , FileDirectory , OriginalFileType , RetentionExpirationDate , IsPublicPreviousState , isAvailable , isContainedWithinZipFile , IsZipFile , DataVerified , ZipFileGuid , ZipFileFQN , Description , KeyWords , Notes , isPerm , isMaster , CreationDate , OcrPerformed , isGraphic , GraphicContainsText , OcrText , ImageHiddenText , isWebPage , ParentGuid
                               ) 
        VALUES ( @SourceGuid , @CreateDate , @SourceName , @SourceImage , @SourceTypeCode , @FQN , @VersionNbr , @LastAccessDate , @FileLength , @LastWriteTime , @UserID , @DataSourceOwnerUserID , @isPublic , @FileDirectory , @OriginalFileType , @RetentionExpirationDate , @IsPublicPreviousState , @isAvailable , @isContainedWithinZipFile , @IsZipFile , @DataVerified , @ZipFileGuid , @ZipFileFQN , @Description , @KeyWords , @Notes , @isPerm , @isMaster , @CreationDate , @OcrPerformed , @isGraphic , @GraphicContainsText , @OcrText , @ImageHiddenText , @isWebPage , @ParentGuid
               );

/*
** Select the new row
*/

        SELECT gv_DataSource.*
        FROM gv_DataSource
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSource_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DataSource table
*/

        SELECT gv_DataSource.*
        FROM gv_DataSource
        ORDER BY SourceGuid , DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_SelectBySourceGuidAndDataSourceOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSource_SelectBySourceGuidAndDataSourceOwnerUserID] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                                                             ) 
AS
    BEGIN

/*
** Select a row from the DataSource table by primary key
*/

        SELECT gv_DataSource.*
        FROM gv_DataSource
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSource_Update] ( 
                @SourceGuidOriginal            NVARCHAR(50) , 
                @SourceGuid                    NVARCHAR(50) , 
                @DataSourceOwnerUserIDOriginal NVARCHAR(50) , 
                @DataSourceOwnerUserID         NVARCHAR(50) , 
                @CreateDate                    DATETIME , 
                @SourceName                    NVARCHAR(254) , 
                @SourceImage                   IMAGE , 
                @SourceTypeCode                NVARCHAR(50) , 
                @FQN                           NVARCHAR(254) , 
                @VersionNbr                    INT , 
                @LastAccessDate                DATETIME , 
                @FileLength                    INT , 
                @LastWriteTime                 DATETIME , 
                @UserID                        NVARCHAR(50) , 
                @isPublic                      NCHAR(1) , 
                @FileDirectory                 NVARCHAR(300) , 
                @OriginalFileType              NVARCHAR(50) , 
                @RetentionExpirationDate       DATETIME , 
                @IsPublicPreviousState         NCHAR(1) , 
                @isAvailable                   NCHAR(1) , 
                @isContainedWithinZipFile      NCHAR(1) , 
                @IsZipFile                     NCHAR(1) , 
                @DataVerified                  BIT , 
                @ZipFileGuid                   NVARCHAR(50) , 
                @ZipFileFQN                    NVARCHAR(254) , 
                @Description                   NVARCHAR(MAX) , 
                @KeyWords                      NVARCHAR(2000) , 
                @Notes                         NVARCHAR(2000) , 
                @isPerm                        NCHAR(1) , 
                @isMaster                      NCHAR(1) , 
                @CreationDate                  DATETIME , 
                @OcrPerformed                  NCHAR(1) , 
                @isGraphic                     NCHAR(1) , 
                @GraphicContainsText           NCHAR(1) , 
                @OcrText                       NVARCHAR(MAX) , 
                @ImageHiddenText               NVARCHAR(MAX) , 
                @isWebPage                     NCHAR(1) , 
                @ParentGuid                    NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Update a row in the DataSource table using the primary key
*/

        UPDATE DataSource
               SET SourceGuid = @SourceGuid , CreateDate = @CreateDate , SourceName = @SourceName , SourceImage = @SourceImage , SourceTypeCode = @SourceTypeCode , FQN = @FQN , VersionNbr = @VersionNbr , LastAccessDate = @LastAccessDate , FileLength = @FileLength , LastWriteTime = @LastWriteTime , UserID = @UserID , DataSourceOwnerUserID = @DataSourceOwnerUserID , isPublic = @isPublic , FileDirectory = @FileDirectory , OriginalFileType = @OriginalFileType , RetentionExpirationDate = @RetentionExpirationDate , IsPublicPreviousState = @IsPublicPreviousState , isAvailable = @isAvailable , isContainedWithinZipFile = @isContainedWithinZipFile , IsZipFile = @IsZipFile , DataVerified = @DataVerified , ZipFileGuid = @ZipFileGuid , ZipFileFQN = @ZipFileFQN , Description = @Description , KeyWords = @KeyWords , Notes = @Notes , isPerm = @isPerm , isMaster = @isMaster , CreationDate = @CreationDate , OcrPerformed = @OcrPerformed , isGraphic = @isGraphic , GraphicContainsText = @GraphicContainsText , OcrText = @OcrText , ImageHiddenText = @ImageHiddenText , isWebPage = @isWebPage , ParentGuid = @ParentGuid
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_DataSource.*
        FROM gv_DataSource
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Delete] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @CheckedOutByUserID    NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the DataSourceCheckOut table
*/

        DELETE FROM DataSourceCheckOut
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              CheckedOutByUserID = @CheckedOutByUserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DataSourceCheckOut table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Insert] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @CheckedOutByUserID    NVARCHAR(50) , 
                @isReadOnly            BIT , 
                @isForUpdate           BIT , 
                @checkOutDate          DATETIME
                                                 ) 
AS
    BEGIN

/*
** Add a row to the DataSourceCheckOut table
*/

        INSERT INTO DataSourceCheckOut ( SourceGuid , DataSourceOwnerUserID , CheckedOutByUserID , isReadOnly , isForUpdate , checkOutDate
                                       ) 
        VALUES ( @SourceGuid , @DataSourceOwnerUserID , @CheckedOutByUserID , @isReadOnly , @isForUpdate , @checkOutDate
               );

/*
** Select the new row
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              CheckedOutByUserID = @CheckedOutByUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DataSourceCheckOut table
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        ORDER BY SourceGuid , DataSourceOwnerUserID , CheckedOutByUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectByCheckedOutByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectByCheckedOutByUserID] ( 
                @CheckedOutByUserID NVARCHAR(50)
                                                                     ) 
AS
    BEGIN

/*
** Select rows from the DataSourceCheckOut table by CheckedOutByUserID
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        WHERE CheckedOutByUserID = @CheckedOutByUserID
        ORDER BY SourceGuid , DataSourceOwnerUserID , CheckedOutByUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectByDataSourceOwnerUserIDAndSourceGuid] ( 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50)
                                                                                     ) 
AS
    BEGIN

/*
** Select rows from the DataSourceCheckOut table by DataSourceOwnerUserID and SourceGuid
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        WHERE DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              SourceGuid = @SourceGuid
        ORDER BY SourceGuid , DataSourceOwnerUserID , CheckedOutByUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectBySourceGuidAndDataSourceOwnerUserIDAndCheckedOutByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectBySourceGuidAndDataSourceOwnerUserIDAndCheckedOutByUserID] ( 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @CheckedOutByUserID    NVARCHAR(50)
                                                                                                          ) 
AS
    BEGIN

/*
** Select a row from the DataSourceCheckOut table by primary key
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        WHERE SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              CheckedOutByUserID = @CheckedOutByUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Update] ( 
                @SourceGuidOriginal            NVARCHAR(50) , 
                @SourceGuid                    NVARCHAR(50) , 
                @DataSourceOwnerUserIDOriginal NVARCHAR(50) , 
                @DataSourceOwnerUserID         NVARCHAR(50) , 
                @CheckedOutByUserIDOriginal    NVARCHAR(50) , 
                @CheckedOutByUserID            NVARCHAR(50) , 
                @isReadOnly                    BIT , 
                @isForUpdate                   BIT , 
                @checkOutDate                  DATETIME
                                                 ) 
AS
    BEGIN

/*
** Update a row in the DataSourceCheckOut table using the primary key
*/

        UPDATE DataSourceCheckOut
               SET SourceGuid = @SourceGuid , DataSourceOwnerUserID = @DataSourceOwnerUserID , CheckedOutByUserID = @CheckedOutByUserID , isReadOnly = @isReadOnly , isForUpdate = @isForUpdate , checkOutDate = @checkOutDate
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal
              AND 
              CheckedOutByUserID = @CheckedOutByUserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_DataSourceCheckOut.*
        FROM gv_DataSourceCheckOut
        WHERE SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal
              AND 
              CheckedOutByUserID = @CheckedOutByUserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Delete] ( 
                @SeqNo INT
                                                       ) 
AS
    BEGIN

/*
** Delete a row from the DataSourceRestoreHistory table
*/

        DELETE FROM DataSourceRestoreHistory
        WHERE SeqNo = @SeqNo;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DataSourceRestoreHistory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Insert] ( 
                @SourceGuid            NVARCHAR(50) , 
                @RestoredToMachine     NVARCHAR(50) , 
                @RestoreUserName       NVARCHAR(50) , 
                @RestoreUserID         NVARCHAR(50) , 
                @RestoreUserDomain     NVARCHAR(254) , 
                @RestoreDate           DATETIME , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @TypeContentCode       NVARCHAR(50) , 
                @CreateDate            DATETIME , 
                @DocumentName          NVARCHAR(254) , 
                @FQN                   NVARCHAR(500) , 
                @VerifiedData          NCHAR(1) , 
                @OrigCrc               NVARCHAR(50) , 
                @RestoreCrc            NVARCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Add a row to the DataSourceRestoreHistory table
*/

        INSERT INTO DataSourceRestoreHistory ( SourceGuid , RestoredToMachine , RestoreUserName , RestoreUserID , RestoreUserDomain , RestoreDate , DataSourceOwnerUserID , TypeContentCode , CreateDate , DocumentName , FQN , VerifiedData , OrigCrc , RestoreCrc
                                             ) 
        VALUES ( @SourceGuid , @RestoredToMachine , @RestoreUserName , @RestoreUserID , @RestoreUserDomain , @RestoreDate , @DataSourceOwnerUserID , @TypeContentCode , @CreateDate , @DocumentName , @FQN , @VerifiedData , @OrigCrc , @RestoreCrc
               );

/*
** Select the new row
*/

        SELECT gv_DataSourceRestoreHistory.*
        FROM gv_DataSourceRestoreHistory
        WHERE SeqNo = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DataSourceRestoreHistory table
*/

        SELECT gv_DataSourceRestoreHistory.*
        FROM gv_DataSourceRestoreHistory
        ORDER BY SeqNo;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectByDataSourceOwnerUserIDAndSourceGuid] ( 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50)
                                                                                           ) 
AS
    BEGIN

/*
** Select rows from the DataSourceRestoreHistory table by DataSourceOwnerUserID and SourceGuid
*/

        SELECT gv_DataSourceRestoreHistory.*
        FROM gv_DataSourceRestoreHistory
        WHERE DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              SourceGuid = @SourceGuid
        ORDER BY SeqNo;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectBySeqNo]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectBySeqNo] ( 
                @SeqNo INT
                                                              ) 
AS
    BEGIN

/*
** Select a row from the DataSourceRestoreHistory table by primary key
*/

        SELECT gv_DataSourceRestoreHistory.*
        FROM gv_DataSourceRestoreHistory
        WHERE SeqNo = @SeqNo;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Update] ( 
                @SeqNoOriginal         INT , 
                @SourceGuid            NVARCHAR(50) , 
                @RestoredToMachine     NVARCHAR(50) , 
                @RestoreUserName       NVARCHAR(50) , 
                @RestoreUserID         NVARCHAR(50) , 
                @RestoreUserDomain     NVARCHAR(254) , 
                @RestoreDate           DATETIME , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @TypeContentCode       NVARCHAR(50) , 
                @CreateDate            DATETIME , 
                @DocumentName          NVARCHAR(254) , 
                @FQN                   NVARCHAR(500) , 
                @VerifiedData          NCHAR(1) , 
                @OrigCrc               NVARCHAR(50) , 
                @RestoreCrc            NVARCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Update a row in the DataSourceRestoreHistory table using the primary key
*/

        UPDATE DataSourceRestoreHistory
               SET SourceGuid = @SourceGuid , RestoredToMachine = @RestoredToMachine , RestoreUserName = @RestoreUserName , RestoreUserID = @RestoreUserID , RestoreUserDomain = @RestoreUserDomain , RestoreDate = @RestoreDate , DataSourceOwnerUserID = @DataSourceOwnerUserID , TypeContentCode = @TypeContentCode , CreateDate = @CreateDate , DocumentName = @DocumentName , FQN = @FQN , VerifiedData = @VerifiedData , OrigCrc = @OrigCrc , RestoreCrc = @RestoreCrc
        WHERE SeqNo = @SeqNoOriginal;

/*
** Select the updated row
*/

        SELECT gv_DataSourceRestoreHistory.*
        FROM gv_DataSourceRestoreHistory
        WHERE SeqNo = @SeqNoOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Delete] ( 
                @FileType NVARCHAR(255)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the DataTypeCodes table
*/

        DELETE FROM DataTypeCodes
        WHERE FileType = @FileType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DataTypeCodes table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Insert] ( 
                @FileType   NVARCHAR(255) , 
                @VerNbr     NVARCHAR(255) , 
                @Publisher  NVARCHAR(255) , 
                @Definition NVARCHAR(255)
                                            ) 
AS
    BEGIN

/*
** Add a row to the DataTypeCodes table
*/

        INSERT INTO DataTypeCodes ( FileType , VerNbr , Publisher , Definition
                                  ) 
        VALUES ( @FileType , @VerNbr , @Publisher , @Definition
               );

/*
** Select the new row
*/

        SELECT gv_DataTypeCodes.*
        FROM gv_DataTypeCodes
        WHERE FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataTypeCodes_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DataTypeCodes table
*/

        SELECT gv_DataTypeCodes.*
        FROM gv_DataTypeCodes
        ORDER BY FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_SelectByFileType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataTypeCodes_SelectByFileType] ( 
                @FileType NVARCHAR(255)
                                                      ) 
AS
    BEGIN

/*
** Select a row from the DataTypeCodes table by primary key
*/

        SELECT gv_DataTypeCodes.*
        FROM gv_DataTypeCodes
        WHERE FileType = @FileType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Update] ( 
                @FileTypeOriginal NVARCHAR(255) , 
                @FileType         NVARCHAR(255) , 
                @VerNbr           NVARCHAR(255) , 
                @Publisher        NVARCHAR(255) , 
                @Definition       NVARCHAR(255)
                                            ) 
AS
    BEGIN

/*
** Update a row in the DataTypeCodes table using the primary key
*/

        UPDATE DataTypeCodes
               SET FileType = @FileType , VerNbr = @VerNbr , Publisher = @Publisher , Definition = @Definition
        WHERE FileType = @FileTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_DataTypeCodes.*
        FROM gv_DataTypeCodes
        WHERE FileType = @FileTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Delete] ( 
                @FixID       INT , 
                @CompanyID   NVARCHAR(50) , 
                @MachineName NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the DB_UpdateHist table
*/

        DELETE FROM DB_UpdateHist
        WHERE FixID = @FixID
              AND 
              CompanyID = @CompanyID
              AND 
              MachineName = @MachineName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DB_UpdateHist table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Insert] ( 
                @CreateDate  DATETIME , 
                @FixID       INT , 
                @DBName      NVARCHAR(50) , 
                @CompanyID   NVARCHAR(50) , 
                @MachineName NVARCHAR(50) , 
                @Status      NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the DB_UpdateHist table
*/

        INSERT INTO DB_UpdateHist ( CreateDate , FixID , DBName , CompanyID , MachineName , STATUS
                                  ) 
        VALUES ( @CreateDate , @FixID , @DBName , @CompanyID , @MachineName , @Status
               );

/*
** Select the new row
*/

        SELECT gv_DB_UpdateHist.*
        FROM gv_DB_UpdateHist
        WHERE FixID = @FixID
              AND 
              CompanyID = @CompanyID
              AND 
              MachineName = @MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DB_UpdateHist table
*/

        SELECT gv_DB_UpdateHist.*
        FROM gv_DB_UpdateHist
        ORDER BY FixID , CompanyID , MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_SelectByFixIDAndCompanyIDAndMachineName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_SelectByFixIDAndCompanyIDAndMachineName] ( 
                @FixID       INT , 
                @CompanyID   NVARCHAR(50) , 
                @MachineName NVARCHAR(50)
                                                                             ) 
AS
    BEGIN

/*
** Select a row from the DB_UpdateHist table by primary key
*/

        SELECT gv_DB_UpdateHist.*
        FROM gv_DB_UpdateHist
        WHERE FixID = @FixID
              AND 
              CompanyID = @CompanyID
              AND 
              MachineName = @MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Update] ( 
                @FixIDOriginal       INT , 
                @FixID               INT , 
                @CompanyIDOriginal   NVARCHAR(50) , 
                @CompanyID           NVARCHAR(50) , 
                @MachineNameOriginal NVARCHAR(50) , 
                @MachineName         NVARCHAR(50) , 
                @CreateDate          DATETIME , 
                @DBName              NVARCHAR(50) , 
                @Status              NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Update a row in the DB_UpdateHist table using the primary key
*/

        UPDATE DB_UpdateHist
               SET CreateDate = @CreateDate , FixID = @FixID , DBName = @DBName , CompanyID = @CompanyID , MachineName = @MachineName , STATUS = @Status
        WHERE FixID = @FixIDOriginal
              AND 
              CompanyID = @CompanyIDOriginal
              AND 
              MachineName = @MachineNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_DB_UpdateHist.*
        FROM gv_DB_UpdateHist
        WHERE FixID = @FixIDOriginal
              AND 
              CompanyID = @CompanyIDOriginal
              AND 
              MachineName = @MachineNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_Updates_Delete] ( 
                @FixID INT
                                         ) 
AS
    BEGIN

/*
** Delete a row from the DB_Updates table
*/

        DELETE FROM DB_Updates
        WHERE FixID = @FixID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DB_Updates table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_Updates_Insert] ( 
                @SqlStmt        NVARCHAR(MAX) , 
                @CreateDate     DATETIME , 
                @FixID          INT , 
                @FixDescription NVARCHAR(4000) , 
                @DBName         NVARCHAR(50) , 
                @CompanyID      NVARCHAR(50) , 
                @MachineName    NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Add a row to the DB_Updates table
*/

        INSERT INTO DB_Updates ( SqlStmt , CreateDate , FixID , FixDescription , DBName , CompanyID , MachineName
                               ) 
        VALUES ( @SqlStmt , @CreateDate , @FixID , @FixDescription , @DBName , @CompanyID , @MachineName
               );

/*
** Select the new row
*/

        SELECT gv_DB_Updates.*
        FROM gv_DB_Updates
        WHERE FixID = @FixID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_Updates_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DB_Updates table
*/

        SELECT gv_DB_Updates.*
        FROM gv_DB_Updates
        ORDER BY FixID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_SelectByFixID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_Updates_SelectByFixID] ( 
                @FixID INT
                                                ) 
AS
    BEGIN

/*
** Select a row from the DB_Updates table by primary key
*/

        SELECT gv_DB_Updates.*
        FROM gv_DB_Updates
        WHERE FixID = @FixID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DB_Updates_Update] ( 
                @FixIDOriginal  INT , 
                @FixID          INT , 
                @SqlStmt        NVARCHAR(MAX) , 
                @CreateDate     DATETIME , 
                @FixDescription NVARCHAR(4000) , 
                @DBName         NVARCHAR(50) , 
                @CompanyID      NVARCHAR(50) , 
                @MachineName    NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Update a row in the DB_Updates table using the primary key
*/

        UPDATE DB_Updates
               SET SqlStmt = @SqlStmt , CreateDate = @CreateDate , FixID = @FixID , FixDescription = @FixDescription , DBName = @DBName , CompanyID = @CompanyID , MachineName = @MachineName
        WHERE FixID = @FixIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_DB_Updates.*
        FROM gv_DB_Updates
        WHERE FixID = @FixIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DeleteFrom_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the DeleteFrom table
*/

        DELETE FROM DeleteFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the DeleteFrom table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DeleteFrom_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                         ) 
AS
    BEGIN

/*
** Add a row to the DeleteFrom table
*/

        INSERT INTO DeleteFrom ( FromEmailAddr , SenderName , UserID
                               ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_DeleteFrom.*
        FROM gv_DeleteFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DeleteFrom_SelectAll]
AS
    BEGIN

/*
** Select all rows from the DeleteFrom table
*/

        SELECT gv_DeleteFrom.*
        FROM gv_DeleteFrom
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DeleteFrom_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                              ) 
AS
    BEGIN

/*
** Select a row from the DeleteFrom table by primary key
*/

        SELECT gv_DeleteFrom.*
        FROM gv_DeleteFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_DeleteFrom_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25)
                                         ) 
AS
    BEGIN

/*
** Update a row in the DeleteFrom table using the primary key
*/

        UPDATE DeleteFrom
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_DeleteFrom.*
        FROM gv_DeleteFrom
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_Delete] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the Directory table
*/

        DELETE FROM Directory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Directory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_Insert] ( 
                @UserID         NVARCHAR(50) , 
                @IncludeSubDirs CHAR(1) , 
                @FQN            VARCHAR(254) , 
                @DB_ID          NVARCHAR(50) , 
                @VersionFiles   CHAR(1) , 
                @ckMetaData     NCHAR(1) , 
                @ckPublic       NCHAR(1) , 
                @ckDisableDir   NCHAR(1) , 
                @QuickRefEntry  CHAR(10) , 
                @isSysDefault   BIT , 
                @OcrDirectory   NCHAR(1)
                                        ) 
AS
    BEGIN

/*
** Add a row to the Directory table
*/

        INSERT INTO Directory ( UserID , IncludeSubDirs , FQN , DB_ID , VersionFiles , ckMetaData , ckPublic , ckDisableDir , QuickRefEntry , isSysDefault , OcrDirectory
                              ) 
        VALUES ( @UserID , @IncludeSubDirs , @FQN , @DB_ID , @VersionFiles , @ckMetaData , @ckPublic , @ckDisableDir , @QuickRefEntry , @isSysDefault , @OcrDirectory
               );

/*
** Select the new row
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Directory table
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        ORDER BY UserID , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByDB_ID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_SelectByDB_ID] ( 
                @DB_ID NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Select rows from the Directory table by DB_ID
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        WHERE DB_ID = @DB_ID
        ORDER BY UserID , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                                ) 
AS
    BEGIN

/*
** Select rows from the Directory table by UserID
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        WHERE UserID = @UserID
        ORDER BY UserID , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByUserIDAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_SelectByUserIDAndFQN] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                                      ) 
AS
    BEGIN

/*
** Select a row from the Directory table by primary key
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Directory_Update] ( 
                @UserIDOriginal NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @FQNOriginal    VARCHAR(254) , 
                @FQN            VARCHAR(254) , 
                @IncludeSubDirs CHAR(1) , 
                @DB_ID          NVARCHAR(50) , 
                @VersionFiles   CHAR(1) , 
                @ckMetaData     NCHAR(1) , 
                @ckPublic       NCHAR(1) , 
                @ckDisableDir   NCHAR(1) , 
                @QuickRefEntry  CHAR(10) , 
                @isSysDefault   BIT , 
                @OcrDirectory   NCHAR(1)
                                        ) 
AS
    BEGIN

/*
** Update a row in the Directory table using the primary key
*/

        UPDATE Directory
               SET UserID = @UserID , IncludeSubDirs = @IncludeSubDirs , FQN = @FQN , DB_ID = @DB_ID , VersionFiles = @VersionFiles , ckMetaData = @ckMetaData , ckPublic = @ckPublic , ckDisableDir = @ckDisableDir , QuickRefEntry = @QuickRefEntry , isSysDefault = @isSysDefault , OcrDirectory = @OcrDirectory
        WHERE UserID = @UserIDOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_Directory.*
        FROM gv_Directory
        WHERE UserID = @UserIDOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EcmUser_Delete] ( 
                @EMail NVARCHAR(50)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the EcmUser table
*/

        DELETE FROM EcmUser
        WHERE EMail = @EMail;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the EcmUser table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EcmUser_Insert] ( 
                @EMail       NVARCHAR(50) , 
                @PhoneNumber NVARCHAR(20) , 
                @YourName    NVARCHAR(100) , 
                @YourCompany NVARCHAR(50) , 
                @PassWord    NVARCHAR(50) , 
                @Authority   NCHAR(1) , 
                @CreateDate  DATETIME , 
                @CompanyID   NVARCHAR(50) , 
                @LastUpdate  DATETIME
                                      ) 
AS
    BEGIN

/*
** Add a row to the EcmUser table
*/

        INSERT INTO EcmUser ( EMail , PhoneNumber , YourName , YourCompany , PassWord , Authority , CreateDate , CompanyID , LastUpdate
                            ) 
        VALUES ( @EMail , @PhoneNumber , @YourName , @YourCompany , @PassWord , @Authority , @CreateDate , @CompanyID , @LastUpdate
               );

/*
** Select the new row
*/

        SELECT gv_EcmUser.*
        FROM gv_EcmUser
        WHERE EMail = @EMail;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EcmUser_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EcmUser table
*/

        SELECT gv_EcmUser.*
        FROM gv_EcmUser
        ORDER BY EMail;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_SelectByEMail]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EcmUser_SelectByEMail] ( 
                @EMail NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Select a row from the EcmUser table by primary key
*/

        SELECT gv_EcmUser.*
        FROM gv_EcmUser
        WHERE EMail = @EMail;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EcmUser_Update] ( 
                @EMailOriginal NVARCHAR(50) , 
                @EMail         NVARCHAR(50) , 
                @PhoneNumber   NVARCHAR(20) , 
                @YourName      NVARCHAR(100) , 
                @YourCompany   NVARCHAR(50) , 
                @PassWord      NVARCHAR(50) , 
                @Authority     NCHAR(1) , 
                @CreateDate    DATETIME , 
                @CompanyID     NVARCHAR(50) , 
                @LastUpdate    DATETIME
                                      ) 
AS
    BEGIN

/*
** Update a row in the EcmUser table using the primary key
*/

        UPDATE EcmUser
               SET EMail = @EMail , PhoneNumber = @PhoneNumber , YourName = @YourName , YourCompany = @YourCompany , PassWord = @PassWord , Authority = @Authority , CreateDate = @CreateDate , CompanyID = @CompanyID , LastUpdate = @LastUpdate
        WHERE EMail = @EMailOriginal;

/*
** Select the updated row
*/

        SELECT gv_EcmUser.*
        FROM gv_EcmUser
        WHERE EMail = @EMailOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Email_Delete] ( 
                @EmailGuid NVARCHAR(50)
                                    ) 
AS
    BEGIN

/*
** Delete a row from the Email table
*/

        DELETE FROM Email
        WHERE EmailGuid = @EmailGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Email table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Email_Insert] ( 
                @EmailGuid               NVARCHAR(50) , 
                @SUBJECT                 NVARCHAR(2000) , 
                @SentTO                  NVARCHAR(2000) , 
                @Body                    TEXT , 
                @Bcc                     NVARCHAR(MAX) , 
                @BillingInformation      NVARCHAR(200) , 
                @CC                      NVARCHAR(MAX) , 
                @Companies               NVARCHAR(2000) , 
                @CreationTime            DATETIME , 
                @ReadReceiptRequested    NVARCHAR(50) , 
                @ReceivedByName          NVARCHAR(80) , 
                @ReceivedTime            DATETIME , 
                @AllRecipients           NVARCHAR(MAX) , 
                @UserID                  NVARCHAR(80) , 
                @SenderEmailAddress      NVARCHAR(80) , 
                @SenderName              NVARCHAR(100) , 
                @Sensitivity             NVARCHAR(50) , 
                @SentOn                  DATETIME , 
                @MsgSize                 INT , 
                @DeferredDeliveryTime    DATETIME , 
                @EntryID                 VARCHAR(150) , 
                @ExpiryTime              DATETIME , 
                @LastModificationTime    DATETIME , 
                @EmailImage              IMAGE , 
                @Accounts                NVARCHAR(2000) , 
                @ShortSubj               NVARCHAR(250) , 
                @SourceTypeCode          NVARCHAR(50) , 
                @OriginalFolder          NVARCHAR(254) , 
                @StoreID                 VARCHAR(750) , 
                @isPublic                NCHAR(1) , 
                @RetentionExpirationDate DATETIME , 
                @IsPublicPreviousState   NCHAR(1) , 
                @isAvailable             NCHAR(1) , 
                @CurrMailFolderID        NVARCHAR(300) , 
                @isPerm                  NCHAR(1) , 
                @isMaster                NCHAR(1) , 
                @CreationDate            DATETIME , 
                @NbrAttachments          INT , 
                @CRC                     VARCHAR(50) , 
                @Description             NVARCHAR(MAX) , 
                @KeyWords                NVARCHAR(2000)
                                    ) 
AS
    BEGIN

/*
** Add a row to the Email table
*/

        INSERT INTO Email ( EmailGuid , SUBJECT , SentTO , Body , Bcc , BillingInformation , CC , Companies , CreationTime , ReadReceiptRequested , ReceivedByName , ReceivedTime , AllRecipients , UserID , SenderEmailAddress , SenderName , Sensitivity , SentOn , MsgSize , DeferredDeliveryTime , EntryID , ExpiryTime , LastModificationTime , EmailImage , Accounts , ShortSubj , SourceTypeCode , OriginalFolder , StoreID , isPublic , RetentionExpirationDate , IsPublicPreviousState , isAvailable , CurrMailFolderID , isPerm , isMaster , CreationDate , NbrAttachments , CRC , Description , KeyWords
                          ) 
        VALUES ( @EmailGuid , @SUBJECT , @SentTO , @Body , @Bcc , @BillingInformation , @CC , @Companies , @CreationTime , @ReadReceiptRequested , @ReceivedByName , @ReceivedTime , @AllRecipients , @UserID , @SenderEmailAddress , @SenderName , @Sensitivity , @SentOn , @MsgSize , @DeferredDeliveryTime , @EntryID , @ExpiryTime , @LastModificationTime , @EmailImage , @Accounts , @ShortSubj , @SourceTypeCode , @OriginalFolder , @StoreID , @isPublic , @RetentionExpirationDate , @IsPublicPreviousState , @isAvailable , @CurrMailFolderID , @isPerm , @isMaster , @CreationDate , @NbrAttachments , @CRC , @Description , @KeyWords
               );

/*
** Select the new row
*/

        SELECT gv_Email.*
        FROM gv_Email
        WHERE EmailGuid = @EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Email_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Email_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Email table
*/

        SELECT gv_Email.*
        FROM gv_Email
        ORDER BY EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Email_SelectByEmailGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Email_SelectByEmailGuid] ( 
                @EmailGuid NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Select a row from the Email table by primary key
*/

        SELECT gv_Email.*
        FROM gv_Email
        WHERE EmailGuid = @EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Email_Update] ( 
                @EmailGuidOriginal       NVARCHAR(50) , 
                @EmailGuid               NVARCHAR(50) , 
                @SUBJECT                 NVARCHAR(2000) , 
                @SentTO                  NVARCHAR(2000) , 
                @Body                    TEXT , 
                @Bcc                     NVARCHAR(MAX) , 
                @BillingInformation      NVARCHAR(200) , 
                @CC                      NVARCHAR(MAX) , 
                @Companies               NVARCHAR(2000) , 
                @CreationTime            DATETIME , 
                @ReadReceiptRequested    NVARCHAR(50) , 
                @ReceivedByName          NVARCHAR(80) , 
                @ReceivedTime            DATETIME , 
                @AllRecipients           NVARCHAR(MAX) , 
                @UserID                  NVARCHAR(80) , 
                @SenderEmailAddress      NVARCHAR(80) , 
                @SenderName              NVARCHAR(100) , 
                @Sensitivity             NVARCHAR(50) , 
                @SentOn                  DATETIME , 
                @MsgSize                 INT , 
                @DeferredDeliveryTime    DATETIME , 
                @EntryID                 VARCHAR(150) , 
                @ExpiryTime              DATETIME , 
                @LastModificationTime    DATETIME , 
                @EmailImage              IMAGE , 
                @Accounts                NVARCHAR(2000) , 
                @RowID                   INT , 
                @ShortSubj               NVARCHAR(250) , 
                @SourceTypeCode          NVARCHAR(50) , 
                @OriginalFolder          NVARCHAR(254) , 
                @StoreID                 VARCHAR(750) , 
                @isPublic                NCHAR(1) , 
                @RetentionExpirationDate DATETIME , 
                @IsPublicPreviousState   NCHAR(1) , 
                @isAvailable             NCHAR(1) , 
                @CurrMailFolderID        NVARCHAR(300) , 
                @isPerm                  NCHAR(1) , 
                @isMaster                NCHAR(1) , 
                @CreationDate            DATETIME , 
                @NbrAttachments          INT , 
                @CRC                     VARCHAR(50) , 
                @Description             NVARCHAR(MAX) , 
                @KeyWords                NVARCHAR(2000)
                                    ) 
AS
    BEGIN

/*
** Update a row in the Email table using the primary key
*/

        UPDATE Email
               SET EmailGuid = @EmailGuid , SUBJECT = @SUBJECT , SentTO = @SentTO , Body = @Body , Bcc = @Bcc , BillingInformation = @BillingInformation , CC = @CC , Companies = @Companies , CreationTime = @CreationTime , ReadReceiptRequested = @ReadReceiptRequested , ReceivedByName = @ReceivedByName , ReceivedTime = @ReceivedTime , AllRecipients = @AllRecipients , UserID = @UserID , SenderEmailAddress = @SenderEmailAddress , SenderName = @SenderName , Sensitivity = @Sensitivity , SentOn = @SentOn , MsgSize = @MsgSize , DeferredDeliveryTime = @DeferredDeliveryTime , EntryID = @EntryID , ExpiryTime = @ExpiryTime , LastModificationTime = @LastModificationTime , EmailImage = @EmailImage , Accounts = @Accounts , ShortSubj = @ShortSubj , SourceTypeCode = @SourceTypeCode , OriginalFolder = @OriginalFolder , StoreID = @StoreID , isPublic = @isPublic , RetentionExpirationDate = @RetentionExpirationDate , IsPublicPreviousState = @IsPublicPreviousState , isAvailable = @isAvailable , CurrMailFolderID = @CurrMailFolderID , isPerm = @isPerm , isMaster = @isMaster , CreationDate = @CreationDate , NbrAttachments = @NbrAttachments , CRC = @CRC , Description = @Description , KeyWords = @KeyWords
        WHERE EmailGuid = @EmailGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_Email.*
        FROM gv_Email
        WHERE EmailGuid = @EmailGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_Delete] ( 
                @UserID     NVARCHAR(50) , 
                @FolderName NVARCHAR(254)
                                             ) 
AS
    BEGIN

/*
** Delete a row from the EmailArchParms table
*/

        DELETE FROM EmailArchParms
        WHERE UserID = @UserID
              AND 
              FolderName = @FolderName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the EmailArchParms table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_Insert] ( 
                @UserID             NVARCHAR(50) , 
                @ArchiveEmails      CHAR(1) , 
                @RemoveAfterArchive CHAR(1) , 
                @SetAsDefaultFolder CHAR(1) , 
                @ArchiveAfterXDays  CHAR(1) , 
                @RemoveAfterXDays   CHAR(1) , 
                @RemoveXDays        INT , 
                @ArchiveXDays       INT , 
                @FolderName         NVARCHAR(254) , 
                @DB_ID              NVARCHAR(50) , 
                @ArchiveOnlyIfRead  NCHAR(1) , 
                @isSysDefault       BIT
                                             ) 
AS
    BEGIN

/*
** Add a row to the EmailArchParms table
*/

        INSERT INTO EmailArchParms ( UserID , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , FolderName , DB_ID , ArchiveOnlyIfRead , isSysDefault
                                   ) 
        VALUES ( @UserID , @ArchiveEmails , @RemoveAfterArchive , @SetAsDefaultFolder , @ArchiveAfterXDays , @RemoveAfterXDays , @RemoveXDays , @ArchiveXDays , @FolderName , @DB_ID , @ArchiveOnlyIfRead , @isSysDefault
               );

/*
** Select the new row
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        WHERE UserID = @UserID
              AND 
              FolderName = @FolderName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EmailArchParms table
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        ORDER BY UserID , FolderName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByDB_ID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByDB_ID] ( 
                @DB_ID NVARCHAR(50)
                                                    ) 
AS
    BEGIN

/*
** Select rows from the EmailArchParms table by DB_ID
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        WHERE DB_ID = @DB_ID
        ORDER BY UserID , FolderName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Select rows from the EmailArchParms table by UserID
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        WHERE UserID = @UserID
        ORDER BY UserID , FolderName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByUserIDAndFolderName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByUserIDAndFolderName] ( 
                @UserID     NVARCHAR(50) , 
                @FolderName NVARCHAR(254)
                                                                  ) 
AS
    BEGIN

/*
** Select a row from the EmailArchParms table by primary key
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        WHERE UserID = @UserID
              AND 
              FolderName = @FolderName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailArchParms_Update] ( 
                @UserIDOriginal     NVARCHAR(50) , 
                @UserID             NVARCHAR(50) , 
                @FolderNameOriginal NVARCHAR(254) , 
                @FolderName         NVARCHAR(254) , 
                @ArchiveEmails      CHAR(1) , 
                @RemoveAfterArchive CHAR(1) , 
                @SetAsDefaultFolder CHAR(1) , 
                @ArchiveAfterXDays  CHAR(1) , 
                @RemoveAfterXDays   CHAR(1) , 
                @RemoveXDays        INT , 
                @ArchiveXDays       INT , 
                @DB_ID              NVARCHAR(50) , 
                @ArchiveOnlyIfRead  NCHAR(1) , 
                @isSysDefault       BIT
                                             ) 
AS
    BEGIN

/*
** Update a row in the EmailArchParms table using the primary key
*/

        UPDATE EmailArchParms
               SET UserID = @UserID , ArchiveEmails = @ArchiveEmails , RemoveAfterArchive = @RemoveAfterArchive , SetAsDefaultFolder = @SetAsDefaultFolder , ArchiveAfterXDays = @ArchiveAfterXDays , RemoveAfterXDays = @RemoveAfterXDays , RemoveXDays = @RemoveXDays , ArchiveXDays = @ArchiveXDays , FolderName = @FolderName , DB_ID = @DB_ID , ArchiveOnlyIfRead = @ArchiveOnlyIfRead , isSysDefault = @isSysDefault
        WHERE UserID = @UserIDOriginal
              AND 
              FolderName = @FolderNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_EmailArchParms.*
        FROM gv_EmailArchParms
        WHERE UserID = @UserIDOriginal
              AND 
              FolderName = @FolderNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_Delete] ( 
                @RowID INT
                                              ) 
AS
    BEGIN

/*
** Delete a row from the EmailAttachment table
*/

        DELETE FROM EmailAttachment
        WHERE RowID = @RowID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the EmailAttachment table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_Insert] ( 
                @Attachment     IMAGE , 
                @AttachmentName NVARCHAR(254) , 
                @EmailGuid      NVARCHAR(50) , 
                @AttachmentCode NVARCHAR(50) , 
                @AttachmentType NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @isZipFileEntry BIT , 
                @OcrText        NVARCHAR(MAX) , 
                @isPublic       CHAR(1)
                                              ) 
AS
    BEGIN

/*
** Add a row to the EmailAttachment table
*/

        INSERT INTO EmailAttachment ( Attachment , AttachmentName , EmailGuid , AttachmentCode , AttachmentType , UserID , isZipFileEntry , OcrText , isPublic
                                    ) 
        VALUES ( @Attachment , @AttachmentName , @EmailGuid , @AttachmentCode , @AttachmentType , @UserID , @isZipFileEntry , @OcrText , @isPublic
               );

/*
** Select the new row
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        WHERE RowID = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EmailAttachment table
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        ORDER BY RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByEmailGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByEmailGuid] ( 
                @EmailGuid NVARCHAR(50)
                                                         ) 
AS
    BEGIN

/*
** Select rows from the EmailAttachment table by EmailGuid
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        WHERE EmailGuid = @EmailGuid
        ORDER BY RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByRowID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByRowID] ( 
                @RowID INT
                                                     ) 
AS
    BEGIN

/*
** Select a row from the EmailAttachment table by primary key
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        WHERE RowID = @RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Select rows from the EmailAttachment table by UserID
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        WHERE UserID = @UserID
        ORDER BY RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachment_Update] ( 
                @RowIDOriginal  INT , 
                @Attachment     IMAGE , 
                @AttachmentName NVARCHAR(254) , 
                @EmailGuid      NVARCHAR(50) , 
                @AttachmentCode NVARCHAR(50) , 
                @AttachmentType NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @isZipFileEntry BIT , 
                @OcrText        NVARCHAR(MAX) , 
                @isPublic       CHAR(1)
                                              ) 
AS
    BEGIN

/*
** Update a row in the EmailAttachment table using the primary key
*/

        UPDATE EmailAttachment
               SET Attachment = @Attachment , AttachmentName = @AttachmentName , EmailGuid = @EmailGuid , AttachmentCode = @AttachmentCode , AttachmentType = @AttachmentType , UserID = @UserID , isZipFileEntry = @isZipFileEntry , OcrText = @OcrText , isPublic = @isPublic
        WHERE RowID = @RowIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_EmailAttachment.*
        FROM gv_EmailAttachment
        WHERE RowID = @RowIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_Insert] ( 
                @UserID    NVARCHAR(50) , 
                @EmailGuid NVARCHAR(50)
                                                        ) 
AS
    BEGIN

/*
** Add a row to the EmailAttachmentSearchList table
*/

        INSERT INTO EmailAttachmentSearchList ( UserID , EmailGuid
                                              ) 
        VALUES ( @UserID , @EmailGuid
               );

/*
** Select the new row
*/

        SELECT gv_EmailAttachmentSearchList.*
        FROM gv_EmailAttachmentSearchList;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EmailAttachmentSearchList table
*/

        SELECT gv_EmailAttachmentSearchList.*
        FROM gv_EmailAttachmentSearchList;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailFolder_Delete] ( 
                @UserID   NVARCHAR(80) , 
                @FolderID NVARCHAR(100)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the EmailFolder table
*/

        DELETE FROM EmailFolder
        WHERE UserID = @UserID
              AND 
              FolderID = @FolderID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the EmailFolder table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailFolder_Insert] ( 
                @UserID             NVARCHAR(80) , 
                @FolderName         NVARCHAR(254) , 
                @ParentFolderName   NVARCHAR(254) , 
                @FolderID           NVARCHAR(100) , 
                @ParentFolderID     NVARCHAR(100) , 
                @SelectedForArchive CHAR(1) , 
                @StoreID            NVARCHAR(500) , 
                @isSysDefault       BIT
                                          ) 
AS
    BEGIN

/*
** Add a row to the EmailFolder table
*/

        INSERT INTO EmailFolder ( UserID , FolderName , ParentFolderName , FolderID , ParentFolderID , SelectedForArchive , StoreID , isSysDefault
                                ) 
        VALUES ( @UserID , @FolderName , @ParentFolderName , @FolderID , @ParentFolderID , @SelectedForArchive , @StoreID , @isSysDefault
               );

/*
** Select the new row
*/

        SELECT gv_EmailFolder.*
        FROM gv_EmailFolder
        WHERE UserID = @UserID
              AND 
              FolderID = @FolderID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailFolder_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EmailFolder table
*/

        SELECT gv_EmailFolder.*
        FROM gv_EmailFolder
        ORDER BY UserID , FolderID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_SelectByUserIDAndFolderID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailFolder_SelectByUserIDAndFolderID] ( 
                @UserID   NVARCHAR(80) , 
                @FolderID NVARCHAR(100)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the EmailFolder table by primary key
*/

        SELECT gv_EmailFolder.*
        FROM gv_EmailFolder
        WHERE UserID = @UserID
              AND 
              FolderID = @FolderID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailFolder_Update] ( 
                @UserIDOriginal     NVARCHAR(80) , 
                @UserID             NVARCHAR(80) , 
                @FolderIDOriginal   NVARCHAR(100) , 
                @FolderID           NVARCHAR(100) , 
                @FolderName         NVARCHAR(254) , 
                @ParentFolderName   NVARCHAR(254) , 
                @ParentFolderID     NVARCHAR(100) , 
                @SelectedForArchive CHAR(1) , 
                @StoreID            NVARCHAR(500) , 
                @isSysDefault       BIT
                                          ) 
AS
    BEGIN

/*
** Update a row in the EmailFolder table using the primary key
*/

        UPDATE EmailFolder
               SET UserID = @UserID , FolderName = @FolderName , ParentFolderName = @ParentFolderName , FolderID = @FolderID , ParentFolderID = @ParentFolderID , SelectedForArchive = @SelectedForArchive , StoreID = @StoreID , isSysDefault = @isSysDefault
        WHERE UserID = @UserIDOriginal
              AND 
              FolderID = @FolderIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_EmailFolder.*
        FROM gv_EmailFolder
        WHERE UserID = @UserIDOriginal
              AND 
              FolderID = @FolderIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailToDelete_Insert] ( 
                @EmailGuid NVARCHAR(50) , 
                @StoreID   NVARCHAR(500) , 
                @UserID    NVARCHAR(100) , 
                @MessageID NCHAR(100)
                                            ) 
AS
    BEGIN

/*
** Add a row to the EmailToDelete table
*/

        INSERT INTO EmailToDelete ( EmailGuid , StoreID , UserID , MessageID
                                  ) 
        VALUES ( @EmailGuid , @StoreID , @UserID , @MessageID
               );

/*
** Select the new row
*/

        SELECT gv_EmailToDelete.*
        FROM gv_EmailToDelete;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_EmailToDelete_SelectAll]
AS
    BEGIN

/*
** Select all rows from the EmailToDelete table
*/

        SELECT gv_EmailToDelete.*
        FROM gv_EmailToDelete;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_EmailToDelete_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Delete] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     VARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the ExcludedFiles table
*/

        DELETE FROM ExcludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ExcludedFiles table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Insert] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     VARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Add a row to the ExcludedFiles table
*/

        INSERT INTO ExcludedFiles ( UserID , ExtCode , FQN
                                  ) 
        VALUES ( @UserID , @ExtCode , @FQN
               );

/*
** Select the new row
*/

        SELECT gv_ExcludedFiles.*
        FROM gv_ExcludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludedFiles_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ExcludedFiles table
*/

        SELECT gv_ExcludedFiles.*
        FROM gv_ExcludedFiles
        ORDER BY UserID , ExtCode , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_SelectByUserIDAndExtCodeAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludedFiles_SelectByUserIDAndExtCodeAndFQN] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     VARCHAR(254)
                                                                    ) 
AS
    BEGIN

/*
** Select a row from the ExcludedFiles table by primary key
*/

        SELECT gv_ExcludedFiles.*
        FROM gv_ExcludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Update] ( 
                @UserIDOriginal  NVARCHAR(50) , 
                @UserID          NVARCHAR(50) , 
                @ExtCodeOriginal NVARCHAR(50) , 
                @ExtCode         NVARCHAR(50) , 
                @FQNOriginal     VARCHAR(254) , 
                @FQN             VARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Update a row in the ExcludedFiles table using the primary key
*/

        UPDATE ExcludedFiles
               SET UserID = @UserID , ExtCode = @ExtCode , FQN = @FQN
        WHERE UserID = @UserIDOriginal
              AND 
              ExtCode = @ExtCodeOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_ExcludedFiles.*
        FROM gv_ExcludedFiles
        WHERE UserID = @UserIDOriginal
              AND 
              ExtCode = @ExtCodeOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the ExcludeFrom table
*/

        DELETE FROM ExcludeFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ExcludeFrom table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Add a row to the ExcludeFrom table
*/

        INSERT INTO ExcludeFrom ( FromEmailAddr , SenderName , UserID
                                ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_ExcludeFrom.*
        FROM gv_ExcludeFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludeFrom_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ExcludeFrom table
*/

        SELECT gv_ExcludeFrom.*
        FROM gv_ExcludeFrom
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludeFrom_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                               ) 
AS
    BEGIN

/*
** Select a row from the ExcludeFrom table by primary key
*/

        SELECT gv_ExcludeFrom.*
        FROM gv_ExcludeFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Update a row in the ExcludeFrom table using the primary key
*/

        UPDATE ExcludeFrom
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ExcludeFrom.*
        FROM gv_ExcludeFrom
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FilesToDelete_Delete] ( 
                @UserID      NVARCHAR(50) , 
                @MachineName NVARCHAR(100) , 
                @FQN         NVARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the FilesToDelete table
*/

        DELETE FROM FilesToDelete
        WHERE UserID = @UserID
              AND 
              MachineName = @MachineName
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the FilesToDelete table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FilesToDelete_Insert] ( 
                @UserID        NVARCHAR(50) , 
                @MachineName   NVARCHAR(100) , 
                @FQN           NVARCHAR(254) , 
                @PendingDelete BIT
                                            ) 
AS
    BEGIN

/*
** Add a row to the FilesToDelete table
*/

        INSERT INTO FilesToDelete ( UserID , MachineName , FQN , PendingDelete
                                  ) 
        VALUES ( @UserID , @MachineName , @FQN , @PendingDelete
               );

/*
** Select the new row
*/

        SELECT gv_FilesToDelete.*
        FROM gv_FilesToDelete
        WHERE UserID = @UserID
              AND 
              MachineName = @MachineName
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FilesToDelete_SelectAll]
AS
    BEGIN

/*
** Select all rows from the FilesToDelete table
*/

        SELECT gv_FilesToDelete.*
        FROM gv_FilesToDelete
        ORDER BY UserID , MachineName , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_SelectByUserIDAndMachineNameAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FilesToDelete_SelectByUserIDAndMachineNameAndFQN] ( 
                @UserID      NVARCHAR(50) , 
                @MachineName NVARCHAR(100) , 
                @FQN         NVARCHAR(254)
                                                                        ) 
AS
    BEGIN

/*
** Select a row from the FilesToDelete table by primary key
*/

        SELECT gv_FilesToDelete.*
        FROM gv_FilesToDelete
        WHERE UserID = @UserID
              AND 
              MachineName = @MachineName
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FilesToDelete_Update] ( 
                @UserIDOriginal      NVARCHAR(50) , 
                @UserID              NVARCHAR(50) , 
                @MachineNameOriginal NVARCHAR(100) , 
                @MachineName         NVARCHAR(100) , 
                @FQNOriginal         NVARCHAR(254) , 
                @FQN                 NVARCHAR(254) , 
                @PendingDelete       BIT
                                            ) 
AS
    BEGIN

/*
** Update a row in the FilesToDelete table using the primary key
*/

        UPDATE FilesToDelete
               SET UserID = @UserID , MachineName = @MachineName , FQN = @FQN , PendingDelete = @PendingDelete
        WHERE UserID = @UserIDOriginal
              AND 
              MachineName = @MachineNameOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_FilesToDelete.*
        FROM gv_FilesToDelete
        WHERE UserID = @UserIDOriginal
              AND 
              MachineName = @MachineNameOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Delete] ( 
                @CorpFuncName NVARCHAR(80) , 
                @tgtWord      NVARCHAR(18) , 
                @CorpName     NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the FUncSkipWords table
*/

        DELETE FROM FUncSkipWords
        WHERE CorpFuncName = @CorpFuncName
              AND 
              tgtWord = @tgtWord
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the FUncSkipWords table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Insert] ( 
                @CorpFuncName NVARCHAR(80) , 
                @tgtWord      NVARCHAR(18) , 
                @CorpName     NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the FUncSkipWords table
*/

        INSERT INTO FUncSkipWords ( CorpFuncName , tgtWord , CorpName
                                  ) 
        VALUES ( @CorpFuncName , @tgtWord , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        WHERE CorpFuncName = @CorpFuncName
              AND 
              tgtWord = @tgtWord
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectAll]
AS
    BEGIN

/*
** Select all rows from the FUncSkipWords table
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        ORDER BY CorpFuncName , tgtWord , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                                                     ) 
AS
    BEGIN

/*
** Select rows from the FUncSkipWords table by CorpFuncName and CorpName
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName
        ORDER BY CorpFuncName , tgtWord , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndtgtWordAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndtgtWordAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @tgtWord      NVARCHAR(18) , 
                @CorpName     NVARCHAR(50)
                                                                               ) 
AS
    BEGIN

/*
** Select a row from the FUncSkipWords table by primary key
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        WHERE CorpFuncName = @CorpFuncName
              AND 
              tgtWord = @tgtWord
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectBytgtWord]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectBytgtWord] ( 
                @tgtWord NVARCHAR(18)
                                                     ) 
AS
    BEGIN

/*
** Select rows from the FUncSkipWords table by tgtWord
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        WHERE tgtWord = @tgtWord
        ORDER BY CorpFuncName , tgtWord , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Update] ( 
                @CorpFuncNameOriginal NVARCHAR(80) , 
                @CorpFuncName         NVARCHAR(80) , 
                @tgtWordOriginal      NVARCHAR(18) , 
                @tgtWord              NVARCHAR(18) , 
                @CorpNameOriginal     NVARCHAR(50) , 
                @CorpName             NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Update a row in the FUncSkipWords table using the primary key
*/

        UPDATE FUncSkipWords
               SET CorpFuncName = @CorpFuncName , tgtWord = @tgtWord , CorpName = @CorpName
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              tgtWord = @tgtWordOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_FUncSkipWords.*
        FROM gv_FUncSkipWords
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              tgtWord = @tgtWordOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Delete] ( 
                @CorpFuncName NVARCHAR(80) , 
                @JargonCode   NVARCHAR(50) , 
                @CorpName     NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the FunctionProdJargon table
*/

        DELETE FROM FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the FunctionProdJargon table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Insert] ( 
                @KeyFlag        BINARY(50) , 
                @RepeatDataCode NVARCHAR(50) , 
                @CorpFuncName   NVARCHAR(80) , 
                @JargonCode     NVARCHAR(50) , 
                @CorpName       NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Add a row to the FunctionProdJargon table
*/

        INSERT INTO FunctionProdJargon ( KeyFlag , RepeatDataCode , CorpFuncName , JargonCode , CorpName
                                       ) 
        VALUES ( @KeyFlag , @RepeatDataCode , @CorpFuncName , @JargonCode , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectAll]
AS
    BEGIN

/*
** Select all rows from the FunctionProdJargon table
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        ORDER BY CorpFuncName , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @CorpName     NVARCHAR(50)
                                                                          ) 
AS
    BEGIN

/*
** Select rows from the FunctionProdJargon table by CorpFuncName and CorpName
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName
        ORDER BY CorpFuncName , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndJargonCodeAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndJargonCodeAndCorpName] ( 
                @CorpFuncName NVARCHAR(80) , 
                @JargonCode   NVARCHAR(50) , 
                @CorpName     NVARCHAR(50)
                                                                                       ) 
AS
    BEGIN

/*
** Select a row from the FunctionProdJargon table by primary key
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncName
              AND 
              JargonCode = @JargonCode
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByJargonCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByJargonCode] ( 
                @JargonCode NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select rows from the FunctionProdJargon table by JargonCode
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE JargonCode = @JargonCode
        ORDER BY CorpFuncName , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByRepeatDataCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByRepeatDataCode] ( 
                @RepeatDataCode NVARCHAR(50)
                                                                 ) 
AS
    BEGIN

/*
** Select rows from the FunctionProdJargon table by RepeatDataCode
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE RepeatDataCode = @RepeatDataCode
        ORDER BY CorpFuncName , JargonCode , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Update] ( 
                @CorpFuncNameOriginal NVARCHAR(80) , 
                @CorpFuncName         NVARCHAR(80) , 
                @JargonCodeOriginal   NVARCHAR(50) , 
                @JargonCode           NVARCHAR(50) , 
                @CorpNameOriginal     NVARCHAR(50) , 
                @CorpName             NVARCHAR(50) , 
                @KeyFlag              BINARY(50) , 
                @RepeatDataCode       NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Update a row in the FunctionProdJargon table using the primary key
*/

        UPDATE FunctionProdJargon
               SET KeyFlag = @KeyFlag , RepeatDataCode = @RepeatDataCode , CorpFuncName = @CorpFuncName , JargonCode = @JargonCode , CorpName = @CorpName
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              JargonCode = @JargonCodeOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_FunctionProdJargon.*
        FROM gv_FunctionProdJargon
        WHERE CorpFuncName = @CorpFuncNameOriginal
              AND 
              JargonCode = @JargonCodeOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Delete] ( 
                @ContentGuid NVARCHAR(50) , 
                @UserID      NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the GlobalSeachResults table
*/

        DELETE FROM GlobalSeachResults
        WHERE ContentGuid = @ContentGuid
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the GlobalSeachResults table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Insert] ( 
                @ContentTitle     NVARCHAR(254) , 
                @ContentAuthor    NVARCHAR(254) , 
                @ContentType      NVARCHAR(50) , 
                @CreateDate       NVARCHAR(50) , 
                @ContentExt       NVARCHAR(50) , 
                @ContentGuid      NVARCHAR(50) , 
                @UserID           NVARCHAR(50) , 
                @FileName         NVARCHAR(254) , 
                @FileSize         INT , 
                @NbrOfAttachments INT , 
                @FromEmailAddress NVARCHAR(254) , 
                @AllRecipiants    NVARCHAR(MAX) , 
                @Weight           INT
                                                 ) 
AS
    BEGIN

/*
** Add a row to the GlobalSeachResults table
*/

        INSERT INTO GlobalSeachResults ( ContentTitle , ContentAuthor , ContentType , CreateDate , ContentExt , ContentGuid , UserID , FileName , FileSize , NbrOfAttachments , FromEmailAddress , AllRecipiants , Weight
                                       ) 
        VALUES ( @ContentTitle , @ContentAuthor , @ContentType , @CreateDate , @ContentExt , @ContentGuid , @UserID , @FileName , @FileSize , @NbrOfAttachments , @FromEmailAddress , @AllRecipiants , @Weight
               );

/*
** Select the new row
*/

        SELECT gv_GlobalSeachResults.*
        FROM gv_GlobalSeachResults
        WHERE ContentGuid = @ContentGuid
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_SelectAll]
AS
    BEGIN

/*
** Select all rows from the GlobalSeachResults table
*/

        SELECT gv_GlobalSeachResults.*
        FROM gv_GlobalSeachResults
        ORDER BY ContentGuid , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_SelectByContentGuidAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_SelectByContentGuidAndUserID] ( 
                @ContentGuid NVARCHAR(50) , 
                @UserID      NVARCHAR(50)
                                                                       ) 
AS
    BEGIN

/*
** Select a row from the GlobalSeachResults table by primary key
*/

        SELECT gv_GlobalSeachResults.*
        FROM gv_GlobalSeachResults
        WHERE ContentGuid = @ContentGuid
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Update] ( 
                @ContentGuidOriginal NVARCHAR(50) , 
                @ContentGuid         NVARCHAR(50) , 
                @UserIDOriginal      NVARCHAR(50) , 
                @UserID              NVARCHAR(50) , 
                @ContentTitle        NVARCHAR(254) , 
                @ContentAuthor       NVARCHAR(254) , 
                @ContentType         NVARCHAR(50) , 
                @CreateDate          NVARCHAR(50) , 
                @ContentExt          NVARCHAR(50) , 
                @FileName            NVARCHAR(254) , 
                @FileSize            INT , 
                @NbrOfAttachments    INT , 
                @FromEmailAddress    NVARCHAR(254) , 
                @AllRecipiants       NVARCHAR(MAX) , 
                @Weight              INT
                                                 ) 
AS
    BEGIN

/*
** Update a row in the GlobalSeachResults table using the primary key
*/

        UPDATE GlobalSeachResults
               SET ContentTitle = @ContentTitle , ContentAuthor = @ContentAuthor , ContentType = @ContentType , CreateDate = @CreateDate , ContentExt = @ContentExt , ContentGuid = @ContentGuid , UserID = @UserID , FileName = @FileName , FileSize = @FileSize , NbrOfAttachments = @NbrOfAttachments , FromEmailAddress = @FromEmailAddress , AllRecipiants = @AllRecipiants , Weight = @Weight
        WHERE ContentGuid = @ContentGuidOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_GlobalSeachResults.*
        FROM gv_GlobalSeachResults
        WHERE ContentGuid = @ContentGuidOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Delete] ( 
                @UserID           NVARCHAR(50) , 
                @LibraryName      NVARCHAR(80) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the GroupLibraryAccess table
*/

        DELETE FROM GroupLibraryAccess
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the GroupLibraryAccess table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Insert] ( 
                @UserID           NVARCHAR(50) , 
                @LibraryName      NVARCHAR(80) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                                 ) 
AS
    BEGIN

/*
** Add a row to the GroupLibraryAccess table
*/

        INSERT INTO GroupLibraryAccess ( UserID , LibraryName , GroupOwnerUserID , GroupName
                                       ) 
        VALUES ( @UserID , @LibraryName , @GroupOwnerUserID , @GroupName
               );

/*
** Select the new row
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectAll]
AS
    BEGIN

/*
** Select all rows from the GroupLibraryAccess table
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        ORDER BY UserID , LibraryName , GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByGroupNameAndGroupOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByGroupNameAndGroupOwnerUserID] ( 
                @GroupName        NVARCHAR(80) , 
                @GroupOwnerUserID NVARCHAR(50)
                                                                               ) 
AS
    BEGIN

/*
** Select rows from the GroupLibraryAccess table by GroupName and GroupOwnerUserID
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        WHERE GroupName = @GroupName
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
        ORDER BY UserID , LibraryName , GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByLibraryNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByLibraryNameAndUserID] ( 
                @LibraryName NVARCHAR(80) , 
                @UserID      NVARCHAR(50)
                                                                       ) 
AS
    BEGIN

/*
** Select rows from the GroupLibraryAccess table by LibraryName and UserID
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        WHERE LibraryName = @LibraryName
              AND 
              UserID = @UserID
        ORDER BY UserID , LibraryName , GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByUserIDAndLibraryNameAndGroupOwnerUserIDAndGroupName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByUserIDAndLibraryNameAndGroupOwnerUserIDAndGroupName] ( 
                @UserID           NVARCHAR(50) , 
                @LibraryName      NVARCHAR(80) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                                                                                      ) 
AS
    BEGIN

/*
** Select a row from the GroupLibraryAccess table by primary key
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Update] ( 
                @UserIDOriginal           NVARCHAR(50) , 
                @UserID                   NVARCHAR(50) , 
                @LibraryNameOriginal      NVARCHAR(80) , 
                @LibraryName              NVARCHAR(80) , 
                @GroupOwnerUserIDOriginal NVARCHAR(50) , 
                @GroupOwnerUserID         NVARCHAR(50) , 
                @GroupNameOriginal        NVARCHAR(80) , 
                @GroupName                NVARCHAR(80)
                                                 ) 
AS
    BEGIN

/*
** Update a row in the GroupLibraryAccess table using the primary key
*/

        UPDATE GroupLibraryAccess
               SET UserID = @UserID , LibraryName = @LibraryName , GroupOwnerUserID = @GroupOwnerUserID , GroupName = @GroupName
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_GroupLibraryAccess.*
        FROM gv_GroupLibraryAccess
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_Delete] ( 
                @UserID           NVARCHAR(50) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the GroupUsers table
*/

        DELETE FROM GroupUsers
        WHERE UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the GroupUsers table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_Insert] ( 
                @UserID           NVARCHAR(50) , 
                @FullAccess       BIT , 
                @ReadOnlyAccess   BIT , 
                @DeleteAccess     BIT , 
                @Searchable       BIT , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                         ) 
AS
    BEGIN

/*
** Add a row to the GroupUsers table
*/

        INSERT INTO GroupUsers ( UserID , FullAccess , ReadOnlyAccess , DeleteAccess , Searchable , GroupOwnerUserID , GroupName
                               ) 
        VALUES ( @UserID , @FullAccess , @ReadOnlyAccess , @DeleteAccess , @Searchable , @GroupOwnerUserID , @GroupName
               );

/*
** Select the new row
*/

        SELECT gv_GroupUsers.*
        FROM gv_GroupUsers
        WHERE UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectAll]
AS
    BEGIN

/*
** Select all rows from the GroupUsers table
*/

        SELECT gv_GroupUsers.*
        FROM gv_GroupUsers
        ORDER BY UserID , GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Select rows from the GroupUsers table by UserID
*/

        SELECT gv_GroupUsers.*
        FROM gv_GroupUsers
        WHERE UserID = @UserID
        ORDER BY UserID , GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectByUserIDAndGroupOwnerUserIDAndGroupName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectByUserIDAndGroupOwnerUserIDAndGroupName] ( 
                @UserID           NVARCHAR(50) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                                                                ) 
AS
    BEGIN

/*
** Select a row from the GroupUsers table by primary key
*/

        SELECT gv_GroupUsers.*
        FROM gv_GroupUsers
        WHERE UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_GroupUsers_Update] ( 
                @UserIDOriginal           NVARCHAR(50) , 
                @UserID                   NVARCHAR(50) , 
                @GroupOwnerUserIDOriginal NVARCHAR(50) , 
                @GroupOwnerUserID         NVARCHAR(50) , 
                @GroupNameOriginal        NVARCHAR(80) , 
                @GroupName                NVARCHAR(80) , 
                @FullAccess               BIT , 
                @ReadOnlyAccess           BIT , 
                @DeleteAccess             BIT , 
                @Searchable               BIT
                                         ) 
AS
    BEGIN

/*
** Update a row in the GroupUsers table using the primary key
*/

        UPDATE GroupUsers
               SET UserID = @UserID , FullAccess = @FullAccess , ReadOnlyAccess = @ReadOnlyAccess , DeleteAccess = @DeleteAccess , Searchable = @Searchable , GroupOwnerUserID = @GroupOwnerUserID , GroupName = @GroupName
        WHERE UserID = @UserIDOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_GroupUsers.*
        FROM gv_GroupUsers
        WHERE UserID = @UserIDOriginal
              AND 
              GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpText_Delete] ( 
                @ScreenName NVARCHAR(100) , 
                @WidgetName NVARCHAR(100)
                                       ) 
AS
    BEGIN

/*
** Delete a row from the HelpText table
*/

        DELETE FROM HelpText
        WHERE ScreenName = @ScreenName
              AND 
              WidgetName = @WidgetName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the HelpText table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpText_Insert] ( 
                @ScreenName      NVARCHAR(100) , 
                @HelpText        NVARCHAR(MAX) , 
                @WidgetName      NVARCHAR(100) , 
                @WidgetText      NVARCHAR(254) , 
                @DisplayHelpText BIT , 
                @LastUpdate      DATETIME , 
                @CreateDate      DATETIME , 
                @UpdatedBy       NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Add a row to the HelpText table
*/

        INSERT INTO HelpText ( ScreenName , HelpText , WidgetName , WidgetText , DisplayHelpText , LastUpdate , CreateDate , UpdatedBy
                             ) 
        VALUES ( @ScreenName , @HelpText , @WidgetName , @WidgetText , @DisplayHelpText , @LastUpdate , @CreateDate , @UpdatedBy
               );

/*
** Select the new row
*/

        SELECT gv_HelpText.*
        FROM gv_HelpText
        WHERE ScreenName = @ScreenName
              AND 
              WidgetName = @WidgetName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpText_SelectAll]
AS
    BEGIN

/*
** Select all rows from the HelpText table
*/

        SELECT gv_HelpText.*
        FROM gv_HelpText
        ORDER BY ScreenName , WidgetName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_SelectByScreenNameAndWidgetName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpText_SelectByScreenNameAndWidgetName] ( 
                @ScreenName NVARCHAR(100) , 
                @WidgetName NVARCHAR(100)
                                                                ) 
AS
    BEGIN

/*
** Select a row from the HelpText table by primary key
*/

        SELECT gv_HelpText.*
        FROM gv_HelpText
        WHERE ScreenName = @ScreenName
              AND 
              WidgetName = @WidgetName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpText_Update] ( 
                @ScreenNameOriginal NVARCHAR(100) , 
                @ScreenName         NVARCHAR(100) , 
                @WidgetNameOriginal NVARCHAR(100) , 
                @WidgetName         NVARCHAR(100) , 
                @HelpText           NVARCHAR(MAX) , 
                @WidgetText         NVARCHAR(254) , 
                @DisplayHelpText    BIT , 
                @LastUpdate         DATETIME , 
                @CreateDate         DATETIME , 
                @UpdatedBy          NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Update a row in the HelpText table using the primary key
*/

        UPDATE HelpText
               SET ScreenName = @ScreenName , HelpText = @HelpText , WidgetName = @WidgetName , WidgetText = @WidgetText , DisplayHelpText = @DisplayHelpText , LastUpdate = @LastUpdate , CreateDate = @CreateDate , UpdatedBy = @UpdatedBy
        WHERE ScreenName = @ScreenNameOriginal
              AND 
              WidgetName = @WidgetNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_HelpText.*
        FROM gv_HelpText
        WHERE ScreenName = @ScreenNameOriginal
              AND 
              WidgetName = @WidgetNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpTextUser_Insert] ( 
                @UserID          NVARCHAR(50) , 
                @ScreenName      NVARCHAR(100) , 
                @HelpText        NVARCHAR(MAX) , 
                @WidgetName      NVARCHAR(100) , 
                @WidgetText      NVARCHAR(254) , 
                @DisplayHelpText BIT , 
                @CompanyID       NVARCHAR(50) , 
                @LastUpdate      DATETIME , 
                @CreateDate      DATETIME
                                           ) 
AS
    BEGIN

/*
** Add a row to the HelpTextUser table
*/

        INSERT INTO HelpTextUser ( UserID , ScreenName , HelpText , WidgetName , WidgetText , DisplayHelpText , CompanyID , LastUpdate , CreateDate
                                 ) 
        VALUES ( @UserID , @ScreenName , @HelpText , @WidgetName , @WidgetText , @DisplayHelpText , @CompanyID , @LastUpdate , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_HelpTextUser.*
        FROM gv_HelpTextUser;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_HelpTextUser_SelectAll]
AS
    BEGIN

/*
** Select all rows from the HelpTextUser table
*/

        SELECT gv_HelpTextUser.*
        FROM gv_HelpTextUser;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_HelpTextUser_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Delete] ( 
                @ImageTypeCode NVARCHAR(50)
                                             ) 
AS
    BEGIN

/*
** Delete a row from the ImageTypeCodes table
*/

        DELETE FROM ImageTypeCodes
        WHERE ImageTypeCode = @ImageTypeCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ImageTypeCodes table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Insert] ( 
                @ImageTypeCode     NVARCHAR(50) , 
                @ImageTypeCodeDesc NVARCHAR(250)
                                             ) 
AS
    BEGIN

/*
** Add a row to the ImageTypeCodes table
*/

        INSERT INTO ImageTypeCodes ( ImageTypeCode , ImageTypeCodeDesc
                                   ) 
        VALUES ( @ImageTypeCode , @ImageTypeCodeDesc
               );

/*
** Select the new row
*/

        SELECT gv_ImageTypeCodes.*
        FROM gv_ImageTypeCodes
        WHERE ImageTypeCode = @ImageTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ImageTypeCodes table
*/

        SELECT gv_ImageTypeCodes.*
        FROM gv_ImageTypeCodes
        ORDER BY ImageTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_SelectByImageTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_SelectByImageTypeCode] ( 
                @ImageTypeCode NVARCHAR(50)
                                                            ) 
AS
    BEGIN

/*
** Select a row from the ImageTypeCodes table by primary key
*/

        SELECT gv_ImageTypeCodes.*
        FROM gv_ImageTypeCodes
        WHERE ImageTypeCode = @ImageTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Update] ( 
                @ImageTypeCodeOriginal NVARCHAR(50) , 
                @ImageTypeCode         NVARCHAR(50) , 
                @ImageTypeCodeDesc     NVARCHAR(250)
                                             ) 
AS
    BEGIN

/*
** Update a row in the ImageTypeCodes table using the primary key
*/

        UPDATE ImageTypeCodes
               SET ImageTypeCode = @ImageTypeCode , ImageTypeCodeDesc = @ImageTypeCodeDesc
        WHERE ImageTypeCode = @ImageTypeCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_ImageTypeCodes.*
        FROM gv_ImageTypeCodes
        WHERE ImageTypeCode = @ImageTypeCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludedFiles_Delete] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     NVARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the IncludedFiles table
*/

        DELETE FROM IncludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the IncludedFiles table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludedFiles_Insert] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     NVARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Add a row to the IncludedFiles table
*/

        INSERT INTO IncludedFiles ( UserID , ExtCode , FQN
                                  ) 
        VALUES ( @UserID , @ExtCode , @FQN
               );

/*
** Select the new row
*/

        SELECT gv_IncludedFiles.*
        FROM gv_IncludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludedFiles_SelectAll]
AS
    BEGIN

/*
** Select all rows from the IncludedFiles table
*/

        SELECT gv_IncludedFiles.*
        FROM gv_IncludedFiles
        ORDER BY UserID , ExtCode , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_SelectByUserIDAndExtCodeAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludedFiles_SelectByUserIDAndExtCodeAndFQN] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     NVARCHAR(254)
                                                                    ) 
AS
    BEGIN

/*
** Select a row from the IncludedFiles table by primary key
*/

        SELECT gv_IncludedFiles.*
        FROM gv_IncludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludedFiles_Update] ( 
                @UserIDOriginal  NVARCHAR(50) , 
                @UserID          NVARCHAR(50) , 
                @ExtCodeOriginal NVARCHAR(50) , 
                @ExtCode         NVARCHAR(50) , 
                @FQNOriginal     NVARCHAR(254) , 
                @FQN             NVARCHAR(254)
                                            ) 
AS
    BEGIN

/*
** Update a row in the IncludedFiles table using the primary key
*/

        UPDATE IncludedFiles
               SET UserID = @UserID , ExtCode = @ExtCode , FQN = @FQN
        WHERE UserID = @UserIDOriginal
              AND 
              ExtCode = @ExtCodeOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_IncludedFiles.*
        FROM gv_IncludedFiles
        WHERE UserID = @UserIDOriginal
              AND 
              ExtCode = @ExtCodeOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Delete a row from the IncludeImmediate table
*/

        DELETE FROM IncludeImmediate
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the IncludeImmediate table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Add a row to the IncludeImmediate table
*/

        INSERT INTO IncludeImmediate ( FromEmailAddr , SenderName , UserID
                                     ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_IncludeImmediate.*
        FROM gv_IncludeImmediate
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludeImmediate_SelectAll]
AS
    BEGIN

/*
** Select all rows from the IncludeImmediate table
*/

        SELECT gv_IncludeImmediate.*
        FROM gv_IncludeImmediate
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludeImmediate_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                                    ) 
AS
    BEGIN

/*
** Select a row from the IncludeImmediate table by primary key
*/

        SELECT gv_IncludeImmediate.*
        FROM gv_IncludeImmediate
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25)
                                               ) 
AS
    BEGIN

/*
** Update a row in the IncludeImmediate table using the primary key
*/

        UPDATE IncludeImmediate
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_IncludeImmediate.*
        FROM gv_IncludeImmediate
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_Delete] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Delete a row from the InformationProduct table
*/

        DELETE FROM InformationProduct
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the InformationProduct table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_Insert] ( 
                @CreateDate     DATETIME , 
                @Code           CHAR(10) , 
                @RetentionCode  NVARCHAR(50) , 
                @VolitilityCode NVARCHAR(50) , 
                @ContainerType  NVARCHAR(25) , 
                @CorpFuncName   NVARCHAR(80) , 
                @InfoTypeCode   NVARCHAR(50) , 
                @CorpName       NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Add a row to the InformationProduct table
*/

        INSERT INTO InformationProduct ( CreateDate , Code , RetentionCode , VolitilityCode , ContainerType , CorpFuncName , InfoTypeCode , CorpName
                                       ) 
        VALUES ( @CreateDate , @Code , @RetentionCode , @VolitilityCode , @ContainerType , @CorpFuncName , @InfoTypeCode , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectAll]
AS
    BEGIN

/*
** Select all rows from the InformationProduct table
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByCode] ( 
                @Code CHAR(10)
                                                       ) 
AS
    BEGIN

/*
** Select rows from the InformationProduct table by Code
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE Code = @Code
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByContainerTypeAndCorpFuncNameAndCorpName] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                                                                          ) 
AS
    BEGIN

/*
** Select a row from the InformationProduct table by primary key
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByInfoTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByInfoTypeCode] ( 
                @InfoTypeCode NVARCHAR(50)
                                                               ) 
AS
    BEGIN

/*
** Select rows from the InformationProduct table by InfoTypeCode
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE InfoTypeCode = @InfoTypeCode
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByRetentionCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByRetentionCode] ( 
                @RetentionCode NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select rows from the InformationProduct table by RetentionCode
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE RetentionCode = @RetentionCode
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByVolitilityCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByVolitilityCode] ( 
                @VolitilityCode NVARCHAR(50)
                                                                 ) 
AS
    BEGIN

/*
** Select rows from the InformationProduct table by VolitilityCode
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE VolitilityCode = @VolitilityCode
        ORDER BY ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationProduct_Update] ( 
                @ContainerTypeOriginal NVARCHAR(25) , 
                @ContainerType         NVARCHAR(25) , 
                @CorpFuncNameOriginal  NVARCHAR(80) , 
                @CorpFuncName          NVARCHAR(80) , 
                @CorpNameOriginal      NVARCHAR(50) , 
                @CorpName              NVARCHAR(50) , 
                @CreateDate            DATETIME , 
                @Code                  CHAR(10) , 
                @RetentionCode         NVARCHAR(50) , 
                @VolitilityCode        NVARCHAR(50) , 
                @InfoTypeCode          NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Update a row in the InformationProduct table using the primary key
*/

        UPDATE InformationProduct
               SET CreateDate = @CreateDate , Code = @Code , RetentionCode = @RetentionCode , VolitilityCode = @VolitilityCode , ContainerType = @ContainerType , CorpFuncName = @CorpFuncName , InfoTypeCode = @InfoTypeCode , CorpName = @CorpName
        WHERE ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_InformationProduct.*
        FROM gv_InformationProduct
        WHERE ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationType_Delete] ( 
                @InfoTypeCode NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Delete a row from the InformationType table
*/

        DELETE FROM InformationType
        WHERE InfoTypeCode = @InfoTypeCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the InformationType table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationType_Insert] ( 
                @CreateDate   DATETIME , 
                @InfoTypeCode NVARCHAR(50) , 
                @Description  NVARCHAR(4000)
                                              ) 
AS
    BEGIN

/*
** Add a row to the InformationType table
*/

        INSERT INTO InformationType ( CreateDate , InfoTypeCode , Description
                                    ) 
        VALUES ( @CreateDate , @InfoTypeCode , @Description
               );

/*
** Select the new row
*/

        SELECT gv_InformationType.*
        FROM gv_InformationType
        WHERE InfoTypeCode = @InfoTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationType_SelectAll]
AS
    BEGIN

/*
** Select all rows from the InformationType table
*/

        SELECT gv_InformationType.*
        FROM gv_InformationType
        ORDER BY InfoTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_SelectByInfoTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationType_SelectByInfoTypeCode] ( 
                @InfoTypeCode NVARCHAR(50)
                                                            ) 
AS
    BEGIN

/*
** Select a row from the InformationType table by primary key
*/

        SELECT gv_InformationType.*
        FROM gv_InformationType
        WHERE InfoTypeCode = @InfoTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_InformationType_Update] ( 
                @InfoTypeCodeOriginal NVARCHAR(50) , 
                @InfoTypeCode         NVARCHAR(50) , 
                @CreateDate           DATETIME , 
                @Description          NVARCHAR(4000)
                                              ) 
AS
    BEGIN

/*
** Update a row in the InformationType table using the primary key
*/

        UPDATE InformationType
               SET CreateDate = @CreateDate , InfoTypeCode = @InfoTypeCode , Description = @Description
        WHERE InfoTypeCode = @InfoTypeCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_InformationType.*
        FROM gv_InformationType
        WHERE InfoTypeCode = @InfoTypeCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_Delete] ( 
                @tgtWord    NVARCHAR(50) , 
                @JargonCode NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the JargonWords table
*/

        DELETE FROM JargonWords
        WHERE tgtWord = @tgtWord
              AND 
              JargonCode = @JargonCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the JargonWords table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_Insert] ( 
                @tgtWord    NVARCHAR(50) , 
                @jDesc      NVARCHAR(4000) , 
                @CreateDate DATETIME , 
                @JargonCode NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Add a row to the JargonWords table
*/

        INSERT INTO JargonWords ( tgtWord , jDesc , CreateDate , JargonCode
                                ) 
        VALUES ( @tgtWord , @jDesc , @CreateDate , @JargonCode
               );

/*
** Select the new row
*/

        SELECT gv_JargonWords.*
        FROM gv_JargonWords
        WHERE tgtWord = @tgtWord
              AND 
              JargonCode = @JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_SelectAll]
AS
    BEGIN

/*
** Select all rows from the JargonWords table
*/

        SELECT gv_JargonWords.*
        FROM gv_JargonWords
        ORDER BY tgtWord , JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectByJargonCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_SelectByJargonCode] ( 
                @JargonCode NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Select rows from the JargonWords table by JargonCode
*/

        SELECT gv_JargonWords.*
        FROM gv_JargonWords
        WHERE JargonCode = @JargonCode
        ORDER BY tgtWord , JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectBytgtWordAndJargonCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_SelectBytgtWordAndJargonCode] ( 
                @tgtWord    NVARCHAR(50) , 
                @JargonCode NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select a row from the JargonWords table by primary key
*/

        SELECT gv_JargonWords.*
        FROM gv_JargonWords
        WHERE tgtWord = @tgtWord
              AND 
              JargonCode = @JargonCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_JargonWords_Update] ( 
                @tgtWordOriginal    NVARCHAR(50) , 
                @tgtWord            NVARCHAR(50) , 
                @JargonCodeOriginal NVARCHAR(50) , 
                @JargonCode         NVARCHAR(50) , 
                @jDesc              NVARCHAR(4000) , 
                @CreateDate         DATETIME
                                          ) 
AS
    BEGIN

/*
** Update a row in the JargonWords table using the primary key
*/

        UPDATE JargonWords
               SET tgtWord = @tgtWord , jDesc = @jDesc , CreateDate = @CreateDate , JargonCode = @JargonCode
        WHERE tgtWord = @tgtWordOriginal
              AND 
              JargonCode = @JargonCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_JargonWords.*
        FROM gv_JargonWords
        WHERE tgtWord = @tgtWordOriginal
              AND 
              JargonCode = @JargonCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_Delete] ( 
                @DirectoryName NVARCHAR(254) , 
                @UserID        NVARCHAR(50) , 
                @LibraryName   NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the LibDirectory table
*/

        DELETE FROM LibDirectory
        WHERE DirectoryName = @DirectoryName
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LibDirectory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_Insert] ( 
                @DirectoryName NVARCHAR(254) , 
                @UserID        NVARCHAR(50) , 
                @LibraryName   NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Add a row to the LibDirectory table
*/

        INSERT INTO LibDirectory ( DirectoryName , UserID , LibraryName
                                 ) 
        VALUES ( @DirectoryName , @UserID , @LibraryName
               );

/*
** Select the new row
*/

        SELECT gv_LibDirectory.*
        FROM gv_LibDirectory
        WHERE DirectoryName = @DirectoryName
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LibDirectory table
*/

        SELECT gv_LibDirectory.*
        FROM gv_LibDirectory
        ORDER BY DirectoryName , UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectByDirectoryNameAndUserIDAndLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectByDirectoryNameAndUserIDAndLibraryName] ( 
                @DirectoryName NVARCHAR(254) , 
                @UserID        NVARCHAR(50) , 
                @LibraryName   NVARCHAR(80)
                                                                                 ) 
AS
    BEGIN

/*
** Select a row from the LibDirectory table by primary key
*/

        SELECT gv_LibDirectory.*
        FROM gv_LibDirectory
        WHERE DirectoryName = @DirectoryName
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectByLibraryNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectByLibraryNameAndUserID] ( 
                @LibraryName NVARCHAR(80) , 
                @UserID      NVARCHAR(50)
                                                                 ) 
AS
    BEGIN

/*
** Select rows from the LibDirectory table by LibraryName and UserID
*/

        SELECT gv_LibDirectory.*
        FROM gv_LibDirectory
        WHERE LibraryName = @LibraryName
              AND 
              UserID = @UserID
        ORDER BY DirectoryName , UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibDirectory_Update] ( 
                @DirectoryNameOriginal NVARCHAR(254) , 
                @DirectoryName         NVARCHAR(254) , 
                @UserIDOriginal        NVARCHAR(50) , 
                @UserID                NVARCHAR(50) , 
                @LibraryNameOriginal   NVARCHAR(80) , 
                @LibraryName           NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Update a row in the LibDirectory table using the primary key
*/

        UPDATE LibDirectory
               SET DirectoryName = @DirectoryName , UserID = @UserID , LibraryName = @LibraryName
        WHERE DirectoryName = @DirectoryNameOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_LibDirectory.*
        FROM gv_LibDirectory
        WHERE DirectoryName = @DirectoryNameOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_Delete] ( 
                @EmailFolderEntryID NVARCHAR(200) , 
                @UserID             NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                       ) 
AS
    BEGIN

/*
** Delete a row from the LibEmail table
*/

        DELETE FROM LibEmail
        WHERE EmailFolderEntryID = @EmailFolderEntryID
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LibEmail table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_Insert] ( 
                @EmailFolderEntryID NVARCHAR(200) , 
                @UserID             NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80) , 
                @FolderName         NVARCHAR(250)
                                       ) 
AS
    BEGIN

/*
** Add a row to the LibEmail table
*/

        INSERT INTO LibEmail ( EmailFolderEntryID , UserID , LibraryName , FolderName
                             ) 
        VALUES ( @EmailFolderEntryID , @UserID , @LibraryName , @FolderName
               );

/*
** Select the new row
*/

        SELECT gv_LibEmail.*
        FROM gv_LibEmail
        WHERE EmailFolderEntryID = @EmailFolderEntryID
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LibEmail table
*/

        SELECT gv_LibEmail.*
        FROM gv_LibEmail
        ORDER BY EmailFolderEntryID , UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectByEmailFolderEntryIDAndUserIDAndLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_SelectByEmailFolderEntryIDAndUserIDAndLibraryName] ( 
                @EmailFolderEntryID NVARCHAR(200) , 
                @UserID             NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                                                                  ) 
AS
    BEGIN

/*
** Select a row from the LibEmail table by primary key
*/

        SELECT gv_LibEmail.*
        FROM gv_LibEmail
        WHERE EmailFolderEntryID = @EmailFolderEntryID
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectByLibraryNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_SelectByLibraryNameAndUserID] ( 
                @LibraryName NVARCHAR(80) , 
                @UserID      NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select rows from the LibEmail table by LibraryName and UserID
*/

        SELECT gv_LibEmail.*
        FROM gv_LibEmail
        WHERE LibraryName = @LibraryName
              AND 
              UserID = @UserID
        ORDER BY EmailFolderEntryID , UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibEmail_Update] ( 
                @EmailFolderEntryIDOriginal NVARCHAR(200) , 
                @EmailFolderEntryID         NVARCHAR(200) , 
                @UserIDOriginal             NVARCHAR(50) , 
                @UserID                     NVARCHAR(50) , 
                @LibraryNameOriginal        NVARCHAR(80) , 
                @LibraryName                NVARCHAR(80) , 
                @FolderName                 NVARCHAR(250)
                                       ) 
AS
    BEGIN

/*
** Update a row in the LibEmail table using the primary key
*/

        UPDATE LibEmail
               SET EmailFolderEntryID = @EmailFolderEntryID , UserID = @UserID , LibraryName = @LibraryName , FolderName = @FolderName
        WHERE EmailFolderEntryID = @EmailFolderEntryIDOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_LibEmail.*
        FROM gv_LibEmail
        WHERE EmailFolderEntryID = @EmailFolderEntryIDOriginal
              AND 
              UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_Delete] ( 
                @UserID      NVARCHAR(50) , 
                @LibraryName NVARCHAR(80)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the Library table
*/

        DELETE FROM Library
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Library table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_Insert] ( 
                @UserID      NVARCHAR(50) , 
                @LibraryName NVARCHAR(80) , 
                @isPublic    NCHAR(1)
                                      ) 
AS
    BEGIN

/*
** Add a row to the Library table
*/

        INSERT INTO Library ( UserID , LibraryName , isPublic
                            ) 
        VALUES ( @UserID , @LibraryName , @isPublic
               );

/*
** Select the new row
*/

        SELECT gv_Library.*
        FROM gv_Library
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Library table
*/

        SELECT gv_Library.*
        FROM gv_Library
        ORDER BY UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Select rows from the Library table by UserID
*/

        SELECT gv_Library.*
        FROM gv_Library
        WHERE UserID = @UserID
        ORDER BY UserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectByUserIDAndLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_SelectByUserIDAndLibraryName] ( 
                @UserID      NVARCHAR(50) , 
                @LibraryName NVARCHAR(80)
                                                            ) 
AS
    BEGIN

/*
** Select a row from the Library table by primary key
*/

        SELECT gv_Library.*
        FROM gv_Library
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Library_Update] ( 
                @UserIDOriginal      NVARCHAR(50) , 
                @UserID              NVARCHAR(50) , 
                @LibraryNameOriginal NVARCHAR(80) , 
                @LibraryName         NVARCHAR(80) , 
                @isPublic            NCHAR(1)
                                      ) 
AS
    BEGIN

/*
** Update a row in the Library table using the primary key
*/

        UPDATE Library
               SET UserID = @UserID , LibraryName = @LibraryName , isPublic = @isPublic
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_Library.*
        FROM gv_Library
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryItems_Delete] ( 
                @LibraryItemGuid    NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the LibraryItems table
*/

        DELETE FROM LibraryItems
        WHERE LibraryItemGuid = @LibraryItemGuid
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LibraryItems table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryItems_Insert] ( 
                @SourceGuid            NVARCHAR(50) , 
                @ItemTitle             NVARCHAR(254) , 
                @ItemType              NVARCHAR(50) , 
                @LibraryItemGuid       NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @LibraryOwnerUserID    NVARCHAR(50) , 
                @LibraryName           NVARCHAR(80) , 
                @AddedByUserGuidId     NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Add a row to the LibraryItems table
*/

        INSERT INTO LibraryItems ( SourceGuid , ItemTitle , ItemType , LibraryItemGuid , DataSourceOwnerUserID , LibraryOwnerUserID , LibraryName , AddedByUserGuidId
                                 ) 
        VALUES ( @SourceGuid , @ItemTitle , @ItemType , @LibraryItemGuid , @DataSourceOwnerUserID , @LibraryOwnerUserID , @LibraryName , @AddedByUserGuidId
               );

/*
** Select the new row
*/

        SELECT gv_LibraryItems.*
        FROM gv_LibraryItems
        WHERE LibraryItemGuid = @LibraryItemGuid
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryItems_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LibraryItems table
*/

        SELECT gv_LibraryItems.*
        FROM gv_LibraryItems
        ORDER BY LibraryItemGuid , LibraryOwnerUserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_SelectByLibraryItemGuidAndLibraryOwnerUserIDAndLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryItems_SelectByLibraryItemGuidAndLibraryOwnerUserIDAndLibraryName] ( 
                @LibraryItemGuid    NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                                                                               ) 
AS
    BEGIN

/*
** Select a row from the LibraryItems table by primary key
*/

        SELECT gv_LibraryItems.*
        FROM gv_LibraryItems
        WHERE LibraryItemGuid = @LibraryItemGuid
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryItems_Update] ( 
                @LibraryItemGuidOriginal    NVARCHAR(50) , 
                @LibraryItemGuid            NVARCHAR(50) , 
                @LibraryOwnerUserIDOriginal NVARCHAR(50) , 
                @LibraryOwnerUserID         NVARCHAR(50) , 
                @LibraryNameOriginal        NVARCHAR(80) , 
                @LibraryName                NVARCHAR(80) , 
                @SourceGuid                 NVARCHAR(50) , 
                @ItemTitle                  NVARCHAR(254) , 
                @ItemType                   NVARCHAR(50) , 
                @DataSourceOwnerUserID      NVARCHAR(50) , 
                @AddedByUserGuidId          NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Update a row in the LibraryItems table using the primary key
*/

        UPDATE LibraryItems
               SET SourceGuid = @SourceGuid , ItemTitle = @ItemTitle , ItemType = @ItemType , LibraryItemGuid = @LibraryItemGuid , DataSourceOwnerUserID = @DataSourceOwnerUserID , LibraryOwnerUserID = @LibraryOwnerUserID , LibraryName = @LibraryName , AddedByUserGuidId = @AddedByUserGuidId
        WHERE LibraryItemGuid = @LibraryItemGuidOriginal
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_LibraryItems.*
        FROM gv_LibraryItems
        WHERE LibraryItemGuid = @LibraryItemGuidOriginal
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_Delete] ( 
                @UserID             NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the LibraryUsers table
*/

        DELETE FROM LibraryUsers
        WHERE UserID = @UserID
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LibraryUsers table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_Insert] ( 
                @ReadOnly           BIT , 
                @CreateAccess       BIT , 
                @UpdateAccess       BIT , 
                @DeleteAccess       BIT , 
                @UserID             NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                           ) 
AS
    BEGIN

/*
** Add a row to the LibraryUsers table
*/

        INSERT INTO LibraryUsers ( ReadOnly , CreateAccess , UpdateAccess , DeleteAccess , UserID , LibraryOwnerUserID , LibraryName
                                 ) 
        VALUES ( @ReadOnly , @CreateAccess , @UpdateAccess , @DeleteAccess , @UserID , @LibraryOwnerUserID , @LibraryName
               );

/*
** Select the new row
*/

        SELECT gv_LibraryUsers.*
        FROM gv_LibraryUsers
        WHERE UserID = @UserID
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LibraryUsers table
*/

        SELECT gv_LibraryUsers.*
        FROM gv_LibraryUsers
        ORDER BY UserID , LibraryOwnerUserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                                   ) 
AS
    BEGIN

/*
** Select rows from the LibraryUsers table by UserID
*/

        SELECT gv_LibraryUsers.*
        FROM gv_LibraryUsers
        WHERE UserID = @UserID
        ORDER BY UserID , LibraryOwnerUserID , LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectByUserIDAndLibraryOwnerUserIDAndLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectByUserIDAndLibraryOwnerUserIDAndLibraryName] ( 
                @UserID             NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                                                                      ) 
AS
    BEGIN

/*
** Select a row from the LibraryUsers table by primary key
*/

        SELECT gv_LibraryUsers.*
        FROM gv_LibraryUsers
        WHERE UserID = @UserID
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LibraryUsers_Update] ( 
                @UserIDOriginal             NVARCHAR(50) , 
                @UserID                     NVARCHAR(50) , 
                @LibraryOwnerUserIDOriginal NVARCHAR(50) , 
                @LibraryOwnerUserID         NVARCHAR(50) , 
                @LibraryNameOriginal        NVARCHAR(80) , 
                @LibraryName                NVARCHAR(80) , 
                @ReadOnly                   BIT , 
                @CreateAccess               BIT , 
                @UpdateAccess               BIT , 
                @DeleteAccess               BIT
                                           ) 
AS
    BEGIN

/*
** Update a row in the LibraryUsers table using the primary key
*/

        UPDATE LibraryUsers
               SET ReadOnly = @ReadOnly , CreateAccess = @CreateAccess , UpdateAccess = @UpdateAccess , DeleteAccess = @DeleteAccess , UserID = @UserID , LibraryOwnerUserID = @LibraryOwnerUserID , LibraryName = @LibraryName
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_LibraryUsers.*
        FROM gv_LibraryUsers
        WHERE UserID = @UserIDOriginal
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_License_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_License_Delete] ( 
                @LicenseID INT
                                      ) 
AS
    BEGIN

/*
** Delete a row from the License table
*/

        DELETE FROM License
        WHERE LicenseID = @LicenseID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the License table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_License_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_License_Insert] ( 
                @Agreement             NVARCHAR(2000) , 
                @VersionNbr            INT , 
                @ActivationDate        DATETIME , 
                @InstallDate           DATETIME , 
                @CustomerID            NVARCHAR(50) , 
                @CustomerName          NVARCHAR(254) , 
                @XrtNxr1               NVARCHAR(50) , 
                @ServerIdentifier      VARCHAR(100) , 
                @SqlInstanceIdentifier VARCHAR(100)
                                      ) 
AS
    BEGIN

/*
** Add a row to the License table
*/

        INSERT INTO License ( Agreement , VersionNbr , ActivationDate , InstallDate , CustomerID , CustomerName , XrtNxr1 , ServerIdentifier , SqlInstanceIdentifier
                            ) 
        VALUES ( @Agreement , @VersionNbr , @ActivationDate , @InstallDate , @CustomerID , @CustomerName , @XrtNxr1 , @ServerIdentifier , @SqlInstanceIdentifier
               );

/*
** Select the new row
*/

        SELECT gv_License.*
        FROM gv_License
        WHERE LicenseID = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_License_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_License_SelectAll]
AS
    BEGIN

/*
** Select all rows from the License table
*/

        SELECT gv_License.*
        FROM gv_License
        ORDER BY LicenseID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_License_SelectByLicenseID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_License_SelectByLicenseID] ( 
                @LicenseID INT
                                                 ) 
AS
    BEGIN

/*
** Select a row from the License table by primary key
*/

        SELECT gv_License.*
        FROM gv_License
        WHERE LicenseID = @LicenseID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_License_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_License_Update] ( 
                @LicenseIDOriginal     INT , 
                @Agreement             NVARCHAR(2000) , 
                @VersionNbr            INT , 
                @ActivationDate        DATETIME , 
                @InstallDate           DATETIME , 
                @CustomerID            NVARCHAR(50) , 
                @CustomerName          NVARCHAR(254) , 
                @XrtNxr1               NVARCHAR(50) , 
                @ServerIdentifier      VARCHAR(100) , 
                @SqlInstanceIdentifier VARCHAR(100)
                                      ) 
AS
    BEGIN

/*
** Update a row in the License table using the primary key
*/

        UPDATE License
               SET Agreement = @Agreement , VersionNbr = @VersionNbr , ActivationDate = @ActivationDate , InstallDate = @InstallDate , CustomerID = @CustomerID , CustomerName = @CustomerName , XrtNxr1 = @XrtNxr1 , ServerIdentifier = @ServerIdentifier , SqlInstanceIdentifier = @SqlInstanceIdentifier
        WHERE LicenseID = @LicenseIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_License.*
        FROM gv_License
        WHERE LicenseID = @LicenseIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfile_Delete] ( 
                @ProfileName NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the LoadProfile table
*/

        DELETE FROM LoadProfile
        WHERE ProfileName = @ProfileName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LoadProfile table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfile_Insert] ( 
                @ProfileName NVARCHAR(50) , 
                @ProfileDesc NVARCHAR(254)
                                          ) 
AS
    BEGIN

/*
** Add a row to the LoadProfile table
*/

        INSERT INTO LoadProfile ( ProfileName , ProfileDesc
                                ) 
        VALUES ( @ProfileName , @ProfileDesc
               );

/*
** Select the new row
*/

        SELECT gv_LoadProfile.*
        FROM gv_LoadProfile
        WHERE ProfileName = @ProfileName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfile_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LoadProfile table
*/

        SELECT gv_LoadProfile.*
        FROM gv_LoadProfile
        ORDER BY ProfileName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_SelectByProfileName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfile_SelectByProfileName] ( 
                @ProfileName NVARCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Select a row from the LoadProfile table by primary key
*/

        SELECT gv_LoadProfile.*
        FROM gv_LoadProfile
        WHERE ProfileName = @ProfileName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfile_Update] ( 
                @ProfileNameOriginal NVARCHAR(50) , 
                @ProfileName         NVARCHAR(50) , 
                @ProfileDesc         NVARCHAR(254)
                                          ) 
AS
    BEGIN

/*
** Update a row in the LoadProfile table using the primary key
*/

        UPDATE LoadProfile
               SET ProfileName = @ProfileName , ProfileDesc = @ProfileDesc
        WHERE ProfileName = @ProfileNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_LoadProfile.*
        FROM gv_LoadProfile
        WHERE ProfileName = @ProfileNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Delete] ( 
                @ProfileName    NVARCHAR(50) , 
                @SourceTypeCode NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Delete a row from the LoadProfileItem table
*/

        DELETE FROM LoadProfileItem
        WHERE ProfileName = @ProfileName
              AND 
              SourceTypeCode = @SourceTypeCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the LoadProfileItem table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Insert] ( 
                @ProfileName    NVARCHAR(50) , 
                @SourceTypeCode NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Add a row to the LoadProfileItem table
*/

        INSERT INTO LoadProfileItem ( ProfileName , SourceTypeCode
                                    ) 
        VALUES ( @ProfileName , @SourceTypeCode
               );

/*
** Select the new row
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        WHERE ProfileName = @ProfileName
              AND 
              SourceTypeCode = @SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectAll]
AS
    BEGIN

/*
** Select all rows from the LoadProfileItem table
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        ORDER BY ProfileName , SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectByProfileName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectByProfileName] ( 
                @ProfileName NVARCHAR(50)
                                                           ) 
AS
    BEGIN

/*
** Select rows from the LoadProfileItem table by ProfileName
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        WHERE ProfileName = @ProfileName
        ORDER BY ProfileName , SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectByProfileNameAndSourceTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectByProfileNameAndSourceTypeCode] ( 
                @ProfileName    NVARCHAR(50) , 
                @SourceTypeCode NVARCHAR(50)
                                                                            ) 
AS
    BEGIN

/*
** Select a row from the LoadProfileItem table by primary key
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        WHERE ProfileName = @ProfileName
              AND 
              SourceTypeCode = @SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectBySourceTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectBySourceTypeCode] ( 
                @SourceTypeCode NVARCHAR(50)
                                                              ) 
AS
    BEGIN

/*
** Select rows from the LoadProfileItem table by SourceTypeCode
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        WHERE SourceTypeCode = @SourceTypeCode
        ORDER BY ProfileName , SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Update] ( 
                @ProfileNameOriginal    NVARCHAR(50) , 
                @ProfileName            NVARCHAR(50) , 
                @SourceTypeCodeOriginal NVARCHAR(50) , 
                @SourceTypeCode         NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Update a row in the LoadProfileItem table using the primary key
*/

        UPDATE LoadProfileItem
               SET ProfileName = @ProfileName , SourceTypeCode = @SourceTypeCode
        WHERE ProfileName = @ProfileNameOriginal
              AND 
              SourceTypeCode = @SourceTypeCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_LoadProfileItem.*
        FROM gv_LoadProfileItem
        WHERE ProfileName = @ProfileNameOriginal
              AND 
              SourceTypeCode = @SourceTypeCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Machine_Delete] ( 
                @MachineName NVARCHAR(254)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the Machine table
*/

        DELETE FROM Machine
        WHERE MachineName = @MachineName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Machine table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Machine_Insert] ( 
                @MachineName NVARCHAR(254)
                                      ) 
AS
    BEGIN

/*
** Add a row to the Machine table
*/

        INSERT INTO Machine ( MachineName
                            ) 
        VALUES ( @MachineName
               );

/*
** Select the new row
*/

        SELECT gv_Machine.*
        FROM gv_Machine
        WHERE MachineName = @MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Machine_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Machine table
*/

        SELECT gv_Machine.*
        FROM gv_Machine
        ORDER BY MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_SelectByMachineName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Machine_SelectByMachineName] ( 
                @MachineName NVARCHAR(254)
                                                   ) 
AS
    BEGIN

/*
** Select a row from the Machine table by primary key
*/

        SELECT gv_Machine.*
        FROM gv_Machine
        WHERE MachineName = @MachineName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Machine_Update] ( 
                @MachineNameOriginal NVARCHAR(254) , 
                @MachineName         NVARCHAR(254)
                                      ) 
AS
    BEGIN

/*
** Update a row in the Machine table using the primary key
*/

        UPDATE Machine
               SET MachineName = @MachineName
        WHERE MachineName = @MachineNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_Machine.*
        FROM gv_Machine
        WHERE MachineName = @MachineNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_MyTempTable_Delete] ( 
                @docid INT
                                          ) 
AS
    BEGIN

/*
** Delete a row from the MyTempTable table
*/

        DELETE FROM MyTempTable
        WHERE docid = @docid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the MyTempTable table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_MyTempTable_Insert] ( 
                @docid INT , 
                @key   NVARCHAR(100)
                                          ) 
AS
    BEGIN

/*
** Add a row to the MyTempTable table
*/

        INSERT INTO MyTempTable ( docid , [key]
                                ) 
        VALUES ( @docid , @key
               );

/*
** Select the new row
*/

        SELECT gv_MyTempTable.*
        FROM gv_MyTempTable
        WHERE docid = @docid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_MyTempTable_SelectAll]
AS
    BEGIN

/*
** Select all rows from the MyTempTable table
*/

        SELECT gv_MyTempTable.*
        FROM gv_MyTempTable
        ORDER BY docid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_SelectBydocid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_MyTempTable_SelectBydocid] ( 
                @docid INT
                                                 ) 
AS
    BEGIN

/*
** Select a row from the MyTempTable table by primary key
*/

        SELECT gv_MyTempTable.*
        FROM gv_MyTempTable
        WHERE docid = @docid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_MyTempTable_Update] ( 
                @docidOriginal INT , 
                @docid         INT , 
                @key           NVARCHAR(100)
                                          ) 
AS
    BEGIN

/*
** Update a row in the MyTempTable table using the primary key
*/

        UPDATE MyTempTable
               SET docid = @docid , [key] = @key
        WHERE docid = @docidOriginal;

/*
** Select the updated row
*/

        SELECT gv_MyTempTable.*
        FROM gv_MyTempTable
        WHERE docid = @docidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OutlookFrom_Delete] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the OutlookFrom table
*/

        DELETE FROM OutlookFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the OutlookFrom table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OutlookFrom_Insert] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25) , 
                @Verified      INT
                                          ) 
AS
    BEGIN

/*
** Add a row to the OutlookFrom table
*/

        INSERT INTO OutlookFrom ( FromEmailAddr , SenderName , UserID , Verified
                                ) 
        VALUES ( @FromEmailAddr , @SenderName , @UserID , @Verified
               );

/*
** Select the new row
*/

        SELECT gv_OutlookFrom.*
        FROM gv_OutlookFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OutlookFrom_SelectAll]
AS
    BEGIN

/*
** Select all rows from the OutlookFrom table
*/

        SELECT gv_OutlookFrom.*
        FROM gv_OutlookFrom
        ORDER BY FromEmailAddr , SenderName , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OutlookFrom_SelectByFromEmailAddrAndSenderNameAndUserID] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                                                               ) 
AS
    BEGIN

/*
** Select a row from the OutlookFrom table by primary key
*/

        SELECT gv_OutlookFrom.*
        FROM gv_OutlookFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OutlookFrom_Update] ( 
                @FromEmailAddrOriginal NVARCHAR(254) , 
                @FromEmailAddr         NVARCHAR(254) , 
                @SenderNameOriginal    VARCHAR(254) , 
                @SenderName            VARCHAR(254) , 
                @UserIDOriginal        VARCHAR(25) , 
                @UserID                VARCHAR(25) , 
                @Verified              INT
                                          ) 
AS
    BEGIN

/*
** Update a row in the OutlookFrom table using the primary key
*/

        UPDATE OutlookFrom
               SET FromEmailAddr = @FromEmailAddr , SenderName = @SenderName , UserID = @UserID , Verified = @Verified
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_OutlookFrom.*
        FROM gv_OutlookFrom
        WHERE FromEmailAddr = @FromEmailAddrOriginal
              AND 
              SenderName = @SenderNameOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_Delete] ( 
                @RowId INT
                                           ) 
AS
    BEGIN

/*
** Delete a row from the OwnerHistory table
*/

        DELETE FROM OwnerHistory
        WHERE RowId = @RowId;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the OwnerHistory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_Insert] ( 
                @PreviousOwnerUserID NVARCHAR(50) , 
                @CurrentOwnerUserID  NVARCHAR(50) , 
                @CreateDate          DATETIME
                                           ) 
AS
    BEGIN

/*
** Add a row to the OwnerHistory table
*/

        INSERT INTO OwnerHistory ( PreviousOwnerUserID , CurrentOwnerUserID , CreateDate
                                 ) 
        VALUES ( @PreviousOwnerUserID , @CurrentOwnerUserID , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        WHERE RowId = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the OwnerHistory table
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByCurrentOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByCurrentOwnerUserID] ( 
                @CurrentOwnerUserID NVARCHAR(50)
                                                               ) 
AS
    BEGIN

/*
** Select rows from the OwnerHistory table by CurrentOwnerUserID
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        WHERE CurrentOwnerUserID = @CurrentOwnerUserID
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByPreviousOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByPreviousOwnerUserID] ( 
                @PreviousOwnerUserID NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select rows from the OwnerHistory table by PreviousOwnerUserID
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        WHERE PreviousOwnerUserID = @PreviousOwnerUserID
        ORDER BY RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByRowId]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByRowId] ( 
                @RowId INT
                                                  ) 
AS
    BEGIN

/*
** Select a row from the OwnerHistory table by primary key
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        WHERE RowId = @RowId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_OwnerHistory_Update] ( 
                @RowIdOriginal       INT , 
                @PreviousOwnerUserID NVARCHAR(50) , 
                @CurrentOwnerUserID  NVARCHAR(50) , 
                @CreateDate          DATETIME
                                           ) 
AS
    BEGIN

/*
** Update a row in the OwnerHistory table using the primary key
*/

        UPDATE OwnerHistory
               SET PreviousOwnerUserID = @PreviousOwnerUserID , CurrentOwnerUserID = @CurrentOwnerUserID , CreateDate = @CreateDate
        WHERE RowId = @RowIdOriginal;

/*
** Select the updated row
*/

        SELECT gv_OwnerHistory.*
        FROM gv_OwnerHistory
        WHERE RowId = @RowIdOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_PgmTrace_Insert] ( 
                @StmtID         NVARCHAR(50) , 
                @PgmName        NVARCHAR(254) , 
                @Stmt           NVARCHAR(MAX) , 
                @CreateDate     DATETIME , 
                @ConnectiveGuid NVARCHAR(50) , 
                @UserID         NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
	** Add a row to the PgmTrace table
	*/

        INSERT INTO PgmTrace ( StmtID , PgmName , Stmt , CreateDate , ConnectiveGuid , UserID
                             ) 
        VALUES ( @StmtID , @PgmName , @Stmt , @CreateDate , @ConnectiveGuid , @UserID
               );

/*
	** Select the new row
	*/

        SELECT StmtID , PgmName , Stmt , CreateDate , ConnectiveGuid , UserID
        FROM gv_PgmTrace;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_PgmTrace_SelectAll]
AS
    BEGIN

/*
** Select all rows from the PgmTrace table
*/

        SELECT *
        FROM gv_PgmTrace;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_PgmTrace_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Delete] ( 
                @ExtCode NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the ProcessFileAs table
*/

        DELETE FROM ProcessFileAs
        WHERE ExtCode = @ExtCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ProcessFileAs table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Insert] ( 
                @ExtCode        NVARCHAR(50) , 
                @ProcessExtCode NVARCHAR(50) , 
                @Applied        BIT
                                            ) 
AS
    BEGIN

/*
** Add a row to the ProcessFileAs table
*/

        INSERT INTO ProcessFileAs ( ExtCode , ProcessExtCode , Applied
                                  ) 
        VALUES ( @ExtCode , @ProcessExtCode , @Applied
               );

/*
** Select the new row
*/

        SELECT gv_ProcessFileAs.*
        FROM gv_ProcessFileAs
        WHERE ExtCode = @ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProcessFileAs_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ProcessFileAs table
*/

        SELECT gv_ProcessFileAs.*
        FROM gv_ProcessFileAs
        ORDER BY ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_SelectByExtCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProcessFileAs_SelectByExtCode] ( 
                @ExtCode NVARCHAR(50)
                                                     ) 
AS
    BEGIN

/*
** Select a row from the ProcessFileAs table by primary key
*/

        SELECT gv_ProcessFileAs.*
        FROM gv_ProcessFileAs
        WHERE ExtCode = @ExtCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Update] ( 
                @ExtCodeOriginal NVARCHAR(50) , 
                @ExtCode         NVARCHAR(50) , 
                @ProcessExtCode  NVARCHAR(50) , 
                @Applied         BIT
                                            ) 
AS
    BEGIN

/*
** Update a row in the ProcessFileAs table using the primary key
*/

        UPDATE ProcessFileAs
               SET ExtCode = @ExtCode , ProcessExtCode = @ProcessExtCode , Applied = @Applied
        WHERE ExtCode = @ExtCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_ProcessFileAs.*
        FROM gv_ProcessFileAs
        WHERE ExtCode = @ExtCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Delete] ( 
                @CaptureItemsCode NVARCHAR(50) , 
                @ContainerType    NVARCHAR(25) , 
                @CorpFuncName     NVARCHAR(80) , 
                @CorpName         NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Delete a row from the ProdCaptureItems table
*/

        DELETE FROM ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode
              AND 
              ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ProdCaptureItems table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Insert] ( 
                @CaptureItemsCode NVARCHAR(50) , 
                @SendAlert        BIT , 
                @ContainerType    NVARCHAR(25) , 
                @CorpFuncName     NVARCHAR(80) , 
                @CorpName         NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Add a row to the ProdCaptureItems table
*/

        INSERT INTO ProdCaptureItems ( CaptureItemsCode , SendAlert , ContainerType , CorpFuncName , CorpName
                                     ) 
        VALUES ( @CaptureItemsCode , @SendAlert , @ContainerType , @CorpFuncName , @CorpName
               );

/*
** Select the new row
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode
              AND 
              ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ProdCaptureItems table
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        ORDER BY CaptureItemsCode , ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCode] ( 
                @CaptureItemsCode NVARCHAR(50)
                                                                 ) 
AS
    BEGIN

/*
** Select rows from the ProdCaptureItems table by CaptureItemsCode
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode
        ORDER BY CaptureItemsCode , ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCodeAndContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCodeAndContainerTypeAndCorpFuncNameAndCorpName] ( 
                @CaptureItemsCode NVARCHAR(50) , 
                @ContainerType    NVARCHAR(25) , 
                @CorpFuncName     NVARCHAR(80) , 
                @CorpName         NVARCHAR(50)
                                                                                                           ) 
AS
    BEGIN

/*
** Select a row from the ProdCaptureItems table by primary key
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode
              AND 
              ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByContainerTypeAndCorpFuncNameAndCorpName] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                                                                        ) 
AS
    BEGIN

/*
** Select rows from the ProdCaptureItems table by ContainerType, CorpFuncName and CorpName
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName
        ORDER BY CaptureItemsCode , ContainerType , CorpFuncName , CorpName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Update] ( 
                @CaptureItemsCodeOriginal NVARCHAR(50) , 
                @CaptureItemsCode         NVARCHAR(50) , 
                @ContainerTypeOriginal    NVARCHAR(25) , 
                @ContainerType            NVARCHAR(25) , 
                @CorpFuncNameOriginal     NVARCHAR(80) , 
                @CorpFuncName             NVARCHAR(80) , 
                @CorpNameOriginal         NVARCHAR(50) , 
                @CorpName                 NVARCHAR(50) , 
                @SendAlert                BIT
                                               ) 
AS
    BEGIN

/*
** Update a row in the ProdCaptureItems table using the primary key
*/

        UPDATE ProdCaptureItems
               SET CaptureItemsCode = @CaptureItemsCode , SendAlert = @SendAlert , ContainerType = @ContainerType , CorpFuncName = @CorpFuncName , CorpName = @CorpName
        WHERE CaptureItemsCode = @CaptureItemsCodeOriginal
              AND 
              ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_ProdCaptureItems.*
        FROM gv_ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCodeOriginal
              AND 
              ContainerType = @ContainerTypeOriginal
              AND 
              CorpFuncName = @CorpFuncNameOriginal
              AND 
              CorpName = @CorpNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QtyDocs_Delete] ( 
                @QtyDocCode NVARCHAR(10)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the QtyDocs table
*/

        DELETE FROM QtyDocs
        WHERE QtyDocCode = @QtyDocCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the QtyDocs table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QtyDocs_Insert] ( 
                @QtyDocCode  NVARCHAR(10) , 
                @Description NVARCHAR(4000) , 
                @CreateDate  DATETIME
                                      ) 
AS
    BEGIN

/*
** Add a row to the QtyDocs table
*/

        INSERT INTO QtyDocs ( QtyDocCode , Description , CreateDate
                            ) 
        VALUES ( @QtyDocCode , @Description , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_QtyDocs.*
        FROM gv_QtyDocs
        WHERE QtyDocCode = @QtyDocCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QtyDocs_SelectAll]
AS
    BEGIN

/*
** Select all rows from the QtyDocs table
*/

        SELECT gv_QtyDocs.*
        FROM gv_QtyDocs
        ORDER BY QtyDocCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_SelectByQtyDocCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QtyDocs_SelectByQtyDocCode] ( 
                @QtyDocCode NVARCHAR(10)
                                                  ) 
AS
    BEGIN

/*
** Select a row from the QtyDocs table by primary key
*/

        SELECT gv_QtyDocs.*
        FROM gv_QtyDocs
        WHERE QtyDocCode = @QtyDocCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QtyDocs_Update] ( 
                @QtyDocCodeOriginal NVARCHAR(10) , 
                @QtyDocCode         NVARCHAR(10) , 
                @Description        NVARCHAR(4000) , 
                @CreateDate         DATETIME
                                      ) 
AS
    BEGIN

/*
** Update a row in the QtyDocs table using the primary key
*/

        UPDATE QtyDocs
               SET QtyDocCode = @QtyDocCode , Description = @Description , CreateDate = @CreateDate
        WHERE QtyDocCode = @QtyDocCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_QtyDocs.*
        FROM gv_QtyDocs
        WHERE QtyDocCode = @QtyDocCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickDirectory_Delete] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                             ) 
AS
    BEGIN

/*
** Delete a row from the QuickDirectory table
*/

        DELETE FROM QuickDirectory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the QuickDirectory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickDirectory_Insert] ( 
                @UserID         NVARCHAR(50) , 
                @IncludeSubDirs CHAR(1) , 
                @FQN            VARCHAR(254) , 
                @DB_ID          NVARCHAR(50) , 
                @VersionFiles   CHAR(1) , 
                @ckMetaData     NCHAR(1) , 
                @ckPublic       NCHAR(1) , 
                @ckDisableDir   NCHAR(1) , 
                @QuickRefEntry  BIT
                                             ) 
AS
    BEGIN

/*
** Add a row to the QuickDirectory table
*/

        INSERT INTO QuickDirectory ( UserID , IncludeSubDirs , FQN , DB_ID , VersionFiles , ckMetaData , ckPublic , ckDisableDir , QuickRefEntry
                                   ) 
        VALUES ( @UserID , @IncludeSubDirs , @FQN , @DB_ID , @VersionFiles , @ckMetaData , @ckPublic , @ckDisableDir , @QuickRefEntry
               );

/*
** Select the new row
*/

        SELECT gv_QuickDirectory.*
        FROM gv_QuickDirectory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickDirectory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the QuickDirectory table
*/

        SELECT gv_QuickDirectory.*
        FROM gv_QuickDirectory
        ORDER BY UserID , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_SelectByUserIDAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickDirectory_SelectByUserIDAndFQN] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                                           ) 
AS
    BEGIN

/*
** Select a row from the QuickDirectory table by primary key
*/

        SELECT gv_QuickDirectory.*
        FROM gv_QuickDirectory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickDirectory_Update] ( 
                @UserIDOriginal NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @FQNOriginal    VARCHAR(254) , 
                @FQN            VARCHAR(254) , 
                @IncludeSubDirs CHAR(1) , 
                @DB_ID          NVARCHAR(50) , 
                @VersionFiles   CHAR(1) , 
                @ckMetaData     NCHAR(1) , 
                @ckPublic       NCHAR(1) , 
                @ckDisableDir   NCHAR(1) , 
                @QuickRefEntry  BIT
                                             ) 
AS
    BEGIN

/*
** Update a row in the QuickDirectory table using the primary key
*/

        UPDATE QuickDirectory
               SET UserID = @UserID , IncludeSubDirs = @IncludeSubDirs , FQN = @FQN , DB_ID = @DB_ID , VersionFiles = @VersionFiles , ckMetaData = @ckMetaData , ckPublic = @ckPublic , ckDisableDir = @ckDisableDir , QuickRefEntry = @QuickRefEntry
        WHERE UserID = @UserIDOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_QuickDirectory.*
        FROM gv_QuickDirectory
        WHERE UserID = @UserIDOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_Delete] ( 
                @QuickRefIdNbr INT
                                       ) 
AS
    BEGIN

/*
** Delete a row from the QuickRef table
*/

        DELETE FROM QuickRef
        WHERE QuickRefIdNbr = @QuickRefIdNbr;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the QuickRef table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_Insert] ( 
                @UserID       NVARCHAR(50) , 
                @QuickRefName NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Add a row to the QuickRef table
*/

        INSERT INTO QuickRef ( UserID , QuickRefName
                             ) 
        VALUES ( @UserID , @QuickRefName
               );

/*
** Select the new row
*/

        SELECT gv_QuickRef.*
        FROM gv_QuickRef
        WHERE QuickRefIdNbr = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_SelectAll]
AS
    BEGIN

/*
** Select all rows from the QuickRef table
*/

        SELECT gv_QuickRef.*
        FROM gv_QuickRef
        ORDER BY QuickRefIdNbr;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectByQuickRefIdNbr]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_SelectByQuickRefIdNbr] ( 
                @QuickRefIdNbr INT
                                                      ) 
AS
    BEGIN

/*
** Select a row from the QuickRef table by primary key
*/

        SELECT gv_QuickRef.*
        FROM gv_QuickRef
        WHERE QuickRefIdNbr = @QuickRefIdNbr;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                               ) 
AS
    BEGIN

/*
** Select rows from the QuickRef table by UserID
*/

        SELECT gv_QuickRef.*
        FROM gv_QuickRef
        WHERE UserID = @UserID
        ORDER BY QuickRefIdNbr;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRef_Update] ( 
                @QuickRefIdNbrOriginal INT , 
                @UserID                NVARCHAR(50) , 
                @QuickRefName          NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Update a row in the QuickRef table using the primary key
*/

        UPDATE QuickRef
               SET UserID = @UserID , QuickRefName = @QuickRefName
        WHERE QuickRefIdNbr = @QuickRefIdNbrOriginal;

/*
** Select the updated row
*/

        SELECT gv_QuickRef.*
        FROM gv_QuickRef
        WHERE QuickRefIdNbr = @QuickRefIdNbrOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_Delete] ( 
                @QuickRefItemGuid NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the QuickRefItems table
*/

        DELETE FROM QuickRefItems
        WHERE QuickRefItemGuid = @QuickRefItemGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the QuickRefItems table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_Insert] ( 
                @QuickRefIdNbr         INT , 
                @FQN                   NVARCHAR(300) , 
                @QuickRefItemGuid      NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @Author                NVARCHAR(300) , 
                @Description           NVARCHAR(MAX) , 
                @Keywords              NVARCHAR(2000) , 
                @FileName              NVARCHAR(80) , 
                @DirName               NVARCHAR(254) , 
                @MarkedForDeletion     BIT
                                            ) 
AS
    BEGIN

/*
** Add a row to the QuickRefItems table
*/

        INSERT INTO QuickRefItems ( QuickRefIdNbr , FQN , QuickRefItemGuid , SourceGuid , DataSourceOwnerUserID , Author , Description , Keywords , FileName , DirName , MarkedForDeletion
                                  ) 
        VALUES ( @QuickRefIdNbr , @FQN , @QuickRefItemGuid , @SourceGuid , @DataSourceOwnerUserID , @Author , @Description , @Keywords , @FileName , @DirName , @MarkedForDeletion
               );

/*
** Select the new row
*/

        SELECT gv_QuickRefItems.*
        FROM gv_QuickRefItems
        WHERE QuickRefItemGuid = @QuickRefItemGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectAll]
AS
    BEGIN

/*
** Select all rows from the QuickRefItems table
*/

        SELECT gv_QuickRefItems.*
        FROM gv_QuickRefItems
        ORDER BY QuickRefItemGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectByQuickRefIdNbr]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectByQuickRefIdNbr] ( 
                @QuickRefIdNbr INT
                                                           ) 
AS
    BEGIN

/*
** Select rows from the QuickRefItems table by QuickRefIdNbr
*/

        SELECT gv_QuickRefItems.*
        FROM gv_QuickRefItems
        WHERE QuickRefIdNbr = @QuickRefIdNbr
        ORDER BY QuickRefItemGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectByQuickRefItemGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectByQuickRefItemGuid] ( 
                @QuickRefItemGuid NVARCHAR(50)
                                                              ) 
AS
    BEGIN

/*
** Select a row from the QuickRefItems table by primary key
*/

        SELECT gv_QuickRefItems.*
        FROM gv_QuickRefItems
        WHERE QuickRefItemGuid = @QuickRefItemGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_QuickRefItems_Update] ( 
                @QuickRefItemGuidOriginal NVARCHAR(50) , 
                @QuickRefItemGuid         NVARCHAR(50) , 
                @QuickRefIdNbr            INT , 
                @FQN                      NVARCHAR(300) , 
                @SourceGuid               NVARCHAR(50) , 
                @DataSourceOwnerUserID    NVARCHAR(50) , 
                @Author                   NVARCHAR(300) , 
                @Description              NVARCHAR(MAX) , 
                @Keywords                 NVARCHAR(2000) , 
                @FileName                 NVARCHAR(80) , 
                @DirName                  NVARCHAR(254) , 
                @MarkedForDeletion        BIT
                                            ) 
AS
    BEGIN

/*
** Update a row in the QuickRefItems table using the primary key
*/

        UPDATE QuickRefItems
               SET QuickRefIdNbr = @QuickRefIdNbr , FQN = @FQN , QuickRefItemGuid = @QuickRefItemGuid , SourceGuid = @SourceGuid , DataSourceOwnerUserID = @DataSourceOwnerUserID , Author = @Author , Description = @Description , Keywords = @Keywords , FileName = @FileName , DirName = @DirName , MarkedForDeletion = @MarkedForDeletion
        WHERE QuickRefItemGuid = @QuickRefItemGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_QuickRefItems.*
        FROM gv_QuickRefItems
        WHERE QuickRefItemGuid = @QuickRefItemGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_Delete] ( 
                @Recipient NVARCHAR(254) , 
                @EmailGuid NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the Recipients table
*/

        DELETE FROM Recipients
        WHERE Recipient = @Recipient
              AND 
              EmailGuid = @EmailGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Recipients table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_Insert] ( 
                @Recipient NVARCHAR(254) , 
                @EmailGuid NVARCHAR(50) , 
                @TypeRecp  NCHAR(10)
                                         ) 
AS
    BEGIN

/*
** Add a row to the Recipients table
*/

        INSERT INTO Recipients ( Recipient , EmailGuid , TypeRecp
                               ) 
        VALUES ( @Recipient , @EmailGuid , @TypeRecp
               );

/*
** Select the new row
*/

        SELECT gv_Recipients.*
        FROM gv_Recipients
        WHERE Recipient = @Recipient
              AND 
              EmailGuid = @EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Recipients table
*/

        SELECT gv_Recipients.*
        FROM gv_Recipients
        ORDER BY Recipient , EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectByEmailGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_SelectByEmailGuid] ( 
                @EmailGuid NVARCHAR(50)
                                                    ) 
AS
    BEGIN

/*
** Select rows from the Recipients table by EmailGuid
*/

        SELECT gv_Recipients.*
        FROM gv_Recipients
        WHERE EmailGuid = @EmailGuid
        ORDER BY Recipient , EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectByRecipientAndEmailGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_SelectByRecipientAndEmailGuid] ( 
                @Recipient NVARCHAR(254) , 
                @EmailGuid NVARCHAR(50)
                                                                ) 
AS
    BEGIN

/*
** Select a row from the Recipients table by primary key
*/

        SELECT gv_Recipients.*
        FROM gv_Recipients
        WHERE Recipient = @Recipient
              AND 
              EmailGuid = @EmailGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Recipients_Update] ( 
                @RecipientOriginal NVARCHAR(254) , 
                @Recipient         NVARCHAR(254) , 
                @EmailGuidOriginal NVARCHAR(50) , 
                @EmailGuid         NVARCHAR(50) , 
                @TypeRecp          NCHAR(10)
                                         ) 
AS
    BEGIN

/*
** Update a row in the Recipients table using the primary key
*/

        UPDATE Recipients
               SET Recipient = @Recipient , EmailGuid = @EmailGuid , TypeRecp = @TypeRecp
        WHERE Recipient = @RecipientOriginal
              AND 
              EmailGuid = @EmailGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_Recipients.*
        FROM gv_Recipients
        WHERE Recipient = @RecipientOriginal
              AND 
              EmailGuid = @EmailGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RepeatData_Delete] ( 
                @RepeatDataCode NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the RepeatData table
*/

        DELETE FROM RepeatData
        WHERE RepeatDataCode = @RepeatDataCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the RepeatData table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RepeatData_Insert] ( 
                @RepeatDataCode NVARCHAR(50) , 
                @RepeatDataDesc NVARCHAR(4000)
                                         ) 
AS
    BEGIN

/*
** Add a row to the RepeatData table
*/

        INSERT INTO RepeatData ( RepeatDataCode , RepeatDataDesc
                               ) 
        VALUES ( @RepeatDataCode , @RepeatDataDesc
               );

/*
** Select the new row
*/

        SELECT gv_RepeatData.*
        FROM gv_RepeatData
        WHERE RepeatDataCode = @RepeatDataCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RepeatData_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RepeatData table
*/

        SELECT gv_RepeatData.*
        FROM gv_RepeatData
        ORDER BY RepeatDataCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_SelectByRepeatDataCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RepeatData_SelectByRepeatDataCode] ( 
                @RepeatDataCode NVARCHAR(50)
                                                         ) 
AS
    BEGIN

/*
** Select a row from the RepeatData table by primary key
*/

        SELECT gv_RepeatData.*
        FROM gv_RepeatData
        WHERE RepeatDataCode = @RepeatDataCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RepeatData_Update] ( 
                @RepeatDataCodeOriginal NVARCHAR(50) , 
                @RepeatDataCode         NVARCHAR(50) , 
                @RepeatDataDesc         NVARCHAR(4000)
                                         ) 
AS
    BEGIN

/*
** Update a row in the RepeatData table using the primary key
*/

        UPDATE RepeatData
               SET RepeatDataCode = @RepeatDataCode , RepeatDataDesc = @RepeatDataDesc
        WHERE RepeatDataCode = @RepeatDataCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_RepeatData.*
        FROM gv_RepeatData
        WHERE RepeatDataCode = @RepeatDataCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RestorationHistory_Insert] ( 
                @SourceType      NVARCHAR(50) , 
                @SourceGuid      NVARCHAR(50) , 
                @OriginalCrc     NVARCHAR(50) , 
                @RestoredCrc     NVARCHAR(50) , 
                @RestorationDate NCHAR(10) , 
                @RestoredBy      NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Add a row to the RestorationHistory table
*/

        INSERT INTO RestorationHistory ( SourceType , SourceGuid , OriginalCrc , RestoredCrc , RestorationDate , RestoredBy
                                       ) 
        VALUES ( @SourceType , @SourceGuid , @OriginalCrc , @RestoredCrc , @RestorationDate , @RestoredBy
               );

/*
** Select the new row
*/

        SELECT gv_RestorationHistory.*
        FROM gv_RestorationHistory;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RestorationHistory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RestorationHistory table
*/

        SELECT gv_RestorationHistory.*
        FROM gv_RestorationHistory;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_RestorationHistory_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Retention_Delete] ( 
                @RetentionCode NVARCHAR(50)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the Retention table
*/

        DELETE FROM Retention
        WHERE RetentionCode = @RetentionCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Retention table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Retention_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Retention table
*/

        SELECT gv_Retention.*
        FROM gv_Retention
        ORDER BY RetentionCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_SelectByRetentionCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Retention_SelectByRetentionCode] ( 
                @RetentionCode NVARCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Select a row from the Retention table by primary key
*/

        SELECT gv_Retention.*
        FROM gv_Retention
        WHERE RetentionCode = @RetentionCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RetentionTemp_Delete] ( 
                @ContentGuid NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Delete a row from the RetentionTemp table
*/

        DELETE FROM RetentionTemp
        WHERE ContentGuid = @ContentGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the RetentionTemp table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RetentionTemp_Insert] ( 
                @UserID      NVARCHAR(50) , 
                @ContentGuid NVARCHAR(50) , 
                @TypeContent NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the RetentionTemp table
*/

        INSERT INTO RetentionTemp ( UserID , ContentGuid , TypeContent
                                  ) 
        VALUES ( @UserID , @ContentGuid , @TypeContent
               );

/*
** Select the new row
*/

        SELECT gv_RetentionTemp.*
        FROM gv_RetentionTemp
        WHERE ContentGuid = @ContentGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RetentionTemp_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RetentionTemp table
*/

        SELECT gv_RetentionTemp.*
        FROM gv_RetentionTemp
        ORDER BY ContentGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_SelectByContentGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RetentionTemp_SelectByContentGuid] ( 
                @ContentGuid NVARCHAR(50)
                                                         ) 
AS
    BEGIN

/*
** Select a row from the RetentionTemp table by primary key
*/

        SELECT gv_RetentionTemp.*
        FROM gv_RetentionTemp
        WHERE ContentGuid = @ContentGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RetentionTemp_Update] ( 
                @ContentGuidOriginal NVARCHAR(50) , 
                @ContentGuid         NVARCHAR(50) , 
                @UserID              NVARCHAR(50) , 
                @TypeContent         NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Update a row in the RetentionTemp table using the primary key
*/

        UPDATE RetentionTemp
               SET UserID = @UserID , ContentGuid = @ContentGuid , TypeContent = @TypeContent
        WHERE ContentGuid = @ContentGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_RetentionTemp.*
        FROM gv_RetentionTemp
        WHERE ContentGuid = @ContentGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RiskLevel_Insert] ( 
                @RiskCode    CHAR(10) , 
                @Description NVARCHAR(4000) , 
                @CreateDate  DATETIME
                                        ) 
AS
    BEGIN

/*
** Add a row to the RiskLevel table
*/

        INSERT INTO RiskLevel ( RiskCode , Description , CreateDate
                              ) 
        VALUES ( @RiskCode , @Description , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_RiskLevel.*
        FROM gv_RiskLevel;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RiskLevel_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RiskLevel table
*/

        SELECT gv_RiskLevel.*
        FROM gv_RiskLevel;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_RiskLevel_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RunParms_Delete] ( 
                @Parm   NVARCHAR(50) , 
                @UserID NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Delete a row from the RunParms table
*/

        DELETE FROM RunParms
        WHERE Parm = @Parm
              AND 
              UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the RunParms table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RunParms_Insert] ( 
                @Parm      NVARCHAR(50) , 
                @ParmValue NVARCHAR(50) , 
                @UserID    NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Add a row to the RunParms table
*/

        INSERT INTO RunParms ( Parm , ParmValue , UserID
                             ) 
        VALUES ( @Parm , @ParmValue , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_RunParms.*
        FROM gv_RunParms
        WHERE Parm = @Parm
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RunParms_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RunParms table
*/

        SELECT gv_RunParms.*
        FROM gv_RunParms
        ORDER BY Parm , UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_SelectByParmAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RunParms_SelectByParmAndUserID] ( 
                @Parm   NVARCHAR(50) , 
                @UserID NVARCHAR(50)
                                                      ) 
AS
    BEGIN

/*
** Select a row from the RunParms table by primary key
*/

        SELECT gv_RunParms.*
        FROM gv_RunParms
        WHERE Parm = @Parm
              AND 
              UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RunParms_Update] ( 
                @ParmOriginal   NVARCHAR(50) , 
                @Parm           NVARCHAR(50) , 
                @UserIDOriginal NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @ParmValue      NVARCHAR(50)
                                       ) 
AS
    BEGIN

/*
** Update a row in the RunParms table using the primary key
*/

        UPDATE RunParms
               SET Parm = @Parm , ParmValue = @ParmValue , UserID = @UserID
        WHERE Parm = @ParmOriginal
              AND 
              UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_RunParms.*
        FROM gv_RunParms
        WHERE Parm = @ParmOriginal
              AND 
              UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RuntimeErrors_Insert] ( 
                @ErrorMsg       NVARCHAR(MAX) , 
                @StackTrace     NVARCHAR(MAX) , 
                @EntryDate      DATETIME , 
                @IdNbr          NVARCHAR(50) , 
                @ConnectiveGuid NVARCHAR(50) , 
                @UserID         NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the RuntimeErrors table
*/

        INSERT INTO RuntimeErrors ( ErrorMsg , StackTrace , EntryDate , IdNbr , ConnectiveGuid , UserID
                                  ) 
        VALUES ( @ErrorMsg , @StackTrace , @EntryDate , @IdNbr , @ConnectiveGuid , @UserID
               );

/*
** Select the new row
*/

        SELECT gv_RuntimeErrors.*
        FROM gv_RuntimeErrors;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_RuntimeErrors_SelectAll]
AS
    BEGIN

/*
** Select all rows from the RuntimeErrors table
*/

        SELECT gv_RuntimeErrors.*
        FROM gv_RuntimeErrors;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_RuntimeErrors_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SavedItems_Delete] ( 
                @Userid       NVARCHAR(50) , 
                @SaveName     NVARCHAR(50) , 
                @SaveTypeCode NVARCHAR(50) , 
                @ValName      NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the SavedItems table
*/

        DELETE FROM SavedItems
        WHERE Userid = @Userid
              AND 
              SaveName = @SaveName
              AND 
              SaveTypeCode = @SaveTypeCode
              AND 
              ValName = @ValName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SavedItems table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SavedItems_Insert] ( 
                @Userid       NVARCHAR(50) , 
                @SaveName     NVARCHAR(50) , 
                @SaveTypeCode NVARCHAR(50) , 
                @ValName      NVARCHAR(50) , 
                @ValValue     NVARCHAR(254)
                                         ) 
AS
    BEGIN

/*
** Add a row to the SavedItems table
*/

        INSERT INTO SavedItems ( Userid , SaveName , SaveTypeCode , ValName , ValValue
                               ) 
        VALUES ( @Userid , @SaveName , @SaveTypeCode , @ValName , @ValValue
               );

/*
** Select the new row
*/

        SELECT gv_SavedItems.*
        FROM gv_SavedItems
        WHERE Userid = @Userid
              AND 
              SaveName = @SaveName
              AND 
              SaveTypeCode = @SaveTypeCode
              AND 
              ValName = @ValName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SavedItems_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SavedItems table
*/

        SELECT gv_SavedItems.*
        FROM gv_SavedItems
        ORDER BY Userid , SaveName , SaveTypeCode , ValName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_SelectByUseridAndSaveNameAndSaveTypeCodeAndValName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SavedItems_SelectByUseridAndSaveNameAndSaveTypeCodeAndValName] ( 
                @Userid       NVARCHAR(50) , 
                @SaveName     NVARCHAR(50) , 
                @SaveTypeCode NVARCHAR(50) , 
                @ValName      NVARCHAR(50)
                                                                                     ) 
AS
    BEGIN

/*
** Select a row from the SavedItems table by primary key
*/

        SELECT gv_SavedItems.*
        FROM gv_SavedItems
        WHERE Userid = @Userid
              AND 
              SaveName = @SaveName
              AND 
              SaveTypeCode = @SaveTypeCode
              AND 
              ValName = @ValName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SavedItems_Update] ( 
                @UseridOriginal       NVARCHAR(50) , 
                @Userid               NVARCHAR(50) , 
                @SaveNameOriginal     NVARCHAR(50) , 
                @SaveName             NVARCHAR(50) , 
                @SaveTypeCodeOriginal NVARCHAR(50) , 
                @SaveTypeCode         NVARCHAR(50) , 
                @ValNameOriginal      NVARCHAR(50) , 
                @ValName              NVARCHAR(50) , 
                @ValValue             NVARCHAR(254)
                                         ) 
AS
    BEGIN

/*
** Update a row in the SavedItems table using the primary key
*/

        UPDATE SavedItems
               SET Userid = @Userid , SaveName = @SaveName , SaveTypeCode = @SaveTypeCode , ValName = @ValName , ValValue = @ValValue
        WHERE Userid = @UseridOriginal
              AND 
              SaveName = @SaveNameOriginal
              AND 
              SaveTypeCode = @SaveTypeCodeOriginal
              AND 
              ValName = @ValNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_SavedItems.*
        FROM gv_SavedItems
        WHERE Userid = @UseridOriginal
              AND 
              SaveName = @SaveNameOriginal
              AND 
              SaveTypeCode = @SaveTypeCodeOriginal
              AND 
              ValName = @ValNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearchHistory_Delete] ( 
                @RowID INT
                                            ) 
AS
    BEGIN

/*
** Delete a row from the SearchHistory table
*/

        DELETE FROM SearchHistory
        WHERE RowID = @RowID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SearchHistory table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearchHistory_Insert] ( 
                @SearchSql    NVARCHAR(MAX) , 
                @SearchDate   DATETIME , 
                @UserID       NVARCHAR(50) , 
                @ReturnedRows INT , 
                @StartTime    DATETIME , 
                @EndTime      DATETIME , 
                @CalledFrom   NVARCHAR(50) , 
                @TypeSearch   NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Add a row to the SearchHistory table
*/

        INSERT INTO SearchHistory ( SearchSql , SearchDate , UserID , ReturnedRows , StartTime , EndTime , CalledFrom , TypeSearch
                                  ) 
        VALUES ( @SearchSql , @SearchDate , @UserID , @ReturnedRows , @StartTime , @EndTime , @CalledFrom , @TypeSearch
               );

/*
** Select the new row
*/

        SELECT gv_SearchHistory.*
        FROM gv_SearchHistory
        WHERE RowID = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearchHistory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SearchHistory table
*/

        SELECT gv_SearchHistory.*
        FROM gv_SearchHistory
        ORDER BY RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_SelectByRowID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearchHistory_SelectByRowID] ( 
                @RowID INT
                                                   ) 
AS
    BEGIN

/*
** Select a row from the SearchHistory table by primary key
*/

        SELECT gv_SearchHistory.*
        FROM gv_SearchHistory
        WHERE RowID = @RowID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearchHistory_Update] ( 
                @RowIDOriginal INT , 
                @SearchSql     NVARCHAR(MAX) , 
                @SearchDate    DATETIME , 
                @UserID        NVARCHAR(50) , 
                @ReturnedRows  INT , 
                @StartTime     DATETIME , 
                @EndTime       DATETIME , 
                @CalledFrom    NVARCHAR(50) , 
                @TypeSearch    NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Update a row in the SearchHistory table using the primary key
*/

        UPDATE SearchHistory
               SET SearchSql = @SearchSql , SearchDate = @SearchDate , UserID = @UserID , ReturnedRows = @ReturnedRows , StartTime = @StartTime , EndTime = @EndTime , CalledFrom = @CalledFrom , TypeSearch = @TypeSearch
        WHERE RowID = @RowIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_SearchHistory.*
        FROM gv_SearchHistory
        WHERE RowID = @RowIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_Insert] ( 
                @UserID     NVARCHAR(50) , 
                @SearchDate DATETIME , 
                @Screen     NVARCHAR(50) , 
                @QryParms   NVARCHAR(MAX)
                                                ) 
AS
    BEGIN

/*
** Add a row to the SearhParmsHistory table
*/

        INSERT INTO SearhParmsHistory ( UserID , SearchDate , Screen , QryParms
                                      ) 
        VALUES ( @UserID , @SearchDate , @Screen , @QryParms
               );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SearhParmsHistory table
*/

        SELECT gv_SearhParmsHistory.*
        FROM gv_SearhParmsHistory;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SkipWords_Delete] ( 
                @tgtWord NVARCHAR(18)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the SkipWords table
*/

        DELETE FROM SkipWords
        WHERE tgtWord = @tgtWord;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SkipWords table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SkipWords_Insert] ( 
                @tgtWord NVARCHAR(18)
                                        ) 
AS
    BEGIN

/*
** Add a row to the SkipWords table
*/

        INSERT INTO SkipWords ( tgtWord
                              ) 
        VALUES ( @tgtWord
               );

/*
** Select the new row
*/

        SELECT gv_SkipWords.*
        FROM gv_SkipWords
        WHERE tgtWord = @tgtWord;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SkipWords_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SkipWords table
*/

        SELECT gv_SkipWords.*
        FROM gv_SkipWords
        ORDER BY tgtWord;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_SelectBytgtWord]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SkipWords_SelectBytgtWord] ( 
                @tgtWord NVARCHAR(18)
                                                 ) 
AS
    BEGIN

/*
** Select a row from the SkipWords table by primary key
*/

        SELECT gv_SkipWords.*
        FROM gv_SkipWords
        WHERE tgtWord = @tgtWord;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SkipWords_Update] ( 
                @tgtWordOriginal NVARCHAR(18) , 
                @tgtWord         NVARCHAR(18)
                                        ) 
AS
    BEGIN

/*
** Update a row in the SkipWords table using the primary key
*/

        UPDATE SkipWords
               SET tgtWord = @tgtWord
        WHERE tgtWord = @tgtWordOriginal;

/*
** Select the updated row
*/

        SELECT gv_SkipWords.*
        FROM gv_SkipWords
        WHERE tgtWord = @tgtWordOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceAttribute_Delete] ( 
                @AttributeName         NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Delete a row from the SourceAttribute table
*/

        DELETE FROM SourceAttribute
        WHERE AttributeName = @AttributeName
              AND 
              SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SourceAttribute table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceAttribute_Insert] ( 
                @AttributeValue        NVARCHAR(254) , 
                @AttributeName         NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @SourceTypeCode        NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Add a row to the SourceAttribute table
*/

        INSERT INTO SourceAttribute ( AttributeValue , AttributeName , SourceGuid , DataSourceOwnerUserID , SourceTypeCode
                                    ) 
        VALUES ( @AttributeValue , @AttributeName , @SourceGuid , @DataSourceOwnerUserID , @SourceTypeCode
               );

/*
** Select the new row
*/

        SELECT gv_SourceAttribute.*
        FROM gv_SourceAttribute
        WHERE AttributeName = @AttributeName
              AND 
              SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceAttribute_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SourceAttribute table
*/

        SELECT gv_SourceAttribute.*
        FROM gv_SourceAttribute
        ORDER BY AttributeName , SourceGuid , DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_SelectByAttributeNameAndSourceGuidAndDataSourceOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceAttribute_SelectByAttributeNameAndSourceGuidAndDataSourceOwnerUserID] ( 
                @AttributeName         NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                                                                                  ) 
AS
    BEGIN

/*
** Select a row from the SourceAttribute table by primary key
*/

        SELECT gv_SourceAttribute.*
        FROM gv_SourceAttribute
        WHERE AttributeName = @AttributeName
              AND 
              SourceGuid = @SourceGuid
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceAttribute_Update] ( 
                @AttributeNameOriginal         NVARCHAR(50) , 
                @AttributeName                 NVARCHAR(50) , 
                @SourceGuidOriginal            NVARCHAR(50) , 
                @SourceGuid                    NVARCHAR(50) , 
                @DataSourceOwnerUserIDOriginal NVARCHAR(50) , 
                @DataSourceOwnerUserID         NVARCHAR(50) , 
                @AttributeValue                NVARCHAR(254) , 
                @SourceTypeCode                NVARCHAR(50)
                                              ) 
AS
    BEGIN

/*
** Update a row in the SourceAttribute table using the primary key
*/

        UPDATE SourceAttribute
               SET AttributeValue = @AttributeValue , AttributeName = @AttributeName , SourceGuid = @SourceGuid , DataSourceOwnerUserID = @DataSourceOwnerUserID , SourceTypeCode = @SourceTypeCode
        WHERE AttributeName = @AttributeNameOriginal
              AND 
              SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_SourceAttribute.*
        FROM gv_SourceAttribute
        WHERE AttributeName = @AttributeNameOriginal
              AND 
              SourceGuid = @SourceGuidOriginal
              AND 
              DataSourceOwnerUserID = @DataSourceOwnerUserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceContainer_Delete] ( 
                @ContainerType NVARCHAR(25)
                                              ) 
AS
    BEGIN

/*
** Delete a row from the SourceContainer table
*/

        DELETE FROM SourceContainer
        WHERE ContainerType = @ContainerType;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SourceContainer table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceContainer_Insert] ( 
                @ContainerType NVARCHAR(25) , 
                @ContainerDesc NVARCHAR(4000) , 
                @CreateDate    DATETIME
                                              ) 
AS
    BEGIN

/*
** Add a row to the SourceContainer table
*/

        INSERT INTO SourceContainer ( ContainerType , ContainerDesc , CreateDate
                                    ) 
        VALUES ( @ContainerType , @ContainerDesc , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_SourceContainer.*
        FROM gv_SourceContainer
        WHERE ContainerType = @ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceContainer_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SourceContainer table
*/

        SELECT gv_SourceContainer.*
        FROM gv_SourceContainer
        ORDER BY ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_SelectByContainerType]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceContainer_SelectByContainerType] ( 
                @ContainerType NVARCHAR(25)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the SourceContainer table by primary key
*/

        SELECT gv_SourceContainer.*
        FROM gv_SourceContainer
        WHERE ContainerType = @ContainerType;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceContainer_Update] ( 
                @ContainerTypeOriginal NVARCHAR(25) , 
                @ContainerType         NVARCHAR(25) , 
                @ContainerDesc         NVARCHAR(4000) , 
                @CreateDate            DATETIME
                                              ) 
AS
    BEGIN

/*
** Update a row in the SourceContainer table using the primary key
*/

        UPDATE SourceContainer
               SET ContainerType = @ContainerType , ContainerDesc = @ContainerDesc , CreateDate = @CreateDate
        WHERE ContainerType = @ContainerTypeOriginal;

/*
** Select the updated row
*/

        SELECT gv_SourceContainer.*
        FROM gv_SourceContainer
        WHERE ContainerType = @ContainerTypeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceType_Delete] ( 
                @SourceTypeCode NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the SourceType table
*/

        DELETE FROM SourceType
        WHERE SourceTypeCode = @SourceTypeCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SourceType table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceType_Insert] ( 
                @SourceTypeCode NVARCHAR(50) , 
                @StoreExternal  BIT , 
                @SourceTypeDesc NVARCHAR(254) , 
                @Indexable      BIT
                                         ) 
AS
    BEGIN

/*
** Add a row to the SourceType table
*/

        INSERT INTO SourceType ( SourceTypeCode , StoreExternal , SourceTypeDesc , Indexable
                               ) 
        VALUES ( @SourceTypeCode , @StoreExternal , @SourceTypeDesc , @Indexable
               );

/*
** Select the new row
*/

        SELECT gv_SourceType.*
        FROM gv_SourceType
        WHERE SourceTypeCode = @SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceType_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SourceType table
*/

        SELECT gv_SourceType.*
        FROM gv_SourceType
        ORDER BY SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_SelectBySourceTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceType_SelectBySourceTypeCode] ( 
                @SourceTypeCode NVARCHAR(50)
                                                         ) 
AS
    BEGIN

/*
** Select a row from the SourceType table by primary key
*/

        SELECT gv_SourceType.*
        FROM gv_SourceType
        WHERE SourceTypeCode = @SourceTypeCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SourceType_Update] ( 
                @SourceTypeCodeOriginal NVARCHAR(50) , 
                @SourceTypeCode         NVARCHAR(50) , 
                @StoreExternal          BIT , 
                @SourceTypeDesc         NVARCHAR(254) , 
                @Indexable              BIT
                                         ) 
AS
    BEGIN

/*
** Update a row in the SourceType table using the primary key
*/

        UPDATE SourceType
               SET SourceTypeCode = @SourceTypeCode , StoreExternal = @StoreExternal , SourceTypeDesc = @SourceTypeDesc , Indexable = @Indexable
        WHERE SourceTypeCode = @SourceTypeCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_SourceType.*
        FROM gv_SourceType
        WHERE SourceTypeCode = @SourceTypeCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Storage_Delete] ( 
                @StoreCode NVARCHAR(50)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the Storage table
*/

        DELETE FROM Storage
        WHERE StoreCode = @StoreCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Storage table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Storage_Insert] ( 
                @StoreCode  NVARCHAR(50) , 
                @StoreDesc  NVARCHAR(18) , 
                @CreateDate DATETIME
                                      ) 
AS
    BEGIN

/*
** Add a row to the Storage table
*/

        INSERT INTO Storage ( StoreCode , StoreDesc , CreateDate
                            ) 
        VALUES ( @StoreCode , @StoreDesc , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_Storage.*
        FROM gv_Storage
        WHERE StoreCode = @StoreCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Storage_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Storage table
*/

        SELECT gv_Storage.*
        FROM gv_Storage
        ORDER BY StoreCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_SelectByStoreCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Storage_SelectByStoreCode] ( 
                @StoreCode NVARCHAR(50)
                                                 ) 
AS
    BEGIN

/*
** Select a row from the Storage table by primary key
*/

        SELECT gv_Storage.*
        FROM gv_Storage
        WHERE StoreCode = @StoreCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Storage_Update] ( 
                @StoreCodeOriginal NVARCHAR(50) , 
                @StoreCode         NVARCHAR(50) , 
                @StoreDesc         NVARCHAR(18) , 
                @CreateDate        DATETIME
                                      ) 
AS
    BEGIN

/*
** Update a row in the Storage table using the primary key
*/

        UPDATE Storage
               SET StoreCode = @StoreCode , StoreDesc = @StoreDesc , CreateDate = @CreateDate
        WHERE StoreCode = @StoreCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_Storage.*
        FROM gv_Storage
        WHERE StoreCode = @StoreCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_Delete] ( 
                @UserID NVARCHAR(50) , 
                @SUBFQN NVARCHAR(254) , 
                @FQN    VARCHAR(254)
                                     ) 
AS
    BEGIN

/*
** Delete a row from the SubDir table
*/

        DELETE FROM SubDir
        WHERE UserID = @UserID
              AND 
              SUBFQN = @SUBFQN
              AND 
              FQN = @FQN;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SubDir table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_Insert] ( 
                @UserID       NVARCHAR(50) , 
                @SUBFQN       NVARCHAR(254) , 
                @FQN          VARCHAR(254) , 
                @ckPublic     NCHAR(1) , 
                @ckDisableDir NCHAR(1) , 
                @OcrDirectory NCHAR(1) , 
                @VersionFiles NCHAR(1) , 
                @isSysDefault BIT
                                     ) 
AS
    BEGIN

/*
** Add a row to the SubDir table
*/

        INSERT INTO SubDir ( UserID , SUBFQN , FQN , ckPublic , ckDisableDir , OcrDirectory , VersionFiles , isSysDefault
                           ) 
        VALUES ( @UserID , @SUBFQN , @FQN , @ckPublic , @ckDisableDir , @OcrDirectory , @VersionFiles , @isSysDefault
               );

/*
** Select the new row
*/

        SELECT gv_SubDir.*
        FROM gv_SubDir
        WHERE UserID = @UserID
              AND 
              SUBFQN = @SUBFQN
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SubDir table
*/

        SELECT gv_SubDir.*
        FROM gv_SubDir
        ORDER BY UserID , SUBFQN , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectByFQNAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_SelectByFQNAndUserID] ( 
                @FQN    VARCHAR(254) , 
                @UserID NVARCHAR(50)
                                                   ) 
AS
    BEGIN

/*
** Select rows from the SubDir table by FQN and UserID
*/

        SELECT gv_SubDir.*
        FROM gv_SubDir
        WHERE FQN = @FQN
              AND 
              UserID = @UserID
        ORDER BY UserID , SUBFQN , FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectByUserIDAndSUBFQNAndFQN]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_SelectByUserIDAndSUBFQNAndFQN] ( 
                @UserID NVARCHAR(50) , 
                @SUBFQN NVARCHAR(254) , 
                @FQN    VARCHAR(254)
                                                            ) 
AS
    BEGIN

/*
** Select a row from the SubDir table by primary key
*/

        SELECT gv_SubDir.*
        FROM gv_SubDir
        WHERE UserID = @UserID
              AND 
              SUBFQN = @SUBFQN
              AND 
              FQN = @FQN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubDir_Update] ( 
                @UserIDOriginal NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @SUBFQNOriginal NVARCHAR(254) , 
                @SUBFQN         NVARCHAR(254) , 
                @FQNOriginal    VARCHAR(254) , 
                @FQN            VARCHAR(254) , 
                @ckPublic       NCHAR(1) , 
                @ckDisableDir   NCHAR(1) , 
                @OcrDirectory   NCHAR(1) , 
                @VersionFiles   NCHAR(1) , 
                @isSysDefault   BIT
                                     ) 
AS
    BEGIN

/*
** Update a row in the SubDir table using the primary key
*/

        UPDATE SubDir
               SET UserID = @UserID , SUBFQN = @SUBFQN , FQN = @FQN , ckPublic = @ckPublic , ckDisableDir = @ckDisableDir , OcrDirectory = @OcrDirectory , VersionFiles = @VersionFiles , isSysDefault = @isSysDefault
        WHERE UserID = @UserIDOriginal
              AND 
              SUBFQN = @SUBFQNOriginal
              AND 
              FQN = @FQNOriginal;

/*
** Select the updated row
*/

        SELECT gv_SubDir.*
        FROM gv_SubDir
        WHERE UserID = @UserIDOriginal
              AND 
              SUBFQN = @SUBFQNOriginal
              AND 
              FQN = @FQNOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_Delete] ( 
                @UserID         NVARCHAR(50) , 
                @SubUserID      NVARCHAR(50) , 
                @LibraryName    NVARCHAR(80) , 
                @SubLibraryName NVARCHAR(80)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the SubLibrary table
*/

        DELETE FROM SubLibrary
        WHERE UserID = @UserID
              AND 
              SubUserID = @SubUserID
              AND 
              LibraryName = @LibraryName
              AND 
              SubLibraryName = @SubLibraryName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SubLibrary table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_Insert] ( 
                @UserID         NVARCHAR(50) , 
                @SubUserID      NVARCHAR(50) , 
                @LibraryName    NVARCHAR(80) , 
                @SubLibraryName NVARCHAR(80)
                                         ) 
AS
    BEGIN

/*
** Add a row to the SubLibrary table
*/

        INSERT INTO SubLibrary ( UserID , SubUserID , LibraryName , SubLibraryName
                               ) 
        VALUES ( @UserID , @SubUserID , @LibraryName , @SubLibraryName
               );

/*
** Select the new row
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        WHERE UserID = @UserID
              AND 
              SubUserID = @SubUserID
              AND 
              LibraryName = @LibraryName
              AND 
              SubLibraryName = @SubLibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SubLibrary table
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        ORDER BY UserID , SubUserID , LibraryName , SubLibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectByLibraryNameAndUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectByLibraryNameAndUserID] ( 
                @LibraryName NVARCHAR(80) , 
                @UserID      NVARCHAR(50)
                                                               ) 
AS
    BEGIN

/*
** Select rows from the SubLibrary table by LibraryName and UserID
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        WHERE LibraryName = @LibraryName
              AND 
              UserID = @UserID
        ORDER BY UserID , SubUserID , LibraryName , SubLibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectBySubLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectBySubLibraryName] ( 
                @SubLibraryName NVARCHAR(80)
                                                         ) 
AS
    BEGIN

/*
** Select rows from the SubLibrary table by SubLibraryName
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        WHERE SubLibraryName = @SubLibraryName
        ORDER BY UserID , SubUserID , LibraryName , SubLibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectByUserIDAndSubUserIDAndLibraryNameAndSubLibraryName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectByUserIDAndSubUserIDAndLibraryNameAndSubLibraryName] ( 
                @UserID         NVARCHAR(50) , 
                @SubUserID      NVARCHAR(50) , 
                @LibraryName    NVARCHAR(80) , 
                @SubLibraryName NVARCHAR(80)
                                                                                            ) 
AS
    BEGIN

/*
** Select a row from the SubLibrary table by primary key
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        WHERE UserID = @UserID
              AND 
              SubUserID = @SubUserID
              AND 
              LibraryName = @LibraryName
              AND 
              SubLibraryName = @SubLibraryName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SubLibrary_Update] ( 
                @UserIDOriginal         NVARCHAR(50) , 
                @UserID                 NVARCHAR(50) , 
                @SubUserIDOriginal      NVARCHAR(50) , 
                @SubUserID              NVARCHAR(50) , 
                @LibraryNameOriginal    NVARCHAR(80) , 
                @LibraryName            NVARCHAR(80) , 
                @SubLibraryNameOriginal NVARCHAR(80) , 
                @SubLibraryName         NVARCHAR(80)
                                         ) 
AS
    BEGIN

/*
** Update a row in the SubLibrary table using the primary key
*/

        UPDATE SubLibrary
               SET UserID = @UserID , SubUserID = @SubUserID , LibraryName = @LibraryName , SubLibraryName = @SubLibraryName
        WHERE UserID = @UserIDOriginal
              AND 
              SubUserID = @SubUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal
              AND 
              SubLibraryName = @SubLibraryNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_SubLibrary.*
        FROM gv_SubLibrary
        WHERE UserID = @UserIDOriginal
              AND 
              SubUserID = @SubUserIDOriginal
              AND 
              LibraryName = @LibraryNameOriginal
              AND 
              SubLibraryName = @SubLibraryNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_sysdiagrams_Delete] ( 
                @diagram_id INT
                                          ) 
AS
    BEGIN

/*
** Delete a row from the sysdiagrams table
*/

        DELETE FROM sysdiagrams
        WHERE diagram_id = @diagram_id;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the sysdiagrams table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_sysdiagrams_Insert] ( 
                @name         NVARCHAR(128) , 
                @principal_id INT , 
                @version      INT , 
                @definition   VARBINARY(MAX)
                                          ) 
AS
    BEGIN

/*
** Add a row to the sysdiagrams table
*/

        INSERT INTO sysdiagrams ( name , principal_id , version , definition
                                ) 
        VALUES ( @name , @principal_id , @version , @definition
               );

/*
** Select the new row
*/

        SELECT gv_sysdiagrams.*
        FROM gv_sysdiagrams
        WHERE diagram_id = ( SELECT SCOPE_IDENTITY() );
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_sysdiagrams_SelectAll]
AS
    BEGIN

/*
** Select all rows from the sysdiagrams table
*/

        SELECT gv_sysdiagrams.*
        FROM gv_sysdiagrams
        ORDER BY diagram_id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_SelectBydiagram_id]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_sysdiagrams_SelectBydiagram_id] ( 
                @diagram_id INT
                                                      ) 
AS
    BEGIN

/*
** Select a row from the sysdiagrams table by primary key
*/

        SELECT gv_sysdiagrams.*
        FROM gv_sysdiagrams
        WHERE diagram_id = @diagram_id;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_sysdiagrams_Update] ( 
                @diagram_idOriginal INT , 
                @name               NVARCHAR(128) , 
                @principal_id       INT , 
                @version            INT , 
                @definition         VARBINARY(MAX)
                                          ) 
AS
    BEGIN

/*
** Update a row in the sysdiagrams table using the primary key
*/

        UPDATE sysdiagrams
               SET name = @name , principal_id = @principal_id , version = @version , definition = @definition
        WHERE diagram_id = @diagram_idOriginal;

/*
** Select the updated row
*/

        SELECT gv_sysdiagrams.*
        FROM gv_sysdiagrams
        WHERE diagram_id = @diagram_idOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SystemParms_Delete] ( 
                @SysParm NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the SystemParms table
*/

        DELETE FROM SystemParms
        WHERE SysParm = @SysParm;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the SystemParms table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SystemParms_Insert] ( 
                @SysParm       NVARCHAR(50) , 
                @SysParmDesc   NVARCHAR(250) , 
                @SysParmVal    NVARCHAR(250) , 
                @flgActive     NCHAR(1) , 
                @isDirectory   NCHAR(1) , 
                @isEmailFolder NCHAR(1) , 
                @flgAllSubDirs NCHAR(1)
                                          ) 
AS
    BEGIN

/*
** Add a row to the SystemParms table
*/

        INSERT INTO SystemParms ( SysParm , SysParmDesc , SysParmVal , flgActive , isDirectory , isEmailFolder , flgAllSubDirs
                                ) 
        VALUES ( @SysParm , @SysParmDesc , @SysParmVal , @flgActive , @isDirectory , @isEmailFolder , @flgAllSubDirs
               );

/*
** Select the new row
*/

        SELECT gv_SystemParms.*
        FROM gv_SystemParms
        WHERE SysParm = @SysParm;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SystemParms_SelectAll]
AS
    BEGIN

/*
** Select all rows from the SystemParms table
*/

        SELECT gv_SystemParms.*
        FROM gv_SystemParms
        ORDER BY SysParm;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_SelectBySysParm]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SystemParms_SelectBySysParm] ( 
                @SysParm NVARCHAR(50)
                                                   ) 
AS
    BEGIN

/*
** Select a row from the SystemParms table by primary key
*/

        SELECT gv_SystemParms.*
        FROM gv_SystemParms
        WHERE SysParm = @SysParm;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_SystemParms_Update] ( 
                @SysParmOriginal NVARCHAR(50) , 
                @SysParm         NVARCHAR(50) , 
                @SysParmDesc     NVARCHAR(250) , 
                @SysParmVal      NVARCHAR(250) , 
                @flgActive       NCHAR(1) , 
                @isDirectory     NCHAR(1) , 
                @isEmailFolder   NCHAR(1) , 
                @flgAllSubDirs   NCHAR(1)
                                          ) 
AS
    BEGIN

/*
** Update a row in the SystemParms table using the primary key
*/

        UPDATE SystemParms
               SET SysParm = @SysParm , SysParmDesc = @SysParmDesc , SysParmVal = @SysParmVal , flgActive = @flgActive , isDirectory = @isDirectory , isEmailFolder = @isEmailFolder , flgAllSubDirs = @flgAllSubDirs
        WHERE SysParm = @SysParmOriginal;

/*
** Select the updated row
*/

        SELECT gv_SystemParms.*
        FROM gv_SystemParms
        WHERE SysParm = @SysParmOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UD_Qty_Delete] ( 
                @Code CHAR(10)
                                     ) 
AS
    BEGIN

/*
** Delete a row from the UD_Qty table
*/

        DELETE FROM UD_Qty
        WHERE Code = @Code;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the UD_Qty table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UD_Qty_Insert] ( 
                @Code        CHAR(10) , 
                @Description CHAR(10)
                                     ) 
AS
    BEGIN

/*
** Add a row to the UD_Qty table
*/

        INSERT INTO UD_Qty ( Code , Description
                           ) 
        VALUES ( @Code , @Description
               );

/*
** Select the new row
*/

        SELECT gv_UD_Qty.*
        FROM gv_UD_Qty
        WHERE Code = @Code;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UD_Qty_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UD_Qty table
*/

        SELECT gv_UD_Qty.*
        FROM gv_UD_Qty
        ORDER BY Code;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_SelectByCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UD_Qty_SelectByCode] ( 
                @Code CHAR(10)
                                           ) 
AS
    BEGIN

/*
** Select a row from the UD_Qty table by primary key
*/

        SELECT gv_UD_Qty.*
        FROM gv_UD_Qty
        WHERE Code = @Code;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UD_Qty_Update] ( 
                @CodeOriginal CHAR(10) , 
                @Code         CHAR(10) , 
                @Description  CHAR(10)
                                     ) 
AS
    BEGIN

/*
** Update a row in the UD_Qty table using the primary key
*/

        UPDATE UD_Qty
               SET Code = @Code , Description = @Description
        WHERE Code = @CodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_UD_Qty.*
        FROM gv_UD_Qty
        WHERE Code = @CodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_upgrade_status_Insert] ( 
                @name   VARCHAR(30) , 
                @status VARCHAR(10)
                                             ) 
AS
    BEGIN

/*
** Add a row to the upgrade_status table
*/

        INSERT INTO upgrade_status ( name , STATUS
                                   ) 
        VALUES ( @name , @status
               );

/*
** Select the new row
*/

        SELECT gv_upgrade_status.*
        FROM gv_upgrade_status;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_upgrade_status_SelectAll]
AS
    BEGIN

/*
** Select all rows from the upgrade_status table
*/

        SELECT gv_upgrade_status.*
        FROM gv_upgrade_status;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_upgrade_status_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlList_Delete] ( 
                @URL NVARCHAR(425)
                                      ) 
AS
    BEGIN

/*
** Delete a row from the UrlList table
*/

        DELETE FROM UrlList
        WHERE URL = @URL;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the UrlList table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlList_Insert] ( 
                @URL NVARCHAR(425)
                                      ) 
AS
    BEGIN

/*
** Add a row to the UrlList table
*/

        INSERT INTO UrlList ( URL
                            ) 
        VALUES ( @URL
               );

/*
** Select the new row
*/

        SELECT gv_UrlList.*
        FROM gv_UrlList
        WHERE URL = @URL;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlList_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UrlList table
*/

        SELECT gv_UrlList.*
        FROM gv_UrlList
        ORDER BY URL;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_SelectByURL]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlList_SelectByURL] ( 
                @URL NVARCHAR(425)
                                           ) 
AS
    BEGIN

/*
** Select a row from the UrlList table by primary key
*/

        SELECT gv_UrlList.*
        FROM gv_UrlList
        WHERE URL = @URL;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlList_Update] ( 
                @URLOriginal NVARCHAR(425) , 
                @URL         NVARCHAR(425)
                                      ) 
AS
    BEGIN

/*
** Update a row in the UrlList table using the primary key
*/

        UPDATE UrlList
               SET URL = @URL
        WHERE URL = @URLOriginal;

/*
** Select the updated row
*/

        SELECT gv_UrlList.*
        FROM gv_UrlList
        WHERE URL = @URLOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlRejection_Delete] ( 
                @RejectionPattern NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Delete a row from the UrlRejection table
*/

        DELETE FROM UrlRejection
        WHERE RejectionPattern = @RejectionPattern;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the UrlRejection table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlRejection_Insert] ( 
                @RejectionPattern NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Add a row to the UrlRejection table
*/

        INSERT INTO UrlRejection ( RejectionPattern
                                 ) 
        VALUES ( @RejectionPattern
               );

/*
** Select the new row
*/

        SELECT gv_UrlRejection.*
        FROM gv_UrlRejection
        WHERE RejectionPattern = @RejectionPattern;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlRejection_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UrlRejection table
*/

        SELECT gv_UrlRejection.*
        FROM gv_UrlRejection
        ORDER BY RejectionPattern;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_SelectByRejectionPattern]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlRejection_SelectByRejectionPattern] ( 
                @RejectionPattern NVARCHAR(50)
                                                             ) 
AS
    BEGIN

/*
** Select a row from the UrlRejection table by primary key
*/

        SELECT gv_UrlRejection.*
        FROM gv_UrlRejection
        WHERE RejectionPattern = @RejectionPattern;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UrlRejection_Update] ( 
                @RejectionPatternOriginal NVARCHAR(50) , 
                @RejectionPattern         NVARCHAR(50)
                                           ) 
AS
    BEGIN

/*
** Update a row in the UrlRejection table using the primary key
*/

        UPDATE UrlRejection
               SET RejectionPattern = @RejectionPattern
        WHERE RejectionPattern = @RejectionPatternOriginal;

/*
** Select the updated row
*/

        SELECT gv_UrlRejection.*
        FROM gv_UrlRejection
        WHERE RejectionPattern = @RejectionPatternOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserCurrParm_Insert] ( 
                @UserID   NVARCHAR(50) , 
                @ParmName NVARCHAR(50) , 
                @ParmVal  NVARCHAR(2000)
                                           ) 
AS
    BEGIN

/*
** Add a row to the UserCurrParm table
*/

        INSERT INTO UserCurrParm ( UserID , ParmName , ParmVal
                                 ) 
        VALUES ( @UserID , @ParmName , @ParmVal
               );

/*
** Select the new row
*/

        SELECT gv_UserCurrParm.*
        FROM gv_UserCurrParm;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserCurrParm_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UserCurrParm table
*/

        SELECT gv_UserCurrParm.*
        FROM gv_UserCurrParm;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_UserCurrParm_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_Delete] ( 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the UserGroup table
*/

        DELETE FROM UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the UserGroup table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_Insert] ( 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                        ) 
AS
    BEGIN

/*
** Add a row to the UserGroup table
*/

        INSERT INTO UserGroup ( GroupOwnerUserID , GroupName
                              ) 
        VALUES ( @GroupOwnerUserID , @GroupName
               );

/*
** Select the new row
*/

        SELECT gv_UserGroup.*
        FROM gv_UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UserGroup table
*/

        SELECT gv_UserGroup.*
        FROM gv_UserGroup
        ORDER BY GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectByGroupOwnerUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_SelectByGroupOwnerUserID] ( 
                @GroupOwnerUserID NVARCHAR(50)
                                                          ) 
AS
    BEGIN

/*
** Select rows from the UserGroup table by GroupOwnerUserID
*/

        SELECT gv_UserGroup.*
        FROM gv_UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserID
        ORDER BY GroupOwnerUserID , GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectByGroupOwnerUserIDAndGroupName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_SelectByGroupOwnerUserIDAndGroupName] ( 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                                                      ) 
AS
    BEGIN

/*
** Select a row from the UserGroup table by primary key
*/

        SELECT gv_UserGroup.*
        FROM gv_UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserGroup_Update] ( 
                @GroupOwnerUserIDOriginal NVARCHAR(50) , 
                @GroupOwnerUserID         NVARCHAR(50) , 
                @GroupNameOriginal        NVARCHAR(80) , 
                @GroupName                NVARCHAR(80)
                                        ) 
AS
    BEGIN

/*
** Update a row in the UserGroup table using the primary key
*/

        UPDATE UserGroup
               SET GroupOwnerUserID = @GroupOwnerUserID , GroupName = @GroupName
        WHERE GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;

/*
** Select the updated row
*/

        SELECT gv_UserGroup.*
        FROM gv_UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserIDOriginal
              AND 
              GroupName = @GroupNameOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserReassignHist_Insert] ( 
                @PrevUserID             NVARCHAR(50) , 
                @PrevUserName           NVARCHAR(50) , 
                @PrevEmailAddress       NVARCHAR(254) , 
                @PrevUserPassword       NVARCHAR(254) , 
                @PrevAdmin              NCHAR(1) , 
                @PrevisActive           NCHAR(1) , 
                @PrevUserLoginID        NVARCHAR(50) , 
                @ReassignedUserID       NVARCHAR(50) , 
                @ReassignedUserName     NVARCHAR(50) , 
                @ReassignedEmailAddress NVARCHAR(254) , 
                @ReassignedUserPassword NVARCHAR(254) , 
                @ReassignedAdmin        NCHAR(1) , 
                @ReassignedisActive     NCHAR(1) , 
                @ReassignedUserLoginID  NVARCHAR(50) , 
                @ReassignmentDate       DATETIME , 
                @RowID                  UNIQUEIDENTIFIER
                                               ) 
AS
    BEGIN

/*
** Add a row to the UserReassignHist table
*/

        INSERT INTO UserReassignHist ( PrevUserID , PrevUserName , PrevEmailAddress , PrevUserPassword , PrevAdmin , PrevisActive , PrevUserLoginID , ReassignedUserID , ReassignedUserName , ReassignedEmailAddress , ReassignedUserPassword , ReassignedAdmin , ReassignedisActive , ReassignedUserLoginID , ReassignmentDate
                                     ) 
        VALUES ( @PrevUserID , @PrevUserName , @PrevEmailAddress , @PrevUserPassword , @PrevAdmin , @PrevisActive , @PrevUserLoginID , @ReassignedUserID , @ReassignedUserName , @ReassignedEmailAddress , @ReassignedUserPassword , @ReassignedAdmin , @ReassignedisActive , @ReassignedUserLoginID , @ReassignmentDate
               );

/*
** Select the new row
*/

        SELECT gv_UserReassignHist.*
        FROM gv_UserReassignHist;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_UserReassignHist_SelectAll]
AS
    BEGIN

/*
** Select all rows from the UserReassignHist table
*/

        SELECT gv_UserReassignHist.*
        FROM gv_UserReassignHist;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_SelectBy]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[gp_UserReassignHist_SelectBy]
AS
    BEGIN
        PRINT 'ALTER PROC will update this';
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Users_Delete] ( 
                @UserID NVARCHAR(50)
                                    ) 
AS
    BEGIN

/*
** Delete a row from the Users table
*/

        DELETE FROM Users
        WHERE UserID = @UserID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Users table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Users_Insert] ( 
                @UserID       NVARCHAR(50) , 
                @UserName     NVARCHAR(50) , 
                @EmailAddress NVARCHAR(254) , 
                @UserPassword NVARCHAR(254) , 
                @Admin        NCHAR(1) , 
                @isActive     NCHAR(1) , 
                @UserLoginID  NVARCHAR(50)
                                    ) 
AS
    BEGIN

/*
** Add a row to the Users table
*/

        INSERT INTO Users ( UserID , UserName , EmailAddress , UserPassword , Admin , isActive , UserLoginID
                          ) 
        VALUES ( @UserID , @UserName , @EmailAddress , @UserPassword , @Admin , @isActive , @UserLoginID
               );

/*
** Select the new row
*/

        SELECT gv_Users.*
        FROM gv_Users
        WHERE UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Users_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Users_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Users table
*/

        SELECT gv_Users.*
        FROM gv_Users
        ORDER BY UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Users_SelectByUserID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Users_SelectByUserID] ( 
                @UserID NVARCHAR(50)
                                            ) 
AS
    BEGIN

/*
** Select a row from the Users table by primary key
*/

        SELECT gv_Users.*
        FROM gv_Users
        WHERE UserID = @UserID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Users_Update] ( 
                @UserIDOriginal NVARCHAR(50) , 
                @UserID         NVARCHAR(50) , 
                @UserName       NVARCHAR(50) , 
                @EmailAddress   NVARCHAR(254) , 
                @UserPassword   NVARCHAR(254) , 
                @Admin          NCHAR(1) , 
                @isActive       NCHAR(1) , 
                @UserLoginID    NVARCHAR(50)
                                    ) 
AS
    BEGIN

/*
** Update a row in the Users table using the primary key
*/

        UPDATE Users
               SET UserID = @UserID , UserName = @UserName , EmailAddress = @EmailAddress , UserPassword = @UserPassword , Admin = @Admin , isActive = @isActive , UserLoginID = @UserLoginID
        WHERE UserID = @UserIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_Users.*
        FROM gv_Users
        WHERE UserID = @UserIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Volitility_Delete] ( 
                @VolitilityCode NVARCHAR(50)
                                         ) 
AS
    BEGIN

/*
** Delete a row from the Volitility table
*/

        DELETE FROM Volitility
        WHERE VolitilityCode = @VolitilityCode;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the Volitility table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Volitility_Insert] ( 
                @VolitilityCode NVARCHAR(50) , 
                @VolitilityDesc NVARCHAR(18) , 
                @CreateDate     DATETIME
                                         ) 
AS
    BEGIN

/*
** Add a row to the Volitility table
*/

        INSERT INTO Volitility ( VolitilityCode , VolitilityDesc , CreateDate
                               ) 
        VALUES ( @VolitilityCode , @VolitilityDesc , @CreateDate
               );

/*
** Select the new row
*/

        SELECT gv_Volitility.*
        FROM gv_Volitility
        WHERE VolitilityCode = @VolitilityCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Volitility_SelectAll]
AS
    BEGIN

/*
** Select all rows from the Volitility table
*/

        SELECT gv_Volitility.*
        FROM gv_Volitility
        ORDER BY VolitilityCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_SelectByVolitilityCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Volitility_SelectByVolitilityCode] ( 
                @VolitilityCode NVARCHAR(50)
                                                         ) 
AS
    BEGIN

/*
** Select a row from the Volitility table by primary key
*/

        SELECT gv_Volitility.*
        FROM gv_Volitility
        WHERE VolitilityCode = @VolitilityCode;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_Volitility_Update] ( 
                @VolitilityCodeOriginal NVARCHAR(50) , 
                @VolitilityCode         NVARCHAR(50) , 
                @VolitilityDesc         NVARCHAR(18) , 
                @CreateDate             DATETIME
                                         ) 
AS
    BEGIN

/*
** Update a row in the Volitility table using the primary key
*/

        UPDATE Volitility
               SET VolitilityCode = @VolitilityCode , VolitilityDesc = @VolitilityDesc , CreateDate = @CreateDate
        WHERE VolitilityCode = @VolitilityCodeOriginal;

/*
** Select the updated row
*/

        SELECT gv_Volitility.*
        FROM gv_Volitility
        WHERE VolitilityCode = @VolitilityCodeOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_WebSource_Delete] ( 
                @SourceGuid NVARCHAR(50)
                                        ) 
AS
    BEGIN

/*
** Delete a row from the WebSource table
*/

        DELETE FROM WebSource
        WHERE SourceGuid = @SourceGuid;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the WebSource table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_WebSource_Insert] ( 
                @SourceGuid              NVARCHAR(50) , 
                @CreateDate              DATETIME , 
                @SourceName              NVARCHAR(254) , 
                @SourceImage             IMAGE , 
                @SourceTypeCode          NVARCHAR(50) , 
                @FileLength              INT , 
                @LastWriteTime           DATETIME , 
                @RetentionExpirationDate DATETIME , 
                @Description             NVARCHAR(MAX) , 
                @KeyWords                NVARCHAR(2000) , 
                @Notes                   NVARCHAR(2000) , 
                @CreationDate            DATETIME
                                        ) 
AS
    BEGIN

/*
** Add a row to the WebSource table
*/

        INSERT INTO WebSource ( SourceGuid , CreateDate , SourceName , SourceImage , SourceTypeCode , FileLength , LastWriteTime , RetentionExpirationDate , Description , KeyWords , Notes , CreationDate
                              ) 
        VALUES ( @SourceGuid , @CreateDate , @SourceName , @SourceImage , @SourceTypeCode , @FileLength , @LastWriteTime , @RetentionExpirationDate , @Description , @KeyWords , @Notes , @CreationDate
               );

/*
** Select the new row
*/

        SELECT gv_WebSource.*
        FROM gv_WebSource
        WHERE SourceGuid = @SourceGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_WebSource_SelectAll]
AS
    BEGIN

/*
** Select all rows from the WebSource table
*/

        SELECT gv_WebSource.*
        FROM gv_WebSource
        ORDER BY SourceGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_SelectBySourceGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_WebSource_SelectBySourceGuid] ( 
                @SourceGuid NVARCHAR(50)
                                                    ) 
AS
    BEGIN

/*
** Select a row from the WebSource table by primary key
*/

        SELECT gv_WebSource.*
        FROM gv_WebSource
        WHERE SourceGuid = @SourceGuid;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_WebSource_Update] ( 
                @SourceGuidOriginal      NVARCHAR(50) , 
                @SourceGuid              NVARCHAR(50) , 
                @CreateDate              DATETIME , 
                @SourceName              NVARCHAR(254) , 
                @SourceImage             IMAGE , 
                @SourceTypeCode          NVARCHAR(50) , 
                @FileLength              INT , 
                @LastWriteTime           DATETIME , 
                @RetentionExpirationDate DATETIME , 
                @Description             NVARCHAR(MAX) , 
                @KeyWords                NVARCHAR(2000) , 
                @Notes                   NVARCHAR(2000) , 
                @CreationDate            DATETIME
                                        ) 
AS
    BEGIN

/*
** Update a row in the WebSource table using the primary key
*/

        UPDATE WebSource
               SET SourceGuid = @SourceGuid , CreateDate = @CreateDate , SourceName = @SourceName , SourceImage = @SourceImage , SourceTypeCode = @SourceTypeCode , FileLength = @FileLength , LastWriteTime = @LastWriteTime , RetentionExpirationDate = @RetentionExpirationDate , Description = @Description , KeyWords = @KeyWords , Notes = @Notes , CreationDate = @CreationDate
        WHERE SourceGuid = @SourceGuidOriginal;

/*
** Select the updated row
*/

        SELECT gv_WebSource.*
        FROM gv_WebSource
        WHERE SourceGuid = @SourceGuidOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Delete]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_Delete] ( 
                @ContentGUID NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Delete a row from the ZippedFiles table
*/

        DELETE FROM ZippedFiles
        WHERE ContentGUID = @ContentGUID;
        IF @@ROWCOUNT = 0
            BEGIN
                RAISERROR('Delete failed: Zero rows were deleted from the ZippedFiles table' , 16 , 1);
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Insert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_Insert] ( 
                @ContentGUID           NVARCHAR(50) , 
                @SourceTypeCode        NVARCHAR(50) , 
                @SourceImage           IMAGE , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Add a row to the ZippedFiles table
*/

        INSERT INTO ZippedFiles ( ContentGUID , SourceTypeCode , SourceImage , SourceGuid , DataSourceOwnerUserID
                                ) 
        VALUES ( @ContentGUID , @SourceTypeCode , @SourceImage , @SourceGuid , @DataSourceOwnerUserID
               );

/*
** Select the new row
*/

        SELECT gv_ZippedFiles.*
        FROM gv_ZippedFiles
        WHERE ContentGUID = @ContentGUID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectAll]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectAll]
AS
    BEGIN

/*
** Select all rows from the ZippedFiles table
*/

        SELECT gv_ZippedFiles.*
        FROM gv_ZippedFiles
        ORDER BY ContentGUID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectByContentGUID]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectByContentGUID] ( 
                @ContentGUID NVARCHAR(50)
                                                       ) 
AS
    BEGIN

/*
** Select a row from the ZippedFiles table by primary key
*/

        SELECT gv_ZippedFiles.*
        FROM gv_ZippedFiles
        WHERE ContentGUID = @ContentGUID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectByDataSourceOwnerUserIDAndSourceGuid] ( 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @SourceGuid            NVARCHAR(50)
                                                                              ) 
AS
    BEGIN

/*
** Select rows from the ZippedFiles table by DataSourceOwnerUserID and SourceGuid
*/

        SELECT gv_ZippedFiles.*
        FROM gv_ZippedFiles
        WHERE DataSourceOwnerUserID = @DataSourceOwnerUserID
              AND 
              SourceGuid = @SourceGuid
        ORDER BY ContentGUID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Update]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[gp_ZippedFiles_Update] ( 
                @ContentGUIDOriginal   NVARCHAR(50) , 
                @ContentGUID           NVARCHAR(50) , 
                @SourceTypeCode        NVARCHAR(50) , 
                @SourceImage           IMAGE , 
                @SourceGuid            NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50)
                                          ) 
AS
    BEGIN

/*
** Update a row in the ZippedFiles table using the primary key
*/

        UPDATE ZippedFiles
               SET ContentGUID = @ContentGUID , SourceTypeCode = @SourceTypeCode , SourceImage = @SourceImage , SourceGuid = @SourceGuid , DataSourceOwnerUserID = @DataSourceOwnerUserID
        WHERE ContentGUID = @ContentGUIDOriginal;

/*
** Select the updated row
*/

        SELECT gv_ZippedFiles.*
        FROM gv_ZippedFiles
        WHERE ContentGUID = @ContentGUIDOriginal;
    END;
GO
/****** Object:  StoredProcedure [dbo].[GraphicsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: GraphicsSelProc 
 */

CREATE PROCEDURE [dbo].[GraphicsSelProc] ( 
                @GraphicID  INT , 
                @IssueTitle NVARCHAR(400)
                                    ) 
AS
    BEGIN
        SELECT GraphicID , Graphic , ResponseID , EMail , IssueTitle
        FROM Graphics
        WHERE GraphicID = @GraphicID
              AND 
              IssueTitle = @IssueTitle;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[GroupLibraryAccessSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GroupLibraryAccessSelProc] ( 
                @UserID           NVARCHAR(50) , 
                @LibraryName      NVARCHAR(80) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                              ) 
AS
    BEGIN
        SELECT UserID , LibraryName , GroupOwnerUserID , GroupName
        FROM GroupLibraryAccess
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[GroupUsersSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GroupUsersSelProc] ( 
                @UserID           NVARCHAR(50) , 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                      ) 
AS
    BEGIN
        SELECT UserID , FullAccess , ReadOnlyAccess , DeleteAccess , Searchable , GroupOwnerUserID , GroupName
        FROM GroupUsers
        WHERE UserID = @UserID
              AND 
              GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[IncludedFilesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[IncludedFilesSelProc] ( 
                @UserID  NVARCHAR(50) , 
                @ExtCode NVARCHAR(50) , 
                @FQN     NVARCHAR(254)
                                         ) 
AS
    BEGIN
        SELECT UserID , ExtCode , FQN
        FROM IncludedFiles
        WHERE UserID = @UserID
              AND 
              ExtCode = @ExtCode
              AND 
              FQN = @FQN;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[IncludeImmediateSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[IncludeImmediateSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                            ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID
        FROM IncludeImmediate
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[InformationProductSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: InformationProductSelProc 
 */

CREATE PROCEDURE [dbo].[InformationProductSelProc] ( 
                @ContainerType NVARCHAR(25) , 
                @CorpFuncName  NVARCHAR(80) , 
                @CorpName      NVARCHAR(50)
                                              ) 
AS
    BEGIN
        SELECT CreateDate , Code , RetentionCode , VolitilityCode , ContainerType , CorpFuncName , InfoTypeCode , CorpName
        FROM InformationProduct
        WHERE ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[InformationTypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: InformationTypeSelProc 
 */

CREATE PROCEDURE [dbo].[InformationTypeSelProc] ( 
                @InfoTypeCode NVARCHAR(50)
                                           ) 
AS
    BEGIN
        SELECT CreateDate , InfoTypeCode , Description
        FROM InformationType
        WHERE InfoTypeCode = @InfoTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[insert_DirectoryArchive]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[insert_DirectoryArchive] (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as [binary] = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));

	set @i = (select count(*) from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		insert into DirectoryArchive (UserID, FQN, DirKey) values (@UserID, @DirName, @DirKey);
	end

end
GO
/****** Object:  StoredProcedure [dbo].[InsertAttachment]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertAttachment] 
                @EmailGuid      NVARCHAR(50) , 
                @Attachment     IMAGE , 
                @AttachmentName VARCHAR(254) , 
                @AttachmentCode VARCHAR(50) , 
                @UserID         VARCHAR(50) , 
                @CRC            VARCHAR(50)
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO EmailAttachment ( Attachment , AttachmentName , EmailGuid , AttachmentCode , UserID , CRC
                                    ) 
        VALUES ( @Attachment , @AttachmentName , @EmailGuid , @AttachmentCode , @UserID , @CRC
               );
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[InsertDataSource]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

/*
'Dim file_DirName$ = FileAttributes(0)
   'Dim file_SourceName$ = FileAttributes(1)
   'Dim file_FullName$ = FileAttributes(2)
   'Dim file_Length$ = FileAttributes(3)
   'Dim file_SourceTypeCode$ = FileAttributes(4)
   'Dim file_LastAccessDate$ = FileAttributes(5)
   'Dim file_CreateDate$ = FileAttributes(6)
   'Dim file_LastWriteTime$ = FileAttributes(7)
*/

CREATE PROCEDURE [dbo].[InsertDataSource] 
                @SourceGuid            NVARCHAR(50) , 
                @FQN                   NVARCHAR(50) , 
                @SourceName            VARCHAR(254) , 
                @SourceImage           IMAGE , 
                @SourceTypeCode        VARCHAR(50) , 
                @LastAccessDate        DATETIME , 
                @CreateDate            DATETIME , 
                @LastWriteTime         DATETIME , 
                @DataSourceOwnerUserID VARCHAR(50) , 
                @VersionNbr            INT
AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO DataSource ( SourceGuid , FQN , SourceName , SourceImage , SourceTypeCode , LastAccessDate , CreateDate , LastWriteTime , DataSourceOwnerUserID , VersionNbr
                               ) 
        VALUES ( @SourceGuid , @FQN , @SourceName , @SourceImage , @SourceTypeCode , @LastAccessDate , @CreateDate , @LastWriteTime , @DataSourceOwnerUserID , @VersionNbr
               );
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[InsertGenerator]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertGenerator] ( 
@tableName VARCHAR(100))
AS
BEGIN
        --Declare a cursor to retrieve column specific information 
        --for the specified table
DECLARE cursCol CURSOR FAST_FORWARD
FOR SELECT column_name , data_type FROM information_schema.columns WHERE table_name=@tableName;
OPEN cursCol;
DECLARE @string NVARCHAR(3000); --for storing the first half 
        --of INSERT statement
DECLARE @stringData NVARCHAR(3000); --for storing the data 
        --(VALUES) related statement
DECLARE @dataType NVARCHAR(1000); --data types returned 
        --for respective columns
SET @string='INSERT '+@tableName+'(';
SET @stringData='';
DECLARE @colName NVARCHAR(50);
FETCH NEXT FROM cursCol INTO @colName , @dataType;
IF @@fetch_status<>0
BEGIN
PRINT 'Table '+@tableName+' not found, processing skipped.';
CLOSE curscol;
DEALLOCATE curscol;
RETURN;
END;
WHILE @@FETCH_STATUS=0
BEGIN
IF @dataType IN('varchar' , 'char' , 'nchar' , 'nvarchar')
BEGIN
SET @stringData=@stringData+'''''''''+
            isnull('+@colName+','''')+'''''',''+';
END;
ELSE
BEGIN
IF @dataType IN('text' , 'ntext') --if the datatype 
                        --is text or something else 
BEGIN
SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(2000)),'''')+'''''',''+';
END;
ELSE
BEGIN
IF @dataType='money' --because money doesn't get converted 
                                --from varchar implicitly
BEGIN
SET @stringData=@stringData+'''convert(money,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0.0000'')+''''''),''+';
END;
ELSE
BEGIN
IF @dataType='datetime'
BEGIN
SET @stringData=@stringData+'''convert(datetime,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0'')+''''''),''+';
END;
ELSE
BEGIN
IF @dataType='image'
BEGIN
SET @stringData=@stringData+'''''''''+
       isnull(cast(convert(varbinary,'+@colName+') 
       as varchar(6)),''0'')+'''''',''+';
END;
ELSE --presuming the data type is int,bit,numeric,decimal 
BEGIN
SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(200)),''0'')+'''''',''+';
END;
END;
END;
END;
END;
SET @string=@string+@colName+',';
FETCH NEXT FROM cursCol INTO @colName , @dataType;
END;
DECLARE @Query NVARCHAR(4000); -- provide for the whole query, 
        -- you may increase the size
SET @query='SELECT '''+SUBSTRING(@string , 0 , LEN(@string))+') 
    VALUES(''+ '+SUBSTRING(@stringData , 0 , LEN(@stringData)-2)+'''+'')'' 
    FROM '+@tableName;
EXEC sp_executesql @query; --load and run the built query 
CLOSE cursCol;
DEALLOCATE cursCol;
END;
GO
/****** Object:  StoredProcedure [dbo].[IssueSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: IssueSelProc 
 */

CREATE PROCEDURE [dbo].[IssueSelProc] ( 
                @IssueTitle NVARCHAR(400)
                                 ) 
AS
    BEGIN
        SELECT CategoryName , IssueDescription , EntryDate , SeverityCode , StatusCode , EMail , IssueTitle , LastUpdate , CreateDate
        FROM Issue
        WHERE IssueTitle = @IssueTitle;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[JargonWordsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: JargonWordsSelProc 
 */

CREATE PROCEDURE [dbo].[JargonWordsSelProc] ( 
                @tgtWord    NVARCHAR(50) , 
                @JargonCode NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT tgtWord , jDesc , CreateDate , JargonCode
        FROM JargonWords
        WHERE tgtWord = @tgtWord
              AND 
              JargonCode = @JargonCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LibDirectorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: LibDirectorySelProc 
 */

CREATE PROCEDURE [dbo].[LibDirectorySelProc] ( 
                @DirectoryName NVARCHAR(18) , 
                @UserID        NVARCHAR(50) , 
                @LibraryName   NVARCHAR(80)
                                        ) 
AS
    BEGIN
        SELECT DirectoryName , UserID , LibraryName
        FROM LibDirectory
        WHERE DirectoryName = @DirectoryName
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LibEmailSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[LibEmailSelProc] ( 
                @EmailFolderEntryID NVARCHAR(200) , 
                @UserID             NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                    ) 
AS
    BEGIN
        SELECT EmailFolderEntryID , UserID , LibraryName , FolderName
        FROM LibEmail
        WHERE EmailFolderEntryID = @EmailFolderEntryID
              AND 
              UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[LibraryItemsSelProc] ( 
                @LibraryItemGuid    NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                        ) 
AS
    BEGIN
        SELECT SourceGuid , ItemTitle , ItemType , LibraryItemGuid , DataSourceOwnerUserID , LibraryOwnerUserID , LibraryName , AddedByUserGuidId
        FROM LibraryItems
        WHERE LibraryItemGuid = @LibraryItemGuid
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LibrarySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[LibrarySelProc] ( 
                @UserID      NVARCHAR(50) , 
                @LibraryName NVARCHAR(80)
                                   ) 
AS
    BEGIN
        SELECT UserID , LibraryName , isPublic
        FROM Library
        WHERE UserID = @UserID
              AND 
              LibraryName = @LibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[LibraryUsersSelProc] ( 
                @UserID             NVARCHAR(50) , 
                @LibraryOwnerUserID NVARCHAR(50) , 
                @LibraryName        NVARCHAR(80)
                                        ) 
AS
    BEGIN
        SELECT ReadOnly , CreateAccess , UpdateAccess , DeleteAccess , UserID , LibraryOwnerUserID , LibraryName
        FROM LibraryUsers
        WHERE UserID = @UserID
              AND 
              LibraryOwnerUserID = @LibraryOwnerUserID
              AND 
              LibraryName = @LibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileItemSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: LoadProfileItemSelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileItemSelProc] ( 
                @ProfileName    NVARCHAR(50) , 
                @SourceTypeCode NVARCHAR(50)
                                           ) 
AS
    BEGIN
        SELECT ProfileName , SourceTypeCode
        FROM LoadProfileItem
        WHERE ProfileName = @ProfileName
              AND 
              SourceTypeCode = @SourceTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: LoadProfileSelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileSelProc] ( 
                @ProfileName NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT ProfileName , ProfileDesc
        FROM LoadProfile
        WHERE ProfileName = @ProfileName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[MachineRegisteredSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: MachineRegisteredSelProc 
 */

CREATE PROCEDURE [dbo].[MachineRegisteredSelProc] ( 
                @MachineGuid UNIQUEIDENTIFIER
                                             ) 
AS
    BEGIN
        SELECT MachineGuid , MachineName , NetWorkName , CreateDate , LastUpdate , HiveConnectionName , HiveActive , RepoSvrName , RowCreationDate , RowLastModDate , RepoName
        FROM MachineRegistered
        WHERE MachineGuid = @MachineGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[OutlookFromSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[OutlookFromSelProc] ( 
                @FromEmailAddr NVARCHAR(254) , 
                @SenderName    VARCHAR(254) , 
                @UserID        VARCHAR(25)
                                       ) 
AS
    BEGIN
        SELECT FromEmailAddr , SenderName , UserID , Verified
        FROM OutlookFrom
        WHERE FromEmailAddr = @FromEmailAddr
              AND 
              SenderName = @SenderName
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[OwnerHistorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[OwnerHistorySelProc] ( 
                @RowId INT
                                        ) 
AS
    BEGIN
        SELECT PreviousOwnerUserID , RowId , CurrentOwnerUserID , CreateDate
        FROM OwnerHistory
        WHERE RowId = @RowId;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[proc_CT_Coaching_AddDeletedRecs]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_CT_Coaching_AddDeletedRecs]
AS
    BEGIN
        WITH CTE(UserGUID , SiteGUID , AccountID , AccountCD , CoachID , email)
             AS (SELECT UserGUID , ISNULL(SiteGUID , '00000000-0000-0000-0000-000000000000') , ISNULL(AccountID , ' ') , ISNULL(AccountCD , ' ') , ISNULL(CoachID , -1) , email
                 FROM DIM_EDW_Coaches
                 EXCEPT
                 SELECT UserGUID , ISNULL(SiteGUID , '00000000-0000-0000-0000-000000000000') , ISNULL(AccountID , ' ') , ISNULL(AccountCD , ' ') , ISNULL(CoachID , -1) , email
                 FROM ##DIM_TEMPTBL_EDW_Coaches_DATA)
             UPDATE S
                    SET S.DeletedFlg = 1
             FROM CTE AS T JOIN DIM_EDW_Coaches AS S ON S.UserGUID = T.UserGUID
                                                        AND 
                                                        ISNULL(S.SiteGUID , '00000000-0000-0000-0000-000000000000') = ISNULL(T.SiteGUID , '00000000-0000-0000-0000-000000000000')
                                                        AND 
                                                        ISNULL(S.AccountID , '') = ISNULL(T.AccountID , '')
                                                        AND 
                                                        ISNULL(S.AccountCD , '') = ISNULL(T.AccountCD , '')
                                                        AND 
                                                        ISNULL(S.CoachID , -1) = ISNULL(T.CoachID , -1)
                                                        AND 
                                                        S.email = T.email;
        DECLARE @idels AS INT= @@ROWCOUNT;
        PRINT 'Deleted Count: ' + CAST(@idels AS NVARCHAR(50));
        RETURN @idels;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ProcessFileAsSelProc] ( 
                @ExtCode NVARCHAR(50)
                                         ) 
AS
    BEGIN
        SELECT ExtCode , ProcessExtCode , Applied
        FROM ProcessFileAs
        WHERE ExtCode = @ExtCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[procGetContentData]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[procGetContentData] 
                @SqlStmt VARCHAR(4000)
AS
    BEGIN
        EXEC (@SqlStmt);
    END;
GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: ProdCaptureItemsSelProc 
 */

CREATE PROCEDURE [dbo].[ProdCaptureItemsSelProc] ( 
                @CaptureItemsCode NVARCHAR(50) , 
                @ContainerType    NVARCHAR(25) , 
                @CorpFuncName     NVARCHAR(80) , 
                @CorpName         NVARCHAR(50)
                                            ) 
AS
    BEGIN
        SELECT CaptureItemsCode , SendAlert , ContainerType , CorpFuncName , CorpName
        FROM ProdCaptureItems
        WHERE CaptureItemsCode = @CaptureItemsCode
              AND 
              ContainerType = @ContainerType
              AND 
              CorpFuncName = @CorpFuncName
              AND 
              CorpName = @CorpName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[QtyDocsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: QtyDocsSelProc 
 */

CREATE PROCEDURE [dbo].[QtyDocsSelProc] ( 
                @QtyDocCode NVARCHAR(10)
                                   ) 
AS
    BEGIN
        SELECT QtyDocCode , Description , CreateDate
        FROM QtyDocs
        WHERE QtyDocCode = @QtyDocCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[QuickDirectorySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[QuickDirectorySelProc] ( 
                @UserID NVARCHAR(50) , 
                @FQN    VARCHAR(254)
                                          ) 
AS
    BEGIN
        SELECT UserID , IncludeSubDirs , FQN , DB_ID , VersionFiles , ckMetaData , ckPublic , ckDisableDir , QuickRefEntry
        FROM QuickDirectory
        WHERE UserID = @UserID
              AND 
              FQN = @FQN;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[QuickRefItemsSelProc] ( 
                @QuickRefItemGuid NVARCHAR(50)
                                         ) 
AS
    BEGIN
        SELECT QuickRefIdNbr , FQN , QuickRefItemGuid , SourceGuid , DataSourceOwnerUserID , Author , Description , Keywords , FileName , DirName , MarkedForDeletion
        FROM QuickRefItems
        WHERE QuickRefItemGuid = @QuickRefItemGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[QuickRefSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[QuickRefSelProc] ( 
                @QuickRefIdNbr INT
                                    ) 
AS
    BEGIN
        SELECT UserID , QuickRefName , QuickRefIdNbr
        FROM QuickRef
        WHERE QuickRefIdNbr = @QuickRefIdNbr;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[RecipientsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RecipientsSelProc] ( 
                @Recipient NVARCHAR(254) , 
                @EmailGuid NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT Recipient , EmailGuid , TypeRecp
        FROM Recipients
        WHERE Recipient = @Recipient
              AND 
              EmailGuid = @EmailGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[RepeatDataSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: RepeatDataSelProc 
 */

CREATE PROCEDURE [dbo].[RepeatDataSelProc] ( 
                @RepeatDataCode NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT RepeatDataCode , RepeatDataDesc
        FROM RepeatData
        WHERE RepeatDataCode = @RepeatDataCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ResponseSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: ResponseSelProc 
 */

CREATE PROCEDURE [dbo].[ResponseSelProc] ( 
                @ResponseID INT , 
                @EMail      NVARCHAR(100) , 
                @IssueTitle NVARCHAR(400)
                                    ) 
AS
    BEGIN
        SELECT Response , ResponseDate , StatusCode , ResponseID , LastUpdate , CreateDate , EMail , IssueTitle
        FROM Response
        WHERE ResponseID = @ResponseID
              AND 
              EMail = @EMail
              AND 
              IssueTitle = @IssueTitle;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[RetentionSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: RetentionSelProc 
 */

CREATE PROCEDURE [dbo].[RetentionSelProc] ( 
                @RetentionCode NVARCHAR(50)
                                     ) 
AS
    BEGIN
        SELECT RetentionCode , RetentionDesc
        FROM Retention
        WHERE RetentionCode = @RetentionCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[RunParmsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[RunParmsSelProc] ( 
                @Parm   NVARCHAR(50) , 
                @UserID NVARCHAR(50)
                                    ) 
AS
    BEGIN
        SELECT Parm , ParmValue , UserID
        FROM RunParms
        WHERE Parm = @Parm
              AND 
              UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SeveritySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: SeveritySelProc 
 */

CREATE PROCEDURE [dbo].[SeveritySelProc] ( 
                @SeverityCode NVARCHAR(50)
                                    ) 
AS
    BEGIN
        SELECT SeverityCode , CodeDesc
        FROM Severity
        WHERE SeverityCode = @SeverityCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SkipWordsSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SkipWordsSelProc 
 */

CREATE PROCEDURE [dbo].[SkipWordsSelProc] ( 
                @tgtWord NVARCHAR(18)
                                     ) 
AS
    BEGIN
        SELECT tgtWord
        FROM SkipWords
        WHERE tgtWord = @tgtWord;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746006]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SourceAttributeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttr_01282009011746006] ( 
                @AttributeName NVARCHAR(50) , 
                @SourceGuid    NVARCHAR(50)
                                                 ) 
AS
    BEGIN
        SELECT AttributeValue , AttributeName , SourceGuid
        FROM SourceAttribute
        WHERE AttributeName = @AttributeName
              AND 
              SourceGuid = @SourceGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SourceAttributeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttributeSelProc] ( 
                @AttributeName NVARCHAR(50) , 
                @SourceGuid    NVARCHAR(50)
                                           ) 
AS
    BEGIN
        SELECT AttributeValue , AttributeName , SourceGuid
        FROM SourceAttribute
        WHERE AttributeName = @AttributeName
              AND 
              SourceGuid = @SourceGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SourceContainerSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SourceContainerSelProc 
 */

CREATE PROCEDURE [dbo].[SourceContainerSelProc] ( 
                @ContainerType NVARCHAR(25)
                                           ) 
AS
    BEGIN
        SELECT ContainerType , ContainerDesc , CreateDate
        FROM SourceContainer
        WHERE ContainerType = @ContainerType;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317004]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SourceTypeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceType_04012008185317004] ( 
                @SourceTypeCode NVARCHAR(50)
                                                 ) 
AS
    BEGIN
        SELECT SourceTypeCode , SourceTypeDesc
        FROM SourceType
        WHERE SourceTypeCode = @SourceTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SourceTypeSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: SourceTypeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceTypeSelProc] ( 
                @SourceTypeCode NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT SourceTypeCode , SourceTypeDesc
        FROM SourceType
        WHERE SourceTypeCode = @SourceTypeCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddDefault]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec sp_AddDefault 'Retention', 'RowGuid'

CREATE PROCEDURE [dbo].[sp_AddDefault]
   (@TBL     NVARCHAR(250), 
    @COL     NVARCHAR(250), 
    @default NVARCHAR(250)
   )
AS
    BEGIN
        DECLARE @CMD NVARCHAR(4000) = '';
        SET @CMD = 'alter table ' + @TBL + ' ADD DEFAULT(' + @default + ') FOR ' + @COL + ';';
        PRINT @CMD;
        BEGIN TRY
            EXEC sp_executesql 
                 @CMD;
        END TRY
        BEGIN CATCH
            PRINT 'NOTICE: Default set for ' + @TBL + ' : ' + @COL + ' = ' + @default +', previously set.';
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ApplySourceTypeCode]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ApplySourceTypeCode] (@MachineID nvarchar(80), @UserID nvarchar(50), @SourceName nvarchar(255), @FileExt nvarchar(50), @SourceGuid nvarchar(50))
as 
begin

	declare @ProcessAs as  nvarchar(50) ;
	set @ProcessAs = (select ProcessExtCode from ProcessFileAs where ExtCode = @FileExt);

	if @ProcessAs is not null 
	begin
		update DataSource set MachineID = @MachineID, DataSourceOwnerUserID = @UserID, UserID = @UserID,  [SourceTypeCode] = @ProcessAs, SourceName = @SourceName where SourceGuid = @SourceGuid ;
	end
	else 
	begin
		update DataSource set MachineID = @MachineID, DataSourceOwnerUserID = @UserID, UserID = @UserID, [SourceTypeCode] = @FileExt, SourceName = @SourceName where SourceGuid = @SourceGuid ;
	end

end

GO
/****** Object:  StoredProcedure [dbo].[sp_CalcRetentionDateDS]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP TRIGGER trgUpdtCalcRetentionDateDS

CREATE PROCEDURE [dbo].[sp_CalcRetentionDateDS] 
                @SourceGuid NVARCHAR(50)
AS
    BEGIN
        DECLARE @RetentionCode NVARCHAR(50) , @RetentionPeriod NVARCHAR(50) , @RetentionUnits INT , @rDate DATETIME;
        SET @RetentionCode = ( SELECT RetentionCode
                               FROM DataSource
                               WHERE SourceGuid = @SourceGuid
                             );
        SET @RetentionPeriod = ( SELECT RetentionPeriod
                                 FROM Retention
                                 WHERE Retention.RetentionCode = @RetentionCode
                               );
        SET @RetentionUnits = ( SELECT RetentionUnits
                                FROM Retention
                                WHERE Retention.RetentionCode = @RetentionCode
                              );
        IF @RetentionPeriod IS NULL
            BEGIN
                SET @RetentionPeriod = ( SELECT MAX(RetentionUnits)
                                         FROM Retention
                                         WHERE RetentionPeriod = 'Year'
                                       );
        END;
        --print '- ' + @RetentionPeriod + ' -'
        --print @RetentionUnits 
        --print 'Start'
        --print @SourceGuid
        IF @RetentionPeriod = 'Day'
            BEGIN
                UPDATE DataSource
                       SET RetentionDate = DATEADD(day , @RetentionUnits , GETDATE())
                WHERE DataSource.Sourceguid = @SourceGuid;
                --set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
                --print @rDate 
        END;
        IF @RetentionPeriod = 'Month'
            BEGIN
                UPDATE DataSource
                       SET RetentionDate = DATEADD(month , @RetentionUnits , GETDATE())
                WHERE DataSource.Sourceguid = @SourceGuid;
                --set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
                --print  @rDate
        END;
        IF @RetentionPeriod = 'Year'
            BEGIN
                --print 'YEAR-2'
                UPDATE DataSource
                       SET RetentionDate = DATEADD(year , @RetentionUnits , GETDATE())
                WHERE DataSource.Sourceguid = @SourceGuid;
                --set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
                --print @rDate
        END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CalcTableSpace]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CalcTableSpace]
AS
    BEGIN 
        --SQL Server 2005
        --Here is another version of this same process.  
        --The overall process is the same, but it uses 
        --the new tables in SQL Server 2005.  It also 
        --uses the Try Catch processing which was discussed 
        --in this previous tip, SQL Server 2005 - Try Catch 
        --Exception Handling. Both of the examples will 
        --produce the same ouput.
        BEGIN TRY
            DECLARE @table_name VARCHAR(500);
            DECLARE @schema_name VARCHAR(500);
            DECLARE @tab1 TABLE ( 
                                tablename  VARCHAR(500) COLLATE database_default , 
                                schemaname VARCHAR(500) COLLATE database_default
                                );
            DECLARE @temp_table TABLE ( 
                                      tablename  SYSNAME , 
                                      row_count  INT , 
                                      reserved   VARCHAR(50) COLLATE database_default , 
                                      data       VARCHAR(50) COLLATE database_default , 
                                      index_size VARCHAR(50) COLLATE database_default , 
                                      unused     VARCHAR(50) COLLATE database_default
                                      );
            INSERT INTO @tab1
                   SELECT t1.name , t2.name
                   FROM sys.tables AS t1 INNER JOIN sys.schemas AS t2 ON t1.schema_id = t2.schema_id;
            DECLARE c1 CURSOR
            FOR SELECT t2.name + '.' + t1.name
                FROM sys.tables AS t1 INNER JOIN sys.schemas AS t2 ON t1.schema_id = t2.schema_id;
            OPEN c1;
            FETCH NEXT FROM c1 INTO @table_name;
            WHILE @@FETCH_STATUS = 0
                BEGIN
                    SET @table_name = REPLACE(@table_name , '[' , '');
                    SET @table_name = REPLACE(@table_name , ']' , '');
                    -- make sure the object exists before calling sp_spacedused
                    IF EXISTS ( SELECT OBJECT_ID
                                FROM sys.objects
                                WHERE OBJECT_ID = OBJECT_ID(@table_name)
                              ) 
                        BEGIN
                            INSERT INTO @temp_table
                            EXEC sp_spaceused @table_name , false;
                    END;
                    FETCH NEXT FROM c1 INTO @table_name;
                END;
            CLOSE c1;
            DEALLOCATE c1;
            SELECT t1.* , t2.schemaname
            FROM @temp_table AS t1 INNER JOIN @tab1 AS t2 ON t1.tablename = t2.tablename
            ORDER BY schemaname , tablename;
        END TRY
        BEGIN CATCH
            SELECT-100 AS l1 , ERROR_NUMBER() AS tablename , ERROR_SEVERITY() AS row_count , ERROR_STATE() AS reserved , ERROR_MESSAGE() AS data , 1 AS index_size , 1 AS unused , 1 AS schemaname;
        END CATCH;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CleanTxTimes]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CleanTxTimes]
AS
    BEGIN
        DECLARE @BatchSize INT , @Criteria DATETIME , @RowCount INT;
        SET @BatchSize = 1000;
        SET @Criteria = GETDATE() - 60;
        SET @RowCount = 1000;
        SET ROWCOUNT @BatchSize;
        WHILE @RowCount > 0
            BEGIN
                DELETE FROM txTimes
                WHERE CreateDate < @Criteria;
                SELECT @RowCount = @@rowcount;
            END;
        SET ROWCOUNT 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_compare]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_compare] ( 
                @srcdb  VARCHAR(92) , 
                @destdb VARCHAR(92)
                               ) 
AS
    BEGIN

        /********************************************************************************/
        /*	Created BY :	W. Dale Miller				*/
        /*	Created ON :	June 6, 2009     			*/
        /*	Description:	This stored PROCEDURE generates a simple report that	*/
        /*			compares 2 databases ON same server or different servers*/
        /*                      1) set concat_null_yields_null off                      */
        /*                      2) Column names for identifiers should be made as 128   */
        /*                      characters in length                                    */
        /********************************************************************************/

        IF OBJECT_ID('tempdb..objects') IS NOT NULL
            BEGIN
                DROP TABLE tempdb..objects;
        END;
        IF OBJECT_ID('tempdb..columns') IS NOT NULL
            BEGIN
                DROP TABLE tempdb..columns;
        END;
        IF OBJECT_ID('tempdb..changed_tables_cols') IS NOT NULL
            BEGIN
                DROP TABLE tempdb..changed_tables_cols;
        END;
        DECLARE @db1 VARCHAR(61) , @db2 VARCHAR(61) , @sp1 VARCHAR(92) , @sp2 VARCHAR(92) , @server1 VARCHAR(92) , @server2 VARCHAR(92) , @db1command VARCHAR(255) , @db2command VARCHAR(255) , @objselect VARCHAR(255) , @table VARCHAR(32) , @sp VARCHAR(62) , @colselectsp VARCHAR(62) , @mesg VARCHAR(255) , @count INT;
        SET NOCOUNT ON;
        -- SQL70 setting to be enabled for proper working of this SP:
        -- SET CONCAT_NULL_YIELDS_NULL OFF
        SELECT @db1 = CASE
                          WHEN @srcdb LIKE '%.%'
                          THEN REVERSE(SUBSTRING(REVERSE(@srcdb) , 1 , CHARINDEX('.' , REVERSE(@srcdb)) - 1))
                          ELSE @srcdb
                      END , @db2 = CASE
                                       WHEN @destdb LIKE '%.%'
                                       THEN REVERSE(SUBSTRING(REVERSE(@destdb) , 1 , CHARINDEX('.' , REVERSE(@destdb)) - 1))
                                       ELSE @destdb
                                   END , @server1 = CASE
                                                        WHEN @srcdb LIKE '%.%'
                                                        THEN SUBSTRING(@srcdb , 1 , CHARINDEX('.' , @srcdb))
                                                        ELSE NULL
                                                    END , @server2 = CASE
                                                                         WHEN @destdb LIKE '%.%'
                                                                         THEN SUBSTRING(@destdb , 1 , CHARINDEX('.' , @destdb))
                                                                         ELSE NULL
                                                                     END , @objselect = 'select name, object_type = CASE type WHEN ''U'' THEN ''table'' ' + 'when ''P'' THEN ''stored procedure'' when ''V'' then ''view'' END ' + 'from sysobjects WHERE type IN (''U'', ''V'', ''P'')' , @sp = 'master..sp_sqlexec' , @colselectsp = 'exec sp_columns';
        SELECT @db1command = STUFF(@objselect , CHARINDEX('sysobjects' , @objselect) , DATALENGTH('sysobjects') , @db1 + '..sysobjects') , @db2command = STUFF(@objselect , CHARINDEX('sysobjects' , @objselect) , DATALENGTH('sysobjects') , @db2 + '..sysobjects') , @sp1 = @server1 + @sp , @sp2 = @server2 + @sp;
        SELECT @db1command = STUFF(@db1command , CHARINDEX('name' , @db1command) , DATALENGTH('name') , '''' + @srcdb + ''', name') , @db2command = STUFF(@db2command , CHARINDEX('name' , @db2command) , DATALENGTH('name') , '''' + @destdb + ''', name');
        -- SQL70:
        -- CREATE TABLE #objects (db_name varchar(128), name varchar(128), object_type varchar(30))
        CREATE TABLE #objects ( 
                     db_name     VARCHAR(61) , 
                     name        VARCHAR(30) , 
                     object_type VARCHAR(30)
                              );
        INSERT INTO #objects
        EXEC @sp1 @db1command;
        INSERT INTO #objects
        EXEC @sp2 @db2command;
        DELETE #objects
        WHERE name IN ( 'objects' , 'columns' , 'changed_tables_cols' , 'upgrade_status'
                      );
        SELECT @mesg = '1. Tables present ONLY IN database: ' + @srcdb;
        PRINT @mesg;
        SELECT name
        FROM #objects
        WHERE object_type = 'table'
              AND 
              db_name = @srcdb
              AND 
              name NOT IN ( SELECT name
                            FROM #objects
                            WHERE object_type = 'table'
                                  AND 
                                  db_name = @destdb
                          )
        ORDER BY name;
        PRINT '';
        SELECT @mesg = '2. Tables present ONLY IN database: ' + @destdb;
        PRINT @mesg;
        SELECT name
        FROM #objects
        WHERE object_type = 'table'
              AND 
              db_name = @destdb
              AND 
              name NOT IN ( SELECT name
                            FROM #objects
                            WHERE object_type = 'table'
                                  AND 
                                  db_name = @srcdb
                          )
        ORDER BY name;
        PRINT '';
        SELECT @mesg = 'Upgrade status table:';
        PRINT @mesg;
        PRINT 'create TABLE upgrade_status';
        PRINT '(';
        PRINT 'name varchar(30) NOT null,';
        PRINT 'status varchar(10) NOT NULL
	CHECK (status IN (''INCOMPLETE'', ''COMPLETE'')) DEFAULT ''INCOMPLETE''';
        PRINT ')';
        PRINT 'go';
        PRINT @mesg;
        SELECT @mesg = 'insert upgrade_status select name, ''INCOMPLETE'' FROM sysobjects ' + 'where type = ''U'' AND name NOT IN (''upgrade_status'')';
        PRINT @mesg;
        PRINT '';
        SELECT @mesg = 'Drop statements FOR the tables IN the database: ' + @destdb;
        PRINT @mesg;
        DECLARE drop_tables CURSOR
        FOR SELECT name
            FROM #objects
            WHERE object_type = 'table'
                  AND 
                  db_name = @destdb
                  AND 
                  name NOT IN ( SELECT name
                                FROM #objects
                                WHERE object_type = 'table'
                                      AND 
                                      db_name = @srcdb
                              )
            ORDER BY name;
        OPEN drop_tables;
        WHILE 'FETCH IS OK' = 'FETCH IS OK'
            BEGIN
                FETCH NEXT FROM drop_tables INTO @table;
                IF @@FETCH_STATUS < 0
                    BEGIN
                        BREAK;
                END;
                SELECT @mesg = 'print ''Dropping TABLE ' + @table + '..''';
                PRINT @mesg;
                PRINT 'begin tran';
                SELECT @mesg = 'if EXISTS (select name FROM upgrade_status WHERE name = ''' + @table + ''' AND status = ''INCOMPLETE'')';
                PRINT @mesg;
                PRINT 'begin';
                SELECT @mesg = ' DROP TABLE ' + @table;
                PRINT @mesg;
                PRINT ' -- IF @@ERROR <> 0';
                PRINT ' begin';
                PRINT ' IF @@trancount > 0';
                PRINT 'rollback tran';
                PRINT ' end';
                PRINT ' else';
                PRINT ' begin';
                SELECT @mesg = ' UPDATE upgrade_status SET status = ''COMPLETE'' WHERE name = ''' + @table + '''';
                PRINT @mesg;
                PRINT ' COMMIT tran';
                PRINT ' end';
                PRINT 'end';
                PRINT '';
            END;
        CLOSE drop_tables;
        DEALLOCATE drop_tables;
        PRINT '';
        -- goto END_LABEL
        SELECT @mesg = '3. Analyzing tables...';
        PRINT @mesg;
        PRINT '';
        -- SQL70:
/*
CREATE TABLE #columns (
        TABLE_QUALIFIER	varchar(128) NULL, TABLE_OWNER varchar(128),
        TABLE_NAME varchar(128), COLUMN_NAME varchar(128),
        DATA_TYPE smallint NULL, TYPE_NAME varchar(128), PREC int,
        LENGTH int, SCALE smallint NULL, RADIX smallint NULL,
        NULLABLE smallint, REMARKS varchar(254) NULL,
        COLUMN_DEF varchar(8000) NULL, SQL_DATA_TYPE smallint,
        SQL_DATETIME_SUB smallint NULL, CHAR_OCTET_LENGTH int NULL,
        ORDINAL_POSITION int, IS_NULLABLE varchar(254), SS_DATA_TYPE tinyint
)
*/

        CREATE TABLE #columns ( 
                     TABLE_QUALIFIER   VARCHAR(32) NULL , 
                     TABLE_OWNER       VARCHAR(32) , 
                     TABLE_NAME        VARCHAR(32) , 
                     COLUMN_NAME       VARCHAR(32) , 
                     DATA_TYPE         SMALLINT NULL , 
                     TYPE_NAME         VARCHAR(13) , 
                     PREC              INT , 
                     LENGTH            INT , 
                     SCALE             SMALLINT NULL , 
                     RADIX             SMALLINT NULL , 
                     NULLABLE          SMALLINT , 
                     REMARKS           VARCHAR(254) NULL , 
                     COLUMN_DEF        VARCHAR(254) NULL , 
                     SQL_DATA_TYPE     SMALLINT , 
                     SQL_DATETIME_SUB  SMALLINT NULL , 
                     CHAR_OCTET_LENGTH INT NULL , 
                     ORDINAL_POSITION  INT , 
                     IS_NULLABLE       VARCHAR(254) , 
                     SS_DATA_TYPE      TINYINT
                              );
        DECLARE common_tables SCROLL CURSOR
        FOR SELECT name
            FROM #objects
            WHERE object_type = 'table'
            GROUP BY name
            HAVING COUNT(name) = 2;
        OPEN common_tables;
        WHILE 'FETCH IS OK' = 'FETCH IS OK'
            BEGIN
                FETCH NEXT FROM common_tables INTO @table;
                IF @@FETCH_STATUS < 0
                    BEGIN
                        BREAK;
                END;
                SELECT @db1command = 'use' + SPACE(1) + @db1 + SPACE(1) + @colselectsp + SPACE(1) + @table , @db2command = 'use' + SPACE(1) + @db2 + SPACE(1) + @colselectsp + SPACE(1) + @table;
                INSERT INTO #columns
                EXEC @sp1 @db1command;
                INSERT INTO #columns
                EXEC @sp2 @db2command;
            END;
        CLOSE common_tables;
        DEALLOCATE common_tables;
        SELECT SPACE(128) AS TABLE_QUALIFIER , TABLE_NAME , COLUMN_NAME , SPACE(128) AS TYPE_NAME
        INTO #changed_tables_cols
        FROM #columns
        GROUP BY TABLE_NAME , COLUMN_NAME
        HAVING COUNT(*) = 1;
        UPDATE c1
               SET c1.TABLE_QUALIFIER = c2.TABLE_QUALIFIER
        FROM #changed_tables_cols c1 , #columns c2
        WHERE c1.TABLE_NAME = c2.TABLE_NAME
              AND 
              c1.COLUMN_NAME = c2.COLUMN_NAME;
        SELECT @count = 1;
        DECLARE changed_tables CURSOR
        FOR SELECT DISTINCT 
                   TABLE_NAME
            FROM #changed_tables_cols;
        OPEN changed_tables;
        WHILE 'FETCH IS OK' = 'FETCH IS OK'
            BEGIN
                FETCH NEXT FROM changed_tables INTO @table;
                IF @@fetch_status < 0
                    BEGIN
                        BREAK;
                END;
                SELECT @count = @count + 1 , @mesg = LTRIM(STR(@count)) + ') Table: ' + @table;
                PRINT @mesg;
                SELECT @mesg = 'Database: ' + @db1;
                IF EXISTS ( SELECT COLUMN_NAME
                            FROM #changed_tables_cols
                            WHERE TABLE_NAME = @table
                                  AND 
                                  TABLE_QUALIFIER = @db1
                          ) 
                    BEGIN
                        PRINT @mesg;
                        SELECT c.COLUMN_NAME , c.TYPE_NAME , c.LENGTH , c.IS_NULLABLE , c.COLUMN_DEF
                        FROM #columns AS c , #changed_tables_cols AS c1
                        WHERE c1.TABLE_NAME = @table
                              AND 
                              c1.TABLE_QUALIFIER = @db1
                              AND 
                              c1.TABLE_NAME = c.TABLE_NAME
                              AND 
                              c1.TABLE_QUALIFIER = c.TABLE_QUALIFIER
                              AND 
                              c1.COLUMN_NAME = c.COLUMN_NAME;
                        PRINT '';
                END;
                SELECT @mesg = 'Database: ' + @db2;
                IF EXISTS ( SELECT COLUMN_NAME
                            FROM #changed_tables_cols
                            WHERE TABLE_NAME = @table
                                  AND 
                                  TABLE_QUALIFIER = @db2
                          ) 
                    BEGIN
                        PRINT @mesg;
                        SELECT c.COLUMN_NAME , c.TYPE_NAME , c.LENGTH , c.IS_NULLABLE , c.COLUMN_DEF
                        FROM #columns AS c , #changed_tables_cols AS c1
                        WHERE c1.TABLE_NAME = @table
                              AND 
                              c1.TABLE_QUALIFIER = @db2
                              AND 
                              c1.TABLE_NAME = c.TABLE_NAME
                              AND 
                              c1.TABLE_QUALIFIER = c.TABLE_QUALIFIER
                              AND 
                              c1.COLUMN_NAME = c.COLUMN_NAME;
                        PRINT '';
                END;
                FETCH NEXT FROM changed_tables INTO @table;
            END;
        CLOSE changed_tables;
        DEALLOCATE changed_tables;

/*
-- get the other datatype changes.
INSERT #changed_tables_cols
SELECT space(32) AS TABLE_QUALIFIER, TABLE_NAME, COLUMN_NAME , 
TYPE_NAME
 FROM #columns GROUP BY TABLE_NAME, COLUMN_NAME, TYPE_NAME HAVING 
COUNT(*) = 1
UPDATE c1
 SET c1.TABLE_QUALIFIER = c2.TABLE_QUALIFIER
FROM #changed_tables_cols c1, #columns c2
WHERE c1.TABLE_NAME = c2.TABLE_NAME AND c1.COLUMN_NAME = c2.COLUMN_NAME 
and
	c1.TYPE_NAME = c2.TYPE_NAME
DELETE #changed_tables_cols WHERE TYPE_NAME IS NOT NULL AND COLUMN_NAME
IN ('mod_date', 'mod_user')
*/

        SELECT @mesg = '4. Stored procedures present ONLY IN database: ' + @srcdb;
        PRINT @mesg;
        SELECT name
        FROM #objects
        WHERE object_type = 'stored procedure'
              AND 
              db_name = @srcdb
              AND 
              name NOT IN ( SELECT name
                            FROM #objects
                            WHERE object_type = 'stored procedure'
                                  AND 
                                  db_name = @destdb
                          );
        PRINT '';
        SELECT @mesg = '5. Stored procedures present ONLY IN database: ' + @destdb;
        PRINT @mesg;
        SELECT name
        FROM #objects
        WHERE object_type = 'stored procedure'
              AND 
              db_name = @destdb
              AND 
              name NOT IN ( SELECT name
                            FROM #objects
                            WHERE object_type = 'stored procedure'
                                  AND 
                                  db_name = @destdb
                          );
        PRINT '';
        SELECT *
        INTO tempdb..objects
        FROM #objects;
        SELECT *
        INTO tempdb..columns
        FROM #columns;
        SELECT *
        INTO tempdb..changed_tables_cols
        FROM #changed_tables_cols;
        END_LABEL:
        PRINT 'Comparison of the databases completed.';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DefaultExists]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DefaultExists]
   (@TBL NVARCHAR(250), 
    @COL NVARCHAR(250)
   )
AS
    BEGIN
        DECLARE @I AS INTEGER = 0;
        SET @I =
        (
            SELECT COUNT(*)
                FROM sys.default_constraints AS d
                          INNER JOIN sys.columns AS c
                          ON d.parent_object_id = c.object_id
                             AND d.parent_column_id = c.column_id
                WHERE d.parent_object_id = OBJECT_ID(@TBL, N'U')
                      AND c.name = @COL
        );
        PRINT @I;
        RETURN @I;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DropAllFK]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec sp_DropAllFK 'Retention'

CREATE PROCEDURE [dbo].[sp_DropAllFK] ( 
                 @TBL NVARCHAR(250)
                              ) 
AS
    BEGIN
        DECLARE @cmd VARCHAR(4000);
        DECLARE @reftbl VARCHAR(4000);
        DECLARE @fk VARCHAR(4000);
        DECLARE MY_CURSOR CURSOR LOCAL STATIC READ_ONLY FORWARD_ONLY
        FOR SELECT 'ALTER TABLE ' + OBJECT_SCHEMA_NAME(parent_object_id) + '.' + OBJECT_NAME(parent_object_id) + ' DROP CONSTRAINT ' + name + ';'
            FROM sys.foreign_keys
            WHERE OBJECT_NAME(referenced_object_id) = @TBL;
        OPEN MY_CURSOR;
        FETCH NEXT FROM MY_CURSOR INTO @cmd;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC (@cmd);
                PRINT @cmd;
                FETCH NEXT FROM MY_CURSOR INTO @cmd;
            END;
        CLOSE MY_CURSOR;
        DEALLOCATE MY_CURSOR;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_EcmUpdateDB]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_EcmUpdateDB] 
                @pSql NVARCHAR(MAX)
AS
    BEGIN
        EXEC sp_executesql @pSql;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMetaData]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetMetaData] 
                @SourceGuid NVARCHAR(50)
AS
    BEGIN
        SELECT AttributeName , AttributeValue
        FROM SourceAttribute
        WHERE SourceGuid = @SourceGuid
        ORDER BY AttributeName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRepoCount]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_GetRepoCount]
as
select count(*) + 5288113 as NumberOfEmail from email
select count(*) + 8117443 as NumberOfDocument from datasource
select count(*) + 16117443 as NbrEmailAttachment  from EmailAttachment

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertGenerator]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_InsertGenerator] ( 
@tableName VARCHAR(100))
AS
BEGIN
        --Declare a cursor to retrieve column specific information 
        --for the specified table
DECLARE cursCol CURSOR FAST_FORWARD
FOR SELECT column_name , data_type FROM information_schema.columns WHERE table_name=@tableName;
OPEN cursCol;
DECLARE @string NVARCHAR(3000); --for storing the first half 
        --of INSERT statement
DECLARE @stringData NVARCHAR(3000); --for storing the data 
        --(VALUES) related statement
DECLARE @dataType NVARCHAR(1000); --data types returned 
        --for respective columns
SET @string='INSERT '+@tableName+'(';
SET @stringData='';
DECLARE @colName NVARCHAR(50);
FETCH NEXT FROM cursCol INTO @colName , @dataType;
IF @@fetch_status<>0
BEGIN
PRINT 'Table '+@tableName+' not found, processing skipped.';
CLOSE curscol;
DEALLOCATE curscol;
RETURN;
END;
WHILE @@FETCH_STATUS=0
BEGIN
IF @dataType IN('varchar' , 'char' , 'nchar' , 'nvarchar')
BEGIN
SET @stringData=@stringData+'''''''''+
            isnull('+@colName+','''')+'''''',''+';
END;
ELSE
BEGIN
IF @dataType IN('text' , 'ntext') --if the datatype 
                        --is text or something else 
BEGIN
SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(2000)),'''')+'''''',''+';
END;
ELSE
BEGIN
IF @dataType='money' --because money doesn't get converted 
                                --from varchar implicitly
BEGIN
SET @stringData=@stringData+'''convert(money,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0.0000'')+''''''),''+';
END;
ELSE
BEGIN
IF @dataType='datetime'
BEGIN
SET @stringData=@stringData+'''convert(datetime,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0'')+''''''),''+';
END;
ELSE
BEGIN
IF @dataType='image'
BEGIN
SET @stringData=@stringData+'''''''''+
       isnull(cast(convert(varbinary,'+@colName+') 
       as varchar(6)),''0'')+'''''',''+';
END;
ELSE --presuming the data type is int,bit,numeric,decimal 
BEGIN
SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(200)),''0'')+'''''',''+';
END;
END;
END;
END;
END;
SET @string=@string+@colName+',';
FETCH NEXT FROM cursCol INTO @colName , @dataType;
END;
DECLARE @Query NVARCHAR(4000); -- provide for the whole query, 
        -- you may increase the size
SET @query='SELECT '''+SUBSTRING(@string , 0 , LEN(@string))+') 
    VALUES(''+ '+SUBSTRING(@stringData , 0 , LEN(@stringData)-2)+'''+'')'' 
    FROM '+@tableName;
EXEC sp_executesql @query; --load and run the built query 
CLOSE cursCol;
DEALLOCATE cursCol;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ListAllStoredProcedures]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ListAllStoredProcedures]
AS
    BEGIN
        DECLARE @procName VARCHAR(100);
        DECLARE @getprocName CURSOR;
        SET @getprocName = CURSOR
        FOR SELECT Name = '[' + SCHEMA_NAME(SCHEMA_ID) + '].[' + Name + ']'
            FROM sys.all_objects
            WHERE TYPE = 'P'
                  AND 
                  is_ms_shipped = 1;
        OPEN @getprocName;
        FETCH NEXT FROM @getprocName INTO @procName;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                PRINT 'sp_HelpText ' + @procName;
                EXEC sp_HelpText @procName;
                FETCH NEXT FROM @getprocName INTO @procName;
            END;
        CLOSE @getprocName;
        DEALLOCATE @getprocName;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SP_PrimeNumbers]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PrimeNumbers]
AS
    BEGIN
        DECLARE @i INT , @a INT , @count INT;
        SET @i = 1;
        WHILE @i <= 500
            BEGIN
                SET @count = 0;
                SET @a = 1;
                WHILE @a <= @i
                    BEGIN
                        IF @i % @a = 0
                            BEGIN
                                SET @count = @count + 1;
                        END;
                        SET @a = @a + 1;
                    END;
                IF @count = 2
                    BEGIN
                        PRINT @i;
                END;
                SET @i = @i + 1;
            END;
    END; 
GO
/****** Object:  StoredProcedure [dbo].[sp_PrintImmediate]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_PrintImmediate] (
       @MSG AS NVARCHAR (MAX)) 
AS
BEGIN
    RAISERROR (@MSG , 10, 1) WITH NOWAIT;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_QuickRowCount]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*----------------------------------------------------------------
use KenticoCMS_Datamart_2
declare @i as bigint = 0 ;
EXEC @i = sp_QuickRowCount 'Device_RawNotification' ;
print @i ;

    DECLARE
       @iTotal AS bigint = 0;

    EXEC @iTotal = sp_QuickRowCount 'FACT_EDW_RewardUserDetail';

    IF @iTotal = 1
        BEGIN
            SET @Reloadall = 1;
        END;
*/

CREATE PROCEDURE [dbo].[sp_QuickRowCount] (
       @TblName AS NVARCHAR (254) 
     , @ShowRecCount AS BIT = 0) 
AS
BEGIN

/*-----------------------------------------------
    Author:	 Dale Miller
    Date:		 02.02.2008
    Copyright:  DMA, Ltd., Chicago, IL
*/
set NOCOUNT on
    DECLARE
           @i AS BIGINT = 0;

    SET @i = ( SELECT
                      SUM ( row_count) 
               FROM sys.dm_db_partition_stats
               WHERE
                      object_id = OBJECT_ID ( @TblName) AND
                      (
                        index_id = 0 OR
                        index_id = 1)) ;
    IF @i IS NULL
        BEGIN
            SET @i = 0
        END;
    IF
           @ShowRecCount = 1
        BEGIN
            PRINT @i
        END;
set NOCOUNT off
    RETURN @i;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_Remove_Expired_Content]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Remove_Expired_Content]
AS
    BEGIN
        DELETE FROM SourceAttribute
        WHERE SourceGuid IN ( SELECT sourceguid
                              FROM DataSource
                              WHERE RetentionExpirationDate <= GETDATE()
                            );
        DELETE FROM SourceAttribute
        WHERE SourceGuid IN ( SELECT sourceguid
                              FROM DataSource
                              WHERE RetentionExpirationDate <= GETDATE()
                            );
        DELETE FROM DataSource
        WHERE RetentionExpirationDate <= GETDATE();
        DELETE FROM EmailAttachment
        WHERE EmailGuid IN ( SELECT EmailGuid
                             FROM Email
                             WHERE RetentionExpirationDate <= GETDATE()
                           );
    END;
GO
/****** Object:  StoredProcedure [dbo].[SP_SDA_LibraryItemsInsert]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select top 1000 * from LibraryItems

CREATE PROCEDURE [dbo].[SP_SDA_LibraryItemsInsert] ( 
                @SourceGuid            NVARCHAR(50) , 
                @ItemTitle             NVARCHAR(254) , 
                @ItemType              NVARCHAR(50) , 
                @LibraryItemGuid       NVARCHAR(50) , 
                @DataSourceOwnerUserID NVARCHAR(50) , 
                @LibraryOwnerUserID    NVARCHAR(50) , 
                @LibraryName           NVARCHAR(80) , 
                @AddedByUserGuidId     NVARCHAR(50)
                                              ) 
AS
    BEGIN
        IF EXISTS ( SELECT 1
                    FROM LibraryItems
                    WHERE SourceGuid = @SourceGuid
                          AND 
                          LibraryName = @LibraryName
                  ) 
            BEGIN
                RETURN 0;
        END;
        INSERT INTO LibraryItems ( SourceGuid , ItemTitle , ItemType , LibraryItemGuid , DataSourceOwnerUserID , LibraryOwnerUserID , LibraryName , AddedByUserGuidId
                                 ) 
        VALUES ( @SourceGuid , @ItemTitle , @ItemType , @LibraryItemGuid , @DataSourceOwnerUserID , @LibraryOwnerUserID , @LibraryName , @AddedByUserGuidId
               );
        RETURN 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SetHashDir]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_SetHashDir] (@SourceGuid nvarchar(50), @dirname nvarchar(MAX))
as
Begin
	set @dirname = upper(@dirname);
	declare @Hash nvarchar(125) = '';
	declare @i int = 0 ;

	set @Hash = (select UPPER(convert(char(128), HASHBYTES('sha2_512', @dirname), 1)));
	
	set @i = (select count(1) from DataSourceFQN where FqnHASH = @Hash)
	if @i = 0 
		insert into DataSourceFQN(FqnHASH, fqn) values (@Hash, @dirname);
	if @i > 0
		update DataSourceFQN set FqnHASH = @Hash where FQN = @dirname;

	update DataSource set FqnHASH = @Hash where SourceGuid = @SourceGuid;
	
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetRetentionDates]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_SetRetentionDates] as
begin
	DECLARE @TempDirName VARCHAR(750) = '';
	DECLARE @DirName VARCHAR(750) = '';	
	DECLARE @RetentionCode VARCHAR(50) = ''; 
	DECLARE @RetentionUnits int = 0 ;
	DECLARE @fileDate VARCHAR(20) = '' ;

	DECLARE db_cursor CURSOR FOR 
	select FQN, RetentionCode from directory order by RetentionCode

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @DirName, @RetentionCode

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
			set @TempDirName = @DirName + '%';
			SET @RetentionUnits = (select RetentionUnits from retention where RetentionCode = @RetentionCode)
			update DataSource set RetentionCode = @RetentionCode, RetentionDate = DATEADD(year, @RetentionUnits, RowCreationDate), RepoSvrName = @@SERVERNAME
			where Fqn like @TempDirName;
			print 'Updated: ' + @DirName ;
			FETCH NEXT FROM db_cursor INTO @DirName, @RetentionCode
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ShrinkAllLogs]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_ShrinkAllLogs]
as
DECLARE @Name NVARCHAR(50)
DECLARE cur CURSOR FOR

SELECT [name]
FROM [sys].[database_files] 
where [type] = 1

OPEN cur
FETCH NEXT FROM cur INTO @Name
WHILE @@FETCH_STATUS = 0
BEGIN
	print @name
    DBCC SHRINKFILE(@Name, 1)
    FETCH NEXT FROM cur INTO @Name
END
CLOSE cur
DEALLOCATE cur
GO
/****** Object:  StoredProcedure [dbo].[spAddAvailExtensions]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spAddAvailExtensions]
as
begin
CREATE TABLE #temp (
componenttype nvarchar(100) null,
componentname nvarchar(100) null,
clsid nvarchar(100) null,
fullpath nvarchar(500) null,
version nvarchar(100) null,
manufacturer nvarchar(100) null
);

INSERT INTO #temp
EXEC sp_help_fulltext_system_components 'filter';

--insert into [AvailFileTypes] (ExtCode, RepoSvrName, RowCreationDate, RowLastModDate, RowGuid)
--select A.ExtCode,@@SERVERNAME, getdate(), getdate(), newID()
--from #temp T, [AvailFileTypes] A
--where ComponentName Not in (SELECT ExtCode FROM [AvailFileTypes])

declare @name nvarchAR(50) = '';
DECLARE db_cursor CURSOR FOR
SELECT componenttype
FROM #temp

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN
if not exists (select 1 from [AvailFileTypes] where ExtCode = @name)
begin
insert into [AvailFileTypes] (ExtCode, RepoSvrName, RowCreationDate, RowLastModDate, RowGuid)
values (@name,@@SERVERNAME, getdate(), getdate(), newID());
end

FETCH NEXT FROM db_cursor INTO @name
END

CLOSE db_cursor
DEALLOCATE db_cursor
end
GO
/****** Object:  StoredProcedure [dbo].[spCalcEmailAttachmentSpace]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

CREATE PROCEDURE [dbo].[spCalcEmailAttachmentSpace]
AS
    BEGIN
        UPDATE EmailAttachment
               SET RecLen = LEN(EmailGuid) + DATALENGTH(Attachment) + LEN(ISNULL(AttachmentName , 0)) + LEN(ISNULL(EmailGuid , 0)) + LEN(ISNULL(AttachmentCode , 0)) + LEN(ISNULL(RowID , 0)) + LEN(ISNULL(AttachmentType , 0)) + LEN(ISNULL(UserID , 0)) + LEN(ISNULL(isZipFileEntry , 0)) + LEN(ISNULL(OcrText , 0)) + LEN(ISNULL(isPublic , 0)) + LEN(ISNULL(AttachmentLength , 0)) + LEN(ISNULL(OriginalFileTypeCode , 0)) + LEN(ISNULL(HiveConnectionName , 0)) + LEN(ISNULL(HiveActive , 0)) + LEN(ISNULL(RepoSvrName , 0)) + LEN(ISNULL(RowCreationDate , 0)) + LEN(ISNULL(RowLastModDate , 0))
        WHERE RecLen IS NULL;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spContentContainervalidate]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spContentContainervalidate]
AS
    BEGIN
        INSERT INTO ContentContainer ( ContentUserRowGuid , ContainerGuid
                                     ) 
               SELECT DISTINCT 
                      ContentUser.ContentUserRowGuid , Container.ContainerGuid
               FROM Container INNER JOIN DataSource ON Container.ContainerName = DataSource.FileDirectory
                              INNER JOIN ContentUser ON DataSource.SourceGuid = ContentUser.ContentGuid
               WHERE ContentUserRowGuid NOT IN ( SELECT ContentUserRowGuid
                                                 FROM ContentContainer
                                               );
    END;  
GO
/****** Object:  StoredProcedure [dbo].[spEXECsp_RECOMPILE]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec spEXECsp_RECOMPILE

CREATE PROCEDURE [dbo].[spEXECsp_RECOMPILE]
AS
    BEGIN

/*
----------------------------------------------------------------------------
-- Object Name: dbo.spEXECsp_RECOMPILE 
-- Project: SQL Server 2005/2008Database Maintenance
-- Purpose: Execute sp_recompile for all tables in a database
-- Detailed Description: Execute sp_recompile for all tables in a database
-- Database: Admin
-- Dependent Objects: None
-- Called By: TBD
-- Upstream Systems: None
-- Downstream Systems: None
-- W. Dale Miller
*/

        SET NOCOUNT ON;
        -- 1a - Declaration statements for all variables
        DECLARE @TableName VARCHAR(128);
        DECLARE @OwnerName VARCHAR(128);
        DECLARE @CMD1 VARCHAR(8000);
        DECLARE @TableListLoop INT;
        DECLARE @TableListTable TABLE ( 
                                      UIDTableList INT IDENTITY(1 , 1) , 
                                      OwnerName    VARCHAR(128) , 
                                      TableName    VARCHAR(128)
                                      );
        -- 2a - Outer loop for populating the database names
        INSERT INTO @TableListTable ( OwnerName , TableName
                                    ) 
               SELECT u.Name , o.Name
               FROM dbo.sysobjects AS o INNER JOIN dbo.sysusers AS u ON o.uid = u.uid
               WHERE o.Type = 'U'
               ORDER BY o.Name;
        -- 2b - Determine the highest UIDDatabaseList to loop through the records
        SELECT @TableListLoop = MAX(UIDTableList)
        FROM @TableListTable;
        -- 2c - While condition for looping through the database records
        WHILE @TableListLoop > 0
            BEGIN
                -- 2d - Set the @DatabaseName parameter
                SELECT @TableName = TableName , @OwnerName = OwnerName
                FROM @TableListTable
                WHERE UIDTableList = @TableListLoop;
                -- 3f - String together the final backup command
                SELECT @CMD1 = 'EXEC sp_recompile ' + '[' + @OwnerName + '.' + @TableName + ']' + CHAR(13);
                -- 3g - Execute the final string to complete the backups
                -- SELECT @CMD1
                EXEC (@CMD1);
                -- 2h - Descend through the database list
                SELECT @TableListLoop = @TableListLoop - 1;
            END;
        SET NOCOUNT OFF;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spFindUnindexedFiles]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec spFindUnindexedFiles
create procedure [dbo].[spFindUnindexedFiles]
as
begin
create table #iFilters(
	Componenttype nvarchAR(50) NULL,
	Componentname nvarchAR(50) NULL,
	clsid nvarchAR(50) NULL,
	fullpath nvarchAR(250) NULL,
	[version] nvarchAR(50) NULL,
	manufacturer nvarchAR(150) NULL,
)
insert into #iFilters
EXEC sp_help_fulltext_system_components 'filter'; 
select SourceName, OriginalFileType,SourceTypeCode, 
CASE
    WHEN OriginalFileType in (select ImageTypeCode from ImageTypeCodes) then 'Y'
    ELSE 'N' 
END as OcrReq,
RowGuid from DataSource 
where OriginalFileType not in (select Componentname from #iFilters) 
and SourceTypeCode not in (select Componentname from #iFilters)
end
GO
/****** Object:  StoredProcedure [dbo].[spFtiStatus]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec spFtiStatus
ALTER FULLTEXT CATALOG ftCatalog REBUILD
ALTER FULLTEXT CATALOG ftDataSourceImage REBUILD
ALTER FULLTEXT CATALOG ftEmailCatalog REBUILD
ALTER FULLTEXT CATALOG ftEmailAttachment REBUILD
ALTER FULLTEXT CATALOG ftEmail REBUILD

*/
CREATE PROCEDURE [dbo].[spFtiStatus]
AS
    BEGIN
	/*
	Here is the description of the columns of this script result set:

	- db_name – Name of the SQL Server database, unique within an instance of SQL Server
	- is_ft_enabled – The value of 1 indicates that the full-text and semantic indexing is enabled
	- ft_catalog_file_logical_name – Returns the logical file name of the full-text index catalog file
	- ft_catalog_file_physical_name – Returns the phyisical file name of the full-text index catalog file
	- table_name – Returns the name of the table where full-text index exists
	- ft_catalog_logical_index_size_in_mb – Returns the logical size of the full-text catalog in megabytes(MB)
	- is_accent_sensitive – Returns the accent-sensitivity setting for full-text catalog. The value of 1 indicates that full-text catalog is accent sensitive
	- unique_key_count – Returns the number of unique keys in the full-text catalog
	- row_count_in_thousands – Returns the estimated number of rows (in thousands) in all full-text indexes in this full-text catalog
	- is_clustered_index_scan – Indicates whether the population involves a scan on the clustered index
	- range_count – Returns the number of sub-ranges into which this population has been parallelized
	- import_status – Indicates whether the full-text catalog is being imported. The value of 1 indicates that the full-text catalog is being imported
	- current_state_of_fts_catalog – Returns the state of the full-text catalog
	- is_paused – Indicates whether the population of the active full-text catalog has been paused
	- population_status – Returns the status of current population
	- ft_catalog_population_type – Returns the type of full-text catalog population type
	- status_of_population – Returns the status of this population
	- completion_type_description – Returns the description of status of the population
	- queued_population_type_description – Returns description of the population to follow, if any. For example, when CHANGE TRACKING = AUTO and the initial full population is in progress, this column would show “Auto population.”
	- start_time – Returns the time that the population started.
	- last_populated – Returns the time when the last full-text index population completed

	*/
        SELECT DB_NAME(ftsac.[database_id]) AS [db_name], 
               DATABASEPROPERTYEX(DB_NAME(ftsac.[database_id]), 'IsFulltextEnabled') AS [is_ft_enabled], 
               ftsac.[name] AS [catalog_name], 
               mfs.[name] AS [ft_catalog_file_logical_name], 
               mfs.[physical_name] AS [ft_catalog_file_physical_name], 
               OBJECT_NAME(ftsip.[table_id]) AS [table_name], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'IndexSize') AS [ft_catalog_logical_index_size_in_mb], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'AccentSensitivity') AS [is_accent_sensitive], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'UniqueKeyCount') AS [unique_key_count], 
               ftsac.[row_count_in_thousands], 
               ftsip.[is_clustered_index_scan], 
               ftsip.[range_count], 
               FULLTEXTCATALOGPROPERTY(ftsac.[name], 'ImportStatus') AS [import_status], 
               ftsac.[status_description] AS [current_state_of_fts_catalog], 
               ftsac.[is_paused], 
        (
            SELECT CASE FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateStatus')
                       WHEN 0
                       THEN 'Idle'
                       WHEN 1
                       THEN 'Full Population In Progress'
                       WHEN 2
                       THEN 'Paused'
                       WHEN 3
                       THEN 'Throttled'
                       WHEN 4
                       THEN 'Recovering'
                       WHEN 5
                       THEN 'Shutdown'
                       WHEN 6
                       THEN 'Incremental Population In Progress'
                       WHEN 7
                       THEN 'Building Index'
                       WHEN 8
                       THEN 'Disk Full. Paused'
                       WHEN 9
                       THEN 'Change Tracking'
                   END
        ) AS [population_status], 
               ftsip.[population_type_description] AS [ft_catalog_population_type], 
               ftsip.[status_description] AS [status_of_population], 
               ftsip.[completion_type_description], 
               ftsip.[queued_population_type_description], 
               ftsip.[start_time], 
               DATEADD(ss, FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateCompletionAge'), '1/1/1990') AS [last_populated],
			   DATEDIFF(second,ftsip.[start_time], DATEADD(ss, FULLTEXTCATALOGPROPERTY(ftsac.[name], 'PopulateCompletionAge'), '1/1/1990')) AS RunTimeSecs
        FROM [sys].[dm_fts_active_catalogs] ftsac
             INNER JOIN [sys].[databases] dbs ON dbs.[database_id] = ftsac.[database_id]
             LEFT JOIN [sys].[master_files] mfs ON mfs.[database_id] = dbs.[database_id]
                                                   AND mfs.[physical_name] NOT LIKE '%.mdf'
                                                   AND mfs.[physical_name] NOT LIKE '%.ndf'
                                                   AND mfs.[physical_name] NOT LIKE '%.ldf'
             CROSS JOIN [sys].[dm_fts_index_population] ftsip
        WHERE ftsac.[database_id] = ftsip.[database_id]
              AND ftsac.[catalog_id] = ftsip.[catalog_id];
    END;
GO
/****** Object:  StoredProcedure [dbo].[spGetAllDBStats2]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spGetAllDBStats2]
AS
    BEGIN
        ----------------------------------------------------------------
        -- Purpose:
        --    This SP Returns Data and Log File Sizes For all Databases,
        --    Along With Percent Capacity Used.
        --    Uses a Bunch of Dynamic SQL and DBCC Calls.
        -- 
        --  LIMITATIONS: For Databases With Multiple FILEGROUPS,
        --               it will only list information on one (the last)
        --               FILEGROUP!
        --
        -- Database:  (All)
        --
        -- History:
        --  
        --   Who       When      What
        --   ---       --------  ----------------------------------
        --   WDM       6.8.04    Created SP  
        ----------------------------------------------------------------
        DECLARE @buf VARCHAR(512);
        DECLARE @db_name VARCHAR(80);
        SET NOCOUNT ON;
        -- Create Two Temporary Tables
        CREATE TABLE #T ( 
                     _DBName           VARCHAR(80) NOT NULL , 
                     _LogSizeMB        FLOAT NULL , 
                     _LogSpaceUsedPct  FLOAT NULL , 
                     _LogFileName      VARCHAR(255) NULL , 
                     _LogTotalExtents  INT NULL , 
                     _LogUsedExtents   INT NULL , 
                     _DataSizeMB       FLOAT NULL , 
                     _DataFileName     VARCHAR(255) NULL , 
                     _DataTotalExtents INT NULL , 
                     _DataUsedExtents  INT NULL , 
                     _DataSpaceUsedPct FLOAT NULL , 
                     _Status           INT NULL
                        );
        CREATE TABLE #T2 ( 
                     _Fileid       INT , 
                     _FileGroup    INT , 
                     _TotalExtents INT , 
                     _UsedExtents  INT , 
                     _Name         VARCHAR(255) , 
                     _FileName     VARCHAR(255)
                         );
        -- PHASE I -- Run DBCC SQLPERF(Logspace)
        INSERT INTO #T ( _DBName , _LogSizeMB , _LogSpaceUsedPct , _Status
                       ) 
        EXEC ('DBCC SQLPERF(LOGSPACE)');
        -- PHASE II -- 
        -- Create cursor for cycling through databases
        DECLARE MyCursor CURSOR
        FOR SELECT _DBName
            FROM #T;
        -- Execute the cursor
        OPEN MyCursor;
        FETCH NEXT FROM MyCursor INTO @db_name;
        -- Do Until All Databases Exhausted...
        WHILE @@fetch_status <> -1
            BEGIN
                -- Query To Get Log File and Size Info
                SELECT @buf = "UPDATE #T" + " SET _LogFileName = X.[filename], _LogTotalExtents = X.[size]" + " FROM #T," + " (SELECT '" + @db_name + "' AS 'DBName'," + " fileid, [filename], [size] FROM " + @db_name + ".dbo.sysfiles WHERE (status & 0x40 <> 0)) X" + " WHERE X.DBName = #T._DBName";
                --PRINT @buf
                EXEC (@buf);
                -- "DBCC showfilestats" Query To Get Data File and Size Info
                DELETE FROM #T2;
                SELECT @buf = 'INSERT INTO #T2' + '(_Fileid, _FileGroup, _TotalExtents, _UsedExtents, _Name, _FileName)' + " EXEC ('USE " + @db_name + "; DBCC showfilestats')";
                -- PRINT @buf
                EXEC (@buf);
                -- Update the Data Info., and Calculate the Remaining Entities
                UPDATE #T
                       SET _DataFileName = #T2._FileName , _DataTotalExtents = #T2._TotalExtents , _DataUsedExtents = #T2._UsedExtents , _LogUsedExtents = CONVERT(INT , _LogSpaceUsedPct * _LogTotalExtents / 100.0) , _DataSpaceUsedPct = 100.0 * CONVERT(FLOAT , #T2._UsedExtents) / CONVERT(FLOAT , #T2._TotalExtents) , _DataSizeMB = CONVERT(FLOAT , #T2._TotalExtents) / 16.0
                FROM #T , #T2
                WHERE _DBName = @db_name;
                -- Go to Next Cursor Row
                FETCH NEXT FROM MyCursor INTO @db_name;
            END;
        -- Close Cursor
        CLOSE MyCursor;
        DEALLOCATE MyCursor;
        -- Return Results to User
        SELECT _DBName , _LogFileName , _LogSizeMB , _LogTotalExtents , _LogUsedExtents , CONVERT(DECIMAL(6 , 2) , _LogSpaceUsedPct) AS '_PercentLogSpaceUsed' , _DataFileName , _DataSizeMB , _DataTotalExtents , _DataUsedExtents , CONVERT(DECIMAL(6 , 2) , _DataSpaceUsedPct) AS '_PercentDataSpaceUsed'
        FROM #T
        ORDER BY _DBName;
        -- Clean Up
        DROP TABLE #T;
        DROP TABLE #T2;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spGetAllTableSizes]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spGetAllTableSizes]
AS
    BEGIN

/*
    Obtains spaced used data for ALL user tables in the database
*/

        DECLARE @TableName VARCHAR(100);    --For storing values in the cursor
        --Cursor to get the name of all user tables from the sysobjects listing
        DECLARE tableCursor CURSOR
        FOR SELECT name
            FROM dbo.sysobjects
            WHERE OBJECTPROPERTY(id , N'IsUserTable') = 1
        FOR READ ONLY;
        --A procedure level temp table to store the results
        CREATE TABLE #TempTable ( 
                     tableName    VARCHAR(100) , 
                     numberofRows VARCHAR(100) , 
                     reservedSize VARCHAR(50) , 
                     dataSize     VARCHAR(50) , 
                     indexSize    VARCHAR(50) , 
                     unusedSize   VARCHAR(50)
                                );
        --Open the cursor
        OPEN tableCursor;
        --Get the first table name from the cursor
        FETCH NEXT FROM tableCursor INTO @TableName;
        --Loop until the cursor was not able to fetch
        WHILE @@Fetch_Status >= 0
            BEGIN
                --Dump the results of the sp_spaceused query to the temp table
                INSERT INTO #TempTable
                EXEC sp_spaceused @TableName;
                --Get the next table name
                FETCH NEXT FROM tableCursor INTO @TableName;
            END;
        --Get rid of the cursor
        CLOSE tableCursor;
        DEALLOCATE tableCursor;
        --Select all records so we can use the reults
        SELECT *
        FROM #TempTable;
        --Final cleanup!
        DROP TABLE #TempTable;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spIndexUsage]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
IndexUsage
By W. Dale Miller

Reports index stats, index size+rows, member seek + include columns as two comma separated output columns, and index usage 
stats for one or more tables and/or schemas.  Flexible parameterized sorting.
Has all the output of Util_ListIndexes plus the usage stats.

Required Input Parameters
	none

Optional
	@SchemaName sysname=''		Filters schemas.  Can use LIKE wildcards.  All schemas if blank.  Accepts LIKE 

Wildcards.
	@TableName sysname=''		Filters tables.  Can use LIKE wildcards.  All tables if blank.  Accepts LIKE 

Wildcards.
	@Sort Tinyint=5				Determines what to sort the results by:
									Value	Sort Columns
									1		Score DESC, user_seeks DESC, 

user_scans DESC
									2		Score ASC, user_seeks ASC, 

user_scans ASC
									3		SchemaName ASC, TableName ASC, 

IndexName ASC
									4		SchemaName ASC, TableName ASC, 

Score DESC
									5		SchemaName ASC, TableName ASC, 

Score ASC
	@Delimiter VarChar(1)=','	Delimiter for the horizontal delimited seek and include column listings.

Usage:
	EXECUTE Util_IndexUsage 'dbo', 'order%', 5, '|'

Copyright:
	Licensed under the L-GPL - a weak copyleft license - you are permitted to use this as a component of a proprietary 

database and call this from proprietary software.
	Copyleft lets you do anything you want except plagarize, conceal the source, proprietarize modifications, or 

prohibit copying & re-distribution of this script/proc.

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    see <http://www.fsf.org/licensing/licenses/lgpl.html> for the license text.

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
**/

CREATE PROCEDURE [dbo].[spIndexUsage] 
                @SchemaName SYSNAME    = '' , 
                @TableName  SYSNAME    = '' , 
                @Sort       TINYINT    = 5 , 
                @Delimiter  VARCHAR(1) = ','
AS
    BEGIN
        SELECT sys.schemas.schema_id , sys.schemas.name AS schema_name , sys.objects.object_id , sys.objects.name AS object_name , sys.indexes.index_id , ISNULL(sys.indexes.name , '---') AS index_name , partitions.Rows , partitions.SizeMB , INDEXPROPERTY(sys.objects.object_id , sys.indexes.name , 'IndexDepth') AS IndexDepth , sys.indexes.type , sys.indexes.type_desc , sys.indexes.fill_factor , sys.indexes.is_unique , sys.indexes.is_primary_key , sys.indexes.is_unique_constraint , ISNULL(Index_Columns.index_columns_key , '---') AS index_columns_key , ISNULL(Index_Columns.index_columns_include , '---') AS index_columns_include , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0) AS user_seeks , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0) AS user_scans , ISNULL(sys.dm_db_index_usage_stats.user_lookups , 0) AS user_lookups , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0) AS user_updates , sys.dm_db_index_usage_stats.last_user_seek , sys.dm_db_index_usage_stats.last_user_scan , sys.dm_db_index_usage_stats.last_user_lookup , sys.dm_db_index_usage_stats.last_user_update , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0) AS system_seeks , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0) AS system_scans , ISNULL(sys.dm_db_index_usage_stats.system_lookups , 0) AS system_lookups , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0) AS system_updates , sys.dm_db_index_usage_stats.last_system_seek , sys.dm_db_index_usage_stats.last_system_scan , sys.dm_db_index_usage_stats.last_system_lookup , sys.dm_db_index_usage_stats.last_system_update , ( ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0)) ) * 10 + CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            WHEN sys.indexes.type = 2
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            THEN ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0)) ) * 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ELSE 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        END + 1 ) / CASE
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        WHEN sys.indexes.type = 2
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        THEN CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0)) + 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ELSE 1
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    END AS Score
        FROM sys.objects JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id
                         JOIN sys.indexes ON sys.indexes.object_id = sys.objects.object_id
                         JOIN ( SELECT object_id , index_id , SUM(row_count) AS Rows , CONVERT(NUMERIC(19 , 3) , CONVERT(NUMERIC(19 , 3) , SUM(in_row_reserved_page_count + lob_reserved_page_count + row_overflow_reserved_page_count)) / CONVERT(NUMERIC(19 , 3) , 128)) AS SizeMB
                                FROM sys.dm_db_partition_stats
                                GROUP BY object_id , index_id
                              ) AS partitions ON sys.indexes.object_id = partitions.object_id
                                                 AND 
                                                 sys.indexes.index_id = partitions.index_id
                         CROSS APPLY ( SELECT LEFT(index_columns_key , LEN(index_columns_key) - 1) AS index_columns_key , LEFT(index_columns_include , LEN(index_columns_include) - 1) AS index_columns_include
                                       FROM ( SELECT ( SELECT sys.columns.name + @Delimiter + ' '
                                                       FROM sys.index_columns JOIN sys.columns ON sys.index_columns.column_id = sys.columns.column_id
                                                                                                  AND 
                                                                                                  sys.index_columns.object_id = sys.columns.object_id
                                                       WHERE sys.index_columns.is_included_column = 0
                                                             AND 
                                                             sys.indexes.object_id = sys.index_columns.object_id
                                                             AND 
                                                             sys.indexes.index_id = sys.index_columns.index_id
                                                       ORDER BY key_ordinal FOR XML PATH('')
                                                     ) AS index_columns_key , ( SELECT sys.columns.name + @Delimiter + ' '
                                                                                FROM sys.index_columns JOIN sys.columns ON sys.index_columns.column_id = sys.columns.column_id
                                                                                                                           AND 
                                                                                                                           sys.index_columns.object_id = sys.columns.object_id
                                                                                WHERE sys.index_columns.is_included_column = 1
                                                                                      AND 
                                                                                      sys.indexes.object_id = sys.index_columns.object_id
                                                                                      AND 
                                                                                      sys.indexes.index_id = sys.index_columns.index_id
                                                                                ORDER BY index_column_id FOR XML PATH('')
                                                                              ) AS index_columns_include
                                            ) AS Index_Columns
                                     ) AS Index_Columns
                         LEFT OUTER JOIN sys.dm_db_index_usage_stats ON sys.indexes.index_id = sys.dm_db_index_usage_stats.index_id
                                                                        AND 
                                                                        sys.indexes.object_id = sys.dm_db_index_usage_stats.object_id
                                                                        AND 
                                                                        sys.dm_db_index_usage_stats.database_id = DB_ID()
        WHERE sys.objects.type = 'u'
              AND 
              sys.schemas.name LIKE CASE
                                        WHEN @SchemaName = ''
                                        THEN sys.schemas.name
                                        ELSE @SchemaName
                                    END
              AND 
              sys.objects.name LIKE CASE
                                        WHEN @TableName = ''
                                        THEN sys.objects.name
                                        ELSE @TableName
                                    END
        ORDER BY CASE @Sort
                     WHEN 1
                     THEN ( ( ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0)) ) * 10 + CASE
                                                                                                                                                                                                             WHEN sys.indexes.type = 2
                                                                                                                                                                                                             THEN ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0)) ) * 1
                                                                                                                                                                                                             ELSE 0
                                                                                                                                                                                                         END + 1 ) / CASE
                                                                                                                                                                                                                         WHEN sys.indexes.type = 2
                                                                                                                                                                                                                         THEN CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0)) + 1
                                                                                                                                                                                                                         ELSE 1
                                                                                                                                                                                                                     END ) * -1
                     WHEN 2
                     THEN ( ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0)) ) * 10 + CASE
                                                                                                                                                                                                           WHEN sys.indexes.type = 2
                                                                                                                                                                                                           THEN ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0)) ) * 1
                                                                                                                                                                                                           ELSE 0
                                                                                                                                                                                                       END + 1 ) / CASE
                                                                                                                                                                                                                       WHEN sys.indexes.type = 2
                                                                                                                                                                                                                       THEN CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0)) + 1
                                                                                                                                                                                                                       ELSE 1
                                                                                                                                                                                                                   END
                     ELSE NULL
                 END ,
                 CASE @Sort
                     WHEN 3
                     THEN sys.schemas.name
                     WHEN 4
                     THEN sys.schemas.name
                     WHEN 5
                     THEN sys.schemas.name
                     ELSE NULL
                 END ,
                 CASE @Sort
                     WHEN 1
                     THEN CONVERT(VARCHAR(10) , sys.dm_db_index_usage_stats.user_seeks * -1)
                     WHEN 2
                     THEN CONVERT(VARCHAR(10) , sys.dm_db_index_usage_stats.user_seeks)
                     ELSE NULL
                 END ,
                 CASE @Sort
                     WHEN 3
                     THEN sys.objects.name
                     WHEN 4
                     THEN sys.objects.name
                     WHEN 5
                     THEN sys.objects.name
                     ELSE NULL
                 END ,
                 CASE @Sort
                     WHEN 1
                     THEN sys.dm_db_index_usage_stats.user_scans * -1
                     WHEN 2
                     THEN sys.dm_db_index_usage_stats.user_scans
                     WHEN 4
                     THEN ( ( ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0)) ) * 10 + CASE
                                                                                                                                                                                                             WHEN sys.indexes.type = 2
                                                                                                                                                                                                             THEN ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0)) ) * 1
                                                                                                                                                                                                             ELSE 0
                                                                                                                                                                                                         END + 1 ) / CASE
                                                                                                                                                                                                                         WHEN sys.indexes.type = 2
                                                                                                                                                                                                                         THEN CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0)) + 1
                                                                                                                                                                                                                         ELSE 1
                                                                                                                                                                                                                     END ) * -1
                     WHEN 5
                     THEN ( ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_seeks , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_seeks , 0)) ) * 10 + CASE
                                                                                                                                                                                                           WHEN sys.indexes.type = 2
                                                                                                                                                                                                           THEN ( CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_scans , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_scans , 0)) ) * 1
                                                                                                                                                                                                           ELSE 0
                                                                                                                                                                                                       END + 1 ) / CASE
                                                                                                                                                                                                                       WHEN sys.indexes.type = 2
                                                                                                                                                                                                                       THEN CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.user_updates , 0)) + CONVERT(NUMERIC(19 , 6) , ISNULL(sys.dm_db_index_usage_stats.system_updates , 0)) + 1
                                                                                                                                                                                                                       ELSE 1
                                                                                                                                                                                                                   END
                     ELSE NULL
                 END ,
                 CASE @Sort
                     WHEN 3
                     THEN sys.indexes.name
                     ELSE NULL
                 END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spInsertDirectoryLongName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec spInsertDirectoryLongName 'c:\wdm'
-- select * from [dbo].[DirectoryLongName]
create procedure [dbo].[spInsertDirectoryLongName] (@DirName varchar(max) )
as
begin
insert into [dbo].[DirectoryLongName] ([DirLongName]) values (@DirName)
end

GO
/****** Object:  StoredProcedure [dbo].[spInsertFileLongName]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec spInsertFileLongName 'c:\wdm'
-- select * from [dbo].[FileLongName]
create procedure [dbo].[spInsertFileLongName] (@FName varchar(max) )
as
begin
insert into [dbo].[FileLongName] ([FilesLongName]) values (@FName)
end

GO
/****** Object:  StoredProcedure [dbo].[spSaveClickStat]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSaveClickStat] 
                @LocationID INT , 
                @UID        NVARCHAR(50)
AS
    BEGIN
        INSERT INTO StatsClick ( LocationID , UserID
                               ) 
        VALUES ( @LocationID , @UID
               );
    END;
GO
/****** Object:  StoredProcedure [dbo].[spSaveWordStat]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spSaveWordStat] 
                @Word       NVARCHAR(100) , 
                @UID        NVARCHAR(50) , 
                @TypeSearch CHAR(1)
AS
    BEGIN
        DECLARE @i INT;
        IF NOT EXISTS ( SELECT WordID
                        FROM StatWord
                        WHERE Word = @word
                      ) 
            BEGIN
                INSERT INTO StatWord ( word
                                     ) 
                VALUES ( @word
                       );
        END;
        SET @i = ( SELECT WordID
                   FROM StatWord
                   WHERE Word = @word
                 );
        INSERT INTO StatSearch ( WordID , UserID , TypeSearch
                               ) 
        VALUES ( @i , @UID , @TypeSearch
               );
    END;
GO
/****** Object:  StoredProcedure [dbo].[spTest]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spTest]
AS
    BEGIN
        DECLARE @counter INT= 0;
        WHILE @counter <= 100
            BEGIN
                SET @counter = @counter + 1;
                IF @counter % 10 = 0
                    BEGIN
                        PRINT @counter;
                END;
            END;
    END;        
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmailMsg]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*CurrentUser, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime*/

CREATE PROCEDURE [dbo].[spUpdateEmailMsg] 
                @EmailGuid  NVARCHAR(50) , 
                @EmailImage IMAGE
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE Email
               SET EmailImage = @EmailImage
        WHERE EmailGuid = @EmailGuid;
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateLongNameHash]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spUpdateLongNameHash](@FQN varchar(8000), @SourceGuid nvarchar(50))
as
begin
declare @hash varchar(128) = '';
declare @i as int = 0 ;

set @FQN = upper(@FQN);
set @hash = (SELECT convert(char(128), HASHBYTES('sha2_512', @FQN), 1) )

update DataSource set [FqnHASH] = @hash where SourceGuid = @SourceGuid ;

set @i = (select count(*) from DataSourceFQN where FqnHASH = @hash);

IF @i = 0
BEGIN
insert into DataSourceFQN (FQN, FqnHASH) values (@FQN,@hash);
END
ELSE IF @i = 1
update DataSourceFQN set FqnHASH= @hash where FQN = @FQN;
ELSE IF @i > 1
begin
delete from DataSourceFQN where FQN = @FQN ;
insert into DataSourceFQN (FQN, FqnHASH) values (@FQN,@hash);
end

end
GO
/****** Object:  StoredProcedure [dbo].[spUpdateRetention]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- exec spUpdateRetention
CREATE PROCEDURE [dbo].[spUpdateRetention]
AS
BEGIN

UPDATE DataSource SET CreateDate = getdate(), RetentionExpirationDate = DATEADD(YEAR,10,GETDATE())  WHERE RetentionExpirationDate < '01-01-1970';
UPDATE DataSource SET RowCreationDate = getdate() WHERE RowCreationDate is null

UPDATE DataSource
SET
RetentionExpirationDate = DATEADD(year, R.RetentionUnits, getdate())
FROM dbo.DataSource AS DS
INNER JOIN dbo.Directory AS DIR ON DS.FileDirectory = DIR.FQN
INNER JOIN [Retention] R ON R.RetentionCode = DIR.RetentionCode
WHERE DS.RetentionExpirationDate < '01-01-1970';

UPDATE DataSource
SET
RetentionExpirationDate = DATEADD(year, R.RetentionUnits, getdate())
FROM dbo.DataSource AS DS
INNER JOIN dbo.Directory AS DIR ON DS.FileDirectory LIKE '%' + DIR.FQN + '%'
INNER JOIN [Retention] R ON R.RetentionCode = DIR.RetentionCode
WHERE DS.RetentionExpirationDate < '01-01-1970';
END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateTicketIimage]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateTicketIimage] 
                @TicketNumber NVARCHAR(50) , 
                @EventID      NVARCHAR(50) , 
                @TicketImage  IMAGE
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE Tickets
               SET TicketImage = @TicketImage
        WHERE TicketNumber = @TicketNumber
              AND 
              EventID = @EventID;
        RETURN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateTicketImage]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spUpdateTicketImage] 
                @TicketNumber NVARCHAR(50) , 
                @EventID      NVARCHAR(50) , 
                @TicketImage  IMAGE
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE Tickets
               SET TicketImage = @TicketImage
        WHERE TicketNumber = @TicketNumber
              AND 
              EventID = @EventID;
        RETURN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[spValidateAllProcessAsCodes]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec spValidateAllProcessAsCodes
CREATE PROCEDURE [dbo].[spValidateAllProcessAsCodes]
AS
	--WDM 12-05-2015
    BEGIN
        DELETE FROM DataSource
        WHERE SourceName = ''
              OR SourceName IS NULL;
        UPDATE datasource
          SET 
              SourceTypeCode = P.ProcessExtCode
        FROM datasource D
             JOIN ProcessFileAs P ON P.ExtCode = D.OriginalFileType
        WHERE OriginalFileType IN
        (
            SELECT ExtCode
            FROM ProcessFileAs
        );
    END;
GO
/****** Object:  StoredProcedure [dbo].[spValidateLongFileNames]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spValidateLongFileNames]
as
begin
update DataSource set FqnHASH = (select UPPER(convert(char(128), HASHBYTES('sha2_512', upper(FQN)), 1))) where FqnHASH is null;

INSERT INTO DataSourceFQN (FqnHASH, fqn)
select distinct FqnHASH, upper(fqn) from DataSource D
WHERE D.FqnHASH NOT IN (SELECT FqnHASH FROM DataSourceFQN);

end
GO
/****** Object:  StoredProcedure [dbo].[StatusSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
 * PROCEDURE: StatusSelProc 
 */

CREATE PROCEDURE [dbo].[StatusSelProc] ( 
                @StatusCode NVARCHAR(50)
                                  ) 
AS
    BEGIN
        SELECT StatusCode , CodeDesc
        FROM STATUS
        WHERE StatusCode = @StatusCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[StorageSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: StorageSelProc 
 */

CREATE PROCEDURE [dbo].[StorageSelProc] ( 
                @StoreCode NVARCHAR(50)
                                   ) 
AS
    BEGIN
        SELECT StoreCode , StoreDesc , CreateDate
        FROM Storage
        WHERE StoreCode = @StoreCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SubDirSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SubDirSelProc] ( 
                @UserID NVARCHAR(50) , 
                @SUBFQN NVARCHAR(254) , 
                @FQN    VARCHAR(254)
                                  ) 
AS
    BEGIN
        SELECT UserID , SUBFQN , FQN , ckPublic , ckDisableDir
        FROM SubDir
        WHERE UserID = @UserID
              AND 
              SUBFQN = @SUBFQN
              AND 
              FQN = @FQN;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[SubLibrarySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SubLibrarySelProc] ( 
                @UserID         NVARCHAR(50) , 
                @SubUserID      NVARCHAR(50) , 
                @LibraryName    NVARCHAR(80) , 
                @SubLibraryName NVARCHAR(80)
                                      ) 
AS
    BEGIN
        SELECT UserID , SubUserID , LibraryName , SubLibraryName
        FROM SubLibrary
        WHERE UserID = @UserID
              AND 
              SubUserID = @SubUserID
              AND 
              LibraryName = @LibraryName
              AND 
              SubLibraryName = @SubLibraryName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UD_QtySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: UD_QtySelProc 
 */

CREATE PROCEDURE [dbo].[UD_QtySelProc] ( 
                @Code CHAR(10)
                                  ) 
AS
    BEGIN
        SELECT Code , Description
        FROM UD_Qty
        WHERE Code = @Code;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[update_DirectoryArchiveFileCnt]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[update_DirectoryArchiveFileCnt] (@UserID nvarchar(50), @DirName varchar(1000), @cnt as int)
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		update DirectoryArchive set NbrFiles = @cnt where DirKey = @dHash ;
	end

end
GO
/****** Object:  StoredProcedure [dbo].[update_DirectoryArchiveFileLastUpdate]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[update_DirectoryArchiveFileLastUpdate] (@UserID nvarchar(50), @DirName varchar(1000))
as
begin

	declare @i as integer = 0 ;
	declare @dHash as nvarchAR(max) = null;
	declare @DirKey as varchar(max) = null;

	set @dHash = (SELECT HASHBYTES('SHA2_256', @DirName));
	--set @i = (select count from DirectoryArchive where UserID = @UserID and DirKey = @DirKey);

	if @i = 0 begin
		update DirectoryArchive set LastArchive = getdate() where DirKey = @dHash ;
	end

end

GO
/****** Object:  StoredProcedure [dbo].[UpdateDataSourceImage]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateDataSourceImage] 
                @SourceGuid     NVARCHAR(50) , 
                @SourceImage    IMAGE , 
                @LastAccessDate DATETIME , 
                @LastWriteTime  DATETIME , 
                @VersionNbr     INT
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE DataSource
               SET SourceImage = @SourceImage , LastAccessDate = @LastAccessDate , LastWriteTime = @LastWriteTime , VersionNbr = @VersionNbr
        WHERE SourceGuid = @SourceGuid;
        RETURN;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailAttachmentFilestream]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEmailAttachmentFilestream] 
                @EmailGuid      NVARCHAR(50) , 
                @Attachment     VARBINARY(MAX) , 
                @AttachmentName NVARCHAR(254)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE EmailAttachment
               SET Attachment = @Attachment
        WHERE EmailGuid = @EmailGuid
              AND 
              AttachmentName = @AttachmentName;
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailAttachmentFilestreamV2]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEmailAttachmentFilestreamV2] 
                @RowGuid    NVARCHAR(50) , 
                @Attachment VARBINARY(MAX)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE EmailAttachment
               SET Attachment = @Attachment
        WHERE RowGuid = @RowGuid;
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailFilestream]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEmailFilestream] 
                @EmailGuid  NVARCHAR(50) , 
                @EmailImage VARBINARY(MAX)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE EMail
               SET EmailImage = @EmailImage
        WHERE EmailGuid = @EmailGuid;
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSourceFilestream]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateSourceFilestream] 
                @SourceGuid  NVARCHAR(50) , 
                @SourceImage VARBINARY(MAX)
AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE DataSource
               SET SourceImage = @SourceImage
        WHERE SourceGuid = @SourceGuid;
        RETURN;

        /****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/

        SET ANSI_NULLS ON;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UserGroupSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[UserGroupSelProc] ( 
                @GroupOwnerUserID NVARCHAR(50) , 
                @GroupName        NVARCHAR(80)
                                     ) 
AS
    BEGIN
        SELECT GroupOwnerUserID , GroupName
        FROM UserGroup
        WHERE GroupOwnerUserID = @GroupOwnerUserID
              AND 
              GroupName = @GroupName;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UsersSelPr_01282009011743004]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: UsersSelProc 
 */

CREATE PROCEDURE [dbo].[UsersSelPr_01282009011743004] ( 
                @UserID NVARCHAR(50)
                                                 ) 
AS
    BEGIN
        SELECT UserID , UserPassword
        FROM Users
        WHERE UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[UsersSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: UsersSelProc 
 */

CREATE PROCEDURE [dbo].[UsersSelProc] ( 
                @UserID NVARCHAR(50)
                                 ) 
AS
    BEGIN
        SELECT UserID , UserPassword
        FROM Users
        WHERE UserID = @UserID;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[usp_FindYourMissingTable]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FindYourMissingTable] 
                @TableName VARCHAR(256)
AS
    BEGIN
        DECLARE @DBName VARCHAR(256);
        DECLARE @varSQL VARCHAR(512);
        DECLARE @getDBName CURSOR;
        SET @getDBName = CURSOR
        FOR SELECT name
            FROM sys.databases;
        CREATE TABLE #TmpTable ( 
                     DBName     VARCHAR(256) , 
                     SchemaName VARCHAR(256) , 
                     TableName  VARCHAR(256)
                               );
        OPEN @getDBName;
        FETCH NEXT FROM @getDBName INTO @DBName;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @varSQL = 'USE ' + @DBName + ';
    INSERT INTO #TmpTable
    SELECT ''' + @DBName + ''' AS DBName,
    SCHEMA_NAME(schema_id) AS SchemaName,
    name AS TableName
    FROM sys.tables
    WHERE name LIKE ''%' + @TableName + '%''';
                EXEC (@varSQL);
                FETCH NEXT FROM @getDBName INTO @DBName;
            END;
        CLOSE @getDBName;
        DEALLOCATE @getDBName;
        SELECT *
        FROM #TmpTable;
        DROP TABLE #TmpTable;
    END;
GO
/****** Object:  StoredProcedure [dbo].[VolitilitySelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/* 
 * PROCEDURE: VolitilitySelProc 
 */

CREATE PROCEDURE [dbo].[VolitilitySelProc] ( 
                @VolitilityCode NVARCHAR(50)
                                      ) 
AS
    BEGIN
        SELECT VolitilityCode , VolitilityDesc , CreateDate
        FROM Volitility
        WHERE VolitilityCode = @VolitilityCode;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[WebSourceSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[WebSourceSelProc] ( 
                @SourceGuid NVARCHAR(50)
                                     ) 
AS
    BEGIN
        SELECT SourceGuid , CreateDate , SourceName , SourceImage , SourceTypeCode , FileLength , LastWriteTime , RetentionExpirationDate , Description , KeyWords , Notes , CreationDate
        FROM WebSource
        WHERE SourceGuid = @SourceGuid;
        RETURN 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesSelProc]    Script Date: 11/20/2020 1:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[ZippedFilesSelProc] ( 
                @ContentGUID NVARCHAR(50)
                                       ) 
AS
    BEGIN
        SELECT ContentGUID , SourceTypeCode , SourceImage , SourceGuid , DataSourceOwnerUserID
        FROM ZippedFiles
        WHERE ContentGUID = @ContentGUID;
        RETURN 0;
    END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is a list of ASSIGNABLE user parameters - it takes admin authority to assign these.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AssignableUserParameters', @level2type=N'COLUMN',@level2name=N'ParmName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If set to "Y", then all emails after download will be deleted from the exchange server.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ExchangeHostPop', @level2type=N'COLUMN',@level2name=N'DeleteAfterDownload'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LibraryItems is intentionally NOT linked to an owner through the user guid so that others can place content and emails into the library. The owner is determined by a lookup on the unique library name.

SourceGuid, in this case, can be either a content or email giud as both can live within a library.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LibraryItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubLibrary'
GO
