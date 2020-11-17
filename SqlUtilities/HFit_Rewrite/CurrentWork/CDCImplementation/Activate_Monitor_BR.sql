USE [DataMartPlatform]
GO
/****** Object:  StoredProcedure [dbo].[Activate_Monitor_BR]    Script Date: 8/15/2016 8:45:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--******************************************************
--Implement this as STEP 1
-- EXEC msdb..sp_start_job 'Activate_Monitor_BR' 1
--******************************************************
-- exec Activate_Monitor_BR 1
ALTER PROCEDURE [dbo].[Activate_Monitor_BR] (@FeedBack AS bit = 0) 
AS
BEGIN
    EXEC Init_Monitor_BR;    

    DECLARE
          @AllDone AS bit = 0 , 
          @BR1 bit = 0 , 
          @BR2 bit = 0 , 
          @BR3 bit = 0 , 
          @Msg AS nvarchar (max) = '' , 
          @i AS int = 0,
		@TotElapsedHours AS int = 0,
		@StartTime AS datetime = getdate();

    WHILE @AllDone = 0
        BEGIN
            SET @i = @i + 1;
            SET @BR1 = (SELECT TOP 1 BR1
                          FROM CT_PULL_Monitor) ;
            SET @BR2 = (SELECT TOP 1 BR2
                          FROM CT_PULL_Monitor) ;
            SET @BR3 = (SELECT TOP 1 BR3
                          FROM CT_PULL_Monitor) ;

            IF @BR1 = 1
           AND @BR2 = 1
           AND @BR3 = 1
                BEGIN
                    SET @AllDone = 1;
                END;

            WAITFOR DELAY '00:05:00';
            IF @FeedBack = 1
                BEGIN
                    SET @msg = 'Wait Minutes: ' + CAST (@i * 5 AS nvarchar (50)) ;
                    EXEC PrintImmediate @msg;
                END;
		  set @TotElapsedHours = datediff (hour, @StartTime, getdate()) ;
		  if @TotElapsedHours >= 5
			 break;
        END;

	   --Launch THE CT Pulls
	   exec RunAllMARTJobs ;

END;

