
go

/*
select count(*) from [dbo].[ActiveServers]
select count(*) from [dbo].[ActiveJobStep]
select count(*) from [dbo].[ActiveJobSchedule]
select count(*) from [dbo].[ActiveJobExecutions]
select count(*) from [dbo].[ActiveJob]
*/

GO

declare @RefillTables int = 1 ;
declare @MasterServer nvarchar(150) = 'ALIEN15';
if (@RefillTables = 1 and db_name() = 'DFINAnalytics' and @@SERVERNAME = @MasterServer)
begin

		DELETE FROM [dbo].[ActiveServers]
		DELETE FROM [dbo].[ActiveJobStep]
		DELETE FROM [dbo].[ActiveJobSchedule]
		DELETE FROM [dbo].[ActiveJobExecutions]
		DELETE FROM [dbo].[ActiveJob]

 
		--GO
		SET IDENTITY_INSERT [dbo].[ActiveJob] ON 
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_CaptureWorstPerfQuery', N'N', N'0de20a26-3d64-4804-8d8a-243493368c09', N'min', 15, CAST(N'2019-03-19T09:35:42.277' AS DateTime), CAST(N'2019-03-19T09:50:42.317' AS DateTime), N'Y', 1, 31, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_DFS_BoundQry_ProcessAllTables', N'N', N'345ec8ea-56fd-4c1e-b451-aecfc73f61b4', N'min', 30, CAST(N'2019-03-19T09:13:20.087' AS DateTime), CAST(N'2019-03-19T09:43:20.137' AS DateTime), N'Y', 2, 25, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_DFS_CleanDFSTables', N'N', N'70712bc9-3bdb-41ce-b72f-04813917107a', N'hour', 12, CAST(N'2019-03-19T07:59:32.643' AS DateTime), CAST(N'2019-03-19T19:59:32.713' AS DateTime), N'Y', 3, 1, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', N'6d81a810-eefb-477c-913a-66c22cf97d55', N'day', 1, CAST(N'2019-03-18T14:43:45.513' AS DateTime), CAST(N'2019-03-19T14:43:45.543' AS DateTime), N'Y', 4, 2, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_DFS_MonitorLocks', N'N', N'c924c740-ff80-489d-83ee-d6499432c55c', N'min', 5, CAST(N'2019-03-19T09:32:23.940' AS DateTime), CAST(N'2019-03-19T09:37:23.970' AS DateTime), N'Y', 5, 3, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', N'9fcee6e6-061d-4439-9037-189feab172c6', N'min', 5, CAST(N'2019-03-19T09:32:23.160' AS DateTime), CAST(N'2019-03-19T09:37:23.190' AS DateTime), N'Y', 6, 4, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_MonitorWorkload', N'N', N'a7b0ea61-e4bb-4139-8cf0-ab913ea2b92e', N'min', 10, CAST(N'2019-03-19T09:36:20.947' AS DateTime), CAST(N'2019-03-19T09:46:21.060' AS DateTime), N'Y', 7, 5, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_DbMon_IndexVolitity', N'N', N'bd72610c-219d-4377-bad3-dfb28115c7b4', N'min', 10, CAST(N'2019-03-19T09:36:45.500' AS DateTime), CAST(N'2019-03-19T09:46:45.557' AS DateTime), N'Y', 8, 6, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_DBSpace', N'N', N'c9446e5a-521f-4dcc-8ae1-138d9a951210', N'day', 7, CAST(N'2019-03-18T14:45:30.353' AS DateTime), CAST(N'2019-03-25T14:45:30.383' AS DateTime), N'Y', 9, 7, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_DBTableSpace', N'N', N'0ca9e101-84f0-4d31-8aab-ae571c4ee3ae', N'day', 1, CAST(N'2019-03-18T14:45:43.713' AS DateTime), CAST(N'2019-03-19T14:45:43.737' AS DateTime), N'Y', 10, 8, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_DFS_DbSize', N'N', N'128d40d9-1393-40fa-934e-22e7e961c62f', N'day', 1, CAST(N'2019-03-18T14:46:03.590' AS DateTime), CAST(N'2019-03-19T14:46:03.637' AS DateTime), N'Y', 11, 9, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_GetIndexStats', N'N', N'def5324b-0cdf-444e-a570-985ed88087e0', N'day', 1, CAST(N'2019-03-18T14:46:30.663' AS DateTime), CAST(N'2019-03-19T14:46:30.733' AS DateTime), N'Y', 12, 10, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_MonitorDeadlocks', N'N', N'1b1607ee-9fe0-40cb-9f0e-8ffbba0a1ecd', N'day', 1, CAST(N'2019-03-15T09:05:11.333' AS DateTime), CAST(N'2019-03-16T09:05:11.357' AS DateTime), N'Y', 13, 11, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_MonitorMostCommonWaits', N'N', N'deeffc77-96f8-4ca1-9302-6106e626d6f2', N'min', 15, CAST(N'2019-03-19T09:35:01.497' AS DateTime), CAST(N'2019-03-19T09:50:01.553' AS DateTime), N'Y', 14, 12, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_ParallelMonitor', N'N', N'82fcb676-fd64-4c04-9f31-8b40fc4310ae', N'min', 15, CAST(N'2019-03-19T09:35:01.013' AS DateTime), CAST(N'2019-03-19T09:50:01.087' AS DateTime), N'Y', 15, 20, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_QryPlanStats', N'N', N'c1370e47-4e70-432e-aedd-37fa95cfb133', N'min', 30, CAST(N'2019-03-19T09:16:19.890' AS DateTime), CAST(N'2019-03-19T09:46:19.913' AS DateTime), N'Y', 16, 30, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_ReorgFragmentedIndexes', N'N', N'be385257-47b2-4646-b28b-6240fbb0cf0c', N'day', 7, CAST(N'2019-03-18T14:48:04.220' AS DateTime), CAST(N'2019-03-25T14:48:04.280' AS DateTime), N'Y', 17, 13, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_TempDbMonitor', N'N', N'ec6778b5-1ac6-40b9-9636-806f767bd35d', N'day', 7, CAST(N'2019-03-18T14:48:31.053' AS DateTime), CAST(N'2019-03-25T14:48:31.080' AS DateTime), N'Y', 18, 14, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_TrackSessionWaitStats', N'N', N'64e66c5f-8315-45c6-ac57-509d2a3f3b1b', N'min', 10, CAST(N'2019-03-19T09:37:23.973' AS DateTime), CAST(N'2019-03-19T09:47:24.010' AS DateTime), N'Y', 19, 15, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_TxMonitorTableStats', N'N', N'94bb81c0-eb2a-4a34-9158-cbee0f2c6db8', N'min', 10, CAST(N'2019-03-15T09:06:34.567' AS DateTime), CAST(N'2019-03-15T09:16:34.633' AS DateTime), N'Y', 20, 16, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'UTIL_TxMonitorIDX', N'N', N'abd48c8e-8298-4f06-85f4-65bc4378a8f8', N'min', 10, CAST(N'2019-03-15T09:06:58.333' AS DateTime), CAST(N'2019-03-15T09:16:58.357' AS DateTime), N'Y', 21, 17, N'N')
		--GO
		INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr], [ExecutionOrder], [OncePerServer]) VALUES (N'JOB_UTIL_DBUsage', N'N', N'abd48c8e-8298-4f06-85f4-65bc4378a8f9', N'min', 10, CAST(N'2019-03-15T09:06:58.333' AS DateTime), CAST(N'2019-03-15T09:16:58.357' AS DateTime), N'Y', 22, 18, N'Y')
		--GO
		SET IDENTITY_INSERT [dbo].[ActiveJob] OFF
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-03-19T09:23:21.260' AS DateTime), CAST(N'2019-03-19T09:51:13.663' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-03-19T09:08:02.103' AS DateTime), CAST(N'2019-03-19T09:51:19.743' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-03-19T07:53:51.927' AS DateTime), CAST(N'2019-03-19T09:51:19.757' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-03-18T14:35:49.190' AS DateTime), CAST(N'2019-03-19T09:51:19.770' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-03-19T09:31:00.210' AS DateTime), CAST(N'2019-03-19T09:51:19.780' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-03-19T09:31:23.400' AS DateTime), CAST(N'2019-03-19T09:51:19.790' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_MonitorWorkload', N'N', CAST(N'2019-03-19T09:23:52.703' AS DateTime), CAST(N'2019-03-19T09:51:19.803' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-03-19T09:24:00.140' AS DateTime), CAST(N'2019-03-19T09:51:19.813' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-03-18T14:36:48.620' AS DateTime), CAST(N'2019-03-19T09:51:19.847' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-03-18T14:36:48.423' AS DateTime), CAST(N'2019-03-19T09:51:19.857' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-03-18T14:36:47.957' AS DateTime), CAST(N'2019-03-19T09:51:19.880' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-03-18T14:37:20.057' AS DateTime), CAST(N'2019-03-19T09:51:19.890' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-19T09:51:19.900' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-03-19T09:31:21.877' AS DateTime), CAST(N'2019-03-19T09:51:19.910' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-03-19T09:31:50.190' AS DateTime), CAST(N'2019-03-19T09:51:19.920' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-03-19T09:09:23.603' AS DateTime), CAST(N'2019-03-19T09:51:19.933' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-03-18T14:37:53.170' AS DateTime), CAST(N'2019-03-19T09:51:19.947' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-03-18T14:38:09.827' AS DateTime), CAST(N'2019-03-19T09:51:19.980' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-03-19T09:24:07.030' AS DateTime), CAST(N'2019-03-19T09:51:19.993' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.810' AS DateTime), CAST(N'2019-03-19T09:51:20.007' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-19T09:51:20.017' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-03-19T09:32:06.890' AS DateTime), CAST(N'2019-03-19T09:51:35.177' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-03-19T09:09:53.140' AS DateTime), CAST(N'2019-03-19T09:51:35.187' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-03-19T07:56:14.013' AS DateTime), CAST(N'2019-03-19T09:51:35.197' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-03-18T14:39:13.353' AS DateTime), CAST(N'2019-03-19T09:51:35.207' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-03-19T09:32:23.977' AS DateTime), CAST(N'2019-03-19T09:51:35.217' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-03-19T09:32:23.207' AS DateTime), CAST(N'2019-03-19T09:51:35.230' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_MonitorWorkload', N'N', CAST(N'2019-03-19T09:24:30.630' AS DateTime), CAST(N'2019-03-19T09:51:35.240' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-03-19T09:24:34.387' AS DateTime), CAST(N'2019-03-19T09:51:35.250' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-03-18T14:39:37.313' AS DateTime), CAST(N'2019-03-19T09:51:35.263' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-03-18T14:39:44.353' AS DateTime), CAST(N'2019-03-19T09:51:35.303' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-03-18T14:39:40.463' AS DateTime), CAST(N'2019-03-19T09:51:35.327' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-03-18T14:39:41.050' AS DateTime), CAST(N'2019-03-19T09:51:35.340' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-19T09:51:35.350' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-03-19T09:35:01.557' AS DateTime), CAST(N'2019-03-19T09:51:35.363' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-03-19T09:35:01.093' AS DateTime), CAST(N'2019-03-19T09:51:35.373' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-03-19T09:10:46.860' AS DateTime), CAST(N'2019-03-19T09:51:35.387' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-03-18T14:40:07.953' AS DateTime), CAST(N'2019-03-19T09:51:35.400' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-03-18T14:40:04.050' AS DateTime), CAST(N'2019-03-19T09:51:35.410' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-03-19T09:24:30.747' AS DateTime), CAST(N'2019-03-19T09:51:35.443' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-19T09:51:35.457' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-19T09:51:35.467' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-03-19T09:35:42.320' AS DateTime), CAST(N'2019-03-19T09:51:51.293' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-03-19T09:13:20.170' AS DateTime), CAST(N'2019-03-19T09:51:51.303' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-03-19T07:59:32.750' AS DateTime), CAST(N'2019-03-19T09:51:51.320' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-03-18T14:43:45.543' AS DateTime), CAST(N'2019-03-19T09:51:51.330' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-03-19T09:25:27.443' AS DateTime), CAST(N'2019-03-19T09:51:51.340' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-03-19T09:25:28.347' AS DateTime), CAST(N'2019-03-19T09:51:51.353' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_MonitorWorkload', N'N', CAST(N'2019-03-19T09:36:21.140' AS DateTime), CAST(N'2019-03-19T09:51:51.363' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-03-19T09:36:45.563' AS DateTime), CAST(N'2019-03-19T09:51:51.393' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-03-18T14:45:30.390' AS DateTime), CAST(N'2019-03-19T09:51:51.403' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-03-18T14:45:43.737' AS DateTime), CAST(N'2019-03-19T09:51:51.413' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-03-18T14:46:03.650' AS DateTime), CAST(N'2019-03-19T09:51:51.440' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-03-18T14:46:30.773' AS DateTime), CAST(N'2019-03-19T09:51:51.453' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-19T09:51:51.467' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-03-19T09:15:16.573' AS DateTime), CAST(N'2019-03-19T09:51:51.480' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-03-19T09:15:16.560' AS DateTime), CAST(N'2019-03-19T09:51:51.490' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-03-19T09:16:19.913' AS DateTime), CAST(N'2019-03-19T09:51:51.507' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-03-18T14:48:04.287' AS DateTime), CAST(N'2019-03-19T09:51:51.543' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-03-18T14:48:31.080' AS DateTime), CAST(N'2019-03-19T09:51:51.567' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-03-19T09:37:24.010' AS DateTime), CAST(N'2019-03-19T09:51:51.600' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-19T09:51:51.617' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-19T09:51:51.633' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_TEST', N'N', CAST(N'2019-03-01T10:49:13.340' AS DateTime), CAST(N'2019-03-08T20:48:04.633' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:18:49.357' AS DateTime), CAST(N'2019-03-08T19:30:55.677' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_TEST', N'N', CAST(N'2019-03-04T16:15:37.093' AS DateTime), CAST(N'2019-03-08T23:27:24.577' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:01.500' AS DateTime), CAST(N'2019-03-08T18:18:32.173' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_TEST', N'N', CAST(N'2019-03-01T13:19:21.940' AS DateTime), CAST(N'2019-03-08T23:24:42.070' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:22.040' AS DateTime), CAST(N'2019-03-08T18:15:46.780' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBUsage', N'N', CAST(N'2019-03-19T09:48:48.837' AS DateTime), CAST(N'2019-03-19T09:51:19.867' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBUsage', N'N', CAST(N'2019-03-19T09:48:48.847' AS DateTime), CAST(N'2019-03-19T09:51:35.313' AS DateTime))
		--GO
		INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBUsage', N'N', CAST(N'2019-03-19T09:48:48.857' AS DateTime), CAST(N'2019-03-19T09:51:51.427' AS DateTime))
		--GO
		SET IDENTITY_INSERT [dbo].[ActiveJobStep] ON 
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'9911e4cb-b047-4b66-977c-db19b9e811c1', N'Y', 208, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'cb142312-c02d-44e5-a83e-51cebe90ab41', N'Y', 209, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f7d9a7eb-f7e8-456c-8098-827e2bd5a89b', N'Y', 210, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'014c0dd0-5432-4c35-9323-814a99e37213', N'Y', 211, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'fba69c87-a70b-4b48-90d6-eb3f5725a749', N'Y', 212, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'ed9a83d8-ba28-4c91-bd33-c2e375e98f0d', N'Y', 213, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'b051b960-57d7-47c3-aa93-44be53ae4938', N'N', 214, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'd654ec5f-1aa2-46ae-bc89-40b8dad0733f', N'Y', 215, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'7fdb32a9-4c19-4a40-a318-3bc4dc9fbd4d', N'Y', 216, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'e6121ff3-d94b-4512-8e2c-18de293eddc2', N'Y', 217, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'dfb9f3ef-0ffa-4f48-bfe3-5ea8943636d0', N'Y', 218, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'd62c9887-d32d-4f67-af3e-9198223d2b35', N'Y', 219, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4755e75e-ae38-42c4-a4ee-0fbc650f64c6', N'Y', 220, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'32633074-61ff-418b-b1b2-ca0e51a07c3e', N'N', 221, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'54cd4fd9-f2ca-477b-a959-ec3a77c1cc38', N'Y', 222, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'ec46336f-42b2-4ac7-aff9-02aa1bbef579', N'Y', 223, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'14ffdb3d-b299-4931-8f75-47d7771d5c43', N'Y', 224, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'faaf4f9b-1f12-49af-9fc1-3897f71d4cb2', N'Y', 225, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 226, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 227, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 228, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 229, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 230, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 231, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ae96a724-fa83-450d-8a46-2ba973f1b9a1', N'Y', 85, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 86, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 87, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 88, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 89, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 90, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 91, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 92, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 93, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'a29c0bbf-29ea-447e-b89b-a7047da0591c', N'Y', 94, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'971bb98b-9714-44af-9d0e-6ec421a3334e', N'Y', 95, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'16fdefc0-a207-45bd-8951-35e0d2167392', N'Y', 96, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'3e720149-1aed-491a-ad18-f142aa4a0e38', N'Y', 97, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'2788b130-9ade-4a4d-a34e-451a0200940e', N'Y', 98, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'87680695-f42b-4465-8a40-b470573bc656', N'Y', 99, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd6c31c69-866b-42ca-94ff-a8b827aaca60', N'Y', 100, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'7a483180-5604-49ca-ac47-e848c4eca4a0', N'Y', 101, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'f783a590-426c-43b6-8097-212a56eeb0b2', N'N', 102, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'e7ff3122-05b1-437b-8778-1e6ec0790edb', N'Y', 103, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'294b86f0-973d-4222-adac-4770689360b6', N'Y', 104, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'65e9fbf2-9985-404a-8caf-2385d6fba2c5', N'Y', 105, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'82b87597-1998-43b9-82bd-8ccabb40a6b2', N'Y', 106, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'7c5a20b0-7981-4446-8c58-6766fcf97c17', N'Y', 107, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'89efb6e5-e151-49a1-b867-067ed953935f', N'Y', 108, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'cc071751-3837-4f9b-8bd5-c7afeb4c65e9', N'Y', 272, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'd675b723-b50e-49bd-9c39-eb0bf30c40c8', N'Y', 273, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'10c45ce1-9cf0-4681-8717-dc829a52b213', N'Y', 274, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'65836f8d-40dc-43fe-a28b-91cbcb088de4', N'Y', 275, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'3f03fc66-c7ab-4cdb-85c8-85bd0c49f4c3', N'Y', 276, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'2d242010-ddfb-47e1-b529-a8253ee9dfa7', N'N', 277, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'c990c1dd-54eb-4d39-8df4-3df7a8f84449', N'Y', 278, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'772a144c-06ac-4963-a4ee-6aba80c370a2', N'Y', 279, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'27cf028c-319e-4e88-8dfb-63ab705c10bf', N'Y', 280, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBUsage', N'N', N'N', N'27cf028c-319e-4e88-8dfb-63ab705c10aa', N'Y', 281, N'JOB_UTIL_DBUsage', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Check Running processes', N'sp_who2', N'Y', N'N', N'5e70100f-3e00-434c-9f0a-4dffa3e2d4ac', N'Y', 334, N'JOB_TEST', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'a1911306-7d38-4688-993a-10d2544911f3', N'Y', 306, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 307, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 308, NULL, 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 309, NULL, 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 310, NULL, 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 311, NULL, 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 312, NULL, 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 313, NULL, 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'ec26f965-a86c-48f0-bfae-223b63b16c0a', N'Y', 314, NULL, 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'9ce6f59f-95f8-4c65-970c-83e5fed49fe1', N'Y', 315, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'6e85916b-c139-4cae-9801-145d2832977a', N'Y', 316, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'8af19b38-a6b1-4918-94dc-aa0fda5c4cbb', N'Y', 317, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'629c8a6e-ce2b-4f37-9328-9b2bfe97d95c', N'Y', 318, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'4a06266b-e886-4920-b5b9-ba93432bce2d', N'Y', 319, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'f632cb11-d36c-401b-acfa-59a84cfe5266', N'Y', 320, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'5aae567d-e776-4bdb-9127-ad159af80d6a', N'Y', 321, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'27387393-040b-4cbd-897f-0f2e7a9a43d4', N'Y', 322, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'83058fcb-016f-4e09-90ff-e7d1f3310141', N'N', 323, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1b0f4eca-8842-43ac-b5d7-5f8ede7505bb', N'Y', 324, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'91d564d0-9890-412f-979f-04b731551e37', N'Y', 325, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'a09c8059-1051-4b35-84f9-bed176de4cbc', N'Y', 326, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'55eb5aba-072d-48cd-bae2-ab27b2a56a3b', N'Y', 327, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'3d4584ef-710c-46a0-a417-f1e925ea1865', N'Y', 328, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'c05ca2cd-4708-48e7-8628-59d36cae8b32', N'Y', 329, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'b06f95ac-b1df-49a1-af59-3db74abff9cc', N'N', 330, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'78d69a45-5823-46da-b644-ae99f4ad9c99', N'Y', 331, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'04b9f98f-a4aa-459d-b3d5-53ad3af16363', N'Y', 332, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'5dcc09c4-ffcc-4e06-b5bc-834a56398c46', N'Y', 333, NULL, 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'7a48e3de-f83d-4b04-85ac-a68d31f8ea7e', N'Y', 1, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 2, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 3, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 4, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 5, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 6, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 7, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 8, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 9, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'ef0df41d-6f9e-465f-914a-1fc622ecb744', N'Y', 10, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'8a351ecf-882a-4128-82e8-14025ba5537e', N'Y', 11, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'8258bd1d-df74-410b-973f-91c52dbc53de', N'Y', 12, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'b559e79a-bc2d-4ddf-b81c-a75e076780a5', N'Y', 13, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a727351e-a627-4ab6-b138-6e888011fcce', N'Y', 14, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'2a5020d8-1005-4f2a-ac9a-3a95a9229f5c', N'Y', 15, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'89c8c938-489d-4b41-b84c-c367488b30b6', N'Y', 16, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'025498da-1fb3-4a5e-9fea-60b584060f66', N'Y', 17, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2d5c93d6-2763-4005-8c8e-4bd923910d0f', N'N', 18, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1643fbbe-79d5-4d6f-abcf-9bae6338380b', N'Y', 19, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 30, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 31, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 32, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 33, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 34, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 35, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 36, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 37, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8203bcf3-f0c4-45f7-ba35-3d376582f6bb', N'Y', 38, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'65d2aea7-32e8-4990-b508-968615adffef', N'Y', 39, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'0dae3845-9a38-4b51-8557-1697a61666ff', N'Y', 40, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'2307ec0c-aed0-421d-942c-89a732982188', N'Y', 41, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'dff23ef3-b73d-45ef-8c34-a3db3b398029', N'Y', 42, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'3abfc9cd-311c-41c2-8933-d98a1b9ded23', N'Y', 43, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'7059151e-344e-497d-b992-b1459f3e6618', N'Y', 44, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'815ae81a-f117-4c79-85c2-d9fa59d2f6e6', N'Y', 45, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'35b25e59-9bff-4434-a39c-84b23ee735f2', N'N', 46, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c86e97ce-cb7f-4da0-938b-5773ab05c8b1', N'Y', 47, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'70b0d4c1-f08d-4178-9a8b-02a9bd81db5e', N'Y', 48, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'c88d2e5c-fc6d-4bc8-81c2-2ca721e4d1df', N'Y', 49, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'faba3768-5d1f-4841-b757-f5ec4382692c', N'Y', 50, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1b65499d-5337-40a9-8231-443394527bec', N'Y', 51, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'2d24005d-b3df-4942-ada7-0175006b6e17', N'Y', 52, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cd0f6c7c-8a11-4b4e-af3b-9cae576a519e', N'N', 53, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'a2da87ee-174c-474c-b590-0e53ce597af9', N'Y', 54, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'a891279a-6302-47cf-a6da-f80e6350179d', N'Y', 55, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'eaa19f60-93c6-4ec6-859c-0487354b4ff3', N'Y', 56, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'82f20db3-bd15-4b8b-8c34-35e915cde54f', N'Y', 57, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 58, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 59, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 60, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 61, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 62, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 63, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 64, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 65, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'6dce5caa-6639-49b2-b73c-a2dbf07777aa', N'Y', 66, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'5db80b4d-7db3-47a0-8887-bf05a1bd252c', N'Y', 67, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'ae459a69-c155-4beb-839c-796ba3718ec7', N'Y', 68, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'892d2808-902e-4283-a02b-b7eb54675a09', N'Y', 69, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'0fc41e38-03c9-4a30-9221-d6497f398cdb', N'Y', 70, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'a479c0c3-08a1-454a-8068-59841533f281', N'Y', 71, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'1d07071c-70b4-4d38-95f2-f2048a3886a7', N'Y', 72, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c7d138f5-487e-4ba5-9964-ea418cf7384b', N'Y', 73, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'946e919a-1a5a-42b1-90be-95df2f14b017', N'N', 74, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'890b31fa-207c-4ad5-b987-09400e625340', N'Y', 75, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'3b259d59-7f49-4dcf-b9be-f1b63ba7c236', N'Y', 76, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'4e4f4756-6074-4273-8da6-1079d06487e4', N'Y', 77, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'9ea424d9-14b1-43d6-bd67-32755137f188', N'Y', 20, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'86e19be4-bf01-4353-b618-f5620a16ab55', N'Y', 21, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'adb0c1fa-5d1a-4a78-8eb3-b11e81e2e3fa', N'Y', 22, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'ebbad699-8d7a-4e92-b647-243ff23fbfd2', N'Y', 23, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'f61e55aa-f9a6-4bd9-a8b9-482ea014658a', N'Y', 24, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'ba42264d-083f-4974-9dbe-1c560ac16630', N'N', 25, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'ef3111bd-2322-4033-98f6-4674bbc03452', N'Y', 26, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'1c151ba9-98d7-4f06-b88e-8eb1fa72493f', N'Y', 27, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'dd4fa58c-38ed-4ace-b349-ab9b467d601c', N'Y', 28, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'72908a6f-3272-4850-ac54-8f0a9abe5018', N'Y', 29, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a1006e4a-c07d-46fe-87ad-7e168003310f', N'N', 109, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'4384dc46-f064-43bc-8e08-e064aca3b0a8', N'Y', 110, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'702266b2-6ce4-4a59-a9fb-dd4ceeff7cd0', N'Y', 111, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'a75f5977-3cda-4199-aa78-53827074c708', N'Y', 112, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'f5b972b9-c7cb-44d3-ab84-2d40becc1d4d', N'Y', 141, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 142, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 143, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 144, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 145, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 146, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 147, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 148, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 149, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'5a2f479c-091b-4969-8520-f69fe5b54066', N'Y', 150, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'91a3cefa-73e8-493d-bcde-e25fd3acb10b', N'Y', 151, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'fd5a3191-d65e-408b-8398-c8841d19b8ff', N'Y', 152, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'f4801c2b-d4f5-4ef7-8a78-95b8e66edac7', N'Y', 153, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'044ea6d5-0e72-431c-9ebf-0bd81fd66411', N'Y', 154, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'164e8c2a-67d5-426e-b90c-5bd437b84b11', N'Y', 155, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'ac77f0a8-2094-4317-88b1-68e2b547b87f', N'Y', 156, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'0f74969c-a766-44fa-93e3-f31ce7ef6ec6', N'Y', 157, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'6d918491-5046-426b-b490-d6b31d517085', N'N', 158, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'1ae80569-dcfd-4fd5-9239-650b3ac6fc56', N'Y', 159, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40273c83-9116-45a4-a424-b70ba19c70b8', N'Y', 160, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'2bc61139-4e95-4ea4-8016-98e559cbe853', N'Y', 161, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'c679a84b-cf30-47b9-bf58-82588f675f2a', N'Y', 162, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'9c39cf2d-d1b0-4366-9a71-a9f03a92f053', N'Y', 163, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'7bbcc3aa-7c0b-47b5-bfa7-c19cb09af5a3', N'Y', 164, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a5a1314b-8d8e-4027-a834-eb4d7355650d', N'N', 165, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2526cb5d-9785-45ed-812c-39683721c986', N'Y', 166, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'11794906-8865-4514-a661-57c6b47c0222', N'Y', 167, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'88473c7b-e79a-4e9b-a67d-cb1076c6879a', N'Y', 168, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 232, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8843fec6-9f47-4a77-a8d4-a467b7be41de', N'Y', 234, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'23435859-1bd5-4e1f-aaa4-6cf93f539eae', N'Y', 235, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'4289831c-2656-4ba7-9212-b9cae9a32a44', N'Y', 236, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'03b5ff8d-8622-4fbb-b530-c79ab8f3e85f', N'Y', 237, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f5da6dc4-cce7-4159-8486-d49e6e73a5b9', N'Y', 238, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'f3460d20-d1dd-49c6-a08c-5f72bf74b9c4', N'Y', 239, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'6a775a0a-a1db-4820-af5b-88f15cf18cd0', N'Y', 240, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c77ae818-7d3c-4f97-a293-fa221dc812a3', N'Y', 241, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'1a488e87-2467-4433-b765-12e8cff6e933', N'N', 242, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c1423989-77f6-4fc7-8c4d-1800de75525b', N'Y', 243, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40606dc2-dac7-4256-86cf-5463e7e67a73', N'Y', 244, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'640eaa80-de60-41c4-8bcb-27ba1e5c7166', N'Y', 245, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'e4366e59-c986-4a13-b680-867f154e4279', N'Y', 246, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1d2b3ef1-408d-4aa7-8b2a-46eb08fb194f', N'Y', 247, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'87f9f163-74e6-4f0b-a284-75355163fd11', N'Y', 248, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cab12745-105f-45b7-9e5c-2f8167974fdc', N'N', 249, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'59cd0791-aaf8-48f8-88d6-7096fd3e386b', N'Y', 250, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'6a38d7f7-dacd-4500-a7a4-12ea687ad3a7', N'Y', 251, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'91b25b60-a4b7-4f4d-b4be-d18d6494393a', N'Y', 252, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step1', N'sp_who3', N'Y', N'N', N'df0414cb-1661-47e5-b41f-0b5dc45de071', N'N', 282, N'JOB_TEST', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 171, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 172, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 173, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 174, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 175, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 176, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 177, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'e15ceb1f-75d9-4455-950c-51d78e39dd06', N'Y', 178, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'9fce1f76-01b8-4851-be82-4aa0ecd5441b', N'Y', 179, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'cc440148-dfa7-4169-a8da-0975f9049f11', N'Y', 180, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'96aa26f5-3c21-415c-a64e-c786c31c0407', N'Y', 181, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'6cb3d54e-69ae-4d70-8b85-efad3c1051d0', N'Y', 182, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'062aea06-153b-49b4-9bc1-41d84026817a', N'Y', 183, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd77f16ad-bf60-4122-a5ac-e941f62d926b', N'Y', 184, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'98f1e17b-c18e-4dc9-b965-6db42f34d060', N'Y', 185, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2b44188f-cd38-451f-89be-aad487565d7a', N'N', 186, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'2250a5ee-c931-4017-b27e-9248f3dc33dd', N'Y', 187, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'c9cfb88e-84e3-45fe-9159-3fc01a48da43', N'Y', 188, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'22a33f12-a84f-4eba-bc30-56de7fa193fe', N'Y', 189, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'980e03e5-977b-44f0-8473-cfffb91357b0', N'Y', 190, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'36f38e66-00f4-4a0a-b201-1bbedb24f3e0', N'Y', 191, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4412fd00-eba3-496f-b3dc-36e72aae3c5d', N'Y', 192, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'c2767c3a-bed7-4c74-b3f3-0e5d88e38cbc', N'N', 193, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'8b47b8e5-4b4f-43c2-94d0-3e9c1b01eb2c', N'Y', 194, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'4b4f24ca-8b13-4ccc-9871-e298283cac86', N'Y', 195, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'6426b370-c08d-486e-b62e-c3e0d8e865c1', N'Y', 196, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 233, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'448f0260-3a56-4a6f-a1ea-ac4c9c605263', N'Y', 253, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 254, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 255, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 256, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 257, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 258, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 259, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 260, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 261, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'217899bc-4071-4b75-a8c7-5f0284af3357', N'Y', 262, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'942b8bdf-f031-4ab6-809b-329bfcacf195', N'Y', 263, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'92eb136a-dcff-4249-bf35-ad5cd118d215', N'Y', 264, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'a60d4078-74dd-48fd-a245-26002f55061a', N'Y', 265, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'e49fd974-48b9-4d2d-9d77-449b89bacda3', N'Y', 266, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'410b1946-bc26-4684-9fbf-561b6807f7c8', N'Y', 267, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'5fd418b9-e3ef-4354-91d4-7c12e351b152', N'Y', 268, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'3491e4f1-54fb-4a08-81a8-ee0f26b0f46b', N'Y', 269, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'52f96d9f-5789-427c-ad76-0b7a4d23b8fc', N'N', 270, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'c9bed2a3-8b1e-489d-a255-166f267d8ba7', N'Y', 271, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'b22d702d-fffb-4d1a-9a83-479b81692c3e', N'Y', 78, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'c6bc37a4-5148-454d-a36c-6b8f2a347ef5', N'Y', 79, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'25864f68-7c27-40c0-9b11-677a07d3bc26', N'Y', 80, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'5a868f12-1ced-48ce-8e4e-dbfd39fa573b', N'N', 81, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'babacaef-44d8-410d-b523-567f35450776', N'Y', 82, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'78718fa4-7a86-4388-a81b-d9479c2e1885', N'Y', 83, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'263e288d-4eb9-43ad-bd6e-90d0703272f7', N'Y', 84, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'5ff535ea-5614-4ac4-9140-73c2f16afb5d', N'Y', 113, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 114, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 115, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 116, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 117, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 118, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 119, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 120, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 121, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'bd5af2ee-cc50-4253-9ef5-56af2131f7e6', N'Y', 122, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'ebc5339a-51e6-41ae-97be-7cac8971162f', N'Y', 123, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'd749b33f-bb2b-43c0-8a0d-cdefc7c4c20b', N'Y', 124, N'JOB_DFS_MonitorLocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'c9160b0a-ff34-4be4-ab91-e9779287c3ac', N'Y', 125, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a3ad0aee-6a91-493d-bf67-22cb72de0ff4', N'Y', 126, N'JOB_MonitorWorkload', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'b57e8106-df52-46df-b4ad-b3a57730b5a5', N'Y', 127, N'JOB_UTIL_DbMon_IndexVolitity', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'93765a74-9d65-44cd-869d-946f00cd7b81', N'Y', 128, N'JOB_UTIL_DBSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'6a42e0f4-78d9-4029-bdb8-7f0cf06ad7a8', N'Y', 129, N'JOB_UTIL_DBTableSpace', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'c9fe8a15-244b-42d2-9100-8c7f38323bc9', N'N', 130, N'JOB_UTIL_DFS_DbSize', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats @RunID', N'N', N'Y', N'507ec161-0114-4f34-8e06-c2d214a91cbc', N'Y', 131, N'JOB_UTIL_GetIndexStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'6c2d721d-498c-4d26-94a0-2609397a0ac9', N'Y', 132, N'JOB_JOB_UTIL_MonitorDeadlocks', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'0f24f6c2-e149-41cc-8414-d606f293ad1d', N'Y', 133, N'JOB_UTIL_MonitorMostCommonWaits', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'0623c052-1fbb-43df-9243-9d7f366ec26b', N'Y', 134, N'JOB_UTIL_ParallelMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'24227f73-e8cc-4540-ba48-2d8ca41e8123', N'Y', 135, N'JOB_UTIL_QryPlanStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'6cf8d9dd-583b-4055-9369-8ea6834b6da9', N'Y', 136, N'JOB_UTIL_ReorgFragmentedIndexes', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'4a6cfd66-ccff-4466-a584-5f6a61f29455', N'N', 137, N'JOB_UTIL_TempDbMonitor', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2368ac20-6bb7-4863-991a-f99af95ef90b', N'Y', 138, N'JOB_UTIL_TrackSessionWaitStats', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'06a6bb48-dcaa-4e78-b859-024551450dea', N'Y', 139, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'e22f5cab-98af-4dca-837f-c8a5b1177a52', N'Y', 140, N'JOB_UTIL_Monitor_TPS', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ce610c62-6553-4893-9bd0-f150182a6df0', N'Y', 169, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 170, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ba44111b-83ce-4de8-915b-e88a7fe18299', N'Y', 197, N'JOB_CaptureWorstPerfQuery', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 198, N'JOB_UpdateQryPlans', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 199, N'JOB_UpdateQryPlans', 2)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 200, N'JOB_UpdateQryPlans', 3)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 201, N'JOB_UpdateQryPlans', 4)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 202, N'JOB_DFS_BoundQry_ProcessAllTables', 5)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 203, N'JOB_DFS_BoundQry_ProcessAllTables', 6)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 204, N'JOB_DFS_BoundQry_ProcessAllTables', 7)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 205, N'JOB_DFS_BoundQry_ProcessAllTables', 8)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'dbc36f52-4ac4-4d55-9896-2608dda7620a', N'Y', 206, N'JOB_DFS_CleanDFSTables', 1)
		--GO
		INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName], [ExecutionOrder]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'cb678e7c-6965-4e51-a128-43bab79b8b0c', N'Y', 207, N'JOB_DFS_GetAllTableSizesAndRowCnt', 1)
		--GO
		SET IDENTITY_INSERT [dbo].[ActiveJobStep] OFF
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'Y', N'dfin.database.windows.net,1433', N'TestAzureDB', N'wmiller', N'Junebug1', N'1f171c2d-5cb4-49f6-bb15-14a510aa321e', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'Y', N'dfin.database.windows.net,1433', N'AW_AZURE', N'wmiller', N'Junebug1', N'23c3c555-6fcf-44b2-8d18-d79d149be616', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'AW2016', N'sa', N'Junebug1', N'14817462-8896-42d1-b3aa-f832188b05b0', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'WDM', N'sa', N'Junebug1', N'8a5fae65-4ab1-483a-a377-5d0d7ceff46a', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'TestDB', N'sa', N'Junebug1', N'25212014-0787-476a-874f-b71f528d6284', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'ALIEN15', N'PowerDatabase', N'sa', N'Junebug1', N'ed0367a1-b8bb-468e-902d-83c5c398eded', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'DFINAnalytics', N'sa', N'Junebug1', N'3822a6d0-5ebb-47be-9090-0a6f315eaeaf', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'DFS', N'sa', N'Junebug1', N'569324ac-9817-4cfe-b306-4117b0eab426', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrData', N'sa', N'Junebug1', N'e78ca36c-651a-4cb3-b775-91518524781d', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrPort', N'sa', N'Junebug1', N'ae158695-02e6-46ed-acc8-b091c5bf7c64', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'MstrLog', N'sa', N'Junebug1', N'b5be8517-8a7f-45d0-bb7a-836e79fbb7aa', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'TestXml', N'sa', N'Junebug1', N'0223844b-a5cb-4cb4-9c26-6dbe1c7a1842', 1)
		--GO
		INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'TESTGROUP', N'N', N'SVR2016', N'AW_VMWARE', N'sa', N'Junebug1', N'3c383759-5550-46de-8723-ffe5fcd84595', 1)
		--GO


end