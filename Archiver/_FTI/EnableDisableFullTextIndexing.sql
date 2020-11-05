EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[DataSource]', @action=N'deactivate'
GO

EXEC dbo.sp_fulltext_table @tabname=N'[dbo].[DataSource]', @action=N'activate'
GO
