select COUNT(*) as EmptyEmailSubject from Email where DATALENGTH(subject) = 0 
go
select COUNT(*) as EmptyEmailBody from Email where DATALENGTH(body) = 0
go
select COUNT(*) as EmptyEmailSubjectAndBody from Email where DATALENGTH(body) = 0 and DATALENGTH(subject) = 0 
go
select COUNT(*) as EmptyEmailAtttachment from EmailAttachment where DATALENGTH(Attachment) = 0
go
select COUNT(*) as EmailAtttachmentStoredAsZero from EmailAttachment where AttachmentLength = 0
go
select COUNT(*) as EmptyEmailAtttachment from EmailAttachment where DATALENGTH(OcrText) = 0
go

