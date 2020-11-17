USE KenticoCMS_Datamart_2;
GO
-- exec reset_SvrKey BASE_View_Hfit_CoachingSystemSettings_Joined
if exists (select name from sys.procedures where name = 'reset_SvrKey')
    drop procedure reset_SvrKey ;
go
create PROCEDURE reset_SvrKey (
      @TblName AS NVARCHAR (250)) 
AS
BEGIN    
    set NOCOUNT on ;
    DECLARE
           @iCnt AS BIGINT = 0
         , @TotRecs AS BIGINT = 0
         , @PCT AS FLOAT = 0
         , @TotProcessed AS BIGINT = 0
         , @iCurr AS BIGINT = 0
		  , @iLoop AS BIGINT = 0
         , @iRemain AS BIGINT = 0
         , @msg AS NVARCHAR (MAX) = ''
         , @start AS DATETIME
         , @end AS DATETIME
         , @secs AS DECIMAL (10 , 2) 
         , @minutes AS DECIMAL (10 , 2) 
         , @MySQl AS NVARCHAR (MAX) = ''
         , @IdentCol AS NVARCHAR (250) = '';

    SET @IdentCol = (SELECT
                            COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                     WHERE
                            TABLE_SCHEMA = 'dbo' AND
                            TABLE_NAME = @TblNAme AND
                            COLUMNPROPERTY (object_id (TABLE_NAME) , COLUMN_NAME , 'IsIdentity') = 1) ;

    IF @IdentCol IS NULL
        BEGIN
            PRINT 'Table ' + @TblName + ' has no identity column, adding one called RowNbrIdent, standby...';
            SET @MySql = 'alter table ' + @TblName + ' add RowNbrIdent bigint identity (1,1) ';
            EXEC (@MySql);
		  set @iCnt = @@ROWCOUNT ;
		  Set @msg = 'Added indentity ID to ' + CAST(@iCnt  as nvarchar(50)) + ' rows.';
        END;

    DECLARE
           @rowcount TABLE (
                           Value BIGINT) ;

    EXEC @TotRecs = proc_QuickRowCount @TblName , 1;

    SET @MySql = 'select count(*) from ' + @TblName + ' where SVR = '' TGT-AZUSQL01'' OR SVR IS NULL ';
    DELETE FROM @rowcount;
    INSERT INTO @rowcount
    EXEC ('SELECT COUNT(*) ' + @MySql) ;
    SELECT
           @iCnt = Value
    FROM @rowcount;

    if @iCnt = 0
    begin
	   set NOCOUNT OFF;
	   print 'NO ROWS FOUND, in ' + @TblName + ', Skipping...' ;
	   return;
    end
    else 
	   begin
		  set @MSg = cast (@iCnt as nvarchar) + ' ROWS FOUND, in ' + @TblName + ', Processing...' ;  
		  exec PrintImmediate @msg ;
	   end 
    if @iCnt <= 50000 
    begin 
	   set NOCOUNT OFF;
	   set @Msg = 'Processing ' + cast(@iCnt as nvarchar(50)) + ' rows immediately... standy.';
	   exec PrintImmediate @Msg ;
	   SET @MySql = 'update ' + @TblName + ' set SVR = ''TGT-AZUSQL02'' where '+@IdentCol+' in (Select top 10000 '+@IdentCol+' from ' + @TblName + ' where SVR = ''TGT-AZUSQL01'' or SVR is null) ';
	   exec (@MySql) ;
  set @iCnt = @@ROWCOUNT ;
		  Set @msg = 'Successfully updated ' + CAST(@iCnt  as nvarchar(50)) + ' rows. Finished.';
	   return ;
    end

    EXEC Disable_TableTriggers @TblName;
    --exec Disable_TableINDEXES @TblName ;

    WHILE @iCnt > 0
        BEGIN
		  set @iLoop = @iLoop +1 ;
            SET @start = getdate () ;
            BEGIN TRANSACTION tx1;
            SET @MySql = 'update ' + @TblName + ' set SVR = ''TGT-AZUSQL02'' where '+@IdentCol+' in (Select top 10000 '+@IdentCol+' from ' + @TblName + ' where SVR = ''TGT-AZUSQL01'' or SVR is null) ';

		  if @iLoop <= 3 			 
	   		  exec PrintImmediate @MySql ;

            EXEC (@MySql) ;
            SET @iCurr = @@ROWCOUNT;
            SET @TotProcessed = @TotProcessed + @iCurr;
            SET @iRemain = @TotRecs - @TotProcessed;
            COMMIT TRANSACTION tx1;
            SET @end = getdate () ;
            SET @secs = datediff (second , @start , @end) ;
            SET @minutes = @secs / 60;
            SET @PCT = cast (@TotProcessed AS FLOAT) / cast (@TotRecs AS FLOAT) * 100;
            SET @msg = 'Total Recs: ' + cast (@TotRecs AS NVARCHAR (50)) + ' / Total Processed: ' + cast (@TotProcessed AS NVARCHAR (50)) + ' / Remaining: ' + cast (@iRemain AS  NVARCHAR (50)) ;
            SET @msg = @msg + ' / Seconds: ' + cast (@secs AS NVARCHAR (50)) + ' / minutes: ' + cast (@minutes AS NVARCHAR (50)) ;
            EXEC PrintImmediate @msg;

            SET @MySql = 'select count(*) from ' + @TblName + ' where SVR = '' TGT-AZUSQL01'' OR SVR IS NULL ';
            DELETE FROM @rowcount;
            INSERT INTO @rowcount
            EXEC (@MySql) ;
            SELECT
                   @iCnt = Value
            FROM @rowcount;

        END;

    -- exec Enable_TableINDEXES @TblName ;
    EXEC Enable_TableTriggers @TblName;
    set NOCOUNT OFF;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
