--SELECT
--       *
--       FROM information_schema.tables
--       WHERE table_name LIKE 'staging_edw%';

/* HOW TO USE THIS PROCEDURE:
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_BioMetrics'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_Coaches'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_CoachingDetail'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthAssesmentClientView'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_MART_EDW_HealthAssesment'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthDefinition'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthInterestDetail'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_HealthInterestList'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_RewardAwardDetail'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_RewardsDefinition'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_RewardTriggerParameters'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_RewardUserDetail'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_RewardUserLevel'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_SmallSteps'
exec proc_EDW_ChangeGmtToCentralTime 'FACT_EDW_Trackers'
*/

/*
SELECT
       table_name
     , column_name
       FROM information_schema.columns
       WHERE
    data_type = 'datetime'
   AND table_name = 'FACT_EDW_Coaches'
       ORDER BY
                table_name, column_name;
*/

/* EXAMPLE:
    Update FACT_EDW_BioMetrics SET 
    CreatedDate = DateAdd(hour, -5, CreatedDate) ,
    EventDate = DateAdd(hour, -5, EventDate) ,
    ItemCreatedWhen = DateAdd(hour, -5, ItemCreatedWhen) ,
    ItemModifiedWhen = DateAdd(hour, -5, ItemModifiedWhen) ,
    LastModifiedDate = DateAdd(hour, -5, LastModifiedDate) ,
    ModifiedDate = DateAdd(hour, -5, ModifiedDate) ,
	ConvertedToCentralTime = 1 
    where ConvertedToCentralTime is null 
*/

GO
IF EXISTS (SELECT
                  name
                  FROM sys.procedures
                  WHERE name = 'proc_EDW_ChangeGmtToCentralTime') 
    BEGIN
        DROP PROCEDURE
             proc_EDW_ChangeGmtToCentralTime;
    END;
GO

CREATE PROCEDURE proc_EDW_ChangeGmtToCentralTime (
     @TblName AS nvarchar (100)) 
AS
BEGIN
    BEGIN
	   --Author:  W. Dale Miller
	   --Date  :  05.21.2015
	   --Purpose: Converts a GMT date to Central time considering whether DST or not. Done specificially for the EDW, expressly, laura B.
	   --		Adds a column to track whether the date is converted to central time or not to provide easy fallback if deemed unneeded.
	   
        --DECLARE @TblName AS nvarchar (100) = 'FACT_EDW_RewardUserDetail';

	   DECLARE @CurrTZ nvarchar (250) = null ;
        DECLARE @dstStart AS datetime;
        DECLARE @dstEnd AS datetime;
        DECLARE @currYear AS int = DATEPART (year, GETDATE ()) ;
        DECLARE @t nvarchar (250) ;
        DECLARE @c nvarchar (250) ;
        DECLARE @offset int;
        DECLARE @localDateTime datetime;
        DECLARE @utcDateTime datetime = null ;
	   

        SET @dstStart = dbo.udfGetDstStart ( @currYear) ;
        SET @dstEnd = dbo.udfGetDstEnd ( @currYear) ;
        --PRINT @dstStart;
        --PRINT @dstEnd;

        DECLARE @isDst AS int = 0;

        IF GETDATE () BETWEEN @dstStart AND @dstEnd
            BEGIN
                SET @isDst = 1;
            END;

        --PRINT @isDst;

        DECLARE @CT_Offset AS nvarchar (50) = NULL;
        IF @isDst = 1
            BEGIN
                SET @offset = -5;
                SET @CT_Offset = '-05:00';
			 set @CurrTZ = 'CDT' ;
            END ;
        ELSE
            BEGIN
                SET @offset = -6;
                SET @CT_Offset = '-06:00';
			 set @CurrTZ = 'CST' ;
            END;

        DECLARE @i AS int = 0;
        DECLARE @MySql AS nvarchar (max) = NULL;
        DECLARE db_cursor CURSOR
            FOR
                SELECT
                       column_name
                       FROM information_schema.columns
                       WHERE
                       table_name = @TblName
                   AND data_type = 'datetime'
                       ORDER BY
                                column_name;

        --SELECT SYSDATETIMEOFFSET() ;
        --SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), @CT_Offset) AS 'US Central Time';

        --SET @offset = DATEDIFF (hour, GETUTCDATE () , GETDATE ()) ;
        --SET @localDateTime = DATEADD (hour, @offset, @utcDateTime) ;

        --PRINT @offset;
        --PRINT @localDateTime;

        IF NOT EXISTS (SELECT
                              column_name
                              FROM information_schema.columns
                              WHERE
                              table_name = @TblName
                          AND column_name = 'ConvertedToCentralTime') 
            BEGIN
                DECLARE @s AS nvarchar (500) ;
                SET @s = 'alter table ' + @TblName + ' add ConvertedToCentralTime bit null ';
                EXEC (@s) ;
                PRINT 'Added column ConvertedToCentralTime to ' + @TblName;
            END;
        DECLARE @idxname AS nvarchar (250) = NULL;
        SET @idxname = 'PI_' + @TblName + '_CDT';
        IF NOT EXISTS (SELECT
                              name
                              FROM sys.indexes
                              WHERE
                              name = @idxname) 
            BEGIN
		      declare @idxsql as nvarchar(max) = '
                CREATE NONCLUSTERED INDEX PI_'+@TblName+'_CDT ON ' + @TblName + ' (ConvertedToCentralTime ASC)';
			 exec (@idxsql ) ;
                PRINT 'Added index ConvertedToCentralTime to ' + @TblName;
            END;

        SET @MySql = 'Update ' + @TblName + ' SET ';
        --PRINT @MySql;

        OPEN db_cursor;
        FETCH NEXT FROM db_cursor INTO  @c;
        WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @i = @i + 1;
                --print '@i = ' + cast(@i as nvarchar(50)) ;
                --            PRINT 'Column: ' + @c;
                SET @MySql = @MySql + CHAR (10) + @c + ' = DateAdd(hour, ' + CAST (@offset AS nvarchar (50)) + ', ' + @c + ') ,';
                --PRINT  @MySql;
                --PRINT '_______________________________________________';
                FETCH NEXT FROM db_cursor INTO @c;
            END;

        CLOSE db_cursor;
        DEALLOCATE db_cursor;

        SET @MySql = @MySql + CHAR (10) + ' ConvertedToCentralTime = 1, TimeZone = ''' + @CurrTZ + '''' + CHAR (10) + '    where ConvertedToCentralTime is null ';

	   --print @MySql ;

        exec( @MySql ) ;
	   declare @iCnt as bigint = @@ROWCOUNT ;
	   print 'Records Updated: ' + cast(@iCnt as nvarchar(50)) ;
    END;
END;
go
print 'EXecuted proc_EDW_ChangeGmtToCentralTime';
go