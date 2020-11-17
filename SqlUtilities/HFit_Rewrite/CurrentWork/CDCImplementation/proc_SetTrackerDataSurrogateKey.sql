

GO
PRINT 'Executing proc_SetTrackerDataSurrogateKey.sql';
GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_SetTrackerDataSurrogateKey') 
    BEGIN
        DROP PROCEDURE
             proc_SetTrackerDataSurrogateKey;
    END;
GO
-- exec proc_SetTrackerDataSurrogateKey
CREATE PROCEDURE proc_SetTrackerDataSurrogateKey
AS
BEGIN

    DECLARE
           @Tbl AS NVARCHAR (250) = ''
         , @suffix AS NVARCHAR (250) = ''
         , @IdxName AS NVARCHAR (250) = ''
         , @iCnt AS BIGINT
         , @MySql AS NVARCHAR (MAX) = ''
         , @Msg  AS NVARCHAR (MAX) ;

    DECLARE C CURSOR
        FOR
            SELECT
                   table_name
            FROM information_schema.tables
            WHERE
            table_name LIKE 'BASE_HFit_Tracker%' AND
            table_name NOT LIKE '%_DEL' AND
            table_name NOT LIKE 'BASE_HFit_TrackerDef_Tracker' AND
            table_name NOT LIKE '%_CTVerHIST'
            ORDER BY
                     table_name;

    OPEN C;

    FETCH NEXT FROM C  INTO @tbl;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            SET @suffix = substring (@Tbl , charindex ('_' , @Tbl) + 1 , 9999) ;
            SET @Msg = 'Processing Table suffix: ' + @suffix;
            EXEC PrintImmediate @msg;

            SET @IdxName = 'PI_TrackerData_SKEY_' + @suffix;
            SET @MySql = '';
            SET @MySql = @MySql + ' CREATE NONCLUSTERED INDEX ' + @IdxName + ' ON [dbo].[FACT_TrackerData] ' + char (10) ;
            SET @MySql = @MySql + ' ( ' + char (10) ;
            SET @MySql = @MySql + ' 	DBNAME ASC, TrackerName ASC, [SurrogateKey_' + @suffix + '] ASC ' + char (10) ;
            SET @MySql = @MySql + ' ) ' + char (10) ;
            SET @MySql = @MySql + ' INCLUDE ([TrackerName] ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)  ' + char (10) ;

            IF NOT EXISTS (SELECT
                                  name
                           FROM sys.indexes
                           WHERE name = @IdxName) 
                BEGIN
                    BEGIN TRY
                        EXEC (@Mysql) ;
                        PRINT 'Created Index: ' + @IdxName + '.';
                    END TRY
                    BEGIN CATCH
                        SET @Msg = 'Failed INDEX: ' + @MySql;
                        EXEC PrintImmediate @msg;
                    END CATCH
                END;

            SET @MySql = ' UPDATE T2 ' + char (10) ;
            SET @MySql = @MySql + '     SET ' + char (10) ;
            SET @MySql = @MySql + '        T2.SurrogateKey_XXXXX = T1.SurrogateKey_XXXXX ' + char (10) ;
            SET @MySql = @MySql + ' FROM BASE_XXXXX T1 ' + char (10) ;
            SET @MySql = @MySql + '    INNER JOIN FACT_TrackerData T2 ' + char (10) ;
            SET @MySql = @MySql + '    ON ' + char (10) ;
            SET @MySql = @MySql + '      T1.DBNAME = T2.DBNAME AND ' + char (10) ;
            SET @MySql = @MySql + '      T1.ItemID = T2.ItemID AND ' + char (10) ;
            SET @MySql = @MySql + '	  T1.SurrogateKey_XXXXX != isnull(T2.SurrogateKey_XXXXX,-1) and ' + char (10) ;
            SET @MySql = @MySql + '       T2.TrackerName = ''XXXXX''; ' + char (10) ;

            SET @MySql = replace ( @MySql , 'XXXXX' , @suffix) ;

            BEGIN TRY
                EXEC (@Mysql) ;
                SET @iCnt = @@ROWCOUNT;
                PRINT 'Updated ' + cast (@iCnt AS NVARCHAR (50)) + ' from ' + @Tbl + '.';
            END TRY
            BEGIN CATCH
                SET @Msg = 'Failed: ' + @MySql;
                EXEC PrintImmediate @msg;
            END CATCH;
            FETCH NEXT FROM C  INTO @tbl;
        END;
    CLOSE C;
    DEALLOCATE C;
END;

GO
PRINT 'Executed proc_SetTrackerDataSurrogateKey.sql';
GO
