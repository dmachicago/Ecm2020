
/*
SELECT   
    'IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = '''+name+''') Print ''MISSING JOB: ' + name + '''' + char(10) + 'GO '
FROM
    msdb.dbo.sysjobs job
INNER JOIN 
    msdb.dbo.sysjobsteps steps        
ON
    job.job_id = steps.job_id
where name like 'job_EDW_GetStagingData%' or name like 'job_proc_FACT_%' or name like 'job_FACT_%'
union
SELECT          
    'IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = '''+name+''') Print ''MISSING PROC: ' + name + '''' + char(10) + 'GO '
FROM
    KenticoCMS_DataMart.sys.procedures 
where name like 'proc_FACT%' or name like '%_CTHIST' 
union
SELECT          
    'IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = '''+table_name+''') Print ''MISSING TABLE: ' + table_name + '''' + char(10) + 'GO '
FROM
    KenticoCMS_DataMart.INFORMATION_SCHEMA.TABLES
where table_name like 'FACT_%' or table_name like 'DIM_%'
GO
*/

print '************************* INVENTORY CHECK *************************'
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Class_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_CMS_Class_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Document_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_CMS_Document_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Site_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_CMS_Site_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_CMS_Tree_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_CMS_Tree_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_user_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_cms_user_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersettings_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_cms_usersettings_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_cms_usersite_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_cms_usersite_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_COM_SKU_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_COM_SKU_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_GetMaxCTVersionNbr') Print 'MISSING PROC: proc_FACT_GetMaxCTVersionNbr'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_Account_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_Account_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HACampaign_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HACampaign_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessment_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_OutComeMessages_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_hfit_PPTEligibility_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardActivity_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardActivity_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardException_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardException_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardGroup_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardGroup_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardLevel_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardLevel_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardProgram_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardProgram_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTrigger_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFIT_Tracker_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFIT_Tracker_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBMI_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCardio_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerFruits_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHeight_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerShots_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerShots_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStrength_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStress_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStress_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTests_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTests_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWater_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWater_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWeight_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_Delete') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_Insert') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_SYNC') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_1_Update') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_1_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_Delete') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_Insert') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_SYNC') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_2_Update') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_2_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_ApplyCT') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_CTHIST') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_CTHIST'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_Delete') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_Delete'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_Insert') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_Insert'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_SYNC') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_SYNC'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_HFit_UserTracker_KenticoCMS_3_Update') Print 'MISSING PROC: proc_FACT_HFit_UserTracker_KenticoCMS_3_Update'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_RecompileAllProcs') Print 'MISSING PROC: proc_FACT_RecompileAllProcs'
GO 
IF not EXISTS (SELECT name FROM KenticoCMS_DataMart.sys.procedures WHERE name = 'proc_FACT_SaveCurrCTVersionNbr') Print 'MISSING PROC: proc_FACT_SaveCurrCTVersionNbr'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Class_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Class_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Class_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Class_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Class_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Document_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Document_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Document_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Document_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Document_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Document_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Site_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Site_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Site_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Site_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Site_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Site_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Tree_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Tree_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Tree_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Tree_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_CMS_Tree_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_CMS_Tree_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_user_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_user_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_user_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_user_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_user_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_user_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersettings_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersettings_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersettings_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersettings_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersettings_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersettings_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersite_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersite_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersite_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersite_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_cms_usersite_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_cms_usersite_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_COM_SKU_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_COM_SKU_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_COM_SKU_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_COM_SKU_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_COM_SKU_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_COM_SKU_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_Account_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_Account_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_Account_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_Account_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_Account_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_Account_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_CoachingHealthInterest_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HACampaign_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HACampaign_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HACampaign_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HACampaign_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HACampaign_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HACampaign_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMatrixQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentModule_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentMultipleChoiceQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentRiskCategory_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserAnswers_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserModule_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestion_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserQuestionGroupResults_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskArea_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserRiskCategory_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssesmentUserStarted_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessment_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessment_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessment_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessment_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessment_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessment_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_HealthAssessmentFreeForm_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_EDW_RejectMPI_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardActivity_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardLevelType_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardTrigger_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_RewardType_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_LKP_TrackerVendor_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_OutComeMessages_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_OutComeMessages_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_OutComeMessages_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_OutComeMessages_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_OutComeMessages_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_OutComeMessages_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_hfit_PPTEligibility_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_hfit_PPTEligibility_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_hfit_PPTEligibility_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_hfit_PPTEligibility_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_hfit_PPTEligibility_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_hfit_PPTEligibility_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardActivity_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardActivity_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardActivity_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardActivity_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardActivity_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardActivity_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardException_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardException_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardException_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardException_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardException_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardException_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardGroup_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardGroup_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardGroup_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardGroup_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardGroup_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardGroup_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardLevel_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardLevel_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardLevel_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardLevel_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardLevel_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardLevel_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardProgram_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardProgram_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardProgram_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardProgram_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardProgram_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardProgram_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserActivityDetail_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardsUserLevelDetail_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTrigger_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTrigger_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTrigger_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTrigger_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTrigger_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTrigger_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_RewardTriggerParameter_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_Hfit_SmallStepResponses_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_ToDoSmallSteps_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFIT_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFIT_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFIT_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFIT_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFIT_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFIT_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodPressure_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBloodSugarAndGlucose_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBMI_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBMI_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBMI_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBMI_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBMI_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBMI_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyFat_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerBodyMeasurements_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCardio_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCardio_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCardio_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCardio_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCardio_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCardio_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCholesterol_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCollectionSource_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerCotinine_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDailySteps_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerDef_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFlexibility_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFruits_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFruits_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFruits_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFruits_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerFruits_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerFruits_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHbA1c_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHeight_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHeight_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHeight_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHeight_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHeight_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHeight_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighFatFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerHighSodiumFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerInstance_Tracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMealPortions_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerMedicalCarePlan_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerPreventiveCare_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRegularMeals_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerRestingHeartRate_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerShots_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerShots_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerShots_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerShots_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerShots_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerShots_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSitLess_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSleepPlan_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStrength_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStrength_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStrength_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStrength_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStrength_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStrength_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStress_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStress_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStress_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStress_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStress_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStress_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerStressManagement_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryDrinks_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerSugaryFoods_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTests_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTests_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTests_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTests_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTests_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTests_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoAttestation_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerTobaccoFree_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerVegetables_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWater_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWater_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWater_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWater_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWater_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWater_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWeight_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWeight_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWeight_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWeight_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWeight_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWeight_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_TrackerWholeGrains_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_UserTracker_KenticoCMS_1_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_UserTracker_KenticoCMS_1_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_UserTracker_KenticoCMS_2_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_UserTracker_KenticoCMS_2_ApplyCT'
GO 
IF not EXISTS (SELECT name FROM msdb.dbo.sysjobs_view WHERE name = 'job_proc_FACT_HFit_UserTracker_KenticoCMS_3_ApplyCT') Print 'MISSING JOB: job_proc_FACT_HFit_UserTracker_KenticoCMS_3_ApplyCT'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_BioMetrics') Print 'MISSING TABLE: DIM_EDW_BioMetrics'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_CMS_USER') Print 'MISSING TABLE: DIM_EDW_CMS_USER'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_CMS_USERSETTINGS') Print 'MISSING TABLE: DIM_EDW_CMS_USERSETTINGS'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_CMS_USERSITE') Print 'MISSING TABLE: DIM_EDW_CMS_USERSITE'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_Coaches') Print 'MISSING TABLE: DIM_EDW_Coaches'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_CoachingDetail') Print 'MISSING TABLE: DIM_EDW_CoachingDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_CombinedHAViews') Print 'MISSING TABLE: DIM_EDW_CombinedHAViews'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthAssesmentClientView') Print 'MISSING TABLE: DIM_EDW_HealthAssesmentClientView'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthAssessment') Print 'MISSING TABLE: DIM_EDW_HealthAssessment'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthAssessmentDefinition') Print 'MISSING TABLE: DIM_EDW_HealthAssessmentDefinition'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthDefinition') Print 'MISSING TABLE: DIM_EDW_HealthDefinition'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthInterestDetail') Print 'MISSING TABLE: DIM_EDW_HealthInterestDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HealthInterestList') Print 'MISSING TABLE: DIM_EDW_HealthInterestList'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFIT_HealthAssesmentUserAnswers') Print 'MISSING TABLE: DIM_EDW_HFIT_HealthAssesmentUserAnswers'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE') Print 'MISSING TABLE: DIM_EDW_HFIT_HEALTHASSESMENTUSERMODULE'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFit_HealthAssesmentUserQuestion') Print 'MISSING TABLE: DIM_EDW_HFit_HealthAssesmentUserQuestion'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults') Print 'MISSING TABLE: DIM_EDW_HFit_HealthAssesmentUserQuestionGroupResults'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFit_HealthAssesmentUserRiskArea') Print 'MISSING TABLE: DIM_EDW_HFit_HealthAssesmentUserRiskArea'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined') Print 'MISSING TABLE: DIM_EDW_HFIT_HealthAssesmentUserRiskArea_Joined'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY') Print 'MISSING TABLE: DIM_EDW_HFIT_HEALTHASSESMENTUSERRISKCATEGORY'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED') Print 'MISSING TABLE: DIM_EDW_HFIT_HEALTHASSESMENTUSERSTARTED'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_RewardAwardDetail') Print 'MISSING TABLE: DIM_EDW_RewardAwardDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_RewardsDefinition') Print 'MISSING TABLE: DIM_EDW_RewardsDefinition'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_RewardTriggerParameters') Print 'MISSING TABLE: DIM_EDW_RewardTriggerParameters'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_RewardUserDetail') Print 'MISSING TABLE: DIM_EDW_RewardUserDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_RewardUserLevel') Print 'MISSING TABLE: DIM_EDW_RewardUserLevel'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_SmallSteps') Print 'MISSING TABLE: DIM_EDW_SmallSteps'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS') Print 'MISSING TABLE: DIM_EDW_TEMP_VIEW_EDW_HEALTHASSESMENTQUESTIONS'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED') Print 'MISSING TABLE: DIM_EDW_TEMP_VIEW_HFIT_HACAMPAIGN_JOINED'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED') Print 'MISSING TABLE: DIM_EDW_TEMP_VIEW_HFIT_HEALTHASSESSMENT_JOINED'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_Trackers') Print 'MISSING TABLE: DIM_EDW_Trackers'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'DIM_EDW_View_EDW_HealthAssesmentQuestions') Print 'MISSING TABLE: DIM_EDW_View_EDW_HealthAssesmentQuestions'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Class') Print 'MISSING TABLE: FACT_CMS_Class'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Class_CTVerHIST') Print 'MISSING TABLE: FACT_CMS_Class_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Class_DEL') Print 'MISSING TABLE: FACT_CMS_Class_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Document') Print 'MISSING TABLE: FACT_CMS_Document'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Document_CTVerHIST') Print 'MISSING TABLE: FACT_CMS_Document_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Document_DEL') Print 'MISSING TABLE: FACT_CMS_Document_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Site') Print 'MISSING TABLE: FACT_CMS_Site'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Site_CTVerHIST') Print 'MISSING TABLE: FACT_CMS_Site_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Site_DEL') Print 'MISSING TABLE: FACT_CMS_Site_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Tree') Print 'MISSING TABLE: FACT_CMS_Tree'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Tree_CTVerHIST') Print 'MISSING TABLE: FACT_CMS_Tree_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_CMS_Tree_DEL') Print 'MISSING TABLE: FACT_CMS_Tree_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_user') Print 'MISSING TABLE: FACT_cms_user'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_user_CTVerHIST') Print 'MISSING TABLE: FACT_cms_user_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_user_DEL') Print 'MISSING TABLE: FACT_cms_user_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersettings') Print 'MISSING TABLE: FACT_cms_usersettings'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersettings_CTVerHIST') Print 'MISSING TABLE: FACT_cms_usersettings_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersettings_DEL') Print 'MISSING TABLE: FACT_cms_usersettings_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersite') Print 'MISSING TABLE: FACT_cms_usersite'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersite_CTVerHIST') Print 'MISSING TABLE: FACT_cms_usersite_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_cms_usersite_DEL') Print 'MISSING TABLE: FACT_cms_usersite_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_COM_SKU') Print 'MISSING TABLE: FACT_COM_SKU'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_COM_SKU_CTVerHIST') Print 'MISSING TABLE: FACT_COM_SKU_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_COM_SKU_DEL') Print 'MISSING TABLE: FACT_COM_SKU_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_Account') Print 'MISSING TABLE: FACT_HFit_Account'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_Account_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_Account_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_Account_DEL') Print 'MISSING TABLE: FACT_HFit_Account_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthArea') Print 'MISSING TABLE: FACT_HFit_CoachingHealthArea'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthArea_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_CoachingHealthArea_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthArea_DEL') Print 'MISSING TABLE: FACT_HFit_CoachingHealthArea_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthInterest') Print 'MISSING TABLE: FACT_HFit_CoachingHealthInterest'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthInterest_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_CoachingHealthInterest_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_CoachingHealthInterest_DEL') Print 'MISSING TABLE: FACT_HFit_CoachingHealthInterest_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HACampaign') Print 'MISSING TABLE: FACT_HFit_HACampaign'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HACampaign_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HACampaign_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HACampaign_DEL') Print 'MISSING TABLE: FACT_HFit_HACampaign_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMatrixQuestion') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMatrixQuestion'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMatrixQuestion_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMatrixQuestion_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMatrixQuestion_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMatrixQuestion_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentModule') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentModule'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentModule_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentModule_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentModule_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentModule_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMultipleChoiceQuestion') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMultipleChoiceQuestion'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMultipleChoiceQuestion_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMultipleChoiceQuestion_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentMultipleChoiceQuestion_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentMultipleChoiceQuestion_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskArea') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskArea'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskArea_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskArea_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskArea_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskArea_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskCategory') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskCategory'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskCategory_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskCategory_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentRiskCategory_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentRiskCategory_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserAnswers') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserAnswers'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserAnswers_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserAnswers_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserAnswers_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserAnswers_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserModule') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserModule'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserModule_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserModule_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserModule_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserModule_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestion') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestion'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestion_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestion_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestion_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestion_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestionGroupResults') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestionGroupResults'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestionGroupResults_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestionGroupResults_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserQuestionGroupResults_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserQuestionGroupResults_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskArea') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskArea'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskArea_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskArea_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskArea_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskArea_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskCategory') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskCategory'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskCategory_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskCategory_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserRiskCategory_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserRiskCategory_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserStarted') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserStarted'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserStarted_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserStarted_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssesmentUserStarted_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssesmentUserStarted_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessment') Print 'MISSING TABLE: FACT_HFit_HealthAssessment'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessment_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssessment_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessment_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssessment_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessmentFreeForm') Print 'MISSING TABLE: FACT_HFit_HealthAssessmentFreeForm'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessmentFreeForm_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_HealthAssessmentFreeForm_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_HealthAssessmentFreeForm_DEL') Print 'MISSING TABLE: FACT_HFit_HealthAssessmentFreeForm_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_EDW_RejectMPI') Print 'MISSING TABLE: FACT_HFit_LKP_EDW_RejectMPI'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_EDW_RejectMPI_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_EDW_RejectMPI_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_EDW_RejectMPI_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_EDW_RejectMPI_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardActivity') Print 'MISSING TABLE: FACT_HFit_LKP_RewardActivity'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardActivity_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_RewardActivity_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardActivity_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_RewardActivity_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardLevelType') Print 'MISSING TABLE: FACT_HFit_LKP_RewardLevelType'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardLevelType_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_RewardLevelType_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardLevelType_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_RewardLevelType_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardTrigger') Print 'MISSING TABLE: FACT_HFit_LKP_RewardTrigger'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardTrigger_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_RewardTrigger_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardTrigger_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_RewardTrigger_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardType') Print 'MISSING TABLE: FACT_HFit_LKP_RewardType'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardType_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_RewardType_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_RewardType_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_RewardType_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_TrackerVendor') Print 'MISSING TABLE: FACT_HFit_LKP_TrackerVendor'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_TrackerVendor_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_LKP_TrackerVendor_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_LKP_TrackerVendor_DEL') Print 'MISSING TABLE: FACT_HFit_LKP_TrackerVendor_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_OutComeMessages') Print 'MISSING TABLE: FACT_HFit_OutComeMessages'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_OutComeMessages_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_OutComeMessages_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_OutComeMessages_DEL') Print 'MISSING TABLE: FACT_HFit_OutComeMessages_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_hfit_PPTEligibility') Print 'MISSING TABLE: FACT_hfit_PPTEligibility'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_hfit_PPTEligibility_CTVerHIST') Print 'MISSING TABLE: FACT_hfit_PPTEligibility_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_hfit_PPTEligibility_DEL') Print 'MISSING TABLE: FACT_hfit_PPTEligibility_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardActivity') Print 'MISSING TABLE: FACT_HFit_RewardActivity'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardActivity_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardActivity_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardActivity_DEL') Print 'MISSING TABLE: FACT_HFit_RewardActivity_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardException') Print 'MISSING TABLE: FACT_HFit_RewardException'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardException_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardException_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardException_DEL') Print 'MISSING TABLE: FACT_HFit_RewardException_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardGroup') Print 'MISSING TABLE: FACT_HFit_RewardGroup'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardGroup_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardGroup_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardGroup_DEL') Print 'MISSING TABLE: FACT_HFit_RewardGroup_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardLevel') Print 'MISSING TABLE: FACT_HFit_RewardLevel'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardLevel_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardLevel_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardLevel_DEL') Print 'MISSING TABLE: FACT_HFit_RewardLevel_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardProgram') Print 'MISSING TABLE: FACT_HFit_RewardProgram'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardProgram_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardProgram_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardProgram_DEL') Print 'MISSING TABLE: FACT_HFit_RewardProgram_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserActivityDetail') Print 'MISSING TABLE: FACT_HFit_RewardsUserActivityDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserActivityDetail_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardsUserActivityDetail_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserActivityDetail_DEL') Print 'MISSING TABLE: FACT_HFit_RewardsUserActivityDetail_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserLevelDetail') Print 'MISSING TABLE: FACT_HFit_RewardsUserLevelDetail'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserLevelDetail_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardsUserLevelDetail_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardsUserLevelDetail_DEL') Print 'MISSING TABLE: FACT_HFit_RewardsUserLevelDetail_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTrigger') Print 'MISSING TABLE: FACT_HFit_RewardTrigger'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTrigger_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardTrigger_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTrigger_DEL') Print 'MISSING TABLE: FACT_HFit_RewardTrigger_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTriggerParameter') Print 'MISSING TABLE: FACT_HFit_RewardTriggerParameter'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTriggerParameter_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_RewardTriggerParameter_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_RewardTriggerParameter_DEL') Print 'MISSING TABLE: FACT_HFit_RewardTriggerParameter_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_Hfit_SmallStepResponses') Print 'MISSING TABLE: FACT_Hfit_SmallStepResponses'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_Hfit_SmallStepResponses_CTVerHIST') Print 'MISSING TABLE: FACT_Hfit_SmallStepResponses_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_Hfit_SmallStepResponses_DEL') Print 'MISSING TABLE: FACT_Hfit_SmallStepResponses_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_ToDoSmallSteps') Print 'MISSING TABLE: FACT_HFit_ToDoSmallSteps'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_ToDoSmallSteps_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_ToDoSmallSteps_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_ToDoSmallSteps_DEL') Print 'MISSING TABLE: FACT_HFit_ToDoSmallSteps_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFIT_Tracker') Print 'MISSING TABLE: FACT_HFIT_Tracker'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFIT_Tracker_CTVerHIST') Print 'MISSING TABLE: FACT_HFIT_Tracker_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFIT_Tracker_DEL') Print 'MISSING TABLE: FACT_HFIT_Tracker_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodPressure') Print 'MISSING TABLE: FACT_HFit_TrackerBloodPressure'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodPressure_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerBloodPressure_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodPressure_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerBloodPressure_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodSugarAndGlucose') Print 'MISSING TABLE: FACT_HFit_TrackerBloodSugarAndGlucose'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodSugarAndGlucose_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerBloodSugarAndGlucose_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBloodSugarAndGlucose_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerBloodSugarAndGlucose_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBMI') Print 'MISSING TABLE: FACT_HFit_TrackerBMI'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBMI_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerBMI_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBMI_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerBMI_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyFat') Print 'MISSING TABLE: FACT_HFit_TrackerBodyFat'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyFat_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerBodyFat_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyFat_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerBodyFat_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyMeasurements') Print 'MISSING TABLE: FACT_HFit_TrackerBodyMeasurements'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyMeasurements_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerBodyMeasurements_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerBodyMeasurements_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerBodyMeasurements_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCardio') Print 'MISSING TABLE: FACT_HFit_TrackerCardio'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCardio_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerCardio_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCardio_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerCardio_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCholesterol') Print 'MISSING TABLE: FACT_HFit_TrackerCholesterol'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCholesterol_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerCholesterol_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCholesterol_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerCholesterol_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCollectionSource') Print 'MISSING TABLE: FACT_HFit_TrackerCollectionSource'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCollectionSource_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerCollectionSource_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCollectionSource_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerCollectionSource_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCotinine') Print 'MISSING TABLE: FACT_HFit_TrackerCotinine'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCotinine_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerCotinine_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerCotinine_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerCotinine_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDailySteps') Print 'MISSING TABLE: FACT_HFit_TrackerDailySteps'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDailySteps_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerDailySteps_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDailySteps_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerDailySteps_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDef_Tracker') Print 'MISSING TABLE: FACT_HFit_TrackerDef_Tracker'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDef_Tracker_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerDef_Tracker_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerDef_Tracker_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerDef_Tracker_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFlexibility') Print 'MISSING TABLE: FACT_HFit_TrackerFlexibility'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFlexibility_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerFlexibility_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFlexibility_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerFlexibility_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFruits') Print 'MISSING TABLE: FACT_HFit_TrackerFruits'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFruits_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerFruits_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerFruits_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerFruits_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHbA1c') Print 'MISSING TABLE: FACT_HFit_TrackerHbA1c'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHbA1c_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerHbA1c_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHbA1c_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerHbA1c_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHeight') Print 'MISSING TABLE: FACT_HFit_TrackerHeight'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHeight_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerHeight_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHeight_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerHeight_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighFatFoods') Print 'MISSING TABLE: FACT_HFit_TrackerHighFatFoods'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighFatFoods_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerHighFatFoods_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighFatFoods_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerHighFatFoods_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighSodiumFoods') Print 'MISSING TABLE: FACT_HFit_TrackerHighSodiumFoods'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighSodiumFoods_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerHighSodiumFoods_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerHighSodiumFoods_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerHighSodiumFoods_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerInstance_Tracker') Print 'MISSING TABLE: FACT_HFit_TrackerInstance_Tracker'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerInstance_Tracker_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerInstance_Tracker_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerInstance_Tracker_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerInstance_Tracker_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMealPortions') Print 'MISSING TABLE: FACT_HFit_TrackerMealPortions'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMealPortions_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerMealPortions_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMealPortions_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerMealPortions_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMedicalCarePlan') Print 'MISSING TABLE: FACT_HFit_TrackerMedicalCarePlan'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMedicalCarePlan_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerMedicalCarePlan_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerMedicalCarePlan_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerMedicalCarePlan_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerPreventiveCare') Print 'MISSING TABLE: FACT_HFit_TrackerPreventiveCare'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerPreventiveCare_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerPreventiveCare_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerPreventiveCare_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerPreventiveCare_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRegularMeals') Print 'MISSING TABLE: FACT_HFit_TrackerRegularMeals'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRegularMeals_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerRegularMeals_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRegularMeals_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerRegularMeals_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRestingHeartRate') Print 'MISSING TABLE: FACT_HFit_TrackerRestingHeartRate'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRestingHeartRate_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerRestingHeartRate_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerRestingHeartRate_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerRestingHeartRate_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerShots') Print 'MISSING TABLE: FACT_HFit_TrackerShots'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerShots_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerShots_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerShots_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerShots_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSitLess') Print 'MISSING TABLE: FACT_HFit_TrackerSitLess'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSitLess_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerSitLess_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSitLess_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerSitLess_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSleepPlan') Print 'MISSING TABLE: FACT_HFit_TrackerSleepPlan'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSleepPlan_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerSleepPlan_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSleepPlan_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerSleepPlan_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStrength') Print 'MISSING TABLE: FACT_HFit_TrackerStrength'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStrength_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerStrength_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStrength_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerStrength_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStress') Print 'MISSING TABLE: FACT_HFit_TrackerStress'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStress_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerStress_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStress_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerStress_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStressManagement') Print 'MISSING TABLE: FACT_HFit_TrackerStressManagement'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStressManagement_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerStressManagement_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerStressManagement_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerStressManagement_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryDrinks') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryDrinks'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryDrinks_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryDrinks_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryDrinks_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryDrinks_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryFoods') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryFoods'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryFoods_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryFoods_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerSugaryFoods_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerSugaryFoods_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTests') Print 'MISSING TABLE: FACT_HFit_TrackerTests'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTests_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerTests_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTests_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerTests_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoAttestation') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoAttestation'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoAttestation_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoAttestation_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoAttestation_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoAttestation_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoFree') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoFree'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoFree_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoFree_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerTobaccoFree_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerTobaccoFree_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerVegetables') Print 'MISSING TABLE: FACT_HFit_TrackerVegetables'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerVegetables_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerVegetables_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerVegetables_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerVegetables_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWater') Print 'MISSING TABLE: FACT_HFit_TrackerWater'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWater_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerWater_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWater_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerWater_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWeight') Print 'MISSING TABLE: FACT_HFit_TrackerWeight'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWeight_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerWeight_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWeight_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerWeight_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWholeGrains') Print 'MISSING TABLE: FACT_HFit_TrackerWholeGrains'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWholeGrains_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_TrackerWholeGrains_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_TrackerWholeGrains_DEL') Print 'MISSING TABLE: FACT_HFit_TrackerWholeGrains_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_UserTracker') Print 'MISSING TABLE: FACT_HFit_UserTracker'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_UserTracker_CTVerHIST') Print 'MISSING TABLE: FACT_HFit_UserTracker_CTVerHIST'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_HFit_UserTracker_DEL') Print 'MISSING TABLE: FACT_HFit_UserTracker_DEL'
GO 
IF not EXISTS (SELECT table_name FROM KenticoCMS_DataMart.information_schema.tables WHERE table_name = 'FACT_PullTime_DEL') Print 'MISSING TABLE: FACT_PullTime_DEL'
GO 
print '************************* INVENTORY CHECK COMPLETE *************************'