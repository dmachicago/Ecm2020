create procedure spCalcEmailReclaimSpace
as
select distinct AttachmentCode, isnull(SUM(recLen),0) as WastedBytes ,COUNT(*) NbrFiles 
from EmailAttachment
where 
--AttachmentCode = '.msg'
(AttachmentCode in (select ImageTypeCode from ImageTypeCodes)
and OcrText is null)
or AttachmentCode not In (Select document_type from sys.fulltext_document_types)
group by AttachmentCode
order by 2 desc
