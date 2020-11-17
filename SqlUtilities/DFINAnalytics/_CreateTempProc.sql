
GO

/** USEDFINAnalytics;*/

GO
IF EXISTS
(
    SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[UTIL_RemoveCommentsFromCode]')
   AND type IN(N'FN', N'IF', N'TF', N'FS', N'FT')
)
    BEGIN
 DROP FUNCTION [dbo].[UTIL_RemoveCommentsFromCode];
END;
GO

/*
In order to compile/recompile a stored procedure that is pulled from the database
as an existing stored procedure, it is much easier to parse and find the parts needed
to make it transfer across and compile on TEMPDB if there are no comments in the code.
This function removes all comments from source code, or any SQL based code.
*/

CREATE FUNCTION dbo.UTIL_RemoveCommentsFromCode
(@def VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
     BEGIN
  DECLARE @comment VARCHAR(100), @endPosition INT, @startPosition INT, @commentLen INT, @substrlen INT, @len INT;
  WHILE
   (CHARINDEX('/*', @def) <> 0
   )
 BEGIN
   SET @endPosition = CHARINDEX('*/', @def);
   SET @substrlen = LEN(SUBSTRING(@def, 1, @endPosition - 1));
   SET @startPosition = @substrlen - CHARINDEX('*/', REVERSE(SUBSTRING(@def, 1, @endPosition - 1))) + 1;
   SET @commentLen = @endPosition - @startPosition;
   SET @comment = SUBSTRING(@def, @startPosition - 1, @commentLen + 3);
   SET @def = REPLACE(@def, @comment, CHAR(13));
 END;

  /** Dealing with --... kind of comments **/

  WHILE PATINDEX('%--%', @def) <> 0
 BEGIN
   SET @startPosition = PATINDEX('%--%', @def);
   SET @endPosition = ISNULL(CHARINDEX(CHAR(13), @def, @startPosition), 0);
   SET @len = (@endPosition) - @startPosition;

/* This happens at the end of the code block, 
		   when the last line is commented code with no CRLF characters*/

   IF @len <= 0
  BEGIN
    SET @len = (LEN(@def) + 1) - @startPosition;
   END;
   SET @Comment = SUBSTRING(@def, @startPosition, @len);
   SET @def = REPLACE(@def, @comment, CHAR(13));
 END;
  RETURN @def;
     END;
GO

/* drop  table DFS_TempProcErrors*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'DFS_TempProcErrors'
)
    DROP TABLE DFS_TempProcErrors;
GO
CREATE TABLE DFS_TempProcErrors
(ProcName   NVARCHAR(150) NOT NULL, 
 ProcText   NVARCHAR(MAX) NULL, 
 Success    CHAR(1) NULL, 
 CreateDate DATETIME DEFAULT GETDATE(), 
 [UID] UNIQUEIDENTIFIER DEFAULT NEWID()
);
CREATE INDEX pi_DFS_TempProcErrors
ON DFS_TempProcErrors
(ProcName
);
GO

/* Verify that the stored procedure does not already exist.  */

IF OBJECT_ID('UTIL_GetErrorInfo', 'P') IS NOT NULL
    BEGIN
 DROP PROCEDURE UTIL_GetErrorInfo;
END;  
GO

/*
A procedure to retrieve error information.  
*/

CREATE PROCEDURE UTIL_GetErrorInfo
AS
    BEGIN
 DECLARE @i INT= -1;
 SET @i =
 (
     SELECT CHARINDEX('There is already an object', ERROR_MESSAGE())
 );
 IF
    (@i >= 0
    )
     BEGIN
  PRINT 'ALREADY IN TEMPDB... Skipping.';
  PRINT ERROR_MESSAGE();
  RETURN -1;
 END;
 SELECT ERROR_NUMBER() AS ErrorNumber, 
   ERROR_SEVERITY() AS ErrorSeverity, 
   ERROR_STATE() AS ErrorState, 
   ERROR_PROCEDURE() AS ErrorProcedure, 
   ERROR_LINE() AS ErrorLine, 
   ERROR_MESSAGE() AS ErrorMessage;
 RETURN 1;
    END;  
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = '_CreateTempProc'
)
    BEGIN
 DROP PROCEDURE _CreateTempProc;
END;
GO

/*
Procedure _CreateTempProc pulls the source code from an existing stored procedure
and converts it to be created on the TEMPDB. This is done so thet the loss of the 
hidden functionality of an "sp_" procedure created in the master Database can be 
overcome. Having a proc in TEMPDB allows us to run it under any database and --* USEthe 
context of the current database. 
*/
CREATE PROCEDURE _CreateTempProc
(@ProcName NVARCHAR(150), 
 @ShowsqL  INT    = 0
)
AS
    BEGIN
 DECLARE @rc INT= 1;
 DECLARE @tgtproc NVARCHAR(150)= @ProcName;
 DECLARE @i INT= 0;
 DECLARE @j INT= 0;
 DECLARE @k INT= 0;
 DECLARE @sql NVARCHAR(MAX)= '';
 DECLARE @tgttext NVARCHAR(50)= 'create procedure';
 DECLARE @str NVARCHAR(150)= '';
 DECLARE @pname NVARCHAR(150)= '';
 DECLARE @firstline NVARCHAR(1000)= '';
 SET @pname =
 (
     SELECT ROUTINE_NAME
     FROM INFORMATION_SCHEMA.ROUTINES
     WHERE ROUTINE_NAME = @ProcName
 );
 DECLARE @objectid INT= 0;
 SELECT @objectid = OBJECT_ID(@pname);
 SET @sql = OBJECT_DEFINITION(@objectid);
 SET @sql = dbo.UTIL_RemoveCommentsFromCode(@sql);
 SET @i = @i + LEN(@sql);
 PRINT @ProcName + ' LEN = ' + CAST(@i AS NVARCHAR(15));
 SET @j =
 (
     SELECT CHARINDEX(@pname, @sql)
 );
 SET @i =
 (
     SELECT CHARINDEX(@tgttext, @sql)
 );
 SET @i = @i + LEN(@tgttext);
 SET @sql = SUBSTRING(@sql, @j, 99999);
 SET @sql = LTRIM(@sql);
 SET @k =
 (
     SELECT CHARINDEX(CHAR(10), @sql)
 );
 IF(@k <= 0
    OR @k > 1000)
     SET @k = 1000;
 SET @firstline = SUBSTRING(@sql, 1, @k);
 SET @k =
 (
     SELECT CHARINDEX(']', @firstline)
 );
 IF
    (@k > 0
    )
     BEGIN
  SET @sql = STUFF(@sql, @k, 1, ' ');
 END;
 SET @str = SUBSTRING(@sql, 1, 99999);
 DECLARE @obj NVARCHAR(150)= 'tempdb..#' + @pname;
 SET @sql = 'create procedure #' + @sql;
 BEGIN TRY
     IF OBJECT_ID('tempdb..#' + @pname + '''') IS NULL
  BEGIN
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText
 ) 
 VALUES
 (
 @pname
    , @sql
 );
 EXECUTE sp_executesql 
  @sql;
 UPDATE DFS_TempProcErrors
   SET 
     success = 'Y'
 WHERE ProcName = @pname;
 SET @rc = 1;
     END;
  ELSE
  BEGIN
 PRINT '#' + @pname + ' already in temp...';
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText, 
   success
 ) 
 VALUES
 (
 @pname
    , @sql
    , 'X'
 );
 SET @rc = 1;
     END;
 END TRY
 BEGIN CATCH
     SET @rc = 0;
     UPDATE DFS_TempProcErrors
  SET 
    success = 'N'
     WHERE ProcName = @pname;
     EXECUTE @i = UTIL_GetErrorInfo;
     IF @i = -1
  BEGIN
 INSERT INTO DFS_TempProcErrors
 ( ProcName, 
   ProcText, 
   success
 ) 
 VALUES
 (
 @pname
    , @sql
    , 'X'
 );
 SET @rc = 1;
     END;
     IF @i = 1
  BEGIN
 SET @rc = -1;
 PRINT 'IT APPEARS ' + 'tempdb..#' + @pname + ' FAILED.';
 IF
    (@ShowsqL = 1
    )
   BEGIN
  PRINT '****************************************';
  PRINT @SQL;
  SELECT @procname AS ProcName, 
  @SQL AS SqlText;
  PRINT '****************************************';
 END;
     END;
 END CATCH;
 RETURN @rc;
    END;