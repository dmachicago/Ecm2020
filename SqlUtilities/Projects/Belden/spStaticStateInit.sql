--exec spStaticStateInit
--select * from dbo.StaticMigrationState
ALTER PROCEDURE dbo.spStaticStateInit
as
	TRUNCATE TABLE [SMART].[dbo].[StaticMigrationState] ;

	INSERT INTO [SMART].[dbo].[StaticMigrationState]
			   ([Pos1]
			   ,[Pos2]
			   ,[Pos3]
			   ,[Pos4]
			   ,[Pos5]
			   ,[Bi1]
			   ,[Bi2]
			   ,[Bi3]
			   ,[Restart]
			   ,[FullLoadComplete])
		 VALUES
			   (0
			   ,0
			   ,0
			   ,0
			   ,0
			   ,0
			   ,0
			   ,0
			   ,0
			   ,0)
GO


--exec dbo.spStaticStateSetComplete @tVar = 'P4'
--exec dbo.spStaticStateSetComplete @tVar = 'P5'
--exec dbo.spStaticStateSetComplete @tVar = 'P1'
--exec dbo.spStaticStateSetComplete @tVar = 'P3'
--exec dbo.spStaticStateSetComplete @tVar = 'P2'
--exec dbo.spStaticStateSetComplete @tVar = 'B1'
--exec dbo.spStaticStateSetComplete @tVar = 'B2'
--exec dbo.spStaticStateSetComplete @tVar = 'B3'

Alter PROCEDURE dbo.spStaticStateSetComplete @tVar as varchar(2)
as
	print @tVar
	if @tVar = 'P1' Begin
		update [dbo].[StaticMigrationState] set Pos1 = 1
	end
	if @tVar = 'P2' update [dbo].[StaticMigrationState] set Pos2 = 1
	if @tVar = 'P3' update [dbo].[StaticMigrationState] set Pos3 = 1
	if @tVar = 'P4' update [dbo].[StaticMigrationState] set Pos4 = 1
	if @tVar = 'P5' update [dbo].[StaticMigrationState] set Pos5 = 1
	if @tVar = 'B1' update [dbo].[StaticMigrationState] set Bi1 = 1
	if @tVar = 'B2' update [dbo].[StaticMigrationState] set Bi1 = 1
	if @tVar = 'B3' update [dbo].[StaticMigrationState] set Bi1 = 1

GO

Alter  PROCEDURE dbo.spStaticStateSetIncomplete (@tVar as char(2))
as
	if @tVar = 'P1' update [dbo].[StaticMigrationState] set Pos1 = 0
	if @tVar = 'P2' update [dbo].[StaticMigrationState] set Pos2 = 0
	if @tVar = 'P3' update [dbo].[StaticMigrationState] set Pos3 = 0
	if @tVar = 'P4' update [dbo].[StaticMigrationState] set Pos4 = 0
	if @tVar = 'P5' update [dbo].[StaticMigrationState] set Pos5 = 0
	if @tVar = 'B1' update [dbo].[StaticMigrationState] set Bi1 = 0
	if @tVar = 'B2' update [dbo].[StaticMigrationState] set Bi1 = 0
	if @tVar = 'B3' update [dbo].[StaticMigrationState] set Bi1 = 0

GO

alter PROCEDURE dbo.spStaticStateSetRestartTrue
as
	update [dbo].[StaticMigrationState] set Restart = 1
GO

alter PROCEDURE dbo.spStaticStateSetRestartFalse
as
	update [dbo].[StaticMigrationState] set Restart = 0
GO


alter PROCEDURE dbo.spStaticStateSetFullLoadCompleteTrue
as
	update [dbo].[StaticMigrationState] set FullLoadComplete = 1
GO

alter PROCEDURE dbo.spStaticStateSetFullLoadCompleteFalse
as
	update [dbo].[StaticMigrationState] set FullLoadComplete = 0
GO


