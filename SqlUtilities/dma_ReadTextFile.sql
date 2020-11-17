

/*

--NOTE: The directory has to be on the SERVER.
DECLARE @t VARCHAR(MAX) 
EXEC dma_ReadTextFile 'c:\temp\TestDocument.txt', @t output 
SELECT @t AS [SampleTextDoc.txt] 
*/


go
print 'Executing dma_ReadTextFile.sql' ;
go

if exists (select name from sys.procedures where name  = 'dma_ReadTextFile')
    drop procedure dma_ReadTextFile;

go

SET ANSI_NULLS ON; 
GO
SET QUOTED_IDENTIFIER ON; 
GO 

CREATE PROC dma_ReadTextFile @FQN nvarchar (256) , @ReturnedFileContents varchar (max) OUTPUT  

/***************************************************************

Author:	  W. Dale Miller
Date:	  01.22.2005
Copyright:  Copyright @ D. Miller & Associates, Ltd, Jan. 2005, 
		  all rights reserverd.

Purpose:	  Reads a text file into @ReturnedFileContents. 
		  --OPENROWSET is a T-SQL function that allows for 
		  reading data from many sources including using 
		  SQL Server's BULK import capability. One of the 
		  useful features of the BULK provider is its ability 
		  to read individual files from the file system into 
		  SQL Server, such as loading a data from a text file 
		  or a Word document into a SQL Server table. This capability is the subject of this tip.
 
Transaction encapsulation: 
		  may be in a transaction but is not affected 
		  by the transaction. 
 
 Error Handling: 
		  Errors are not trapped and are thrown to 
		  the caller. 
 
 USE: 
    declare @t varchar(max) 
    exec dma_ReadTextFile 'c:\temp\SampleTextDoc.txt', @t output 
    select @t as [SampleTextDoc.txt] 

    declare @t varchar(max) 
    exec dma_ReadTextFile 'X:\ViperTest\TEST_FIS_eligibility_hfc_06132016.txt', @t output 
    select @t as LoadedText ;

NOTE: To get the files in a directory, one can use:
	   EXEC xp_dirtree 'C:\', 10, 1

	   exec xp_dirtree 'X:\ViperTest', 10, 1  

**************************************************************/

AS
BEGIN
    DECLARE
          @sql nvarchar (max) , 
          @parmsdeclare nvarchar (4000) ;

    if not exists (select name from sys.tables where name = 'TEMP_TEXT_DATA')
	   create table TEMP_TEXT_DATA (

    SET NOCOUNT ON;

    SET @sql = 'select @ReturnedFileContents=(select * from openrowset ( 
           bulk ''' + @FQN + ''' 
           ,SINGLE_CLOB) x 
           )';

    SET @parmsdeclare = '@ReturnedFileContents varchar(max) OUTPUT';
    EXEC sp_executesql @stmt = @sql , @params = @parmsdeclare , @ReturnedFileContents = @ReturnedFileContents OUTPUT;
END;

go
print 'Executed dma_ReadTextFile.sql' ;
go

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
