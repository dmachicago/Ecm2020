
-- select * from [ActiveServers]
-- delete from [ActiveServers]

declare @AddActiveServers as int = 1 ;

if (@AddActiveServers = 1 and db_name() = 'DFINAnalytics')
begin
		delete from [dbo].[ActiveServers] where DBNAME in ('TestAzureDB'
			,'AW_AZURE'
			,'AW2016'
			,'DFINAnalytics'
			,'DFS','MstrData','MstrPort','MstrLog' ,'TestXml','AW_VMWARE','PowerDatabase','TestDB', 'WDM');

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','Y','dfin.database.windows.net,1433','TestAzureDB','wmiller','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','Y','dfin.database.windows.net,1433','AW_AZURE','wmiller','Junebug1', newid())

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','AW2016','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','WDM','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','TestDB','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','ALIEN15','PowerDatabase','sa','Junebug1', newid())

		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','DFINAnalytics','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','DFS','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrData','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrPort','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','MstrLog','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','TestXml','sa','Junebug1', newid())
		INSERT INTO [dbo].[ActiveServers]([GroupName], [isAzure],[SvrName],[DBName],[UserID],[pwd], [UID]) VALUES
		('TESTGROUP','N','SVR2016','AW_VMWARE','sa','Junebug1', newid())
		
end 

update [ActiveJobStep] set ExecutionOrder = '1' where StepName = 'Step01';
update [ActiveJobStep] set ExecutionOrder = '2' where StepName = 'Step02';
update [ActiveJobStep] set ExecutionOrder = '3' where StepName = 'Step03';
update [ActiveJobStep] set ExecutionOrder = '4' where StepName = 'Step04';
update [ActiveJobStep] set ExecutionOrder = '5' where StepName = 'Step05';
update [ActiveJobStep] set ExecutionOrder = '6' where StepName = 'Step06';
update [ActiveJobStep] set ExecutionOrder = '7' where StepName = 'Step07';
update [ActiveJobStep] set ExecutionOrder = '8' where StepName = 'Step08';
update [ActiveJobStep] set ExecutionOrder = '8' where StepName = 'Step08';
