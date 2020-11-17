**************************************************
1
**************************************************
CREATE FULLTEXT CATALOG EM_IMAGE
WITH ACCENT_SENSITIVITY = OFF
GO
**************************************************
2
**************************************************
CREATE FULLTEXT CATALOG ftCatalog
WITH ACCENT_SENSITIVITY = OFF
GO

CREATE FULLTEXT INDEX ON [dbo].[DataSource] (
SourceName Language 1033 
,SourceImage Language 1033 
,Description Language 1033 
,KeyWords Language 1033 
,Notes Language 1033 
,OcrText Language 1033 
) 
KEY INDEX PK_DataSource
ON ftCatalog
WITH CHANGE_TRACKING AUTO
GO
**************************************************
3
**************************************************
CREATE FULLTEXT CATALOG ftEmail
WITH ACCENT_SENSITIVITY = OFF
GO
**************************************************
4
**************************************************
CREATE FULLTEXT CATALOG ftEmailCatalog
WITH ACCENT_SENSITIVITY = OFF
GO

DROP FULLTEXT INDEX ON email
go
CREATE FULLTEXT INDEX ON [dbo].[Email] (
SUBJECT
,Body
,ShortSubj
,Description
,KeyWords
,notes
,emailimage TYPE COLUMN SourceTypeCode Language 1033 
) 
KEY INDEX PK__Email__24383F235DE40451
ON ftEmailCatalog
WITH CHANGE_TRACKING AUTO
GO

CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment] (
Attachment Language 1033 
,AttachmentName Language 1033 
,OcrText Language 1033 
) 
KEY INDEX PK__EmailAtt__B975DD8289908A26
ON ftEmailCatalog
WITH CHANGE_TRACKING AUTO
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
