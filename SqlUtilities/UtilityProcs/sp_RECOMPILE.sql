--exec spEXECsp_RECOMPILE
alter PROCEDURE dbo.spEXECsp_RECOMPILE AS 
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spEXECsp_RECOMPILE 
-- Project: SQL Server 2005/2008Database Maintenance
-- Purpose: Execute sp_recompile for all tables in a database
-- Detailed Description: Execute sp_recompile for all tables in a database
-- Database: Admin
-- Dependent Objects: None
-- Called By: TBD
-- Upstream Systems: None
-- Downstream Systems: None
-- W. Dale Miller
*/ 

SET NOCOUNT ON 

-- 1a - Declaration statements for all variables
DECLARE @TableName varchar(128)
DECLARE @OwnerName varchar(128)
DECLARE @CMD1 varchar(8000)
DECLARE @TableListLoop int
DECLARE @TableListTable table
(UIDTableList int IDENTITY (1,1),
OwnerName varchar(128),
TableName varchar(128))

-- 2a - Outer loop for populating the database names
INSERT INTO @TableListTable(OwnerName, TableName)
SELECT u.[Name], o.[Name]
FROM dbo.sysobjects o
	INNER JOIN dbo.sysusers u
	ON o.uid = u.uid
	WHERE o.Type = 'U'
	ORDER BY o.[Name]

-- 2b - Determine the highest UIDDatabaseList to loop through the records
SELECT @TableListLoop = MAX(UIDTableList) FROM @TableListTable

-- 2c - While condition for looping through the database records
WHILE @TableListLoop > 0
BEGIN

	-- 2d - Set the @DatabaseName parameter
	SELECT @TableName = TableName,
	@OwnerName = OwnerName
	FROM @TableListTable
	WHERE UIDTableList = @TableListLoop

	-- 3f - String together the final backup command
	SELECT @CMD1 = 'EXEC sp_recompile ' + '[' + @OwnerName + '.' + @TableName + ']' + char(13)

	-- 3g - Execute the final string to complete the backups
	-- SELECT @CMD1
	EXEC (@CMD1)

	-- 2h - Descend through the database list
	SELECT @TableListLoop = @TableListLoop - 1

END

SET NOCOUNT OFF

GO
