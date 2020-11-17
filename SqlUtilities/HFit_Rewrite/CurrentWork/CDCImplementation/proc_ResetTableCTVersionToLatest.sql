
go

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'get_DBCurrentCT_Version') 
    BEGIN
        DROP PROCEDURE
             get_DBCurrentCT_Version;
    END;
GO
-- drop table ##KenticoCMS_1TempVer
-- select * from ##KenticoCMS_1TempVer
-- exec get_DBCurrentCT_Version @InstanceName = 'XX', @DBNAME = 'KenticoCMS_1', @TblName = 'HFit_TrackerSugaryDrinks'
-- exec get_DBCurrentCT_Version @InstanceName = 'XX', @DBNAME = 'KenticoCMS_1', @TblName = 'HFit_HealthAssesmentUserRiskArea'
CREATE PROCEDURE get_DBCurrentCT_Version (
       @InstanceName NVARCHAR (250) 
     ,@DBNAME NVARCHAR (250) 
     ,@TblName NVARCHAR (250)) 
AS
BEGIN
    DECLARE
    @MySql NVARCHAR (500) = ''
  ,@sql NVARCHAR (500) = ''
  ,@ServerCurrVer BIGINT = 0
  ,@TempTbl NVARCHAR (250) = '##TempVer'
  ,@sp_executesql NVARCHAR (250) = @DBNAME + '.sys.sp_ExecuteSQL';

    BEGIN TRY
        DROP TABLE
             ##TempVer;
        PRINT 'DROPPED TABLE ' + @TempTbl;
    END TRY
    BEGIN CATCH
        PRINT 'Creating TABLE ##TempVer';
    END CATCH;

    SET @sql = 'create table ##TempVer (VerNo bigint null, DBNAME nvarchar(250) not null ) ';
    EXEC @ServerCurrVer = @sp_executesql @sql;

    SET @sql = 'insert into ##TempVer select CHANGE_TRACKING_CURRENT_VERSION(), ''' + @DBNAME + '''';
    EXEC @ServerCurrVer = @sp_executesql @sql;

    SET @ServerCurrVer = (SELECT
                                 VerNo
                          FROM ##TempVer
                          WHERE DBNAME = @DBNAME) ;
    PRINT '@ServerCurrVer = ' + CAST (@ServerCurrVer AS NVARCHAR (50)) ;
    RETURN @ServerCurrVer;
END;

GO

IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_ResetTableCTVersionToLatest') 
    BEGIN
        DROP PROCEDURE
             proc_ResetTableCTVersionToLatest;
    END;
GO

-- exec proc_ResetTableCTVersionToLatest 'PROD', 'KenticoCMS_1', 'HFit_HealthAssesmentUserRiskArea', 1
-- exec proc_ResetTableCTVersionToLatest 'PROD', 'KenticoCMS_2', 'HFit_HealthAssesmentUserRiskArea', 1
-- exec proc_ResetTableCTVersionToLatest 'PROD', 'KenticoCMS_3', 'HFit_HealthAssesmentUserRiskArea', 1
CREATE PROCEDURE proc_ResetTableCTVersionToLatest (@InstanceName NVARCHAR (250) ,@DBNAME NVARCHAR (250) ,@TblName NVARCHAR (250) ,@PreviewOnly BIT = 0) 
AS
BEGIN

    DECLARE @MySql NVARCHAR (MAX) = ''
          ,@LatestVersion BIGINT = 0
          ,@HistTbl NVARCHAR (250) = 'BASE_' + @TblName + '_CTVerHIST';
    EXEC @LatestVersion = get_DBCurrentCT_Version @InstanceName , @DBNAME , @TblName;
    SET @LatestVersion = @LatestVersion - 1;
    IF @PreviewOnly = 0
        BEGIN
	   SET @MySql = 'delete from ' + @HistTbl + ' where SYS_CHANGE_VERSION >= ' + cast(@LatestVersion as nvarchar(50)) + ' AND DBMS = ''' + @DBNAME + '''' +char(10) ;
	   EXEC (@MySql) ;
	   SET @MySql = 'If not exists (select SYS_CHANGE_VERSION from ' + @HistTbl + ' where SYS_CHANGE_VERSION = ' + cast(@LatestVersion as nvarchar(50)) + ' AND DBMS = ''' + @DBNAME + ''')' +char(10) ;
            SET @MySql = @MySql + 'insert into ' + @HistTbl + ' (SYS_CHANGE_VERSION, DBMS) values (' + CAST (@LatestVersion AS NVARCHAR (50)) + ', ''' + @DBNAME + ''')';
            EXEC (@MySql) ;
        END;
    ELSE
        BEGIN
            PRINT 'insert into ' + @HistTbl + ' (SYS_CHANGE_VERSION, DBMS) values (' + CAST (@LatestVersion AS NVARCHAR (50)) + ', ''' + @DBNAME + ''') ;';
        END;

    print '*********RESET VERSION NUMBER*****************' ;
    print '** ON : ' + @HistTbl + ' referencing ' + @DBNAME ;

END; 
