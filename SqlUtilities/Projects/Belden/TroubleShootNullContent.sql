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
			   ('N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N'
			   ,'N')
GO

Create PROCEDURE dbo.spStaticStateSetComplete (@tVar as char(2))
as
	if @tVar = 'P1' update [dbo].[StaticMigrationState] set Pos1 = 'Y'
	if @tVar = 'P2' update [dbo].[StaticMigrationState] set Pos2 = 'Y'
	if @tVar = 'P3' update [dbo].[StaticMigrationState] set Pos3 = 'Y'
	if @tVar = 'P4' update [dbo].[StaticMigrationState] set Pos4 = 'Y'
	if @tVar = 'P5' update [dbo].[StaticMigrationState] set Pos5 = 'Y'
	if @tVar = 'B1' update [dbo].[StaticMigrationState] set Bi1 = 'Y'
	if @tVar = 'B2' update [dbo].[StaticMigrationState] set Bi1 = 'Y'
	if @tVar = 'B3' update [dbo].[StaticMigrationState] set Bi1 = 'Y'

GO



