/* TESTS
select top 100 * from [view_EDW_RewardUserDetail]
select count(*) from [view_EDW_RewardUserDetail]
*/


--EXEC RefreshAllEDWViews;
--go

--SELECT
--	   'EXEC sp_refreshview ' + name + ' ; '
--  FROM sys.views
--  WHERE name LIKE '%EDW%';

if exists (select name from sys.procedures where name = 'RefreshAllEDWViews')
BEGIN
DROP PROCEDURE
	 dbo.RefreshAllEDWViews;
END
GO

CREATE PROCEDURE dbo.RefreshAllEDWViews
AS
	 BEGIN
		 DECLARE @ViewName nvarchar (max) ;
		 DECLARE @SQL nvarchar (max) ;
		 DECLARE extensionViews CURSOR
			 FOR SELECT
						name AS ViewName
				   FROM sys.views
				   WHERE name LIKE '%EDW%';
		 OPEN extensionViews;
		 FETCH NEXT FROM extensionViews INTO @ViewName;
		 WHILE @@FETCH_STATUS = 0
			 BEGIN
				 BEGIN TRY
					 PRINT 'REBUILD ' + @ViewName;
					 SET @SQL = 'IF EXISTS (SELECT * FROM sysobjects WHERE type = ''V'' AND name = ''' + @ViewName + ''')
					BEGIN
					exec sp_refreshview N''dbo.' + @ViewName + '''END';
					 EXEC (@SQL) ;
				 END TRY
				 BEGIN CATCH
					 PRINT 'XXX   FAILED REBUILD ' + @ViewName;
				 END CATCH;

				 -- This is executed as long as the previous fetch succeeds.

				 FETCH NEXT FROM extensionViews INTO @ViewName;
			 END;
		 CLOSE extensionViews;
		 DEALLOCATE extensionViews;
	 END;
GO