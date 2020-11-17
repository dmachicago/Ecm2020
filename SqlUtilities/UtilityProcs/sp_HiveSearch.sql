USE [ECM.Library]
GO
/****** Object:  StoredProcedure [dbo].[sp_HiveSearch]    Script Date: 02/18/2010 19:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_HiveSearch]
(
    @WhereClause varchar(4000),
	@StartRange int,
	@EndRange int)
AS
BEGIN
   SELECT [SourceName]     
      ,[CreateDate] 
      ,[VersionNbr]     
      ,[LastAccessDate] 
      ,[FileLength] 
      ,[LastWriteTime] 
      ,[SourceTypeCode]             
      ,[isPublic] 
      ,[FQN] 
      ,[SourceGuid] 
      ,[DataSourceOwnerUserID], FileDirectory 
FROM ( SELECT [SourceName]    
      ,[CreateDate] 
      ,[VersionNbr]     
      ,[LastAccessDate] 
      ,[FileLength] 
      ,[LastWriteTime] 
      ,[SourceTypeCode]             
      ,[isPublic] 
      ,[FQN] 
      ,[SourceGuid] 
      ,[DataSourceOwnerUserID], FileDirectory 
      ,ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID
	FROM [DataSource] )
	AS xDataSource
	WHERE  ROWID >= 100 AND ROWID <= 200
	order by SourceName


    RETURN(0)
END