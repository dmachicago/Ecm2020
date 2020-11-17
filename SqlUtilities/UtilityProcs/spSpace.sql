select COUNT(*) from 
EmailAttachment
where AttachmentCode = '.pdf'
and OcrText is null