SELECT     Email.SentOn, Email.ShortSubj, Email.SenderEmailAddress, Email.SenderName, Email.SentTO, SUBSTRING(Email.Body, 1, 100) AS Body, Email.CC, Email.Bcc, 
                      Email.CreationTime, Email.AllRecipients, Email.ReceivedByName, Email.ReceivedTime, Email.MsgSize, Email.SUBJECT, Email.OriginalFolder, Email.EmailGuid, 
                      Email.RetentionExpirationDate, Email.isPublic, Email.ConvertEmlToMSG, Email.UserID, Email.NbrAttachments, Email.SourceTypeCode, 'N' AS FoundInAttachment,
                      EmailAttachment.RowID
FROM         Email FULL OUTER JOIN
                      EmailAttachment ON Email.EmailGuid = EmailAttachment.EmailGuid
WHERE     
(
CONTAINS(Email.*, ' dale AND susan AND Liz') OR
CONTAINS(EmailAttachment.*, ' dale AND susan AND Liz') 
) 
AND 
(
Email.SentOn > '12/01/2009 12:00:00 AM'
)

