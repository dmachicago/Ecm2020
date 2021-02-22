USE [ECM.Library.FS]
GO

SELECT top 10 [RowID]
  FROM [dbo].[DataSource]
GO

if exists (select 1 from sys.procedures where name = 'spGetRowIdCSV')
BEGIN
	drop procedure spGetRowIdCSV;
END
GO
create procedure spGetRowIdCSV (@WhereClause nvarchar(1000))
as
BEGIN
	DECLARE @listStr VARCHAR(MAX)
	SELECT top 10 @listStr = COALESCE(@listStr+',' ,'') + cast([RowID] as nvarchar)
	FROM [DataSource]
	where contains (*,'dale')
	--SELECT @listStr

	select ROW_NUMBER() OVER(ORDER BY SourceName ASC) AS Row#, RowGuid, RowID
	FROM [DataSource]
	where RowID in (@listStr);

END


