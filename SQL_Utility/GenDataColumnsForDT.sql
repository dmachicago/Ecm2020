--select top 18 * from INFORMATION_SCHEMA.COLUMNS

DECLARE @cols NVARCHAR(2000)= 'SentOn, 
       ShortSubj, 
       SenderEmailAddress, 
       SenderName, 
       SentTO, 
       Body, 
       CC, 
       Bcc, 
       CreationTime, 
       AllRecipients, 
       ReceivedByName, 
       ReceivedTime, 
       MsgSize, 
       SUBJECT, 
       OriginalFolder, 
       EmailGuid, 
       RetentionExpirationDate, 
       isPublic, 
       EMAIL.UserID, 
       SourceTypeCode, 
       NbrAttachments, 
       RID, 
       RepoSvrName, 
       RANK';

SELECT 'DIM ' + column_name + ' = New DataColumn("' + column_name + '", Type.GetType("System.' + data_type + '"))'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'Email';

SELECT 'DIM s' + column_name + ' as ' + data_type + ' = nothing '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'Email';

SELECT 'DT.Columns.Add(' + column_name + ')'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'Email';

SELECT 's' + column_name + ' = Obj.' + column_name + ' _'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'DataSource';

SELECT ', s' + column_name + ' as ' + data_type + ' _'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'DataSource';

SELECT 'DR("' + column_name + '") = ' + column_name
FROM INFORMATION_SCHEMA.COLUMNS
WHERE column_name IN('SentOn', 
       'ShortSubj', 
       'SenderEmailAddress', 
       'SenderName', 
       'SentTO', 
       'Body', 
       'CC', 
       'Bcc', 
       'CreationTime', 
       'AllRecipients', 
       'ReceivedByName', 
       'ReceivedTime', 
       'MsgSize', 
       'SUBJECT', 
       'OriginalFolder', 
       'EmailGuid', 
       'RetentionExpirationDate', 
       'isPublic', 
       'EMAIL.UserID', 
       'SourceTypeCode', 
       'NbrAttachments', 
       'RID', 
       'RepoSvrName', 
       'RANK')
AND table_name = 'DataSource';