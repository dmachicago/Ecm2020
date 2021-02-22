
	
	
with cte_Content as (	
 SELECT 	[SourceName] 	
	,[CreateDate] 
	,[VersionNbr] 	
	,[LastAccessDate] 
	,[FileLength] 
	,[LastWriteTime] 
	,[OriginalFileType] 		
	,[isPublic] 
	,[FQN] 
	,[SourceGuid] 
	,[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName, Description, RssLinkFlg, isWebPage, RetentionExpirationDate 
	, ROW_NUMBER() OVER(ORDER BY [SourceName] ASC) AS Row#
FROM DataSource 
 WHERE CONTAINS(DataSource.*, 'dale')     /*XX04*/ 
AND (DataSourceOwnerUserID IS NOT NULL)		 /*KEEP*/
-- order by [SourceName]  
)
Select * from cte_Content
where Row# between 5 and 10