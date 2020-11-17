
go
/*
D:\dev\SQL\DFINAnalytics\createActiveServerJobsInsertProcs.sql

ALSO REFER TO:
D:\dev\SQL\DFINAnalytics\_PopulateInitialActiveServersAndJobs.sql

*/
IF not EXISTS
(
	SELECT column_name 
	FROM INFORMATION_SCHEMA.columns 
	WHERE table_name = 'ActiveJobStep'
	and column_name = 'JobName'
)
BEGIN
	alter table ActiveJobStep add JobName nvarchar (150) null;
END;

go

if not exists (select 1 from sys.indexes where name = 'pkActiveJobStep')
	CREATE UNIQUE NONCLUSTERED INDEX [pkActiveJobStep] ON [dbo].[ActiveJobStep]
	(
		[JOBUID] ASC,
		[StepName] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

go
IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_ActiveJobStep'
)
BEGIN
	DROP PROCEDURE UTIL_ActiveJobStep;
END;
GO

CREATE PROCEDURE UTIL_ActiveJobStep
( 
				 @JobName nvarchar(150),@StepName nvarchar(150),  @StepSQL nvarchar(max), @disabled char(1), @RunIdReq char(1), @AzureOK char(1)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].ActiveJobStep
			WHERE JobName = @JobName and StepName = @StepName
	);
	declare @JOBUID as uniqueidentifier = null ;
	IF(@icnt = 0)
	BEGIN
		set @JOBUID = (select [UID] from ActiveJob where JobName = @JobName) ;
		INSERT INTO [dbo].ActiveJobStep( JobName , StepName,  StepSQL, [disabled] , RunIdReq , AzureOK, JOBUID )
		VALUES( @JobName ,@StepName ,  @StepSQL , @disabled , @RunIdReq , @AzureOK ,@JOBUID);
	END
	ELSE
	BEGIN
		set @JOBUID = (select [UID] from ActiveJob where JobName = @JobName) ;
		UPDATE [dbo].ActiveJobStep
		  SET StepSQL = @StepSQL , 
			[disabled] = @disabled, 
			RunIdReq = @RunIdReq ,
			AzureOK = @AzureOK ,
			JOBUID = @JOBUID
		WHERE JobName = @JobName and StepName = @StepName
	END;
END;


GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveJobSchedule'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveJobSchedule;
END;
GO

CREATE PROCEDURE UTIL_InsertActiveJobSchedule
( 
				 @SvrName nvarchar(150), @JobName nvarchar(150), @Disabled char(1)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].ActiveJobSchedule
		WHERE SvrName = @SvrName AND 
			  JobName = @JobName
	);

	begin try
	IF(@icnt = 0)
	BEGIN
		INSERT INTO [dbo].ActiveJobSchedule( SvrName, [JobName], [Disabled],  [LastRunDate], [NextRunDate])
		VALUES( @SvrName, @JobName, @disabled, getdate(), getdate());
	END
	ELSE
	BEGIN
		UPDATE [dbo].ActiveJobSchedule
		  SET [disabled] = @disabled
		WHERE SvrName = @SvrName AND 
			  JobName = @JobName
	END;
	end try
	begin catch 
		print 'ERROR: check data: "' + @SvrName + '" "' + @JobName + '" "' +@Disabled + '"' ;
	end catch 
END;


GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveJob'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveJob;
END;
GO

CREATE PROCEDURE UTIL_InsertActiveJob
( 
				 @JobName nvarchar(150), @disabled nvarchar(150), @ScheduleUnit nvarchar(150), @ScheduleVal nvarchar(150), @Enable nvarchar(150)
)
AS
BEGIN
	DECLARE @icnt AS int= 0;
	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].[ActiveJob]
		WHERE JobName = @JobName
	);

	IF(@icnt = 0)
	BEGIN
		INSERT INTO [dbo].[ActiveJob]( [JobName], [disabled], [ScheduleUnit], [ScheduleVal], [LastRunDate], [NextRunDate], [Enable] )
		VALUES( @JobName, @disabled, @ScheduleUnit, @ScheduleVal, GETDATE(), GETDATE(), @Enable );
	END
	ELSE
	BEGIN
		UPDATE [dbo].[ActiveJob]
		  SET [disabled] = @disabled, [ScheduleUnit] = @ScheduleUnit, [ScheduleVal] = @ScheduleVal, [Enable] = @Enable
		WHERE JobName = @JobName;
	END;
END;



GO

IF EXISTS
(
	SELECT name
	FROM sys.procedures
	WHERE name = 'UTIL_InsertActiveServers'
)
BEGIN
	DROP PROCEDURE UTIL_InsertActiveServers;
END;
GO

/*
exec UTIL_InsertActiveServers 'dfintest', 'N', 'ALIEN15', 'DINAnalytics', 'sa', 'Junebug1', 1 ;
*/

CREATE PROCEDURE UTIL_InsertActiveServers
( 
				 @GroupName nvarchar(50), @isAzure char(1), @SvrName nvarchar(150), @DBName nvarchar(150), @UserID nvarchar(50), @pwd nvarchar(50), @Enable bit
)
AS
BEGIN

	DECLARE @icnt AS int= 0;

	SET @icnt =
	(
		SELECT COUNT(*)
		FROM [dbo].[ActiveServers]
		WHERE GroupName = @GroupName AND 
			  SvrName = @SvrName AND 
			  DBName = @DBName
	);
	IF(@icnt = 1)
	BEGIN
		INSERT INTO [dbo].[ActiveServers]( [GroupName], [isAzure], [SvrName], [DBName], [UserID], [pwd], [Enable] )
		VALUES( @GroupName, @isAzure, @SvrName, @DBName, @UserID, @pwd, @Enable );
	END
	ELSE
	BEGIN
		UPDATE [dbo].[ActiveServers]
		  SET isAzure = @isAzure, UserID = @UserID, pwd = @pwd, Enable = @Enable
		WHERE GroupName = @GroupName AND 
			  SvrName = @SvrName AND 
			  DBName = @DBName;
	END;

END;
GO