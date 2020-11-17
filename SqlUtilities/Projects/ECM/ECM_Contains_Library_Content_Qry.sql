SELECT     DataSource.SourceName, DataSource.CreateDate, DataSource.VersionNbr, DataSource.LastAccessDate, DataSource.FileLength, DataSource.LastWriteTime, 
                      DataSource.SourceTypeCode, DataSource.isPublic, DataSource.FQN, DataSource.SourceGuid, DataSource.DataSourceOwnerUserID, DataSource.FileDirectory, 
                      DataSource.StructuredData, DataSource.RepoSvrName
FROM         DataSource INNER JOIN
                      LibraryItems ON DataSource.SourceGuid = LibraryItems.SourceGuid INNER JOIN
                      LibraryUsers ON DataSource.DataSourceOwnerUserID = LibraryUsers.UserID
WHERE
CONTAINS(SourceImage, '@Contains') 
OR CONTAINS(KeyWords, '@Contains') 
OR CONTAINS(Description, '@Contains') 

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
                      