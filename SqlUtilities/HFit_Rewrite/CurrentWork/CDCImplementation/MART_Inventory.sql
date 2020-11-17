USE KenticoCMS_DataMart_2;
GO
SELECT
       'Required Proc: ' + name
       FROM sys.procedures
       WHERE name LIKE 'proc_BASE_%'
          OR name LIKE '%_CTHIST'
UNION
SELECT
       'Required Table: ' + table_name
       FROM INFORMATION_SCHEMA.TABLES
       WHERE table_name LIKE 'BASE_%' or table_name LIKE 'DIM_%' or table_name LIKE 'FACT_%'
UNION
SELECT
       'Required Job: ' + name
       FROM
           msdb.dbo.sysjobs AS job
               INNER JOIN msdb.dbo.sysjobsteps AS steps
                   ON job.job_id = steps.job_id
       WHERE name LIKE 'job_EDW_GetStagingData%'
          OR name LIKE 'job_proc_BASE_%'
          OR name LIKE 'job_BASE_%'
       ORDER BY
                1;
