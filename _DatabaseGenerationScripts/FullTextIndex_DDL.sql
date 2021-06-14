--**************************************************
-- Item #1
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'EM_IMAGE') is null
BEGIN
CREATE FULLTEXT CATALOG EM_IMAGE
WITH ACCENT_SENSITIVITY = OFF
END
GO
--**************************************************
-- Item #2
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftCatalog') is null
BEGIN
CREATE FULLTEXT CATALOG ftCatalog
WITH ACCENT_SENSITIVITY = OFF
END
GO
--**************************************************
-- Item #3
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSource') is null
BEGIN
CREATE FULLTEXT CATALOG ftDataSource
WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSource') is null
BEGIN

CREATE FULLTEXT INDEX ON dbo.DataSource(
		SourceName LANGUAGE 1033, 
		SourceImage TYPE COLUMN SourceTypeCode LANGUAGE 1033, 
		Description LANGUAGE 1033, 
		KeyWords LANGUAGE 1033, 
		Notes LANGUAGE 1033, 
		OcrText LANGUAGE 1033,
		PdfText Language 1033) 
		KEY INDEX PK_DataSource_1 ON ftDataSource WITH CHANGE_TRACKING AUTO;
END
GO
--**************************************************
-- Item #4
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSourceImage') is null
BEGIN
CREATE FULLTEXT CATALOG ftDataSourceImage
WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftDataSourceImage') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[DataSourceImage] (
SourceImage Language 1033 
) 
KEY INDEX PKey_DataSourceImage
ON ftDataSourceImage
WITH CHANGE_TRACKING AUTO
END
GO
--**************************************************
-- Item #5
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmail') is null
BEGIN
CREATE FULLTEXT CATALOG ftEmail
WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmail') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[Email] (
SUBJECT Language 1033 
,Body Language 1033 
,EmailImage Language 1033 
,ShortSubj Language 1033 
,Description Language 1033 
,KeyWords Language 1033 
,notes Language 1033 
) 
KEY INDEX PKI_Email_FTI
ON ftEmail
WITH CHANGE_TRACKING AUTO
END
GO
--**************************************************
-- Item #6
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailAttachment') is null
BEGIN
CREATE FULLTEXT CATALOG ftEmailAttachment
WITH ACCENT_SENSITIVITY = OFF
END
GO
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailAttachment') is null
BEGIN

CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment] (
AttachmentName Language 1033 
,OcrText Language 1033 
,Attachment Language 1033 
) 
KEY INDEX PK__EmailAtt__B975DD8289908A26
ON ftEmailAttachment
WITH CHANGE_TRACKING AUTO
END
GO
--**************************************************
-- Item #7
--**************************************************
if (select [name] from sys.fulltext_catalogs where [name] = 'ftEmailCatalog') is null
BEGIN
CREATE FULLTEXT CATALOG ftEmailCatalog
WITH ACCENT_SENSITIVITY = OFF
END
GO
