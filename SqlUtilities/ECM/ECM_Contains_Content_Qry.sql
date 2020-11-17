SELECT  
[SourceName]
,[CreateDate]
,[VersionNbr]
,[LastAccessDate]
,[FileLength]
,[LastWriteTime]
,[SourceTypeCode]
,[isPublic]
,[FQN]
,[SourceGuid]
,[DataSourceOwnerUserID], FileDirectory, StructuredData, RepoSvrName
FROM DataSource
WHERE
CONTAINS(*, '@Contains') 
--and not CONTAINS(*, '@NotContains')

-- and CreateDate >= @CreateDateStartDate
-- and CreateDate <= @CreateDateStartDate
-- and CreateDate >= @CreateDateStartDate and  CreateDate >= @CreateDateEndDate

-- and LastWriteTime >= @LastWriteTimeStartDate 
-- and LastWriteTime <= @LastWriteTimeStartDate 
-- and LastWriteTime >= @LastWriteTimeStartDate and  CreateDate >= @LastWriteTimeEndDate 

-- and SourceName like '@SourceName'
-- and FileDirectory like '@FileDirectory'
-- and OriginalFileType like '@OriginalFileType'

/* This is where the library search would go - you have global rights, it is not needed.*/
--All Libraries
--A specific Library

/* This is where the metadata search will go*/

-- AND (DataSourceOwnerUserID IS NOT NULL)
-- AND (DataSourceOwnerUserID = @UserID or isPublic = 'Y' ) 
-- AND (DataSourceOwnerUserID = @UserID ) 
