declare @TotBytes float

select @TotBytes = (select SUM(RecLen) from EmailAttachment)

select distinct 
	AttachmentCode, 
	Count(*) as NbrAttach, 
	isnull(sum(RecLen),0) as DBSizeBytes,
	round(isnull(sum(RecLen),0) / @TotBytes * 100, 2,0) as PctOftotal
from EmailAttachment 
where AttachmentCode = '.pdf' 
and contains (Attachment, ' "FontName" ')
group by AttachmentCode
order by 3 desc