IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'FulltextSUpportedFileExtension'
)
    DROP TABLE FulltextSUpportedFileExtension;
GO
SELECT document_type, 
       version, 
       manufacturer
INTO FulltextSupportedFileExtension
FROM sys.fulltext_document_types;

CREATE INDEX PI_FulltextSUpportedFileExtension ON FulltextSUpportedFileExtension(document_type);
go
SELECT *
FROM FulltextSUpportedFileExtension
ORDER BY document_type;