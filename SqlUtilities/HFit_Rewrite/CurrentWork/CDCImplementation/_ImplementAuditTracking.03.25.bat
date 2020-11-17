
cd\
cd C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation

rem call _CkFileExists "IVP.AuditTracking.sql"
del IVP.AuditTracking.sql

copy spacer.txt IVP.AuditTracking.sql

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_QuickRowCount.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\ckChangeTrackingTurnedON.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_ChangeTracking.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\SetCtHA.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\DisableCT_EDW.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_EnableAuditControl.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_DisableAuditControl.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\createTable_EDW_CT_ExecutionLog.sql"

rem ******************************************************************************
copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_cms_user.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CMS_User_AddDeletedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_User_AddNewRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_USER_AddUpdatedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_cms_user.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_CT_USER.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_job_EDW_GetStagingData_CT_USER.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\TRIG_CMS_User_Audit.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_CMS_USER_History.SQL"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\view_AUDIT_CMS_User.sql"

rem ******************************************************************************
copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_CMS_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CMS_UserSettings_AddDeletedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSettings_AddNewRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSettings_AddUpdatedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_CMS_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSettings_History.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_CMS_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_CT_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_job_EDW_GetStagingData_CT_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\TRIG_CMS_UserSettings_Audit.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\view_AUDIT_CMS_UserSettings.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "Create_job_EDW_GetStagingData_CMS_UserSettings.sql"

rem ******************************************************************************
copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_CMS_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_CMS_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSite_History.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CMS_UserSite_AddDeletedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSite_AddNewRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_CMS_UserSite_AddUpdatedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_CMS_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_CT_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_job_EDW_GetStagingData_CT_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\TRIG_CMS_UserSite_Audit.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\view_AUDIT_CMS_UserSite.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "Create_job_EDW_GetStagingData_CMS_UserSite.sql"

rem ******************************************************************************

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_getPrevVer.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\udf_CT_GetCommitTime.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_HFIT_PPTEligibility.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_HFIT_PPTEligibility_AddDeletedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_HFIT_PPTEligibility_AddNewRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_HFIT_PPTEligibility_AddUpdatedRecs.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_CT_HFIT_PPTEligibility_History.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_table_STAGING_HFIT_PPTEligibility.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "proc_STAGING_EDW_HFIT_PPTEligibility.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "create_job_EDW_GetStagingData_HFIT_PPTEligibility.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\proc_CT_HFIT_PPTEligibility_History.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\TRIG_HFIT_PPTEligibility_Audit.sql"

copy /B /Y IVP.AuditTracking.sql + spacer.txt
copy /B /Y IVP.AuditTracking.sql + "C:\Users\wmiller\Documents\SQL Server Management Studio\HFit_Rewrite\CurrentWork\CDCImplementation\view_AUDIT_HFit_PPTEligibility.sql"


rem ******************************************************************************
