
-- use KenticoCMS_Datamart_2
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'genInsertStatements') 
    BEGIN
        DROP PROCEDURE
             genInsertStatements;
    END;

-- exec genInsertStatements 'DFS_IO_BoundQry', 2
-- exec genInsertStatements 'DFS_IO_BoundQry'

GO

CREATE PROC genInsertStatements (
       @tableName VARCHAR (100) 
     ,@NbrOfStatments AS INT = 25) 
AS
BEGIN
    --D. Miller Copyright @ August 2000
    --Declare a cursor to retrieve column specific information 
    --for the specified table
    DECLARE cursCol CURSOR FAST_FORWARD
        FOR SELECT
                   column_name
                 ,data_type
            FROM information_schema.columns
            WHERE
                   table_name = @tableName;
    OPEN cursCol;
    DECLARE
    @string NVARCHAR (MAX) ; --for storing the first half 
    --of INSERT statement
    DECLARE
    @stringData NVARCHAR (MAX) ; --for storing the data 
    --(VALUES) related statement
    DECLARE
    @dataType NVARCHAR (1000) ; --data types returned 
    --for respective columns
    DECLARE
    @iCnt AS INT = 0;
    SET @string = 'INSERT ' + @tableName + '(';
    SET @stringData = '';

    DECLARE
    @colName NVARCHAR (80) ;

    FETCH NEXT FROM cursCol INTO @colName , @dataType;

    IF
           @@fetch_status <> 0
        BEGIN
            PRINT 'Table ' + @tableName + ' not found, processing skipped.';
            CLOSE curscol;
            DEALLOCATE curscol;
            RETURN;
        END;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @iCnt = @iCnt + 1;
            --IF @NbrOfStatments > @iCnt
            --    BEGIN
            --        BREAK
            --    END;

            IF @dataType IN ('varchar' , 'char' , 'nchar' , 'nvarchar') 
                BEGIN
                    SET @stringData = @stringData + '''''''''+
            isnull(' + @colName + ','''')+'''''',''+';
                END;
            ELSE
                BEGIN
                    IF @dataType IN ('text' , 'ntext') --if the datatype 
                        --is text or something else 
                        BEGIN
                            SET @stringData = @stringData + '''''''''+
          isnull(cast(' + @colName + ' as varchar(2000)),'''')+'''''',''+';
                        END;
                    ELSE
                        BEGIN
                            IF
                                   @dataType = 'money' --because money doesn't get converted 
                                --from varchar implicitly
                                BEGIN
                                    SET @stringData = @stringData + '''convert(money,''''''+
        isnull(cast(' + @colName + ' as varchar(200)),''0.0000'')+''''''),''+';
                                END;
                            ELSE
                                BEGIN
                                    IF
                                           @dataType = 'datetime'
                                        BEGIN
                                            SET @stringData = @stringData + '''convert(datetime,''''''+
        isnull(cast(' + @colName + ' as varchar(200)),''0'')+''''''),''+';
                                        END;
                                    ELSE
                                        BEGIN
                                            IF
                                                   @dataType = 'image'
                                                BEGIN
                                                    SET @stringData = @stringData + '''''''''+
       isnull(cast(convert(varbinary,' + @colName + ') 
       as varchar(6)),''0'')+'''''',''+';
                                                END;
                                            ELSE --presuming the data type is int,bit,numeric,decimal 
                                                BEGIN
                                                    SET @stringData = @stringData + '''''''''+
          isnull(cast(' + @colName + ' as varchar(200)),''0'')+'''''',''+';
                                                END;
                                        END;
                                END;
                        END;
                END;

            SET @string = @string + @colName + ',';

            FETCH NEXT FROM cursCol INTO @colName , @dataType;
        END;

    DECLARE
    @Query NVARCHAR (MAX) ; -- provide for the whole query, 
    -- you may increase the size

    SET @query = 'SELECT top ' + CAST (@NbrOfStatments AS NVARCHAR (50)) + ' ''' + SUBSTRING (@string , 0 , LEN (@string)) + ') 
    VALUES(''+ ' + SUBSTRING (@stringData , 0 , LEN (@stringData) - 2) + '''+'')'' 
    FROM ' + @tableName;

    --print @query ;
    EXEC sp_executesql @query; --load and run the built query

    CLOSE cursCol;
    DEALLOCATE cursCol;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
