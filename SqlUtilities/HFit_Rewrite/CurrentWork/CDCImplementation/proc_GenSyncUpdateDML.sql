

GO
PRINT 'Executing proc_GenSyncUpdateDML.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_GenSyncUpdateDML') 
    BEGIN
        DROP PROCEDURE
             proc_GenSyncUpdateDML
    END;
GO


CREATE PROCEDURE proc_GenSyncUpdateDML (
       @DBNAME VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @GeneratedSourceCode VARCHAR (MAX) OUT) 
AS
BEGIN
    /* USE: 
		  DECLARE @DDL VARCHAR(max)
		  EXEC proc_GenSyncUpdateDML 'KenticoCMS_1', 'hfit_goalOutcome', @DDL OUTPUT
		  SELECT @DDL	 
	  
	  RETURNS: Generated DDL if all is good, a NULL if it detects missing values.

	  NOTE: It is critical to note that I used a hard coded KenticoCMS_1
			 in this PROC as a reference to save time. It should be replaced 
			 as time permits. WDM 
    */
    --DECLARE @DBNAME VARCHAR(250) = 'KenticoCMS_1';
    --DECLARE @TblName VARCHAR(250) = 'HFit_HealthAssesmentUserRiskArea';
    DECLARE @DDL VARCHAR(max) ='';
    DECLARE @MySql VARCHAR(max) ='';
    DECLARE @pkey VARCHAR (250) = '';
    DECLARE @DateCol VARCHAR (250) = '';
    DECLARE @i INT = 0;
    
    SET @i = (SELECT
                     COUNT (1) 
              FROM
              kenticoCMS_1.INFORMATION_SCHEMA.COLUMNS
              WHERE
              column_name LIKE '%Modified%' AND (
                                                data_type = 'DATETIME' OR
                     data_type = 'DATETIME2') AND
                     table_name = @TblName) ;

    IF @i = 0
        BEGIN
            PRINT 'NO MOD DATES FOUND FOR: ' + @TblName ;
        END
    ELSE
        BEGIN
            SET @DateCol = (SELECT TOP 1
                                   Column_Name
                            FROM
                            kenticoCMS_1.INFORMATION_SCHEMA.COLUMNS
                            WHERE
                            column_name LIKE '%Modified%' AND (
                                                              data_type = 'DATETIME' OR
                                   data_type = 'DATETIME2') AND
                                   table_name = @TblName) ;

            SET @pkey = (SELECT
                                Col.Column_Name
                         FROM
                         kenticoCMS_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS Tab,
                         kenticoCMS_1.INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS Col
                         WHERE
                                Col.Constraint_Name = Tab.Constraint_Name AND
                                Col.Table_Name = @TblName AND
                                Constraint_Type = 'PRIMARY KEY') ;

            SELECT
                   @DDL = @DDL + ', ' + 'BASE.' + column_name + ' = ' + 'K.' + column_name + CHAR (10) 
            FROM kenticoCMS_1.information_schema.columns
            WHERE
                   table_name = @TblName AND column_name NOT IN (
                   SELECT
                          Col.Column_Name
                   FROM
                   kenticoCMS_1.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS Tab,
                   kenticoCMS_1.INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS Col
                   WHERE
                          Col.Constraint_Name = Tab.Constraint_Name AND
                          Col.Table_Name = @TblName AND
                          Constraint_Type = 'PRIMARY KEY') ;

            declare @SelectCOlumns as nvarchar(max) = '' ;
		  set @SelectCOlumns =SUBSTRING (@DDL, 2, 9999) ;
		  
		  declare @CTE as nvarchar(max) = '' ;
		  SET @CTE = 'with CTE ('+@pkey+','+@DateCol+') as ( ' + CHAR (10)
		  SET @CTE = + @CTE + 'SELECT '+@pkey+','+@DateCol  + CHAR (10);
            SET @CTE = + @CTE + '  FROM '+@DBNAME+'.dbo.'+@TblName+ CHAR (10);
            SET @CTE = + @CTE + 'EXCEPT ' + CHAR (10);
            SET @CTE = + @CTE + 'SELECT '+@pkey+','+@DateCol  + CHAR (10);
            SET @CTE = + @CTE + '  FROM BASE_'+@TblName + CHAR (10);
            SET @CTE = + @CTE + '  WHERE DBNAME = '''+@DBNAME+'''' + CHAR (10);
		  SET @CTE = + @CTE + ')'+ CHAR (10);

            SET @DDL =  @CTE + 'UPDATE BASE SET' + CHAR (10) ;
		  set @DDL = @DDL + @SelectCOlumns ;
            SET @DDL = @DDL + 'FROM BASE_' + @TblName + ' as BASE ' + CHAR (10) ;
            SET @DDL = @DDL + '    JOIN ' + CHAR (10) ;
            SET @DDL = @DDL + '        '+@DBNAME+'.dbo.' + @TblName + ' K ' + CHAR (10) ;
		  SET @DDL = @DDL + '        ON K.' + @pkey + ' = BASE.' + @pkey + '' + CHAR (10) ;
            set @DDL = @DDL + '    join CTE on CTE.'+@pkey+' = K.'+@pkey+' ' + char(10)             
		  SET @DDL = @DDL + '        where K.' + @DateCol + ' > BASE.' + @DateCol + '' + CHAR (10) ;
		  SET @DDL = @DDL + '		AND DBNAME = ''' + @DBNAME + '''' + CHAR (10) ;
            -- PRINT @DDL;
        END;
    set @GeneratedSourceCode = @DDL ;
END;

GO
PRINT 'Executed proc_GenSyncUpdateDML.sql';
GO