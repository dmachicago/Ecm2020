SELECT 
KEY_TBL.RANK, DS.SentOn
,DS.ShortSubj
,DS.SenderEmailAddress
,DS.SenderName
,DS.SentTO
,DS.Body
,DS.CC
,DS.Bcc
,DS.CreationTime
,DS.AllRecipients
,DS.ReceivedByName
,DS.ReceivedTime
,DS.MsgSize
,DS.SUBJECT
,DS.OriginalFolder
,DS.EmailGuid, DS.RetentionExpirationDate, DS.isPublic, DS.UserID, DS.SourceTypeCode, DS.NbrAttachments , ' ' as RID, RepoSvrName
,ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID
FROM EMAIL AS DS
INNER JOIN CONTAINSTABLE(EMAIL, *,
'ISABOUT (@ISABOUT)' ) as KEY_TBL
ON DS.EmailGuid = KEY_TBL.[KEY]
WHERE
( CONTAINS(BODY, '@CONTAINS')  
or CONTAINS(SUBJECT, '@CONTAINS') 
or CONTAINS(Description, '@CONTAINS') 
or CONTAINS(KeyWords, '@CONTAINS') 
or CONTAINS(EmailImage, '@CONTAINS') )  
-- AND NOT (CONTAINS(BODY, '@NOTCONTAINS')  
-- or CONTAINS(SUBJECT, '@NOTCONTAINS') 
-- or CONTAINS(Description, '@NOTCONTAINS') 
-- or CONTAINS(KeyWords, '@NOTCONTAINS') 
-- or CONTAINS(EmailImage, '@NOTCONTAINS') )  
-- @LibrarySearch
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
--and KEY_TBL.RANK >= 0
ORDER BY KEY_TBL.RANK DESC


/*************************************************/
WITH xContent AS (SELECT 
KEY_TBL.RANK, DS.SourceName
,DS.CreateDate
,DS.VersionNbr
,DS.LastAccessDate
,DS.FileLength
,DS.LastWriteTime
,DS.OriginalFileType
,DS.isPublic
,DS.FQN
,DS.SourceGuid
,DS.DataSourceOwnerUserID, DS.FileDirectory, DS.RetentionExpirationDate, DS.isMaster, DS.StructuredData, DS.RepoSvrName
,ROW_NUMBER() OVER (ORDER BY SourceName ASC) AS ROWID
FROM DataSource as DS
INNER JOIN CONTAINSTABLE(dataSource, *,
'ISABOUT (dale, susan)' ) as KEY_TBL
ON DS.SourceGuid = KEY_TBL.[KEY]
WHERE
(CONTAINS(SourceImage, ' dale AND susan') 
or CONTAINS(KeyWords, ' dale AND susan')
or CONTAINS(Description, ' dale AND susan') 
or CONTAINS(OcrText, ' dale AND susan'))   
-- AND NOT CONTAINS(SourceImage, '@NOTCONTAINS')
-- AND NOT CONTAINS(KeyWords, '@NOTCONTAINS')
-- AND NOT CONTAINS(Description, '@NOTCONTAINS')
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
ORDER BY KEY_TBL.RANK DESC
