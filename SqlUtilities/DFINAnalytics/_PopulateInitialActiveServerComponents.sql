
go
SET IDENTITY_INSERT [dbo].[ActiveJob] ON 
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_CaptureWorstPerfQuery', N'N', N'448f0260-3a56-4a6f-a1ea-ac4c9c605263', N'min', 15, CAST(N'2019-03-01T14:26:26.507' AS DateTime), CAST(N'2019-03-02T08:15:01.307' AS DateTime), N'Y', 1)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_DFS_BoundQry_ProcessAllTables', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'min', 30, CAST(N'2019-02-28T15:52:18.173' AS DateTime), CAST(N'2019-03-02T08:34:33.513' AS DateTime), N'Y', 2)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_DFS_CleanDFSTables', N'N', N'217899bc-4071-4b75-a8c7-5f0284af3357', N'hour', 12, CAST(N'2019-02-28T15:52:18.180' AS DateTime), CAST(N'2019-03-02T20:07:04.580' AS DateTime), N'Y', 3)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', N'942b8bdf-f031-4ab6-809b-329bfcacf195', N'day', 1, CAST(N'2019-03-01T14:33:33.427' AS DateTime), CAST(N'2019-03-02T14:33:33.447' AS DateTime), N'Y', 4)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_DFS_MonitorLocks', N'N', N'92eb136a-dcff-4249-bf35-ad5cd118d215', N'min', 5, CAST(N'2019-02-28T15:52:18.180' AS DateTime), CAST(N'2019-03-02T08:12:31.760' AS DateTime), N'Y', 5)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', N'a60d4078-74dd-48fd-a245-26002f55061a', N'min', 5, CAST(N'2019-02-28T15:52:18.197' AS DateTime), CAST(N'2019-03-02T08:13:05.477' AS DateTime), N'Y', 6)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_MonitorWorkload', N'N', N'e49fd974-48b9-4d2d-9d77-449b89bacda3', N'min', 10, CAST(N'2019-02-28T15:52:18.197' AS DateTime), CAST(N'2019-03-02T08:18:21.130' AS DateTime), N'Y', 7)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_DbMon_IndexVolitity', N'N', N'410b1946-bc26-4684-9fbf-561b6807f7c8', N'min', 10, CAST(N'2019-02-28T15:52:18.197' AS DateTime), CAST(N'2019-03-02T08:19:21.093' AS DateTime), N'Y', 8)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_DBSpace', N'N', N'5fd418b9-e3ef-4354-91d4-7c12e351b152', N'day', 7, CAST(N'2019-02-28T15:52:18.197' AS DateTime), CAST(N'2019-03-08T14:47:27.503' AS DateTime), N'Y', 9)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_DBTableSpace', N'N', N'3491e4f1-54fb-4a08-81a8-ee0f26b0f46b', N'day', 1, CAST(N'2019-02-28T15:52:18.210' AS DateTime), CAST(N'2019-03-02T14:47:45.180' AS DateTime), N'Y', 10)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_DFS_DbSize', N'N', N'52f96d9f-5789-427c-ad76-0b7a4d23b8fc', N'day', 1, CAST(N'2019-02-28T15:52:18.213' AS DateTime), CAST(N'2019-03-02T14:48:08.830' AS DateTime), N'Y', 11)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_GetIndexStats', N'N', N'c9bed2a3-8b1e-489d-a255-166f267d8ba7', N'day', 1, CAST(N'2019-02-28T15:52:18.213' AS DateTime), CAST(N'2019-03-02T14:48:31.293' AS DateTime), N'Y', 12)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_MonitorDeadlocks', N'N', N'cc071751-3837-4f9b-8bd5-c7afeb4c65e9', N'day', 1, CAST(N'2019-02-28T15:52:18.213' AS DateTime), CAST(N'2019-03-02T14:48:55.487' AS DateTime), N'Y', 13)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_MonitorMostCommonWaits', N'N', N'd675b723-b50e-49bd-9c39-eb0bf30c40c8', N'min', 15, CAST(N'2019-02-28T15:52:18.217' AS DateTime), CAST(N'2019-03-02T08:24:45.820' AS DateTime), N'Y', 14)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_ParallelMonitor', N'N', N'10c45ce1-9cf0-4681-8717-dc829a52b213', N'min', 15, CAST(N'2019-02-28T15:52:18.237' AS DateTime), CAST(N'2019-03-02T08:25:07.963' AS DateTime), N'Y', 15)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_QryPlanStats', N'N', N'65836f8d-40dc-43fe-a28b-91cbcb088de4', N'min', 30, CAST(N'2019-02-28T15:52:18.237' AS DateTime), CAST(N'2019-03-02T08:41:05.827' AS DateTime), N'Y', 16)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_ReorgFragmentedIndexes', N'N', N'3f03fc66-c7ab-4cdb-85c8-85bd0c49f4c3', N'day', 7, CAST(N'2019-02-28T15:52:18.237' AS DateTime), CAST(N'2019-03-08T14:50:27.753' AS DateTime), N'Y', 17)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_TempDbMonitor', N'N', N'2d242010-ddfb-47e1-b529-a8253ee9dfa7', N'day', 7, CAST(N'2019-02-28T15:52:18.240' AS DateTime), CAST(N'2019-03-08T14:50:56.813' AS DateTime), N'Y', 18)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_TrackSessionWaitStats', N'N', N'c990c1dd-54eb-4d39-8df4-3df7a8f84449', N'min', 10, CAST(N'2019-02-28T15:52:18.280' AS DateTime), CAST(N'2019-03-02T08:24:16.060' AS DateTime), N'Y', 19)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UTIL_TxMonitorTableStats', N'N', N'772a144c-06ac-4963-a4ee-6aba80c370a2', N'min', 10, CAST(N'2019-02-28T15:52:18.280' AS DateTime), CAST(N'2019-03-02T08:24:39.927' AS DateTime), N'Y', 20)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'UTIL_TxMonitorIDX', N'N', N'27cf028c-319e-4e88-8dfb-63ab705c10bf', N'min', 10, CAST(N'2019-02-28T15:52:18.280' AS DateTime), CAST(N'2019-03-02T08:25:05.420' AS DateTime), N'Y', 21)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_TEST', N'N', N'df0414cb-1661-47e5-b41f-0b5dc45de071', N'hour', 8, CAST(N'2019-03-01T10:48:56.090' AS DateTime), CAST(N'2019-03-02T16:08:49.223' AS DateTime), N'Y', 22)
INSERT [dbo].[ActiveJob] ([JobName], [disabled], [UID], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable], [RowNbr]) VALUES (N'JOB_UpdateQryPlans', N'N', N'66572618-0092-4aaa-81a4-7487717c77ba', N'hour', 4, CAST(N'2019-03-01T13:14:20.267' AS DateTime), CAST(N'2019-03-01T13:14:20.267' AS DateTime), N'Y', 23)
SET IDENTITY_INSERT [dbo].[ActiveJob] OFF
GO


INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_CaptureWorstPerfQuery', N'ALIEN15', N'PowerDatabase', N'Step01', N'c2840d90-d5e1-4a32-a07d-0d84949d7c25', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:26:19.5633333' AS DateTime2), CAST(N'2019-03-01T14:26:26.5066667' AS DateTime2), CAST(6943.0000 AS Decimal(18, 4)), 1, 253, CAST(7.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'ALIEN15', N'PowerDatabase', N'Step01', N'c2840d90-d5e1-4a32-a07d-0d84949d7c25', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:32:30.7833333' AS DateTime2), CAST(N'2019-03-01T14:32:34.2200000' AS DateTime2), CAST(3437.0000 AS Decimal(18, 4)), 4, 263, CAST(4.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'ALIEN15', N'TestDB', N'Step01', N'9bf1dc60-edf4-46f6-84a4-ec24abfef02f', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:32:57.3233333' AS DateTime2), CAST(N'2019-03-01T14:32:57.3466667' AS DateTime2), CAST(23.0000 AS Decimal(18, 4)), 4, 263, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'ALIEN15', N'WDM', N'Step01', N'6282b34d-4f9c-4ee3-8e0b-814ab31e6777', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:00.4700000' AS DateTime2), CAST(N'2019-03-01T14:33:00.5100000' AS DateTime2), CAST(40.0000 AS Decimal(18, 4)), 4, 263, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'dfin.database.windows.net,1433', N'AW_AZURE', N'Step01', N'45d9391f-c752-423c-966c-36dec7d708ae', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:03.8966667' AS DateTime2), CAST(N'2019-03-01T14:33:04.6800000' AS DateTime2), CAST(784.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'dfin.database.windows.net,1433', N'TestAzureDB', N'Step01', N'4868606a-95b5-4925-906a-7431e9393f3b', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:13.6000000' AS DateTime2), CAST(N'2019-03-01T14:33:13.9466667' AS DateTime2), CAST(346.0000 AS Decimal(18, 4)), 4, 263, CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'dfin.database.windows.net,1433', N'TestAzureDB', N'Step01', N'9681af5e-14b8-4136-8fd6-b2db74ebe567', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:16.9566667' AS DateTime2), CAST(N'2019-03-01T14:33:17.0366667' AS DateTime2), CAST(80.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'SVR2016', N'AW_VMWARE', N'Step01', N'70a5919e-6b2b-449e-ae2e-a7138751c743', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:20.0400000' AS DateTime2), CAST(N'2019-03-01T14:33:21.1366667' AS DateTime2), CAST(1096.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'SVR2016', N'DFS', N'Step01', N'ce2ee4bc-5cd6-4547-b892-eee66eb51993', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:24.1566667' AS DateTime2), CAST(N'2019-03-01T14:33:25.1866667' AS DateTime2), CAST(1030.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'SVR2016', N'MstrData', N'Step01', N'0bfe261d-7567-46aa-b52b-f750dceac5a4', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:28.1633333' AS DateTime2), CAST(N'2019-03-01T14:33:29.2366667' AS DateTime2), CAST(1073.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'SVR2016', N'MstrPort', N'Step01', N'eabece66-fd14-446f-8fd6-c916db611f80', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:32.3300000' AS DateTime2), CAST(N'2019-03-01T14:33:33.4266667' AS DateTime2), CAST(1096.0000 AS Decimal(18, 4)), 4, 263, CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_GetAllTableSizesAndRowCnt', N'SVR2016', N'TestXml', N'Step01', N'65dd60af-33a3-4595-be05-72b3749d1733', CAST(N'2019-03-01' AS Date), CAST(N'2019-03-01T14:33:42.4633333' AS DateTime2), NULL, NULL, 4, 263, NULL, NULL, NULL)
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_DbMon_IndexVolitity', N'dfin.database.windows.net,1433', N'AW_AZURE', N'Step01', N'2fb61d50-0c92-4c9a-b594-bb68aadd99c4', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:18:20.6800000' AS DateTime2), CAST(N'2019-02-28T15:18:22.7666667' AS DateTime2), CAST(2086.0000 AS Decimal(18, 4)), 183, 8, CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_DbMon_IndexVolitity', N'SVR2016', N'MstrPort', N'Step01', N'35d10f88-b4f1-4b93-b8e4-ea780ed4f56f', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:18:55.5500000' AS DateTime2), CAST(N'2019-02-28T15:18:59.8166667' AS DateTime2), CAST(4266.0000 AS Decimal(18, 4)), 183, 8, CAST(4.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_GetIndexStats', N'ALIEN15', N'WDM', N'Step01', N'a39dcdf2-86ea-434c-b51c-3e2cb8b52fe0', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:19:33.6633333' AS DateTime2), CAST(N'2019-02-28T15:19:35.5100000' AS DateTime2), CAST(1847.0000 AS Decimal(18, 4)), 187, 12, CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_GetIndexStats', N'ALIEN15', N'TestDB', N'Step01', N'a2c3d6da-7d23-4d44-861b-5dac24a1a375', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:19:47.2900000' AS DateTime2), CAST(N'2019-02-28T15:19:49.7500000' AS DateTime2), CAST(2460.0000 AS Decimal(18, 4)), 187, 12, CAST(2.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_MonitorDeadlocks', N'SVR2016', N'TestXml', N'Step01', N'62e22200-b991-4ee9-84a7-e763995c9bef', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:35:42.4866667' AS DateTime2), NULL, NULL, 188, 13, NULL, NULL, NULL)
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_DFS_BoundQry_ProcessAllTables', N'SVR2016', N'AW_VMWARE', N'Step01', N'b106fc14-5cd7-4374-a2b4-5bd1f4127865', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:39:50.2633333' AS DateTime2), CAST(N'2019-02-28T15:40:31.9733333' AS DateTime2), CAST(41710.0000 AS Decimal(18, 4)), 170, 2, CAST(41.0000 AS Decimal(18, 4)), CAST(1.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_UTIL_MonitorDeadlocks', N'SVR2016', N'TestXml', N'Step01', N'62e22200-b991-4ee9-84a7-e763995c9bef', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T15:35:17.1400000' AS DateTime2), NULL, NULL, 188, 13, NULL, NULL, NULL)
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_CaptureWorstPerfQuery', N'ALIEN15', N'PowerDatabase', N'Step01', N'c2840d90-d5e1-4a32-a07d-0d84949d7c25', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T16:07:37.1333333' AS DateTime2), CAST(N'2019-02-28T16:14:26.5800000' AS DateTime2), CAST(409447.0000 AS Decimal(18, 4)), 253, 1, CAST(409.0000 AS Decimal(18, 4)), CAST(7.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobExecutions] ([JobName], [SvrName], [DBName], [StepName], [JOBUID], [ExecutionDate], [StartExecutionDate], [EndExecutionDate], [elapsedMS], [JobRowNbr], [StepRowNbr], [elapsedSEC], [elapsedMIN], [elapsedHR]) VALUES (N'JOB_CaptureWorstPerfQuery', N'ALIEN15', N'PowerDatabase', N'Step01', N'c2840d90-d5e1-4a32-a07d-0d84949d7c25', CAST(N'2019-02-28' AS Date), CAST(N'2019-02-28T16:14:11.6433333' AS DateTime2), CAST(N'2019-02-28T16:14:26.5800000' AS DateTime2), CAST(14937.0000 AS Decimal(18, 4)), 253, 1, CAST(15.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)), CAST(0.0000 AS Decimal(18, 4)))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.780' AS DateTime), CAST(N'2019-03-02T08:14:37.753' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.793' AS DateTime), CAST(N'2019-03-02T08:31:03.023' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T20:07:04.587' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:33:00.527' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T08:12:21.913' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T08:12:50.853' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T08:18:07.917' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T08:18:59.460' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-08T14:47:08.550' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:47:43.810' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:48:02.907' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:48:23.713' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T14:48:47.203' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.797' AS DateTime), CAST(N'2019-03-02T08:24:27.133' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-02T08:24:52.283' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-02T08:40:35.587' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-08T14:50:01.523' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-08T14:50:39.207' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.800' AS DateTime), CAST(N'2019-03-02T08:21:22.160' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.810' AS DateTime), CAST(N'2019-03-02T08:24:26.450' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:24:50.910' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:15:01.343' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:34:33.520' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T20:07:03.480' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T14:33:17.080' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:12:31.763' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:13:05.483' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:18:21.133' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-02T08:19:21.133' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.813' AS DateTime), CAST(N'2019-03-08T14:47:22.380' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-02T14:47:45.270' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-02T14:48:01.770' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-02T14:48:22.347' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.817' AS DateTime), CAST(N'2019-03-02T14:48:40.270' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:24:45.823' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:25:07.967' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:41:05.840' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T14:50:22.080' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-08T14:50:42.447' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:24:16.060' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:24:39.930' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.843' AS DateTime), CAST(N'2019-03-02T08:25:05.427' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_CaptureWorstPerfQuery', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:14:10.027' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_BoundQry_ProcessAllTables', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:33:29.997' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_CleanDFSTables', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T03:11:35.053' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_GetAllTableSizesAndRowCnt', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-02T14:33:33.447' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_DFS_MonitorLocks', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:17:41.307' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:17:50.570' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_MonitorWorkload', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:14:55.707' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DbMon_IndexVolitity', N'N', CAST(N'2019-02-26T11:41:35.847' AS DateTime), CAST(N'2019-03-01T18:15:19.713' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBSpace', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-08T14:47:27.530' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DBTableSpace', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-02T14:47:43.433' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_DFS_DbSize', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-02T14:48:08.833' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_GetIndexStats', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-02T14:48:31.303' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorDeadlocks', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-02T14:48:55.500' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_MonitorMostCommonWaits', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-01T18:20:40.223' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ParallelMonitor', N'N', CAST(N'2019-02-26T11:41:35.867' AS DateTime), CAST(N'2019-03-01T18:21:06.730' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_QryPlanStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:36:36.210' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_ReorgFragmentedIndexes', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-08T14:50:27.770' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TempDbMonitor', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-08T14:50:56.823' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TrackSessionWaitStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:16:54.980' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UTIL_TxMonitorTableStats', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:17:16.863' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'UTIL_TxMonitorIDX', N'N', CAST(N'2019-02-26T11:41:35.870' AS DateTime), CAST(N'2019-03-01T18:17:31.070' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_TEST', N'N', CAST(N'2019-03-01T10:49:13.340' AS DateTime), CAST(N'2019-03-02T16:08:36.183' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'ALIEN15', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:18:49.357' AS DateTime), CAST(N'2019-03-01T13:18:49.357' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_TEST', N'N', CAST(N'2019-03-01T13:19:01.420' AS DateTime), CAST(N'2019-03-01T22:46:05.290' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'SVR2016', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:01.500' AS DateTime), CAST(N'2019-03-01T13:19:01.500' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_TEST', N'N', CAST(N'2019-03-01T13:19:21.940' AS DateTime), CAST(N'2019-03-02T16:08:49.227' AS DateTime))
GO
INSERT [dbo].[ActiveJobSchedule] ([SvrName], [JobName], [Disabled], [LastRunDate], [NextRunDate]) VALUES (N'dfin.database.windows.net,1433', N'JOB_UpdateQryPlans', N'N', CAST(N'2019-03-01T13:19:22.040' AS DateTime), CAST(N'2019-03-01T13:19:22.040' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ActiveJobStep] ON 
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'e', N'df0414cb-1661-47e5-b41f-0b5dc45de071', N'N', 290, N'JOB_TEST')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'66572618-0092-4aaa-81a4-7487717c77ba', N'N', 291, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step04', N'U', N'N', N'410b1946-bc26-4684-9fbf-561b6807f7c8', N'N', 292, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'5fd418b9-e3ef-4354-91d4-7c12e351b152', N'N', 293, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step01', N'U', N'N', N'3491e4f1-54fb-4a08-81a8-ee0f26b0f46b', N'N', 294, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step03', N'U', N'N', N'52f96d9f-5789-427c-ad76-0b7a4d23b8fc', N'N', 295, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'c9bed2a3-8b1e-489d-a255-166f267d8ba7', N'N', 296, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step08', N'U', N'N', N'cc071751-3837-4f9b-8bd5-c7afeb4c65e9', N'N', 297, N'JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step1', N'e', N'N', N'd675b723-b50e-49bd-9c39-eb0bf30c40c8', N'N', 298, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step03', N'U', N'N', N'10c45ce1-9cf0-4681-8717-dc829a52b213', N'N', 299, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'65836f8d-40dc-43fe-a28b-91cbcb088de4', N'N', 300, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step1', N'e', N'N', N'3f03fc66-c7ab-4cdb-85c8-85bd0c49f4c3', N'N', 301, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'e', N'2d242010-ddfb-47e1-b529-a8253ee9dfa7', N'N', 302, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step03', N'U', N'N', N'c990c1dd-54eb-4d39-8df4-3df7a8f84449', N'N', 303, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'772a144c-06ac-4963-a4ee-6aba80c370a2', N'N', 304, N'JOB_UTIL_TxMonitorTableStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'27cf028c-319e-4e88-8dfb-63ab705c10bf', N'N', 305, N'UTIL_TxMonitorIDX')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'7a48e3de-f83d-4b04-85ac-a68d31f8ea7e', N'Y', 1, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 2, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 3, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 4, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 5, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 6, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 7, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 8, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'df5f7776-520c-403f-b504-ae0ac65bcf65', N'Y', 9, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'ef0df41d-6f9e-465f-914a-1fc622ecb744', N'Y', 10, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'8a351ecf-882a-4128-82e8-14025ba5537e', N'Y', 11, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'8258bd1d-df74-410b-973f-91c52dbc53de', N'Y', 12, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'b559e79a-bc2d-4ddf-b81c-a75e076780a5', N'Y', 13, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a727351e-a627-4ab6-b138-6e888011fcce', N'Y', 14, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'2a5020d8-1005-4f2a-ac9a-3a95a9229f5c', N'Y', 15, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'89c8c938-489d-4b41-b84c-c367488b30b6', N'Y', 16, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'025498da-1fb3-4a5e-9fea-60b584060f66', N'Y', 17, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2d5c93d6-2763-4005-8c8e-4bd923910d0f', N'N', 18, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'1643fbbe-79d5-4d6f-abcf-9bae6338380b', N'Y', 19, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'9ea424d9-14b1-43d6-bd67-32755137f188', N'Y', 20, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'86e19be4-bf01-4353-b618-f5620a16ab55', N'Y', 21, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'adb0c1fa-5d1a-4a78-8eb3-b11e81e2e3fa', N'Y', 22, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'ebbad699-8d7a-4e92-b647-243ff23fbfd2', N'Y', 23, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'f61e55aa-f9a6-4bd9-a8b9-482ea014658a', N'Y', 24, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'ba42264d-083f-4974-9dbe-1c560ac16630', N'N', 25, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'ef3111bd-2322-4033-98f6-4674bbc03452', N'Y', 26, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'1c151ba9-98d7-4f06-b88e-8eb1fa72493f', N'Y', 27, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'dd4fa58c-38ed-4ace-b349-ab9b467d601c', N'Y', 28, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'72908a6f-3272-4850-ac54-8f0a9abe5018', N'Y', 29, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 30, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 31, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 32, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 33, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 34, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 35, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 36, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'b1229309-626e-4c42-9775-c0161859b46f', N'Y', 37, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8203bcf3-f0c4-45f7-ba35-3d376582f6bb', N'Y', 38, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'65d2aea7-32e8-4990-b508-968615adffef', N'Y', 39, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'0dae3845-9a38-4b51-8557-1697a61666ff', N'Y', 40, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'2307ec0c-aed0-421d-942c-89a732982188', N'Y', 41, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'dff23ef3-b73d-45ef-8c34-a3db3b398029', N'Y', 42, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'3abfc9cd-311c-41c2-8933-d98a1b9ded23', N'Y', 43, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'7059151e-344e-497d-b992-b1459f3e6618', N'Y', 44, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'815ae81a-f117-4c79-85c2-d9fa59d2f6e6', N'Y', 45, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'35b25e59-9bff-4434-a39c-84b23ee735f2', N'N', 46, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'c86e97ce-cb7f-4da0-938b-5773ab05c8b1', N'Y', 47, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'70b0d4c1-f08d-4178-9a8b-02a9bd81db5e', N'Y', 48, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'c88d2e5c-fc6d-4bc8-81c2-2ca721e4d1df', N'Y', 49, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'faba3768-5d1f-4841-b757-f5ec4382692c', N'Y', 50, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1b65499d-5337-40a9-8231-443394527bec', N'Y', 51, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'2d24005d-b3df-4942-ada7-0175006b6e17', N'Y', 52, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cd0f6c7c-8a11-4b4e-af3b-9cae576a519e', N'N', 53, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'a2da87ee-174c-474c-b590-0e53ce597af9', N'Y', 54, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'a891279a-6302-47cf-a6da-f80e6350179d', N'Y', 55, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'eaa19f60-93c6-4ec6-859c-0487354b4ff3', N'Y', 56, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'82f20db3-bd15-4b8b-8c34-35e915cde54f', N'Y', 57, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 58, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 59, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 60, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 61, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 62, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 63, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 64, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'f18c5f76-4f4b-42f4-988f-4199771b194d', N'Y', 65, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'6dce5caa-6639-49b2-b73c-a2dbf07777aa', N'Y', 66, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'5db80b4d-7db3-47a0-8887-bf05a1bd252c', N'Y', 67, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'ae459a69-c155-4beb-839c-796ba3718ec7', N'Y', 68, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'892d2808-902e-4283-a02b-b7eb54675a09', N'Y', 69, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'0fc41e38-03c9-4a30-9221-d6497f398cdb', N'Y', 70, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'a479c0c3-08a1-454a-8068-59841533f281', N'Y', 71, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'1d07071c-70b4-4d38-95f2-f2048a3886a7', N'Y', 72, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c7d138f5-487e-4ba5-9964-ea418cf7384b', N'Y', 73, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'946e919a-1a5a-42b1-90be-95df2f14b017', N'N', 74, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'890b31fa-207c-4ad5-b987-09400e625340', N'Y', 75, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'3b259d59-7f49-4dcf-b9be-f1b63ba7c236', N'Y', 76, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'4e4f4756-6074-4273-8da6-1079d06487e4', N'Y', 77, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'b22d702d-fffb-4d1a-9a83-479b81692c3e', N'Y', 78, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'c6bc37a4-5148-454d-a36c-6b8f2a347ef5', N'Y', 79, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'25864f68-7c27-40c0-9b11-677a07d3bc26', N'Y', 80, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'5a868f12-1ced-48ce-8e4e-dbfd39fa573b', N'N', 81, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'babacaef-44d8-410d-b523-567f35450776', N'Y', 82, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'78718fa4-7a86-4388-a81b-d9479c2e1885', N'Y', 83, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'263e288d-4eb9-43ad-bd6e-90d0703272f7', N'Y', 84, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'5ff535ea-5614-4ac4-9140-73c2f16afb5d', N'Y', 113, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 114, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 115, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 116, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 117, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 118, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 119, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 120, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'591937ec-d07f-4528-a0d3-1b11b6f43088', N'Y', 121, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'bd5af2ee-cc50-4253-9ef5-56af2131f7e6', N'Y', 122, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'ebc5339a-51e6-41ae-97be-7cac8971162f', N'Y', 123, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'd749b33f-bb2b-43c0-8a0d-cdefc7c4c20b', N'Y', 124, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'c9160b0a-ff34-4be4-ab91-e9779287c3ac', N'Y', 125, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'a3ad0aee-6a91-493d-bf67-22cb72de0ff4', N'Y', 126, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'b57e8106-df52-46df-b4ad-b3a57730b5a5', N'Y', 127, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'93765a74-9d65-44cd-869d-946f00cd7b81', N'Y', 128, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'6a42e0f4-78d9-4029-bdb8-7f0cf06ad7a8', N'Y', 129, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'c9fe8a15-244b-42d2-9100-8c7f38323bc9', N'N', 130, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'507ec161-0114-4f34-8e06-c2d214a91cbc', N'Y', 131, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'6c2d721d-498c-4d26-94a0-2609397a0ac9', N'Y', 132, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'0f24f6c2-e149-41cc-8414-d606f293ad1d', N'Y', 133, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'0623c052-1fbb-43df-9243-9d7f366ec26b', N'Y', 134, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'24227f73-e8cc-4540-ba48-2d8ca41e8123', N'Y', 135, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'6cf8d9dd-583b-4055-9369-8ea6834b6da9', N'Y', 136, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'4a6cfd66-ccff-4466-a584-5f6a61f29455', N'N', 137, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2368ac20-6bb7-4863-991a-f99af95ef90b', N'Y', 138, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'06a6bb48-dcaa-4e78-b859-024551450dea', N'Y', 139, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'e22f5cab-98af-4dca-837f-c8a5b1177a52', N'Y', 140, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ce610c62-6553-4893-9bd0-f150182a6df0', N'Y', 169, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 170, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ba44111b-83ce-4de8-915b-e88a7fe18299', N'Y', 197, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 198, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 199, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 200, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 201, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 202, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 203, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 204, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'eea70383-6f17-4a63-a650-2860f7d4dd8d', N'Y', 205, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'dbc36f52-4ac4-4d55-9896-2608dda7620a', N'Y', 206, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'cb678e7c-6965-4e51-a128-43bab79b8b0c', N'Y', 207, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'9911e4cb-b047-4b66-977c-db19b9e811c1', N'Y', 208, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'cb142312-c02d-44e5-a83e-51cebe90ab41', N'Y', 209, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f7d9a7eb-f7e8-456c-8098-827e2bd5a89b', N'Y', 210, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'014c0dd0-5432-4c35-9323-814a99e37213', N'Y', 211, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'fba69c87-a70b-4b48-90d6-eb3f5725a749', N'Y', 212, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'ed9a83d8-ba28-4c91-bd33-c2e375e98f0d', N'Y', 213, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'b051b960-57d7-47c3-aa93-44be53ae4938', N'N', 214, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'd654ec5f-1aa2-46ae-bc89-40b8dad0733f', N'Y', 215, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'7fdb32a9-4c19-4a40-a318-3bc4dc9fbd4d', N'Y', 216, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'e6121ff3-d94b-4512-8e2c-18de293eddc2', N'Y', 217, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'dfb9f3ef-0ffa-4f48-bfe3-5ea8943636d0', N'Y', 218, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'd62c9887-d32d-4f67-af3e-9198223d2b35', N'Y', 219, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4755e75e-ae38-42c4-a4ee-0fbc650f64c6', N'Y', 220, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'32633074-61ff-418b-b1b2-ca0e51a07c3e', N'N', 221, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'54cd4fd9-f2ca-477b-a959-ec3a77c1cc38', N'Y', 222, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'ec46336f-42b2-4ac7-aff9-02aa1bbef579', N'Y', 223, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'14ffdb3d-b299-4931-8f75-47d7771d5c43', N'Y', 224, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'faaf4f9b-1f12-49af-9fc1-3897f71d4cb2', N'Y', 225, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 226, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 227, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 228, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 229, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 230, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 231, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'ae96a724-fa83-450d-8a46-2ba973f1b9a1', N'Y', 85, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 86, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 87, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 88, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 89, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 90, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 91, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 92, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'a5aeb6cf-20ad-4f62-b4f0-378d4ed463ad', N'Y', 93, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'a29c0bbf-29ea-447e-b89b-a7047da0591c', N'Y', 94, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'971bb98b-9714-44af-9d0e-6ec421a3334e', N'Y', 95, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'16fdefc0-a207-45bd-8951-35e0d2167392', N'Y', 96, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'3e720149-1aed-491a-ad18-f142aa4a0e38', N'Y', 97, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'2788b130-9ade-4a4d-a34e-451a0200940e', N'Y', 98, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'87680695-f42b-4465-8a40-b470573bc656', N'Y', 99, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd6c31c69-866b-42ca-94ff-a8b827aaca60', N'Y', 100, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'7a483180-5604-49ca-ac47-e848c4eca4a0', N'Y', 101, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'f783a590-426c-43b6-8097-212a56eeb0b2', N'N', 102, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'e7ff3122-05b1-437b-8778-1e6ec0790edb', N'Y', 103, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'294b86f0-973d-4222-adac-4770689360b6', N'Y', 104, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'65e9fbf2-9985-404a-8caf-2385d6fba2c5', N'Y', 105, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'82b87597-1998-43b9-82bd-8ccabb40a6b2', N'Y', 106, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'7c5a20b0-7981-4446-8c58-6766fcf97c17', N'Y', 107, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'89efb6e5-e151-49a1-b867-067ed953935f', N'Y', 108, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a1006e4a-c07d-46fe-87ad-7e168003310f', N'N', 109, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'4384dc46-f064-43bc-8e08-e064aca3b0a8', N'Y', 110, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'702266b2-6ce4-4a59-a9fb-dd4ceeff7cd0', N'Y', 111, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'a75f5977-3cda-4199-aa78-53827074c708', N'Y', 112, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'f5b972b9-c7cb-44d3-ab84-2d40becc1d4d', N'Y', 141, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 142, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 143, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 144, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 145, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 146, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 147, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 148, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'652b316f-da35-468e-b7f6-02bda1c17b5c', N'Y', 149, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'5a2f479c-091b-4969-8520-f69fe5b54066', N'Y', 150, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'91a3cefa-73e8-493d-bcde-e25fd3acb10b', N'Y', 151, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'fd5a3191-d65e-408b-8398-c8841d19b8ff', N'Y', 152, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'f4801c2b-d4f5-4ef7-8a78-95b8e66edac7', N'Y', 153, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'044ea6d5-0e72-431c-9ebf-0bd81fd66411', N'Y', 154, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'164e8c2a-67d5-426e-b90c-5bd437b84b11', N'Y', 155, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'ac77f0a8-2094-4317-88b1-68e2b547b87f', N'Y', 156, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'0f74969c-a766-44fa-93e3-f31ce7ef6ec6', N'Y', 157, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'6d918491-5046-426b-b490-d6b31d517085', N'N', 158, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'1ae80569-dcfd-4fd5-9239-650b3ac6fc56', N'Y', 159, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40273c83-9116-45a4-a424-b70ba19c70b8', N'Y', 160, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'2bc61139-4e95-4ea4-8016-98e559cbe853', N'Y', 161, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'c679a84b-cf30-47b9-bf58-82588f675f2a', N'Y', 162, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'9c39cf2d-d1b0-4366-9a71-a9f03a92f053', N'Y', 163, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'7bbcc3aa-7c0b-47b5-bfa7-c19cb09af5a3', N'Y', 164, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'a5a1314b-8d8e-4027-a834-eb4d7355650d', N'N', 165, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'2526cb5d-9785-45ed-812c-39683721c986', N'Y', 166, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'11794906-8865-4514-a661-57c6b47c0222', N'Y', 167, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'88473c7b-e79a-4e9b-a67d-cb1076c6879a', N'Y', 168, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 232, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'8843fec6-9f47-4a77-a8d4-a467b7be41de', N'Y', 234, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'23435859-1bd5-4e1f-aaa4-6cf93f539eae', N'Y', 235, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'4289831c-2656-4ba7-9212-b9cae9a32a44', N'Y', 236, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'03b5ff8d-8622-4fbb-b530-c79ab8f3e85f', N'Y', 237, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'f5da6dc4-cce7-4159-8486-d49e6e73a5b9', N'Y', 238, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'f3460d20-d1dd-49c6-a08c-5f72bf74b9c4', N'Y', 239, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'6a775a0a-a1db-4820-af5b-88f15cf18cd0', N'Y', 240, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'c77ae818-7d3c-4f97-a293-fa221dc812a3', N'Y', 241, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'1a488e87-2467-4433-b765-12e8cff6e933', N'N', 242, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'c1423989-77f6-4fc7-8c4d-1800de75525b', N'Y', 243, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'40606dc2-dac7-4256-86cf-5463e7e67a73', N'Y', 244, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'640eaa80-de60-41c4-8bcb-27ba1e5c7166', N'Y', 245, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'e4366e59-c986-4a13-b680-867f154e4279', N'Y', 246, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'1d2b3ef1-408d-4aa7-8b2a-46eb08fb194f', N'Y', 247, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'87f9f163-74e6-4f0b-a284-75355163fd11', N'Y', 248, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'cab12745-105f-45b7-9e5c-2f8167974fdc', N'N', 249, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'59cd0791-aaf8-48f8-88d6-7096fd3e386b', N'Y', 250, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'6a38d7f7-dacd-4500-a7a4-12ea687ad3a7', N'Y', 251, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'91b25b60-a4b7-4f4d-b4be-d18d6494393a', N'Y', 252, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step1', N'exec sp_who2', N'N', N'N', N'df0414cb-1661-47e5-b41f-0b5dc45de071', N'Y', 282, N'JOB_TEST')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 171, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 172, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 173, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 174, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 175, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 176, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'7fcbceb8-cfd4-4873-9677-1f5d5ed817bb', N'Y', 177, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'e15ceb1f-75d9-4455-950c-51d78e39dd06', N'Y', 178, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'9fce1f76-01b8-4851-be82-4aa0ecd5441b', N'Y', 179, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'cc440148-dfa7-4169-a8da-0975f9049f11', N'Y', 180, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'96aa26f5-3c21-415c-a64e-c786c31c0407', N'Y', 181, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'6cb3d54e-69ae-4d70-8b85-efad3c1051d0', N'Y', 182, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'062aea06-153b-49b4-9bc1-41d84026817a', N'Y', 183, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'd77f16ad-bf60-4122-a5ac-e941f62d926b', N'Y', 184, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'98f1e17b-c18e-4dc9-b965-6db42f34d060', N'Y', 185, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'2b44188f-cd38-451f-89be-aad487565d7a', N'N', 186, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'2250a5ee-c931-4017-b27e-9248f3dc33dd', N'Y', 187, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'c9cfb88e-84e3-45fe-9159-3fc01a48da43', N'Y', 188, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'22a33f12-a84f-4eba-bc30-56de7fa193fe', N'Y', 189, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'980e03e5-977b-44f0-8473-cfffb91357b0', N'Y', 190, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'36f38e66-00f4-4a0a-b201-1bbedb24f3e0', N'Y', 191, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'4412fd00-eba3-496f-b3dc-36e72aae3c5d', N'Y', 192, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'c2767c3a-bed7-4c74-b3f3-0e5d88e38cbc', N'N', 193, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'8b47b8e5-4b4f-43c2-94d0-3e9c1b01eb2c', N'Y', 194, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'4b4f24ca-8b13-4ccc-9871-e298283cac86', N'Y', 195, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'6426b370-c08d-486e-b62e-c3e0d8e865c1', N'Y', 196, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'ebf76842-87f8-488e-ae13-c4cacd3a6f39', N'Y', 233, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'448f0260-3a56-4a6f-a1ea-ac4c9c605263', N'N', 283, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step05', N'D', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'N', 284, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'217899bc-4071-4b75-a8c7-5f0284af3357', N'N', 285, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Y', N'S', N'U', N'942b8bdf-f031-4ab6-809b-329bfcacf195', N'N', 286, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step1', N'e', N'N', N'92eb136a-dcff-4249-bf35-ad5cd118d215', N'N', 287, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step03', N'U', N'N', N'a60d4078-74dd-48fd-a245-26002f55061a', N'N', 288, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Y', N'Step04', N'U', N'N', N'e49fd974-48b9-4d2d-9d77-449b89bacda3', N'N', 289, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_MSTR_BoundQry2000', N'N', N'N', N'448f0260-3a56-4a6f-a1ea-ac4c9c605263', N'Y', 253, N'JOB_CaptureWorstPerfQuery')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 254, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step02', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry2000''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 255, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step03', N'UTIL_UpdateQryPlansAndText ''DFS_IO_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 256, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step04', N'UTIL_UpdateQryPlansAndText ''DFS_CPU_BoundQry''', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 257, N'JOB_UpdateQryPlans')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step05', N'DFS_CPU_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 258, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step06', N'DFS_IO_BoundQry2000_ProcessTable', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 259, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step07', N'UTIL_DFS_CPU_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 260, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step08', N'UTIL_IO_BoundQry', N'N', N'N', N'49c03dd8-f0da-43e2-8ba6-b48e11ed6453', N'Y', 261, N'JOB_DFS_BoundQry_ProcessAllTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_CleanDFSTables', N'N', N'N', N'217899bc-4071-4b75-a8c7-5f0284af3357', N'Y', 262, N'JOB_DFS_CleanDFSTables')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'DFS_GetAllTableSizesAndRowCnt', N'N', N'N', N'942b8bdf-f031-4ab6-809b-329bfcacf195', N'Y', 263, N'JOB_DFS_GetAllTableSizesAndRowCnt')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_DFS_MonitorLocks', N'N', N'N', N'92eb136a-dcff-4249-bf35-ad5cd118d215', N'Y', 264, N'JOB_DFS_MonitorLocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats', N'N', N'Y', N'a60d4078-74dd-48fd-a245-26002f55061a', N'Y', 265, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorWorkload', N'N', N'N', N'e49fd974-48b9-4d2d-9d77-449b89bacda3', N'Y', 266, N'JOB_MonitorWorkload')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableIndexStats', N'N', N'Y', N'410b1946-bc26-4684-9fbf-561b6807f7c8', N'Y', 267, N'JOB_UTIL_DbMon_IndexVolitity')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBSpace', N'N', N'N', N'5fd418b9-e3ef-4354-91d4-7c12e351b152', N'Y', 268, N'JOB_UTIL_DBSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DBTableSpace', N'N', N'N', N'3491e4f1-54fb-4a08-81a8-ee0f26b0f46b', N'Y', 269, N'JOB_UTIL_DBTableSpace')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_DFS_DbFileSizing', N'N', N'N', N'52f96d9f-5789-427c-ad76-0b7a4d23b8fc', N'N', 270, N'JOB_UTIL_DFS_DbSize')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_GetIndexStats', N'N', N'Y', N'c9bed2a3-8b1e-489d-a255-166f267d8ba7', N'Y', 271, N'JOB_UTIL_GetIndexStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_DeadlockStats ', N'N', N'Y', N'cc071751-3837-4f9b-8bd5-c7afeb4c65e9', N'Y', 272, N'JOB_JOB_UTIL_MonitorDeadlocks')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_MonitorMostCommonWaits', N'N', N'N', N'd675b723-b50e-49bd-9c39-eb0bf30c40c8', N'Y', 273, N'JOB_UTIL_MonitorMostCommonWaits')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_ParallelMonitor', N'N', N'Y', N'10c45ce1-9cf0-4681-8717-dc829a52b213', N'Y', 274, N'JOB_UTIL_ParallelMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_QryPlanStats', N'N', N'N', N'65836f8d-40dc-43fe-a28b-91cbcb088de4', N'Y', 275, N'JOB_UTIL_QryPlanStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_ReorgFragmentedIndexes', N'N', N'N', N'3f03fc66-c7ab-4cdb-85c8-85bd0c49f4c3', N'Y', 276, N'JOB_UTIL_ReorgFragmentedIndexes')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'UTIL_TempDbMonitor', N'N', N'Y', N'2d242010-ddfb-47e1-b529-a8253ee9dfa7', N'N', 277, N'JOB_UTIL_TempDbMonitor')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_DFS_WaitStats @RunID 30', N'N', N'N', N'c990c1dd-54eb-4d39-8df4-3df7a8f84449', N'Y', 278, N'JOB_UTIL_TrackSessionWaitStats')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorTableStats', N'N', N'Y', N'772a144c-06ac-4963-a4ee-6aba80c370a2', N'Y', 279, N'JOB_UTIL_Monitor_TPS')
GO
INSERT [dbo].[ActiveJobStep] ([StepName], [StepSQL], [disabled], [RunIdReq], [JOBUID], [AzureOK], [RowNbr], [JobName]) VALUES (N'Step01', N'sp_UTIL_TxMonitorIDX', N'N', N'Y', N'27cf028c-319e-4e88-8dfb-63ab705c10bf', N'Y', 280, N'JOB_UTIL_Monitor_TPS')
GO
SET IDENTITY_INSERT [dbo].[ActiveJobStep] OFF
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'Y', N'dfin.database.windows.net,1433', N'TestAzureDB', N'wmiller', N'Junebug1', N'9681af5e-14b8-4136-8fd6-b2db74ebe567', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'Y', N'dfin.database.windows.net,1433', N'AW_AZURE', N'wmiller', N'Junebug1', N'45d9391f-c752-423c-966c-36dec7d708ae', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'SVR2016', N'MstrData', N'sa', N'Junebug1', N'0bfe261d-7567-46aa-b52b-f750dceac5a4', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'SVR2016', N'TestXml', N'sa', N'Junebug1', N'65dd60af-33a3-4595-be05-72b3749d1733', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'ALIEN15', N'PowerDatabase', N'sa', N'Junebug1', N'c2840d90-d5e1-4a32-a07d-0d84949d7c25', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'ALIEN15', N'WDM', N'sa', N'Junebug1', N'6282b34d-4f9c-4ee3-8e0b-814ab31e6777', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'ALIEN15', N'TestDB', N'sa', N'Junebug1', N'9bf1dc60-edf4-46f6-84a4-ec24abfef02f', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'SVR2016', N'AW_VMWARE', N'sa', N'Junebug1', N'70a5919e-6b2b-449e-ae2e-a7138751c743', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'SVR2016', N'DFS', N'sa', N'Junebug1', N'ce2ee4bc-5cd6-4547-b892-eee66eb51993', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'N', N'SVR2016', N'MstrPort', N'sa', N'Junebug1', N'eabece66-fd14-446f-8fd6-c916db611f80', 1)
GO
INSERT [dbo].[ActiveServers] ([GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [UID], [Enable]) VALUES (N'dfintest', N'Y', N'dfin.database.windows.net,1433', N'TestAzureDB', N'wmiller', N'Junebug1', N'4868606a-95b5-4925-906a-7431e9393f3b', 1)
GO
