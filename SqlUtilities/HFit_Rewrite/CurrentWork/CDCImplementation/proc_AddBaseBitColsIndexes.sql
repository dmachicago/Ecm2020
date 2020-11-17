
-- USE KenticoCMS_Datamart_2;
GO
PRINT 'Executing proc_AddBaseBitColsIndexes.sql';
--DECLARE
--     @PreviewOnly AS BIT = 0;
--DECLARE
--     @BTable AS NVARCHAR (250) = 'HFit_HealthAssesmentUserStarted';

GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_AddBaseBitColsIndexes') 
    BEGIN
        DROP PROCEDURE
             proc_AddBaseBitColsIndexes;
    END;

GO

/*------------------------------------------------------------------------------------------------------
select distinct 'exec proc_AddBaseBitColsIndexes ' +  C.table_name +', 0 ' + char(10) + 'GO' + char(10) 
    FROM
         information_schema.tables AS T
         JOIN
         information_schema.columns AS C
         ON
           T.table_name = C.table_name AND
           T.TABLE_SCHEMA = T.TABLE_SCHEMA
    WHERE
    column_name LIKE 'CT_%' AND
           DATA_TYPE = 'bit' AND
           table_type = 'BASE TABLE' AND C.TABLE_NAME NOT LIKE  '%_DEL' AND
           T.table_schema = 'dbo' AND
           C.TABLE_NAME like '%Hfit_Tracker%'

		   exec proc_AddBaseBitColsIndexes HFIT_Tracker, 0 

USE KenticoCMS_Datamart_2;
exec proc_AddBaseBitColsIndexes HFit_HealthAssessment, 0
*/
CREATE PROCEDURE proc_AddBaseBitColsIndexes (
       @BTable AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
AS
BEGIN
    DECLARE
         @BCol AS NVARCHAR (250) = ''
       , @XCol AS NVARCHAR (250) = ''
       , @XTable AS NVARCHAR (250) = ''
       , @MySql AS NVARCHAR (MAX) 
       , @msg AS NVARCHAR (MAX) 
       , @i AS INT
       , @j AS INT
       , @k AS INT
       , @iLo AS INT
       , @iHi AS INT
       , @iCurr AS INT
       , @iMax AS INT
       , @IName AS NVARCHAR (500) 
       , @SurrKey AS NVARCHAR (500) 
       , @IDXCOLS AS NVARCHAR (500) 
       , @inc INT = 10;

    SET @i = CHARINDEX ('_' , @BTable) ;
    SET @SurrKey = SUBSTRING (@BTable , @i + 1 , 9999) ;
    SET @SurrKey = 'SurrogateKey_' + @SurrKey;
    PRINT '@SurrKey : ' + @SurrKey;

    IF
           CURSOR_STATUS ('global' , 'C') >= -1
        BEGIN
            DEALLOCATE C;
        END;
    IF
           CURSOR_STATUS ('global' , 'CCols') >= -1
        BEGIN
            DEALLOCATE CCols;
        END;

    DECLARE
         @Tbl TABLE (
                    TblName NVARCHAR (250) 
                  , ColName NVARCHAR (250) 
                  , RID INT IDENTITY (1 , 1)) ;

    INSERT INTO @Tbl
    SELECT
           C.table_name
         , C.column_name
    FROM
         information_schema.tables AS T
         JOIN
         information_schema.columns AS C
         ON
           T.table_name = C.table_name AND
           T.TABLE_SCHEMA = T.TABLE_SCHEMA
    WHERE
    column_name LIKE 'CT_%' AND
           DATA_TYPE = 'bit' AND
           table_type = 'BASE TABLE' AND C.TABLE_NAME NOT LIKE  '%_DEL' AND C.TABLE_NAME NOT LIKE  '%_CTVerHist' AND
           T.table_schema = 'dbo' AND
           C.TABLE_NAME = @BTable;

    SET @iLo = 1;
    SET @iHi = @inc;
    SET @iMax = (SELECT
                        COUNT (*) 
                 FROM @Tbl) ;

    --SELECT
    --       *
    --FROM @Tbl;

    DECLARE C CURSOR
        FOR
            SELECT DISTINCT
                   C.table_name
                 , C.column_name
            FROM
                 information_schema.tables AS T
                 JOIN
                 information_schema.columns AS C
                 ON
                   T.table_name = C.table_name AND
                   T.TABLE_SCHEMA = T.TABLE_SCHEMA
            WHERE
            column_name LIKE 'CT_%' AND
                   DATA_TYPE = 'bit' AND
                   table_type = 'BASE TABLE' AND C.TABLE_NAME NOT LIKE  '%_DEL' AND
                   T.table_schema = 'dbo' AND
                   C.TABLE_NAME = @BTable
            ORDER BY
                     C.table_name , C.column_name;

    OPEN C;

    FETCH NEXT FROM C INTO @BTable , @BCol;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @IName = 'CT_Bit_' + @BTable + '_' + CAST (@iLo AS NVARCHAR (50)) ;
            SET @i = (SELECT
                             COUNT (*) 
                      FROM sys.indexes
                      WHERE name = @IName) ;
            IF @i = 0
                BEGIN
                    DECLARE CCols CURSOR
                        FOR
                            SELECT
                                   TblName
                                 , ColName
                            FROM @Tbl
                            WHERE RID BETWEEN @iLo AND @iHi;

                    SET  @i = ( SELECT
                                       COUNT (*) 
                                FROM @Tbl
                                WHERE RID BETWEEN @iLo AND @iHi) ;

                    IF @i = 0
                        BEGIN
                            GOTO NOMORE;
                        END;

                    SET @IDXCOLS = '';
                    OPEN CCols;
                    FETCH NEXT FROM CCols INTO @XTable , @XCol;
                    WHILE
                           @@FETCH_STATUS = 0
                        BEGIN
                            SET @IDXCOLS = @IDXCOLS + @XCol + ',';
                            --exec PrintImmediate @IDXCOLS ;
                            FETCH NEXT FROM CCols INTO @XTable , @XCol;
                        END;
                    CLOSE CCols;
                    DEALLOCATE CCols;

                    SET @IDXCOLS = SUBSTRING (@IDXCOLS , 1 , LEN (@IDXCOLS) - 1) ;

                    --exec PrintImmediate @IDXCOLS ;

                    SET @iLo = @iHi + 1;
                    SET @iHi = @iHi + @inc;
                    SET @MySql = 'CREATE NONCLUSTERED INDEX ' + @IName + ' on dbo.' + @BTable + '(' + @SurrKey + ' ASC) INCLUDE (' + @IDXCOLS + ')';

                    IF @PreviewOnly = 0
                        BEGIN
                            SET @Msg = 'CREATING INDEX: ' + @IName;
                            EXEC PrintImmediate  @Msg;
                            EXEC PrintImmediate  @MySql;
                            EXEC (@MySql) ;
                        END;
                    ELSE
                        BEGIN
                            SET @Msg = 'INDEX DDL: ' + @IName;
                            EXEC PrintImmediate  @Msg;
                            EXEC PrintImmediate  @MySql;
                        END;
                    SET @IName = 'CT_Bit_' + @BTable + '_' + CAST (@iLo AS NVARCHAR (50)) ;
                END;
            GETNEXT:
            FETCH NEXT FROM C INTO @BTable , @BCol;
        END;
    NOMORE:
    CLOSE C;
    DEALLOCATE C;
END;
GO
PRINT 'Executed proc_AddBaseBitColsIndexes.sql';
GO