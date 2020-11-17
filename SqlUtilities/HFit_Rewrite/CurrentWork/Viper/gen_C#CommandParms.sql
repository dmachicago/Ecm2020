

GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'generatePushToOracleC#Pgm') 
    BEGIN
        DROP PROCEDURE generatePushToOracleC#Pgm
    END;
GO

-- exec generatePushToOracleC#Pgm 'ELIGIBILITY_MPI_TEMP'
CREATE PROCEDURE generatePushToOracleC#Pgm (@TblName nvarchar (254)) 
AS
BEGIN 

/*
Author: W. Dale Miller
Date:   04/13/2011
Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
Note: Data type definitions will be expanded as needed.
	   Developed for DMA internal use at the Bureau.
*/

    DECLARE
           @s nvarchar (max) = '';
    BEGIN TRY
        DROP TABLE ##CProgram;
    END TRY
    BEGIN CATCH
        PRINT 'Dropped Table ##CProgram';
    END CATCH;
    CREATE TABLE ##CProgram (line nvarchar (max)) ;
    EXEC generateCPgmHeader @TblName;
    EXEC generatePushToOracleInsertC#Pgm @TblName;

    SET @s = 'using (Oracle.DataAccess.Client.OracleConnection OraConn = new Oracle.DataAccess.Client.OracleConnection(ConnStr)) ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '            { ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                OraConn.Open(); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                using (var command = OraConn.CreateCommand()) ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                {';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    command.CommandText = query; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    command.CommandType = CommandType.Text; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    command.BindByName = true; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    // In order to use ArrayBinding, the ArrayBindCount property of OracleCommand object must be set to the number of records to be inserted ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    command.ArrayBindCount = bulkData.Count; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    EXEC generatePushToOracleCmdParmsC#Pgm @TblName;

    SET @s = '                   result = command.ExecuteNonQuery(); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                    if (result == bulkData.Count) ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                        returnValue = true; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '                } ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '            } ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        } ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        catch (Oracle.DataAccess.Client.OracleException ex) ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        { ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '            Console.WriteLine("ERROR UploadBulk ' + @TblName + ': {0}", ex.Message); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '            LOG.logmsg = String.Format("ERROR UploadBulk ' + @TblName + ' : {0}", ex.Message); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '            LOG.write(RunID, LOG.logmsg); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        } ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        swload.Stop(); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        float rps = (float)result / swload.ElapsedMilliseconds * 1000; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        LOG.logmsg = String.Format("Load {0} rows : {1} @ {2}/rps",swload.Elapsed, result,rps); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        LOG.write(RunID, LOG.logmsg); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        Console.WriteLine(LOG.logmsg); ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '        return returnValue; ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    SET @s = '    } ';
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
    EXEC genOracleCustomDataTypeFromSqlServer @TblName, 0;
    EXEC genOracleTableFromSqlServer @TblName, 0;

    SELECT *
      FROM ##CProgram;
END; 
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'generateCPgmHeader') 
    BEGIN
        DROP PROCEDURE generateCPgmHeader
    END;
GO

CREATE PROCEDURE generateCPgmHeader (@TblName nvarchar (254)) 
AS
BEGIN 

/*
Author: W. Dale Miller
Date:   04/13/2011
Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
Note: Data type definitions will be expanded as needed.
	   Developed for DMA internal use at the Bureau.
*/

    DECLARE
           @s nvarchar (max) = '';
    SET @s = @s + 'public static bool Push' + @TblName + 'Data(string RunID, List<ds_' + @TblName + '> bulkData)' + CHAR (10) ;
    SET @s = @s + '    { ' + CHAR (10) ;
    SET @s = @s + '        int result = 0; ' + CHAR (10) ;
    SET @s = @s + '        Stopwatch swload = new Stopwatch(); ' + CHAR (10) ;
    SET @s = @s + '        swload.Start();' + CHAR (10) ;
    SET @s = @s + '        bool returnValue = false; ' + CHAR (10) ;
    SET @s = @s + '        try ' + CHAR (10) ;
    SET @s = @s + '        { ' + CHAR (10) ;
    SET @s = @s + '            string ConnStr = System.Configuration.ConfigurationManager.AppSettings.Get("XXXXXXX"); ' + CHAR (10) ;
    INSERT INTO ##CProgram (line) 
    VALUES
           (@s) ;
END; 


GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'genOracleTableFromSqlServer') 
    BEGIN
        DROP PROCEDURE genOracleTableFromSqlServer
    END;
GO

-- exec genOracleTableFromSqlServer 'Client' , 1
CREATE PROCEDURE genOracleTableFromSqlServer (@TblName nvarchar (100) 
                                            , @PreviewOnly bit = 1) 
AS
BEGIN
    
/*
    Author: W. Dale Miller
    Date:   04/13/2011
    Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
    Note: Data type definitions will be expanded as needed.
		  Developed for DMA internal use at the Bureau.
    */

    --******************************************************************************************************************************
    -- GENERATE an ORACLE table from SQL Server
    -- declare @TblName nvarchar(100) = 'ELIGIBILITY_MPI_TEMP' ;
    DECLARE
           @S3 varchar (max) = ')'
         , @S2 varchar (max) = ''
         , @S1 varchar (max) = '';

    SET @S1 = '-- drop table ELIGIBILITY_MPI_TEMP' + CHAR (10) + 'create table ' + @TblName + '(' + CHAR (10) ;

    SELECT @S2 = @S2 + ',' + column_name + ' ' + CASE
                                                 WHEN data_type = 'real'
                                                     THEN 'binary_float'
                                                 WHEN data_type = 'float'
                                                     THEN 'binary_double'
                                                 WHEN data_type = 'smalldatetime'
                                                     THEN 'timestamp(3)'
                                                 WHEN data_type = 'varchar(max)'
                                                     THEN 'clob'
                                                 WHEN data_type = 'smallmoney'
                                                     THEN 'Number'
                                                 WHEN data_type = 'money'
                                                     THEN 'Number'
                                                 WHEN data_type = 'tinyint'
                                                     THEN 'Number(3)'
                                                 WHEN data_type = 'smallint'
                                                     THEN 'Number(5)'
                                                 WHEN data_type = 'blob'
                                                     THEN 'Blob'
                                                 WHEN data_type = 'binary'
                                                     THEN 'Raw'
                                                 WHEN data_type = 'uniqueidentifier'
                                                     THEN 'Char(36)'
                                                 WHEN data_type = 'timestamp'
                                                     THEN 'TimeStamp'
                                                 WHEN data_type = 'float'
                                                     THEN 'Double'
                                                 WHEN data_type = 'double'
                                                     THEN 'Double'
                                                 WHEN data_type = 'decimal'
                                                     THEN 'Decimal'
                                                 WHEN data_type = 'char'
                                                     THEN 'CHAR'
                                                 WHEN data_type = 'nchar'
                                                     THEN 'NChar'
                                                 WHEN data_type = 'bit'
                                                     THEN 'Number(1)'
                                                 WHEN data_type = 'varchar'
                                                     THEN 'Varchar2'
                                                 WHEN data_type = 'nvarchar'
                                                     THEN 'Varchar2'
                                                 WHEN data_type = 'bigint'
                                                     THEN 'Number'
                                                 WHEN data_type = 'int'
                                                     THEN 'Number'
                                                 WHEN data_type = 'datetime'
                                                     THEN 'Date'
                                                     ELSE 'Varchar2'
                                                 END + ' ' + CASE
                                                             WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
                                                                 THEN '(' + CAST (CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ')'
                                                                 ELSE ''
                                                             END + ' ' + CASE
                                                                         WHEN IS_NULLABLE = 'YES'
                                                                             THEN 'NULL'
                                                                             ELSE 'NOT NULL'
                                                                         END + CHAR (10)
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      ORDER BY ORDINAL_POSITION;

    SET @S2 = SUBSTRING (@S2, 2, 99999) ;


    IF @PreviewOnly = 1
        BEGIN
            SELECT @S1 + @S2 + @S3;
        END
    ELSE
        BEGIN
            SET @S1 = CHAR (10) + CHAR (10) + CHAR (10) + @S1;
            INSERT INTO ##CProgram (line) 
            VALUES
                   (@S1) ;
        END;
END; 
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'genOracleCustomDataTypeFromSqlServer') 
    BEGIN
        DROP PROCEDURE genOracleCustomDataTypeFromSqlServer
    END;
GO

-- exec genOracleCustomDataTypeFromSqlServer 'Client', 1
CREATE PROCEDURE genOracleCustomDataTypeFromSqlServer (@TblName nvarchar (100) 
                                                     , @PreviewOnly bit = 1) 
AS
BEGIN
    
/*
    Author: W. Dale Miller
    Date:   04/13/2011
    Copyright @ DMA, Limited 04/13/20011 all rights reserved.	   
    Note: Data type definitions will be expanded as needed.
		  Developed for DMA internal use at the Bureau.
    */

    --******************************************************************************************************************************
    -- GENERATE an ORACLE table from SQL Server
    DECLARE
           @S3 varchar (max) = ')';
    DECLARE
           @S2 varchar (max) = '';
    DECLARE
           @S1 varchar (max) = '';
    -- declare @TblName nvarchar(100) = 'ELIGIBILITY_MPI_TEMP' ;

    --select * from INFORMATION_SCHEMA.COLUMNS where table_name = 'ELIGIBILITY_MPI_TEMP'

    SET @S1 = '-- drop TYPE DT_' + @TblName + CHAR (10) + 'create TYPE  DT_' + @TblName + ' as OBJECT (' + CHAR (10) ;

    SELECT @S2 = @S2 + ',' + column_name + ' ' + CASE
                                                 WHEN data_type = 'real'
                                                     THEN 'binary_float'
                                                 WHEN data_type = 'float'
                                                     THEN 'binary_double'
                                                 WHEN data_type = 'smalldatetime'
                                                     THEN 'timestamp(3)'
                                                 WHEN data_type = 'varchar(max)'
                                                     THEN 'clob'
                                                 WHEN data_type = 'smallmoney'
                                                     THEN 'Number'
                                                 WHEN data_type = 'money'
                                                     THEN 'Number'
                                                 WHEN data_type = 'tinyint'
                                                     THEN 'Number(3)'
                                                 WHEN data_type = 'smallint'
                                                     THEN 'Number(5)'
                                                 WHEN data_type = 'blob'
                                                     THEN 'Blob'
                                                 WHEN data_type = 'binary'
                                                     THEN 'Raw'
                                                 WHEN data_type = 'uniqueidentifier'
                                                     THEN 'Char(36)'
                                                 WHEN data_type = 'timestamp'
                                                     THEN 'TimeStamp'
                                                 WHEN data_type = 'float'
                                                     THEN 'Double'
                                                 WHEN data_type = 'double'
                                                     THEN 'Double'
                                                 WHEN data_type = 'decimal'
                                                     THEN 'Decimal'
                                                 WHEN data_type = 'char'
                                                     THEN 'Char'
                                                 WHEN data_type = 'nchar'
                                                     THEN 'NChar'
                                                 WHEN data_type = 'bit'
                                                     THEN 'Number(1)'
                                                 WHEN data_type = 'varchar'
                                                     THEN 'Varchar2'
                                                 WHEN data_type = 'nvarchar'
                                                     THEN 'Varchar2'
                                                 WHEN data_type = 'bigint'
                                                     THEN 'Number'
                                                 WHEN data_type = 'int'
                                                     THEN 'Number'
                                                 WHEN data_type = 'datetime'
                                                     THEN 'Date'
                                                     ELSE 'Varchar2'
                                                 END + ' ' + CASE
                                                             WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
                                                                 THEN '(' + CAST (CHARACTER_MAXIMUM_LENGTH AS nvarchar (50)) + ')'
                                                                 ELSE ''
                                                             END + ' ' + CASE
                                                                         WHEN IS_NULLABLE = 'YES'
                                                                             THEN 'NULL'
                                                                         --else 'NOT NULL'
                                                                             ELSE 'NULL'
                                                                         END + CHAR (10)
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      ORDER BY ORDINAL_POSITION;
    SET @S2 = LTRIM (@S2) ;
    SET @S2 = SUBSTRING (@S2, 2, 99999) ;
    SELECT @S1 + @S2 + @S3;
    IF @PreviewOnly = 1
        BEGIN
            SELECT @S1 + @S2 + @S3;
        END
    ELSE
        BEGIN
            SET @S1 = CHAR (10) + CHAR (10) + CHAR (10) + @S1;
            INSERT INTO ##CProgram (line) 
            VALUES
                   (@S1) ;
        END;
END; 
GO
--******************************************************************************************************************************
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'generateTableClassForC#Pgm') 
    BEGIN
        DROP PROCEDURE generateTableClassForC#Pgm
    END;
GO

-- GENERATE C# Class FROM SQL SERVER 
-- exec generateTableClassForC#Pgm 'ELIGIBILITY_MPI_TEMP' ;
CREATE PROCEDURE generateTableClassForC#Pgm (@TblName nvarchar (254)) 
AS
BEGIN

/*
Author: W. Dale Miller
Date:   04/13/2011
Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
Note: Data type definitions will be expanded as needed.
	   Developed for DMA internal use at the Bureau.
*/

    DECLARE
           @S3 varchar (max) = '}';
    DECLARE
           @S2 varchar (max) = '';
    DECLARE
           @S1 varchar (max) = '';
    --declare @TblName nvarchar(100) = 'ELIGIBILITY_MPI_TEMP' ;

    SET @S1 = 'public class ds_' + @TblName + '{' + CHAR (10) ;
    SET @S1 = @S1 + '    public object this[string propertyName] ' + CHAR (10) ;
    SET @S1 = @S1 + '    { ' + CHAR (10) ;
    SET @S1 = @S1 + '        get { return this.GetType().GetProperty(propertyName).GetValue(this, null); } ' + CHAR (10) ;
    SET @S1 = @S1 + '        set { this.GetType().GetProperty(propertyName).SetValue(this, value, null); } ' + CHAR (10) ;
    SET @S1 = @S1 + '    } ' + CHAR (10) ;


    SELECT @S2 = @S2 + '    public ' + CASE
                                       WHEN data_type = 'varchar'
                                           THEN 'string'
                                       WHEN data_type = 'varchar2'
                                           THEN 'string'
                                       WHEN data_type = 'smalldatetime'
                                           THEN 'DateTime'
                                       WHEN data_type = 'varchar(max)'
                                           THEN 'stirng'
                                       WHEN data_type = 'smallmoney'
                                           THEN 'int'
                                       WHEN data_type = 'money'
                                           THEN 'int'
                                       WHEN data_type = 'tinyint'
                                           THEN 'int'
                                       WHEN data_type = 'smallint'
                                           THEN 'int'
                                       WHEN data_type = 'blob'
                                           THEN 'Blob'
                                       WHEN data_type = 'binary'
                                           THEN 'Raw'
                                       WHEN data_type = 'uniqueidentifier'
                                           THEN 'string'
                                       WHEN data_type = 'timestamp'
                                           THEN 'TimeStamp'
                                       WHEN data_type = 'float'
                                           THEN 'fouble'
                                       WHEN data_type = 'double'
                                           THEN 'double'
                                       WHEN data_type = 'decimal'
                                           THEN 'decimal'
                                       WHEN data_type = 'char'
                                           THEN 'string'
                                       WHEN data_type = 'nchar'
                                           THEN 'string'
                                       WHEN data_type = 'bit'
                                           THEN 'bool'
                                       WHEN data_type = 'nvarchar'
                                           THEN 'string'
                                       WHEN data_type = 'bigint'
                                           THEN 'Int64'
                                       WHEN data_type = 'int'
                                           THEN 'Int32'
                                       WHEN data_type = 'datetime'
                                           THEN 'DateTime'
                                           ELSE 'string'
                                       END + ' ' + ' ' + UPPER (COLUMN_NAME) + ' { get; set; } ' + CHAR (10)
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      ORDER BY ORDINAL_POSITION;

    SELECT @S1 + @S2 + @S3;
END; 
GO
--******************************************************************************************************************************
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'generatePushToOracleInsertC#Pgm') 
    BEGIN
        DROP PROCEDURE generatePushToOracleInsertC#Pgm
    END;
GO

-- GENERATE C# INSERT STATEMENT
CREATE PROCEDURE generatePushToOracleInsertC#Pgm (@TblName nvarchar (254)) 
AS
BEGIN

/*
Author: W. Dale Miller
Date:   04/13/2011
Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
Note: Data type definitions will be expanded as needed.
	   Developed for DMA internal use at the Bureau.
*/

    --declare @TblName nvarchar(100) = 'ELIGIBILITY_MPI_TEMP' ;
    DECLARE
           @S3 varchar (max) = '';
    DECLARE
           @S2 varchar (max) = '';
    DECLARE
           @S1 varchar (max) = '';

    SELECT @S2 = @S2 + ',' + column_Name
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      ORDER BY ORDINAL_POSITION;
    --and (data_type = 'nvarchar' or data_type = 'varchar' or data_type = 'datetime')

    SELECT @S3 = @S3 + ',:' + column_Name
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      ORDER BY ORDINAL_POSITION;
    --and (data_type = 'nvarchar' or data_type = 'varchar' or data_type = 'datetime')

    SET @S3 = SUBSTRING (@S3, 2, 9999) ;
    SET @S3 = ' query += "(' + @S3 + ')";';
    SET @S2 = SUBSTRING (@S2, 2, 9999) ;
    SET @S1 = '//GENERATE C# INSERT STATEMENT' + CHAR (10) ;
    SET @S1 = @S1 + 'string query = @"insert into ' + @TblName + ' (' + @S2 + ') values " ; ' + CHAR (10) + @S3;
    SELECT @S1;
    INSERT INTO ##CProgram (line) 
    VALUES
           (@S1) ;
--select @S1 ;
END; 
--******************************************************************************************************************************
-- GENERATE in C# THE necessary COMMAND PARMS
GO

IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'generatePushToOracleCmdParmsC#Pgm') 
    BEGIN
        DROP PROCEDURE generatePushToOracleCmdParmsC#Pgm
    END;
GO

-- exec generatePushToOracleCmdParmsC#Pgm 'ELIGIBILITY_MPI_TEMP'
CREATE PROCEDURE generatePushToOracleCmdParmsC#Pgm (@TblName nvarchar (254)) 
AS
BEGIN

/*
Author: W. Dale Miller
Date:   04/13/2011
Copyright@ DMA, Limited 04/13/20011 all rights reserved.	   
Note: Data type definitions will be expanded as needed.
	   Developed for DMA internal use at the Bureau.
*/

    --declare @TblName nvarchar(100) = 'ELIGIBILITY_MPI_TEMP' ;
    DECLARE
           @S1 nvarchar (max) = '';
    SELECT @S1 = @S1 + 'command.Parameters.Add(":' + column_name + '", OracleDbType.' + CASE
                                                                                        WHEN data_type = 'blob'
                                                                                            THEN 'Blob'
                                                                                        WHEN data_type = 'binary'
                                                                                            THEN 'Raw'
                                                                                        WHEN data_type = 'uniqueidentifier'
                                                                                            THEN 'Char'
                                                                                        WHEN data_type = 'timestamp'
                                                                                            THEN 'TimeStamp'
                                                                                        WHEN data_type = 'float'
                                                                                            THEN 'Double'
                                                                                        WHEN data_type = 'double'
                                                                                            THEN 'Double'
                                                                                        WHEN data_type = 'decimal'
                                                                                            THEN 'Decimal'
                                                                                        WHEN data_type = 'char'
                                                                                            THEN 'Char'
                                                                                        WHEN data_type = 'nchar'
                                                                                            THEN 'NChar'
                                                                                        --when data_type = 'bit' then 'Boolean'
                                                                                        WHEN data_type = 'bit'
                                                                                            THEN 'Int32'
                                                                                        WHEN data_type = 'varchar'
                                                                                            THEN 'Varchar2'
                                                                                        WHEN data_type = 'nvarchar'
                                                                                            THEN 'NVarchar2'
                                                                                        WHEN data_type = 'bigint'
                                                                                            THEN 'Int64'
                                                                                        WHEN data_type = 'int'
                                                                                            THEN 'Int32'
                                                                                        WHEN data_type = 'datetime'
                                                                                            THEN 'Date'
                                                                                        WHEN data_type = 'datetime2'
                                                                                            THEN 'Date'
                                                                                            ELSE 'Varchar2'
                                                                                        END + ', bulkData.Select(c => c.' + UPPER (column_name) + ').ToArray(), ParameterDirection.Input);' + CHAR (10)
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE table_name = @TblName
      --and (data_type = 'nvarchar' or data_type = 'varchar' or data_type = 'datetime') 
      ORDER BY ORDINAL_POSITION;

    SELECT @S1;
    --and (data_type = 'nvarchar' or data_type = 'varchar' or data_type = 'bit')
    INSERT INTO ##CProgram (line) 
    VALUES
           (@S1) ;

END; 
GO

--******************************************************************************************************************************
-- GENERATE in C# datatable set value commands
DECLARE
       @TblName nvarchar (100) = 'ELIGIBILITY_MPI_TEMP';
DECLARE
       @s1 nvarchar (max) = 'try {' + CHAR (10) + 'switch (keyCol)' + CHAR (10) + '{';
DECLARE
       @s2 nvarchar (max) = '';
DECLARE
       @s3 nvarchar (max) = '';

SELECT @s2 = @s2 + CHAR (10) + 'case "' + column_name + '":' + CHAR (10) + '    dsmpi.' + column_name + ' = ColValue; ' + CHAR (10) + '    break; '
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = @TblName
  ORDER BY ORDINAL_POSITION;

SET @s3 = CHAR (10) + '    default:' + CHAR (10) + '         LOG.logmsg = String.Format("Column Not Found {0}", keyCol); ' + CHAR (10) + '         LOG.write(RunID, LOG.logmsg); ' + CHAR (10) + '         Console.WriteLine("Column Not Found {0}", keyCol); ' + CHAR (10) + '         break; ' + CHAR (10) + '}' + CHAR (10) ;

SELECT @S1 + ' ' + @s2 + ' ' + @s3;
GO
