
rem schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file myScript.ps1" /sc minute /mo 1 /ru System

schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_ UTIL_Monitor_TPS.ps1" /sc minute /mo 5 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_ UTIL_ReorgFragmentedIndexes.ps1" /sc week /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_CaptureWorstPerfQuery.ps1" /sc minute /mo 15 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_DFS_CleanDFSTables.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_DFS_GetAllTableSizesAndRowCnt.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_DFS_MonitorLocks.ps1" /sc minute /mo 5 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_JOB_UTIL_MonitorDeadlocks.ps1" /sc minute /mo 5 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_MonitorWorkload.ps1" /sc minute /mo 15 /ru System
REM schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_StdFunctions.ps1" /sc minute /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_DbMon_IndexVolitity.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_DBSpace.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_DBTableSpace.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_DFS_DbSize.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_GetIndexStats.ps1" /sc day /mo 1 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_MonitorDeadlocks.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_MonitorMostCommonWaits.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_ParallelMonitor.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_QryPlanStats.ps1" /sc minute /mo 15 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_TempDbMonitor.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_TrackSessionWaitStats.ps1" /sc minute /mo 10 /ru System
schtasks /create /tn myTask /tr "powershell -NoLogo -WindowStyle hidden -file JOB_UTIL_TxMonitorTableStats.ps1" /sc minute /mo 10 /ru System
