--**************************************************
-- Item #1
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'EM_IMAGE'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG EM_IMAGE WITH ACCENT_SENSITIVITY = OFF;
END;
GO
--**************************************************
-- Item #2
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftCatalog'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftCatalog WITH ACCENT_SENSITIVITY = OFF;
END;
GO

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftCatalog'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT INDEX ON dbo.DataSource ( SourceName LANGUAGE 1033 , SourceImage LANGUAGE 1033 , Description LANGUAGE 1033 , KeyWords LANGUAGE 1033 , Notes LANGUAGE 1033 , OcrText LANGUAGE 1033
                                                ) KEY INDEX PK_DataSource ON ftCatalog WITH CHANGE_TRACKING AUTO;
END;
GO
--**************************************************
-- Item #3
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftDataSource'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftDataSource WITH ACCENT_SENSITIVITY = OFF;
END;
GO
--**************************************************
-- Item #4
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftDataSourceImage'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftDataSourceImage WITH ACCENT_SENSITIVITY = OFF;
END;
GO

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftDataSourceImage'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT INDEX ON dbo.DataSourceImage ( Description LANGUAGE 1033 , KeyWords LANGUAGE 1033 , Notes LANGUAGE 1033 , OcrText LANGUAGE 1033 , SourceImage LANGUAGE 1033 , SourceName LANGUAGE 1033
                                                     ) KEY INDEX PKey_DataSourceImage ON ftDataSourceImage WITH CHANGE_TRACKING AUTO;
END;
GO
--**************************************************
-- Item #5
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftEmail'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftEmail WITH ACCENT_SENSITIVITY = OFF;
END;
GO
--**************************************************
-- Item #6
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftEmailAttachment'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftEmailAttachment WITH ACCENT_SENSITIVITY = OFF;
END;
GO
--**************************************************
-- Item #7
--**************************************************

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftEmailCatalog'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT CATALOG ftEmailCatalog WITH ACCENT_SENSITIVITY = OFF;
END;
GO

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftEmailCatalog'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT INDEX ON dbo.Email ( SUBJECT LANGUAGE 1033 , Body LANGUAGE 1033 , EmailImage LANGUAGE 1033 , ShortSubj LANGUAGE 1033 , Description LANGUAGE 1033 , KeyWords LANGUAGE 1033 , notes LANGUAGE 1033
                                           ) KEY INDEX PK__Email__24383F235DE40451 ON ftEmailCatalog WITH CHANGE_TRACKING AUTO;
END;
GO

IF ( SELECT name
     FROM sys.fulltext_catalogs
     WHERE name = 'ftEmailCatalog'
   ) IS NULL
    BEGIN
        CREATE FULLTEXT INDEX ON dbo.EmailAttachment ( Attachment LANGUAGE 1033 , AttachmentName LANGUAGE 1033 , OcrText LANGUAGE 1033
                                                     ) KEY INDEX PK__EmailAtt__B975DD8289908A26 ON ftEmailCatalog WITH CHANGE_TRACKING AUTO;
END;
GO