--* USEDFINAnalytics;
GO

/****** Object:  StoredProcedure [dbo].[sp_MeasurePerformanceInSP]    Script Date: 12/31/2018 7:50:02 AM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'sp_MeasurePerformanceInSP'
)
    DROP PROCEDURE sp_MeasurePerformanceInSP;
GO
CREATE PROCEDURE [dbo].[sp_MeasurePerformanceInSP]
(@action   VARCHAR(10), 
 @RunID    INT, 
 @UKEY     VARCHAR(50), 
 @ProcName VARCHAR(50) = NULL, 
 @LocID    VARCHAR(50) = NULL
)
AS
    -- DMA, Limited July 26, 2014
    -- Developer:	W. Dale Miller
    -- License MIT Open Source
    BEGIN
        IF(@action = 'start')
            BEGIN
                INSERT INTO [dbo].[PerfMonitor]
                ([RunID], 
                 [ProcName], 
                 [LocID], 
                 [UKEY], 
                 [StartTime], 
                 [EndTime], 
                 [ElapsedTime]
                )
                VALUES
                (@RunID, 
                 @ProcName, 
                 @LocID, 
                 @UKEY, 
                 GETDATE(), 
                 NULL, 
                 NULL
                );
        END;
        IF(@action = 'end')
            BEGIN
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [EndTime] = GETDATE()
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      [ElapsedTime] = DATEDIFF(MILLISECOND, [StartTime], [EndTime])
                WHERE UKEY = @UKEY;
                UPDATE [dbo].[PerfMonitor]
                  SET 
                      ExecutionTime =
                (
                    SELECT CONVERT(CHAR(13), DATEADD(ms, [ElapsedTime], '01/01/00'), 14)
                )
                WHERE UKEY = @UKEY;
        END;
    END;
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016