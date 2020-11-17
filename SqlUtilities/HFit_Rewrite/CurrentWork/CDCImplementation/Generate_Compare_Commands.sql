



create procedure PROC_CompareMartToProduction
as

BEGIN TRY
    DROP TABLE #TmpCmds;
END TRY
BEGIN CATCH
    PRINT 'replaced table #TmpCmds';
END CATCH; 

SELECT 'exec proc_Compare_Tables @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_1''' + CHAR (10) + ', @LinkedTBL = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrTBL = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD INTO #TmpCmds
  FROM Information_Schema.tables
  WHERE table_type = 'BASE TABLE'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
    AND table_name NOT LIKE '%[_]VIEW[_]%'
UNION ALL
SELECT 'exec proc_Compare_Tables @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_2''' + CHAR (10) + ', @LinkedTBL = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrTBL = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD
  FROM Information_Schema.tables
  WHERE table_type = 'BASE TABLE'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
    AND table_name NOT LIKE '%[_]VIEW[_]%'
UNION ALL
SELECT 'exec proc_Compare_Tables @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_3''' + CHAR (10) + ', @LinkedTBL = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrTBL = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD
  FROM Information_Schema.tables
  WHERE table_type = 'BASE TABLE'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
    AND table_name NOT LIKE '%[_]VIEW[_]%'
UNION ALL
SELECT 'exec proc_Compare_Views @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_1''' + CHAR (10) + ', @LinkedVIEW = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrVIEW = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD
  FROM Information_Schema.tables
  WHERE table_type = 'VIEW'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
UNION ALL
SELECT 'exec proc_Compare_Views @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_2''' + CHAR (10) + ', @LinkedVIEW = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrVIEW = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD
  FROM Information_Schema.tables
  WHERE table_type = 'VIEW'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
UNION ALL
SELECT 'exec proc_Compare_Views @LinkedSVR = ''hfitazuprdsql05.cloudapp.net''' + CHAR (10) + ', @LinkedDB = ''KenticoCMS_3''' + CHAR (10) + ', @LinkedVIEW = ''' + REPLACE (table_name, 'BASE_', '') + '''' + CHAR (10) + ', @CurrDB = ''DataMartPlatform''' + CHAR (10) + ', @CurrVIEW = ''' + table_name + '''' + CHAR (10) + ', @NewRun = 0 ; ' + CHAR (10) AS CMD
  FROM Information_Schema.tables
  WHERE table_type = 'VIEW'
    AND table_name NOT LIKE '%[_]CTVerHIST'
    AND table_name NOT LIKE '%[_]DEL'
    AND table_name NOT LIKE '%[_]TESTDATA'
UNION ALL
SELECT 'delete from TBL_DIFF1 where COLUMN_NAME like ''SYS_CHANGE_VERSION''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''SYS_CHANGE_VERSION''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''SYS_CHANGE_VERSION''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''SurrogateKey%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''SurrogateKey%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''SurrogateKey%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''LASTMODIFIEDDATE''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''LASTMODIFIEDDATE''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''LASTMODIFIEDDATE''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''HashCode''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''HashCode''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''HashCode''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''DBNAME''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''DBNAME''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''DBNAME''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''SVR''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''SVR''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''SVR''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''action''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''action''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''action''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF1 where COLUMN_NAME like ''ct[_]%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF2 where COLUMN_NAME like ''ct[_]%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'DELETE from TBL_DIFF3 where COLUMN_NAME like ''ct[_]%''' + CHAR (10) AS CMD
UNION ALL
SELECT 'select * from view_SchemaDiff;' AS CMD;

DECLARE
       @CMD nvarchar (max) = ''
     , @Msg nvarchar (max) = ''
     , @I int = 0
     , @ITot int = 0;

SET @ITot = (SELECT COUNT (*)
               FROM #TmpCmds) ;

DECLARE db_cursor CURSOR
    FOR SELECT CMD
          FROM #TmpCmds;

OPEN db_cursor;   
FETCH NEXT FROM db_cursor INTO @CMD; 

WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @I = 0
            BEGIN
                SET @CMD = REPLACE (@CMD, '@NewRun = 0', '@NewRun = 1') ;
            END;
        BEGIN TRY
            --EXEC PrintImmediate @CMD;
            EXEC (@CMD) ;
        END TRY
        BEGIN CATCH
            PRINT 'ERROR TRAPPED:';
            PRINT @CMD;
        END CATCH;

        FETCH NEXT FROM db_cursor INTO @CMD;
        SET @I = @I + 1;
        SET @Msg = 'Processed: ' + CAST (@i AS nvarchar (50)) + ' of ' + CAST (@ITot AS nvarchar (50)) ;
        BEGIN TRY
            EXEC PrintImmediate @Msg;
        END TRY
        BEGIN CATCH
        END CATCH;

    END;   

CLOSE db_cursor;   
DEALLOCATE db_cursor;

PRINT '_________________________________________________';
PRINT 'To see "deltas" - select * from view_SchemaDiff';
PRINT '_________________________________________________';
-- select * from #TmpCmds;
GO

/*
exec proc_Compare_Views @LinkedSVR = 'hfitazuprdsql05.cloudapp.net'
                                   , @LinkedDB = 'KenticoCMS_1'
                                   , @LinkedVIEW = 'view_EDW_HealthAssesment'
                                   , @CurrDB = 'DataMartPlatform'
                                   , @CurrVIEW = 'BASE_view_EDW_HealthAssesment'
                                   , @NewRun = 1 ;


exec proc_Compare_Tables @LinkedSVR = 'hfitazuprdsql05.cloudapp.net'
                                   , @LinkedDB = 'KenticoCMS_1'
                                   , @LinkedTBL = 'CMS_Site'
                                   , @CurrDB = 'DataMartPlatform'
                                   , @CurrTBL = 'BASE_CMS_Site'
                                   , @NewRun = 1 ;
*/