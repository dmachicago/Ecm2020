
GO
PRINT 'EXECUTING proc_CheckJobRunSetting.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_CheckJobRunSetting') 
    BEGIN
        DROP PROCEDURE proc_CheckJobRunSetting;
    END;

GO
-- exec proc_CheckJobRunSetting @PreviewOnly = 1
CREATE PROCEDURE proc_CheckJobRunSetting (@PreviewOnly int = 0) 
AS
BEGIN
    DECLARE
           @MySql AS nvarchar (max) 
         , @NAME AS nvarchar (250) = ''
         , @TURNON AS tinyint = 0
         , @CurrentlyEnabled AS tinyint = 0
         , @ROWID AS int = -1
         , @T AS nvarchar (250) = '';

    UPDATE M
      SET M.CurrentlyEnabled = S.Enabled
      FROM MART_Jobs M
           JOIN
           msdb.dbo.sysjobs S
           ON M.name = S.name;

IF CURSOR_STATUS('global','C')>=-1
BEGIN
 DEALLOCATE C
END

    DECLARE C CURSOR
        FOR SELECT name
                 , CurrentlyEnabled
                 , TurnON
                 , RowID
              FROM MART_Jobs;

    OPEN C;

    FETCH NEXT FROM C INTO @NAME, @CurrentlyEnabled, @TURNON, @ROWID;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'exec msdb.dbo.sp_update_job  @job_name = ''' + @NAME + ''', @enabled = ' + CAST (@TURNON AS nvarchar (10)) ;
            IF @CurrentlyEnabled != @TURNON
                BEGIN 
				EXEC PrintImmediate @MySql;
                    IF @PreviewOnly = 0				    
                        BEGIN 
					   EXEC PrintImmediate 'CHANGED STATUS!';
					   EXEC (@MySql) ;
                        END;
                END;
            FETCH NEXT FROM C INTO @NAME, @CurrentlyEnabled, @TURNON, @ROWID;
        END;

    CLOSE C;
    DEALLOCATE C;
END;
GO
PRINT 'EXECUTING proc_CheckJobRunSetting.sql';
PRINT 'CREATED proc_CheckJobRunSetting.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_ChangeJobRunSetting') 
    BEGIN
        DROP PROCEDURE proc_ChangeJobRunSetting;
    END;

GO

-- Select * from MART_Jobs where name like '[_]2' or name like '[_]3' and currentlyEnabled = 1 
-- UPDATE MART_Jobs set TurnOn = 0 where name like '[_]2' or name like '[_]3' and currentlyEnabled = 1 
-- exec proc_ChangeJobRunSetting  @jobname = 'job_proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_1_ApplyCT' , @StatusON = 0, @PreviewOnly = 0
-- exec proc_ChangeJobRunSetting  @jobname = 'job_proc_hfit_schedulednotificationhistory_KenticoCMS_1' , @StatusON = 1, @PreviewOnly = 0
CREATE PROCEDURE proc_ChangeJobRunSetting (@JobName nvarchar (250) 
                                         , @StatusON varchar(1)
                                         , @PreviewOnly int = 0) 
AS
BEGIN
    DECLARE
           @MySql AS nvarchar (max) 
         , @NAME AS nvarchar (250) = @JobName
         , @CurrentlyEnabled AS tinyint = 0
         , @ROWID AS int = -1
	    , @TURNON as int = -1
         , @T AS nvarchar (250) = '';

IF CURSOR_STATUS('global','CX1')>=-1
BEGIN
 DEALLOCATE CX1
END

    DECLARE CX1 CURSOR
        FOR SELECT name
                 , RowID
              FROM MART_Jobs
		    where name = @JobName;
    OPEN CX1;

    FETCH NEXT FROM CX1 INTO @NAME, @ROWID;

    WHILE @@FETCH_STATUS = 0
        BEGIN

            SET @MySql = 'UPDATE MART_Jobs set TurnOn = ' + CAST (@StatusON AS nvarchar (10))  + ' where ROWID = ' + cast(@ROWID as nvarchar(50)) ;
            PRINT @MySql;
            IF @PreviewOnly = 0
                BEGIN 
				EXEC (@MySql);
				exec proc_CheckJobRunSetting;
				PRINT 'Successfully Executed: ' + @MySql ;
                END;
            FETCH NEXT FROM CX1 INTO @NAME, @ROWID;
        END;

    CLOSE CX1;
    DEALLOCATE CX1;
    print 'Set Job: ' + @JobName + ' Enabled to: ' + @StatusON
END;
GO
PRINT 'EXECUTING proc_CheckJobRunSetting.sql';
PRINT 'CREATED proc_ChangeJobRunSetting.sql';
GO
