

GO
PRINT 'Executing PROC_GetJobHISTORY.sql';
-- exec PROC_GetJobHISTORY @Days = 3, @FailedOnly = 0
GO
IF OBJECT_ID ('PROC_GetJobHISTORY') IS NOT NULL
    BEGIN
        PRINT 'Dropping procedure: PROC_GetJobHISTORY';
        DROP PROCEDURE
             DBO.PROC_GetJobHISTORY;
    END;
PRINT 'Creating procedure: PROC_GetJobHISTORY';
GO
CREATE PROCEDURE PROC_GetJobHISTORY
       @Days INT = 2
     , @Failedonly INT = 1
AS
BEGIN
    ---------------------------------------------------------------------------------------------------
    -- Date Created: July 26, 2009
    -- Author:       W. Dale Miller
    -- Description:  This procedure produces a report that details all jobs
    --               that have run on this server in the specified number of days.
    --               
    --  Parameter:	  @FailedOnly int = 1 - brings back only jobs that have failed.
    --							0 - brings back all jobs' status
    --			  @Days int = X - brings back only jobs within the last X days
    --  Defaults:	  The default excution brings back only jobs that have failed witin the 
    --			  last 2 days.
    ---------------------------------------------------------------------------------------------------
    SET NOCOUNT ON;
    IF @Failedonly = 1
        BEGIN
            SELECT
                   'ID' = CONVERT (CHAR (8) , H.INSTANCE_ID) 
                 , 'Run Time' = CONVERT (CHAR (10) , CONVERT (DATETIME , CONVERT (CHAR (8) , H.RUN_DATE)) , 120) + ' ' + LEFT (RIGHT ('00000' + CAST (RUN_TIME AS VARCHAR (6)) , 6) , 2) + ':' + LEFT (RIGHT ('00000' + CAST (RUN_TIME AS VARCHAR (6)) , 4) , 2) + ':' + RIGHT (CAST (RUN_TIME AS VARCHAR (6)) , 2) + ' '
                 , 'Duration' = CASE
                                    WHEN
                   H.RUN_DURATION > 1800
                                        THEN '>'
                                    ELSE ' '
                                END + LEFT (RIGHT (CONVERT ( CHAR (19) , DATEADD (SS , H.RUN_DURATION , '') , 20) , 8) , 8) + ' '
                 , 'Status' = CASE RUN_STATUS
                                  WHEN 0
                                      THEN 'FAILED '
                                  WHEN 1
                                      THEN 'Success '
                                  WHEN 2
                                      THEN 'RETRY '
                                  WHEN 3
                                      THEN 'CANCELLED '
                                  WHEN 4
                                      THEN 'IN PROGRESS '
                                  ELSE '??'
                              END
                 , 'Step' = CONVERT (CHAR (3) , H.STEP_ID) 
                 , 'Job Name' = LEFT (S.NAME , 50) 
                 , 'Step Name' = LEFT (H.STEP_NAME , 35) 
                 , 'Message' = LEFT (H.MESSAGE , 2000) 
                   FROM
                        MSDB.DBO.SYSJOBHISTORY AS H
                             RIGHT JOIN MSDB.DBO.SYSJOBS AS S
                             ON
                   S.JOB_ID = H.JOB_ID
                   WHERE
                   H.RUN_DATE >= CONVERT(INT, CONVERT ( CHAR (8) , GETDATE () - @Days , 112)) AND
                   H.STEP_ID = 0 AND
                   RUN_STATUS = 0
                   ORDER BY
                            S.NAME , H.INSTANCE_ID DESC;
        END;
    IF @Failedonly = 0
        BEGIN
            SELECT
                   'ID' = CONVERT (CHAR (8) , H.INSTANCE_ID) 
                 , 'Run Time' = CONVERT (CHAR (10) , CONVERT (DATETIME , CONVERT (CHAR (8) , H.RUN_DATE)) , 120) + ' ' + LEFT (RIGHT ('00000' + CAST (RUN_TIME AS VARCHAR (6)) , 6) , 2) + ':' + LEFT (RIGHT ('00000' + CAST (RUN_TIME AS VARCHAR (6)) , 4) , 2) + ':' + RIGHT (CAST (RUN_TIME AS VARCHAR (6)) , 2) + ' '
                 , 'Duration' = CASE
                                    WHEN
                   H.RUN_DURATION > 1800
                                        THEN '>'
                                    ELSE ' '
                                END + LEFT (RIGHT (CONVERT ( CHAR (19) , DATEADD (SS , H.RUN_DURATION , '') , 20) , 8) , 8) + ' '
                 , 'Status' = CASE RUN_STATUS
                                  WHEN 0
                                      THEN 'FAILED '
                                  WHEN 1
                                      THEN 'Success '
                                  WHEN 2
                                      THEN 'RETRY '
                                  WHEN 3
                                      THEN 'CANCELLED '
                                  WHEN 4
                                      THEN 'IN PROGRESS '
                                  ELSE '??'
                              END
                 , 'Step' = CONVERT (CHAR (3) , H.STEP_ID) 
                 , 'Job Name' = LEFT (S.NAME , 50) 
                 , 'Step Name' = LEFT (H.STEP_NAME , 35) 
                 , 'Message' = LEFT (H.MESSAGE , 200) 
                   FROM
                        MSDB.DBO.SYSJOBHISTORY AS H
                             RIGHT JOIN MSDB.DBO.SYSJOBS AS S
                             ON
                   S.JOB_ID = H.JOB_ID
                   WHERE
                   H.RUN_DATE >= CONVERT(INT, CONVERT ( CHAR (8) , GETDATE () - @Days , 112)) 
                   --   and (h.step_id = 0 or run_status = 0)
                   ORDER BY
                            S.NAME , H.INSTANCE_ID DESC;
        END;
END;

GO
IF OBJECT_ID ('PROC_GetJobHISTORY') IS NOT NULL
    BEGIN
        PRINT 'PROC_GetJobHISTORY: Procedure created';
    END;
ELSE
    BEGIN
        PRINT 'PROC_GetJobHISTORY: Procedure NOT created';
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
