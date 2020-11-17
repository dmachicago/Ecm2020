
DROP TABLE IO_Sql;
GO 
CREATE TABLE IO_Sql (RowNbr bigint IDENTITY (1 , 1) 
                                   NOT NULL , 
                     DBMS_Code nvarchar (50) NOT NULL , 
                     SqlStmt nvarchar (max) NOT NULL , 
                     Applied bit NULL , 
                     ErrorDetected bit NULL) ;

GO
CREATE NONCLUSTERED INDEX PI_IO_Sql ON dbo.IO_Sql (DBMS_Code ASC , RowNbr ASC) INCLUDE (Applied) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO

if exists(select name from sys.procedures where name = 'ApplySqlIO')
    drop procedure ApplySqlIO;
go


CREATE PROCEDURE ApplySqlIO (@DBMS_CODE nvarchar (50) , 
                             @PreviewOnly bit = 0) 
AS
BEGIN
    DECLARE
          @RowNbr bigint = 0 , 
          @MySql nvarchar (max) = '';
    SET @RowNbr = (SELECT MIN (RowNbr)
                     FROM IO_Sql
                     WHERE DBMS_CODE = @DBMS_CODE
                       AND Applied != 1) ;

    WHILE @RowNbr IS NOT NULL
        BEGIN
            SET @MySql = (SELECT SqlStmt
                            FROM IO_Sql
                            WHERE RowNbr = @RowNbr) ;
            BEGIN TRY
                IF @PreviewOnly = 1
                    BEGIN
                        PRINT @MySql;
                    END
                ELSE
                    BEGIN EXEC (@MySql) ;
                    END;
            END TRY
            BEGIN CATCH
                PRINT 'ERROR: ' + @MySql;
			 SET @MySql = 'update IO_Sql set ErrorDetected = 1 where WHERE RowNbr = ' + cast(@RowNbr as nvarchar(50)) ;
			 exec (@MySql) ;
            END CATCH;
            SET @RowNbr = (SELECT MIN (RowNbr)
                             FROM IO_Sql
                             WHERE DBMS_CODE = @DBMS_CODE
                               AND Applied != 1
                               AND RowNbr > @RowNbr) ;
        END;
    SET @MySql = 'update SqlStmt from IO_Sql where DBMS_CODE = ''' + @DBMS_CODE + ''' and Applied != 1 ';
END; 
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

