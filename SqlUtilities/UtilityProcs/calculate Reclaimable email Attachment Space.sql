

--150.2GB is what I can get back in one statement !!!! With relative safety.
select distinct AttachmentCode, isnull(SUM(recLen),0) as WastedBytes ,COUNT(*) NbrFiles 
from EmailAttachment
where 
--AttachmentCode = '.msg'
(AttachmentCode in (select ImageTypeCode from ImageTypeCodes)
and OcrText is null)
or AttachmentCode not In (Select document_type from sys.fulltext_document_types)
group by AttachmentCode
order by 2 desc


delete from EmailAttachment
where 
--AttachmentCode = '.msg'
(AttachmentCode like '.tif%'
and OcrText is null)
or (AttachmentCode like '.jpg'
and OcrText is null)
or (AttachmentCode like '.bmp'
and OcrText is null)
or (AttachmentCode like '.png'
and OcrText is null)
or (AttachmentCode like '.gif'
and OcrText is null)
or (AttachmentCode != '.msg' and OcrText is null and AttachmentCode not In (
'.ascx',
'.asm',
'.asp',
'.aspx',
'.bat',
'.c',
'.cmd',
'.cpp',
'.cxx',
'.def',
'.dic',
'.doc',
'.dot',
'.h',
'.hhc',
'.hpp',
'.htm',
'.html',
'.htw',
'.htx',
'.hxx',
'.ibq',
'.idl',
'.inc',
'.inf',
'.ini',
'.inx',
'.js',
'.log',
'.m3u',
'.mht',
'.obd',
'.obt',
'.odc',
'.pl',
'.pot',
'.ppt',
'.rc',
'.reg',
'.rtf',
'.stm',
'.txt',
'.url',
'.vbs',
'.wtx',
'.xlb',
'.xlc',
'.xls',
'.xlt',
'.xml'))

