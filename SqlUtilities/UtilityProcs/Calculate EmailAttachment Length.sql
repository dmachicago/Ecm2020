
update EmailAttachment 
set RecLen = 
 len (EmailGuid)   
      + DATALENGTH ( Attachment )
      + len ( ISNULL ( AttachmentName, 0 ) )
      + len ( ISNULL ( EmailGuid, 0 ) )
      + len ( ISNULL ( AttachmentCode, 0 ) )
      + len ( ISNULL ( RowID, 0 ) )
      + len ( ISNULL ( AttachmentType, 0 ) )
      + len ( ISNULL ( UserID, 0 ) )
      + len ( ISNULL ( isZipFileEntry, 0 ) )
      + len ( ISNULL ( OcrText, 0 ) )
      + len ( ISNULL ( isPublic, 0 ) )
      + len ( ISNULL ( AttachmentLength, 0 ) )
      + len ( ISNULL ( OriginalFileTypeCode, 0 ) )
      + len ( ISNULL ( HiveConnectionName, 0 ) )
      + len ( ISNULL ( HiveActive, 0 ) )
      + len ( ISNULL ( RepoSvrName, 0 ) )
      + len ( ISNULL ( RowCreationDate, 0 ) )
      + len ( ISNULL ( RowLastModDate, 0 ) )
Where RecLen is null
