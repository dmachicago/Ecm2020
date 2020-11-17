SELECT 
[SentOn]
,[ShortSubj]
,[SenderEmailAddress]
,[SenderName]
,[SentTO]
,[Body]
,[CC]
,[Bcc]
,[CreationTime]
,[AllRecipients]
,[ReceivedByName]
,[ReceivedTime]
,[MsgSize]
,[SUBJECT]
,[OriginalFolder]
,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName, 0 as RANK
FROM EMAIL
WHERE
( CONTAINS(BODY, '@CONTAINS')  
or CONTAINS(SUBJECT, '@CONTAINS') 
or CONTAINS(Description, '@CONTAINS') 
or CONTAINS(KeyWords, '@CONTAINS') 
or CONTAINS(EmailImage, '@CONTAINS') 
)  
-- AND NOT CONTAINS(Body, '@NOTCONTAINS')  
-- AND NOT CONTAINS(SUBJECT, '@NOTCONTAINS')  
-- AND NOT CONTAINS(Description, '@NOTCONTAINS')  
-- AND NOT CONTAINS(KeyWords, '@NOTCONTAINS')  
-- AND NOT CONTAINS(EmailImage, '@NOTCONTAINS')  
-- and @LibrarySearch
-- and SenderEmailAddress like '@SenderEmailAddress'
-- and SentTO like '@SentTO' or AllRecipients like '@SentTO'
-- and SenderName like @SenderName
-- and ReceivedByName like '@ReceivedByName'
-- and OriginalFolder like '@OriginalFolder'
-- and SUBJECT Like '@SUBJECT' 
-- and (CC like '@CC' or BCC like '@BCC' or AllRecipients like '@AllRecipients')
-- and CreationTime <= '@CreationTimeStart'
-- and CreationTime >= '@CreationTimeStart'
-- and CreationTime Between '@CreationTimeStart' and '@CreationTimeEnd'
-- and SentOn <= '@SentOn'
-- and SentOn >= '@SentOn'
-- and SentOn Between '@SentOnStart' and '@SentOnEnd'
-- and ReceivedTime <= '@ReceivedTime'
-- and ReceivedTime <= '@ReceivedTime'
-- and ReceivedTime Between '@ReceivedTimeStart' and '@ReceivedTimeEnd'
-- and @LibrarySearch
-- AND (UserID IS NOT NULL)
-- AND (UserID = '@UserID' ) 
-- Order by @OrderByColumns



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
,ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID
FROM DataSource
WHERE
CONTAINS(*, '@CONTAINS')
-- AND NOT CONTAINS(*, '@NOTCONTAINS')
/* This is where the library search would go unless you have global rights, think about it.*/ 
-- and CreateDate <= '@CreateDateStart'
-- and CreateDate >= '@CreateDateEnd'
-- and CreateDate Between '@CreateDateStart' and '@CreateDateEnd'
-- and LastWriteTime <= '@LastWriteTimeStart'
-- and LastWriteTime >= '@LastWriteTimeEnd'
-- and LastWriteTime Between '@LastWriteTimeStart' and '@LastWriteTimeEnd'
-- and SourceTypeCode like '@SourceTypeCode' 
-- and FQN like '@FQN'
-- and SourceName like '@SourceName'
-- AND (DataSourceOwnerUserID IS NOT NULL)
-- AND (DataSourceOwnerUserID = @DataSourceOwnerUserID)
--order by [SourceName]
