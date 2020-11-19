
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'spFindUnindexedFiles'
)
    DROP PROCEDURE spFindUnindexedFiles;
GO
-- exec spFindUnindexedFiles
CREATE PROCEDURE spFindUnindexedFiles
AS
    BEGIN
        CREATE TABLE #iFilters
        (Componenttype NVARCHAR(50) NULL, 
         Componentname NVARCHAR(50) NULL, 
         clsid         NVARCHAR(50) NULL, 
         fullpath      NVARCHAR(250) NULL, 
         [version]     NVARCHAR(50) NULL, 
         manufacturer  NVARCHAR(150) NULL,
        );
        INSERT INTO #iFilters
        EXEC sp_help_fulltext_system_components 
             'filter';
        SELECT SourceName, 
               OriginalFileType, 
               SourceTypeCode,
               CASE
                   WHEN OriginalFileType IN(SELECT ImageTypeCode
                                            FROM ImageTypeCodes)
                   THEN 'Y'
                   ELSE 'N'
               END AS OcrReq, 
               RowGuid
        FROM DataSource
        WHERE OriginalFileType NOT IN
        (
            SELECT Componentname
            FROM #iFilters
        )
              AND SourceTypeCode NOT IN
        (
            SELECT Componentname
            FROM #iFilters
        );
    END;