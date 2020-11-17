/* Calculate Email Row Size */
update Email 
set RecLen =  LEN (ISNULL ( [EmailGuid] , 0 ) ) 
 + LEN (ISNULL ( [SUBJECT] , 0 ) ) 
 + LEN (ISNULL ( [SentTO] , 0 ) ) 
 + DATALENGTH  ( [Body]) 
 + LEN (ISNULL ( [Bcc] , 0 ) ) 
 + LEN (ISNULL ( [BillingInformation] , 0 ) ) 
 + LEN (ISNULL ( [CC] , 0 ) ) 
 + LEN (ISNULL ( [Companies] , 0 ) ) 
 + LEN (ISNULL ( [CreationTime] , 0 ) ) 
 + LEN (ISNULL ( [ReadReceiptRequested] , 0 ) ) 
 + LEN (ISNULL ( [ReceivedByName] , 0 ) ) 
 + LEN (ISNULL ( [ReceivedTime] , 0 ) ) 
 + LEN (ISNULL ( [AllRecipients] , 0 ) ) 
 + LEN (ISNULL ( [UserID] , 0 ) ) 
 + LEN (ISNULL ( [SenderEmailAddress] , 0 ) ) 
 + LEN (ISNULL ( [SenderName] , 0 ) ) 
 + LEN (ISNULL ( [Sensitivity] , 0 ) ) 
 + LEN (ISNULL ( [SentOn] , 0 ) ) 
 + LEN (ISNULL ( [MsgSize] , 0 ) ) 
 + LEN (ISNULL ( [DeferredDeliveryTime] , 0 ) ) 
 + LEN (ISNULL ( [EntryID] , 0 ) ) 
 + LEN (ISNULL ( [ExpiryTime] , 0 ) ) 
 + LEN (ISNULL ( [LastModificationTime] , 0 ) ) 
 + DATALENGTH  ( [EmailImage]) 
 + LEN (ISNULL ( [Accounts] , 0 ) ) 
 + LEN (ISNULL ( [RowID] , 0 ) ) 
 + LEN (ISNULL ( [ShortSubj] , 0 ) ) 
 + LEN (ISNULL ( [SourceTypeCode] , 0 ) ) 
 + LEN (ISNULL ( [OriginalFolder] , 0 ) ) 
 + LEN (ISNULL ( [StoreID] , 0 ) ) 
 + LEN (ISNULL ( [isPublic] , 0 ) ) 
 + LEN (ISNULL ( [RetentionExpirationDate] , 0 ) ) 
 + LEN (ISNULL ( [IsPublicPreviousState] , 0 ) ) 
 + LEN (ISNULL ( [isAvailable] , 0 ) ) 
 + LEN (ISNULL ( [CurrMailFolderID] , 0 ) ) 
 + LEN (ISNULL ( [isPerm] , 0 ) ) 
 + LEN (ISNULL ( [isMaster] , 0 ) ) 
 + LEN (ISNULL ( [CreationDate] , 0 ) ) 
 + LEN (ISNULL ( [NbrAttachments] , 0 ) ) 
 + LEN (ISNULL ( [CRC] , 0 ) ) 
 + LEN (ISNULL ( [Description] , 0 ) ) 
 + LEN (ISNULL ( [KeyWords] , 0 ) ) 
 + LEN (ISNULL ( [RetentionCode] , 0 ) ) 
 + LEN (ISNULL ( [EmailIdentifier] , 0 ) ) 
 + LEN (ISNULL ( [ConvertEmlToMSG] , 0 ) ) 
 + LEN (ISNULL ( [HiveConnectionName] , 0 ) ) 
 + LEN (ISNULL ( [HiveActive] , 0 ) ) 
 + LEN (ISNULL ( [RepoSvrName] , 0 ) ) 
 + LEN (ISNULL ( [RowCreationDate] , 0 ) ) 
 + LEN (ISNULL ( [RowLastModDate] , 0 ) ) 
 + LEN (ISNULL ( [UIDL] , 0 ) ) 
 + LEN (ISNULL ( [RecLen] , 0 ) ) 
 + LEN (ISNULL ( [RecHash] , 0 ) ) 
where RecLen is null
go

select distinct COUNT(*), RecLen from DataSource 
group by RecLen
having COUNT(*) > 1
order by 1 desc


select distinct count(*), RecHash  from Email 
group by RecHash
having COUNT(*) > 2
order by RecHash


ALTER TABLE email add RecLen int NULL
GO
ALTER TABLE DataSource add RecLen int NULL
GO
ALTER TABLE EmailAttachment add RecLen int NULL
GO

ALTER TABLE email add RecHash varchar(50) null
GO
ALTER TABLE DataSource add RecHash varchar(50) null
GO
ALTER TABLE EmailAttachment add  RecHash varchar(50) null 
GO

select distinct AttachmentCode , SUM(reclen) as Bytes, COUNT(*) as Cnt from EmailAttachment
group by AttachmentCode 
order by AttachmentCode