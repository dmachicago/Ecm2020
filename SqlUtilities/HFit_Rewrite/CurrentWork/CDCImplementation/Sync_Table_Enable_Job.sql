--exec proc_ChangeJobRunSetting  @jobname = 'job_proc_BASE_HFit_CoachingUserServiceLevel_KenticoCMS_1_ApplyCT' , @StatusON = 0, @PreviewOnly = 0
DECLARE
       @Method AS int = 1;

IF @Method = 1
    BEGIN
        SELECT 'exec proc_ActivateTable ''' + name + ''' , 0, 1' + CHAR (10) + 'GO'
          FROM sys.tables
          WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
            AND name NOT LIKE '%[_]del'
            AND name NOT LIKE '%[_]CTVerHIST'
            AND name NOT LIKE '%[_]TESTDATA';
    --union
    END;
ELSE
    BEGIN SELECT 'exec ' + name + '  @VersionNbr = 0, @ReloadAll = 1 ' + CHAR (10) + 'GO'
            FROM sys.procedures
            WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
              AND name LIKE '%KenticoCMS[_]1[_]SYNC'
          UNION
          SELECT 'exec ' + name + '  @VersionNbr = 0, @ReloadAll = 0 ' + CHAR (10) + 'GO'
            FROM sys.procedures
            WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
              AND name LIKE '%KenticoCMS[_]2[_]SYNC'
          UNION
          SELECT 'exec ' + name + '  @VersionNbr = 0, @ReloadAll = 0 ' + CHAR (10) + 'GO'
            FROM sys.procedures
            WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
              AND name LIKE '%KenticoCMS[_]3[_]SYNC';
    --union
    END;
SELECT 'exec proc_ChangeJobRunSetting @jobname = ''' + name + ''' , @StatusON = 1, @PreviewOnly = 0 ' + CHAR (10) + 'GO'
  FROM msdb..sysjobs
  WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
    AND name LIKE '%1[_]ApplyCT'
UNION
SELECT 'exec msdb..sp_start_job ''' + name + '''' + CHAR (10) + 'GO'
  FROM msdb..sysjobs
  WHERE name LIKE '%HFIT[_]LKP[_]Tracker%'
    AND name LIKE '%1[_]ApplyCT';
