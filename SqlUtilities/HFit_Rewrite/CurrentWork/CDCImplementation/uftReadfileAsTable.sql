USE KenticoCMS_Datamart_2;
GO

/*
SELECT * FROM OPENROWSET(BULK N'c:\temp\TestDocument.txt', SINGLE_CLOB) AS Contents

Select line from
 Dbo.uftReadfileAsTable('c:\temp','TestDocument.txt')
 */

CREATE FUNCTION dbo.uftReadfileAsTable (@Path varchar (255) , 
                                        @Filename varchar (100)) 
RETURNS @File TABLE (LineNo int IDENTITY (1 , 1) , 
                     line varchar (8000)) 
AS
BEGIN

    DECLARE
          @objFileSystem int , 
          @objTextStream int , 
          @objErrorObject int , 
          @strErrorMessage varchar (1000) , 
          @Command varchar (1000) , 
          @hr int , 
          @String varchar (8000) , 
          @YesOrNo int;

    SELECT @strErrorMessage = 'opening the File System Object';
    EXECUTE @hr = sp_OACreate 'Scripting.FileSystemObject' , @objFileSystem OUT;


    IF @HR = 0
        BEGIN
            SELECT @objErrorObject = @objFileSystem , 
                   @strErrorMessage = 'Opening file "' + @path + '\' + @filename + '"' , 
                   @command = @path + '\' + @filename
        END;

    IF @HR = 0
        BEGIN EXECUTE @hr = sp_OAMethod @objFileSystem , 'OpenTextFile' , @objTextStream OUT , @command , 1 , false , 0
        END;--for reading, FormatASCII

    WHILE @hr = 0
        BEGIN
            IF @HR = 0
                BEGIN
                    SELECT @objErrorObject = @objTextStream , 
                           @strErrorMessage = 'finding out if there is more to read in "' + @filename + '"'
                END;
            IF @HR = 0
                BEGIN EXECUTE @hr = sp_OAGetProperty @objTextStream , 'AtEndOfStream' , @YesOrNo OUTPUT
                END;

            IF @YesOrNo <> 0
                BEGIN BREAK
                END;
            IF @HR = 0
                BEGIN
                    SELECT @objErrorObject = @objTextStream , 
                           @strErrorMessage = 'reading from the output file "' + @filename + '"'
                END;
            IF @HR = 0
                BEGIN EXECUTE @hr = sp_OAMethod @objTextStream , 'Readline' , @String OUTPUT
                END;
            INSERT INTO @file (line) 
            SELECT @String;
        END;

    IF @HR = 0
        BEGIN
            SELECT @objErrorObject = @objTextStream , 
                   @strErrorMessage = 'closing the output file "' + @filename + '"'
        END;
    IF @HR = 0
        BEGIN EXECUTE @hr = sp_OAMethod @objTextStream , 'Close'
        END;


    IF @hr <> 0
        BEGIN
            DECLARE
                  @Source varchar (255) , 
                  @Description varchar (255) , 
                  @Helpfile varchar (255) , 
                  @HelpID int;
            EXECUTE sp_OAGetErrorInfo @objErrorObject , @source OUTPUT , @Description OUTPUT , @Helpfile OUTPUT , @HelpID OUTPUT;
            SELECT @strErrorMessage = 'Error whilst ' + COALESCE (@strErrorMessage , 'doing something') + ', ' + COALESCE (@Description , '') ;
            INSERT INTO @File (line) 
            SELECT @strErrorMessage;
        END;
    EXECUTE sp_OADestroy @objTextStream;
    -- Fill the table variable with the rows for your result set

    RETURN;
END;